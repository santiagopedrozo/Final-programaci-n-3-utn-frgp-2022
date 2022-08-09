using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Negocio;
using Entidades;

namespace Vistas
{
    public partial class HomeMp : System.Web.UI.Page
    {
        private FiltrosProductos _filtros = new FiltrosProductos();
        private LogicaProductos _LogicaProd = new LogicaProductos();
        private LogicaSubCategorias _LogicaSubCat = new LogicaSubCategorias();
        private LogicaCategorias _logicaCategorias = new LogicaCategorias();

        private void cargarDDLCategorias(ref DropDownList ddl)
        {
            LogicaCategorias _logicaCat = new LogicaCategorias();

            ddl.DataSource = _logicaCat.getCategorias();
            ddl.DataValueField = "id_categoria";
            ddl.DataTextField = "Descripcion_Categoria";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("", "-1"));
        }

        private void cargarDDLSubCategorias(ref DropDownList ddl, int id)
        {
            LogicaSubCategorias _logicaSubCat = new LogicaSubCategorias();

            ddl.DataSource = _logicaSubCat.getSubCategoriasXidCategoria(id);
            ddl.DataTextField = "Descripcion_Subcategoria";
            ddl.DataValueField = "Id_Subcategoria";
            ddl.DataBind();
            ddl.Visible = true;
            ddl.Items.Insert(0, new ListItem("", "-1"));
        }

        private void cargadoListView()
        {
            FiltrosProductos _filtrosSession = Session[Globales.FiltrosLvHome] as FiltrosProductos;
            lvProductos.DataSource = _LogicaProd.BusquedaConFiltrosLvHome(_filtrosSession.IdCat, _filtrosSession.IdSubCat, _filtrosSession.Nombre, _filtrosSession.PrecioMinimo, _filtrosSession.PrecioMaximo);
            lvProductos.DataBind();
        }

        //private void EsAdmin()
        //{
        //    if (Session[Globales.usuario] != null && ((Usuarios)Session[Globales.usuario]).EsAdmin == true)
        //    {
        //        hlReporteVentas.Visible = true;
        //        hlFuncionesAdmin.Visible = true;
        //    }
        //}

        //private void NoEstaIniciado()
        //{
        //    if (Session[Globales.usuario] == null)
        //    {
        //        hlUsuario.Text = "Ingresar";
        //        hlUsuario.NavigateUrl = "~/iniciarSesion.aspx";
        //        lblNombreUsuario.Text = "";
        //    }
        //}

        //private void EstaIniciado()
        //{
        //    if (Session[Globales.usuario] != null)
        //    {
        //        lbCerrarSesion.Visible = true;
        //        hlUsuario.Text = "Mi Perfil";
        //        hlUsuario.NavigateUrl = "~/MiPerfil.aspx";
        //        Usuarios usuarioNombre = (Usuarios)Session[Globales.usuario];
        //        lblNombreUsuario.Text = usuarioNombre.Nombre + " " + usuarioNombre.Apellido;
        //    }
        //}

