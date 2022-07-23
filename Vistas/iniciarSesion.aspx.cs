using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class iniciarSesion : System.Web.UI.Page
    {
        LogicaUsuarios logUs = new LogicaUsuarios();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                hlUsuario.Text = "Ingresar";
                hlUsuario.NavigateUrl = "~/iniciarSesion.aspx";
                lblNombreUsuario.Text = "";
            }
            else
            {
                hlUsuario.Text = "Mi Perfil";
                hlUsuario.NavigateUrl = "~/MiPerfil.aspx";
                Usuarios usuarioNombre = (Usuarios)Session["Usuario"];
                lblNombreUsuario.Text = usuarioNombre.Nombre + " " + usuarioNombre.Apellido;
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Usuarios AuxUs = new Usuarios();
            AuxUs.Email = floatingInput.Value;
            AuxUs.Contraseña = floatingPassword.Value;

            if (logUs.verificarQueUsuarioExiste(AuxUs))
            {
                lblMensaje.Text = "Sesión iniciada correctamente!!";

                Session["Usuario"] = logUs.getUsuarioSegunMail(AuxUs);
                hlUsuario.Text = "Mi Perfil";
                Usuarios usuarioNombre = (Usuarios)Session["Usuario"];
                lblNombreUsuario.Text = usuarioNombre.Nombre + " " + usuarioNombre.Apellido;
            }
            else
            {
                lblMensaje.Text = "Nombre o contraseña incorrectos";
            }
        }


        protected void cmvCorreoMayus_ServerValidate(object source, ServerValidateEventArgs args)
        {
            
        }

        protected void imgBtn_Logo_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void imgBtn_Carrito_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }
    }
}