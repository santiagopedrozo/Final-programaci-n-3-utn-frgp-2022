using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Negocio;
using Entidades;

namespace Vistas
{
    public partial class Carrito : System.Web.UI.Page
    {
        private void cargarGrilla()
        {
            grdProductosCarrito.DataSource = (DataTable)Session[Globales.carrito];
            grdProductosCarrito.DataBind();
        }

        private void actualizarTotal()
        {
            float total = 0;
            DataTable dt = new DataTable();
            dt = (DataTable)Session[Globales.carrito];

            foreach (DataRow dr in dt.Rows)
            {
                total += float.Parse(dr["Total"].ToString());
            }
            lblTotal.Text = "Precio total: " + total;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session[Globales.usuario] == null)
            //    Server.Transfer("iniciarSesion.aspx");

            if (!IsPostBack)
            {
                if (Session[Globales.usuario] == null)
                {
                    hlUsuario.Text = "Ingresar";
                    hlUsuario.NavigateUrl = "~/iniciarSesion.aspx";
                    lblNombreUsuario.Text = "";
                }
                else
                {
                    hlUsuario.Text = "Mi Perfil";
                    hlUsuario.NavigateUrl = "~/MiPerfil.aspx";
                    Usuarios usuarioNombre = (Usuarios)Session[Globales.usuario];
                    lblNombreUsuario.Text = usuarioNombre.Nombre + " " + usuarioNombre.Apellido;
                }
                if(Session[Globales.carrito] != null)
                {
                    cargarGrilla();
                    actualizarTotal();
                }

            }
        }

        protected void btnBorrarCarrito_Click(object sender, EventArgs e)
        {
            Session[Globales.carrito] = null;
            lblTotal.Text = "Precio total = 0";
            cargarGrilla();
        }

        protected void grdProductosCarrito_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = new DataTable();
            String nombre = ((Label)grdProductosCarrito.Rows[e.RowIndex].FindControl("lbl_grd_Nombre")).Text;

            dt = (DataTable)Session[Globales.carrito];

            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Nombre"].ToString() == nombre)
                {
                    dt.Rows.Remove(dr);
                    break;
                }
            }

            Session[Globales.carrito] = dt;
            cargarGrilla();
            actualizarTotal();
        }

        protected void grdProductosCarrito_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdProductosCarrito.EditIndex = e.NewEditIndex;
            cargarGrilla();
        }

        protected void grdProductosCarrito_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdProductosCarrito.EditIndex = -1;
            cargarGrilla();
        }

        protected void grdProductosCarrito_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String nombre = ((Label)grdProductosCarrito.Rows[e.RowIndex].FindControl("lbl_edit_Nombre")).Text;
            String precio = ((Label)grdProductosCarrito.Rows[e.RowIndex].FindControl("lbl_edit_Precio")).Text;
            String cantidad = ((TextBox)grdProductosCarrito.Rows[e.RowIndex].FindControl("txt_edit_Cantidad")).Text;
            String total = ((Label)grdProductosCarrito.Rows[e.RowIndex].FindControl("lbl_edit_Total")).Text;

            DataTable dt = new DataTable();
            dt = (DataTable)Session[Globales.carrito];

            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Nombre"].ToString() == nombre)
                {
                    dr["Cantidad"] = int.Parse(cantidad);
                    dr["Total"] = int.Parse(cantidad) * float.Parse(precio);
                }
            }

            grdProductosCarrito.EditIndex = -1;
            cargarGrilla();
            actualizarTotal();
        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("FinalizaarCompra.aspx");
        }

        protected void txt_edit_Cantidad_TextChanged(object sender, EventArgs e)
        {
        }

        protected void imgBtn_Logo_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void imgBtn_Carrito_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }
    }
}