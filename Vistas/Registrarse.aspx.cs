using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Registrarse : System.Web.UI.Page
    {
        LogicaUsuarios logUS = new LogicaUsuarios();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hlUsuario.Text = "Ingresar";
                hlUsuario.NavigateUrl = "~/iniciarSesion.aspx";
                lblNombreUsuario.Text = "";
            }
        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            Usuarios user = new Usuarios();
            user.Nombre = txtNombre.Value;
            user.Apellido = txtApellido.Value;
            user.Dni = int.Parse(txtDni.Value);
            user.Email = txtEmail.Value;
            user.Contraseña = txtConfirmarContra.Value;

            if (logUS.agregarUsuario(user))
            {
                lblMensaje.Text = "Se ha registrado correctamente!";
            }
            else
            {
                lblMensaje.Text = "No se pudo registrar.";
            }
            LimpiarCampos();
        }

        public void LimpiarCampos()
        {
            foreach (Control control in Form.Controls)
            {
                if (control is HtmlInputText)
                {
                    HtmlInputText txtcampo = (HtmlInputText)control;
                    txtcampo.Value = "";
                }
                else if (control is HtmlInputGenericControl)
                {
                    HtmlInputGenericControl txtcampo = (HtmlInputGenericControl)control;
                    txtcampo.Value = "";
                }
            }
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