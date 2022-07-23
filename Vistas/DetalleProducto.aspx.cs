using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Negocio;
using Entidades;
using System.Data;
using System.Web.UI.WebControls;

namespace Vistas
{
    public partial class DetalleProducto : System.Web.UI.Page
    {
        
        LogicaReseñas logr = new LogicaReseñas();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Usuarios)Session[Globales.usuario] == null) //si no esta iniciado sesion los controles de agregar reseña no aparecen
                AgregarReseñaDiv.Visible = false;

            if (!IsPostBack)
            {
                Productos productos = new Productos();
                productos.IdProducto = Convert.ToInt32(Session[Globales.prodDetalle]);//Esta session es un int del id
                LogicaProductos logp = new LogicaProductos();
                productos = logp.getProducto(productos);

                CargadoProductoLabels(ref productos);
                cargadoReseñas(productos);
            }

        }

        private void cargadoReseñas(Productos productos)
        {
            dlResenias.DataSource = logr.ultimas10Reseñas(productos);
            dlResenias.DataBind();

            if (dlResenias.Items.Count == 0)
                lblVacio.Visible = true;
        }

        private void CargadoProductoLabels(ref Productos productos)
        {
            lblNombreProducto.Text = productos.Nombre;
            lblPrecio.Text = productos.Precio.ToString();
            lblSubCategoria.Text = productos.Subcategoria.Descripcion;
            lblCategoria.Text = productos.Subcategoria.Categoria.Descripcion;
            lblDescripcion.Text = productos.Descripcion;
            imgProducto.ImageUrl = productos.UrlImage;
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

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            LogicaProductos logProd = new LogicaProductos();
            Productos prodAux = new Productos();
            prodAux.IdProducto = (int.Parse(Session[Globales.prodDetalle].ToString()));

            agregarFilaCarrito(logProd.getProducto(prodAux));
        }

        protected void btnEnviarReseña_Click(object sender, EventArgs e)
        {
            ReseñasProducto res = new ReseñasProducto();
            Usuarios us = new Usuarios();
            us = (Usuarios)Session[Globales.usuario];

            res.Producto.IdProducto = (int)Session[Globales.prodDetalle];
            res.Usuario.Dni = us.Dni;
            res.Contenido = txtReseña.Text;
            res.Calificación = Convert.ToInt32(txtPuntuacion.Text);

            //Response.Write(res.Producto.IdProducto.ToString())

            if (logr.agregarReseña(res))
            {
                Productos prod = new Productos();
                prod.IdProducto = (int)Session[Globales.prodDetalle];

                lblErrorReseña.Text = "Agregada correctamente";
                cargadoReseñas(prod);
                lblVacio.Text = "";
                txtReseña.Text = "";
                txtPuntuacion.Text = "";
            }    
            else
                lblErrorReseña.Text = "No se pudo agregar correctamente, recordar que solo se puede agregar una reseña por persona en cada producto";

        }
        protected void imgBtn_Logo_Click1(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void imgBtn_Carrito_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }
    }
}