        //private void sesionesUsuario()
        //{
        //    EsAdmin();
        //    NoEstaIniciado();
        //    EstaIniciado();
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                Session[Globales.FiltrosLvHome] = new FiltrosProductos();
                cargadoListView();
                //sesionesUsuario();
                cargarDDLCategorias(ref ddlCategorias);
            }

        }

        //paginación de productos
        protected void lvProductos_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvProductos.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            cargadoListView();
        }

        protected void imgProducto_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "seleccionProductoDetalle")
            {
                Session[Globales.prodDetalle] = Convert.ToInt32(e.CommandArgument.ToString());
                Response.Redirect("DetalleProducto.aspx");
            }
        }

        private bool validarRepeticion(string nombreProd) //true si es valido el id que se va a ingresar
        {
            if (Session[Globales.carrito] == null)
                return true;

            DataTable dt = new DataTable();
            dt = (DataTable)Session[Globales.carrito];

            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Nombre"].ToString() == nombreProd)
                    return false;
            }
            return true;
        }

        public void agregarFilaCarrito(Productos prod) //Si la tabla no existe la crea, sino, agrega una fila
        {
            DataTable dt = new DataTable();
            int cantidad = 1;
            DataRow dr = dt.NewRow();

            if (Session[Globales.carrito] == null)
            {
                dt.Columns.Add(new DataColumn("IdProd"));
                dt.Columns.Add(new DataColumn("Nombre"));
                dt.Columns.Add(new DataColumn("Precio"));
                dt.Columns.Add(new DataColumn("Cantidad"));
                dt.Columns.Add(new DataColumn("Total"));
            }
            else
                dt = (DataTable)Session[Globales.carrito];

            if (validarRepeticion(prod.Nombre))
            {
                cantidad = 1;
                dr = dt.NewRow();
            }
            else
            {
                foreach (DataRow dtr in dt.Rows)
                {
                    if (dtr["Nombre"].ToString() == prod.Nombre)
                    {
                        cantidad = int.Parse(dtr["Cantidad"].ToString()) + 1;
                        dr = dtr;
                    }
                }
            }

            dr["IdProd"] = prod.IdProducto;
            dr["Nombre"] = prod.Nombre;
            dr["Precio"] = prod.Precio;

            dr["Cantidad"] = cantidad;
            dr["Total"] = prod.Precio * cantidad;

            if (validarRepeticion(prod.Nombre))
                dt.Rows.Add(dr);

            Session[Globales.carrito] = dt;
        }


        protected void btnAgregarAlCarrito_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "ProductoCarrito")
            {
                if (Session[Globales.usuario] != null)
                {
                    Productos prodAux = new Productos();
                    prodAux.IdProducto = (int.Parse(e.CommandArgument.ToString()));

                    agregarFilaCarrito(_LogicaProd.getProducto(prodAux));

                    //lblIniciarSesion.Text = "";
                }
                else
                {
                    //lblIniciarSesion.Text = "Para agregar productos al carrito debe iniciar sesion!";
                }

            }
        }
        private void VaciadoControles() //vacia todos los filtros que contienen controles
        {
            txtBusqueda.Text = "";
            txtMaximo.Text = "";
            txtMinimo.Text = "";
        }


        protected void btnQuitar_Click(object sender, EventArgs e)
        {
            Session[Globales.FiltrosLvHome] = new FiltrosProductos();
            FiltrosProductos _filtrosSession = Session[Globales.FiltrosLvHome] as FiltrosProductos;

            VaciadoControles();
            cargadoListView();
        }

        private bool verificacionFiltrosPrecio()
        {
            bool estado = true;
            if (txtMinimo.Text == "" || txtMaximo.Text == "")
            {
                estado = false;
                return estado;
            }
            else if (Convert.ToInt32(txtMinimo.Text) > Convert.ToInt32(txtMaximo.Text))
            {
                estado = false;
            }

            return estado;
        }

        //protected void lbCarrito_Click(object sender, ImageClickEventArgs e)
        //{
        //    Response.Write("hola");
        //    if (Session[Globales.usuario] == null)
        //        Response.Redirect("Registrarse.aspx");
        //    else
        //        Response.Redirect("Carrito.aspx");
        //}

        protected void ddlCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            cargarDDLSubCategorias(ref ddlSubCat, int.Parse(ddl.SelectedValue));

            FiltrosProductos _filtrosSession = Session[Globales.FiltrosLvHome] as FiltrosProductos;
            _filtrosSession.IdCat = int.Parse(ddl.SelectedValue);
            Session[Globales.FiltrosLvHome] = _filtrosSession;
            cargadoListView();
        }

        protected void ddlSubCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            FiltrosProductos _filtrosSession = Session[Globales.FiltrosLvHome] as FiltrosProductos;
            Response.Write(ddl.SelectedValue);
            _filtrosSession.IdSubCat = int.Parse(ddl.SelectedValue);
            Session[Globales.FiltrosLvHome] = _filtrosSession;
            cargadoListView();
        }

        protected void lbCerrarSesion_Click(object sender, EventArgs e)
        {
            Session[Globales.usuario] = null;
            Response.Redirect("Home.aspx");
        }

        protected void lbBuscar_Click(object sender, EventArgs e)
        {
            int min = -1;
            int max = -1;

            if (txtMinimo.Text != "" && txtMaximo.Text != "")
            {
                min = int.Parse(txtMinimo.Text);
                max = int.Parse(txtMaximo.Text);
            }


            FiltrosProductos _filtrosSession = Session[Globales.FiltrosLvHome] as FiltrosProductos;
            _filtrosSession.PrecioMaximo = max;
            _filtrosSession.PrecioMinimo = min;
            _filtrosSession.Nombre = txtBusqueda.Text;
            Session[Globales.FiltrosLvHome] = _filtrosSession;

            cargadoListView();
        }

        protected void lbCarrito_Click(object sender, EventArgs e)
        {
            Response.Write("hola");
            if (Session[Globales.usuario] == null)
                Response.Redirect("Registrarse.aspx");
            else
                Response.Redirect("Carrito.aspx");
        }
    }
}