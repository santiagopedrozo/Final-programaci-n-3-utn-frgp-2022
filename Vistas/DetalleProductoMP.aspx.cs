﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Entidades;
using System.Data;

namespace Vistas
{
    public partial class DetalleProductoMP : System.Web.UI.Page
    {
        LogicaReseñas logr = new LogicaReseñas();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Usuarios)Session[Globales.usuario] != null) //si no esta iniciado sesion los controles de agregar reseña no aparecen
                AgregarReseñaDiv.Visible = true;

            if (!IsPostBack)
            {
                Session["Puntaje"] = -1;
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
            lblPrecio.Text = "$ " + productos.Precio.ToString();
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

            if (Session[Globales.usuario] != null)
                agregarFilaCarrito(logProd.getProducto(prodAux));
            else
                ErrorCarrito.Visible = true;
        }


        protected void btnEnviarReseña_Click(object sender, EventArgs e)
        {
            if (Session[Globales.usuario] == null)
            {
                ReseñasProducto res = new ReseñasProducto();
                Usuarios us = new Usuarios();
                us = (Usuarios)Session[Globales.usuario];

                res.Producto.IdProducto = (int)Session[Globales.prodDetalle];
                res.Usuario.Dni = us.Dni;
                res.Contenido = txtReseña.Text;

                var pnt = int.Parse(Session["Puntaje"].ToString());
                if (pnt != -1)
                    res.Calificación = pnt;
                else
                {
                    lblError.Text = "Eliga un puntaje del producto";
                    return;
                }
                    


                if (logr.agregarReseña(res))
                {
                    Productos prod = new Productos();
                    prod.IdProducto = (int)Session[Globales.prodDetalle];

                    cargadoReseñas(prod);
                    lblVacio.Text = "";
                    txtReseña.Text = "";

                }
            }
            else
                lblError.Text = "Para agregar reseña debe estar iniciado sesión";
        }
       


        private void Estrellas(string nro, DataListItemEventArgs e)
        {
            switch (nro)
            {
                case "1":
                    ((LinkButton)e.Item.FindControl("lb1")).Visible = true;
                    break;
                case "2":
                    ((LinkButton)e.Item.FindControl("lb1")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb2")).Visible = true;
                    break;
                case "3":
                    ((LinkButton)e.Item.FindControl("lb1")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb2")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb3")).Visible = true;
                    break;
                case "4":
                    ((LinkButton)e.Item.FindControl("lb1")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb2")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb3")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb4")).Visible = true;
                    break;
                case "5":
                    ((LinkButton)e.Item.FindControl("lb1")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb2")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb3")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb4")).Visible = true;
                    ((LinkButton)e.Item.FindControl("lb5")).Visible = true;
                    break;
            }
        }

        private void vaciadoStar()
        {
            str1.ForeColor = System.Drawing.Color.Gray;
            str2.ForeColor = System.Drawing.Color.Gray;
            str3.ForeColor = System.Drawing.Color.Gray;
            str4.ForeColor = System.Drawing.Color.Gray;
            str5.ForeColor = System.Drawing.Color.Gray;
        }

        protected void dlResenias_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            var lbl = (Label)e.Item.FindControl("lblCalificacion");
            Estrellas(lbl.Text, e);
        }

        protected void str1_Click(object sender, EventArgs e)
        {
            Session["Puntaje"] = 1;
            vaciadoStar();
            str1.ForeColor = System.Drawing.Color.Gold;
        }

        protected void str2_Click(object sender, EventArgs e)
        {
            Session["Puntaje"] = 2;
            vaciadoStar();
            str1.ForeColor = System.Drawing.Color.Gold;
            str2.ForeColor = System.Drawing.Color.Gold;
        }

        protected void str3_Click(object sender, EventArgs e)
        {
            Session["Puntaje"] = 3;
            vaciadoStar();
            str1.ForeColor = System.Drawing.Color.Gold;
            str2.ForeColor = System.Drawing.Color.Gold;
            str3.ForeColor = System.Drawing.Color.Gold;
        }

        protected void str4_Click(object sender, EventArgs e)
        {
            Session["Puntaje"] = 4;
            vaciadoStar();
            str1.ForeColor = System.Drawing.Color.Gold;
            str2.ForeColor = System.Drawing.Color.Gold;
            str3.ForeColor = System.Drawing.Color.Gold;
            str4.ForeColor = System.Drawing.Color.Gold;
        }

        protected void str5_Click(object sender, EventArgs e)
        {
            Session["Puntaje"] = 5;
            vaciadoStar();
            str1.ForeColor = System.Drawing.Color.Gold;
            str2.ForeColor = System.Drawing.Color.Gold;
            str3.ForeColor = System.Drawing.Color.Gold;
            str4.ForeColor = System.Drawing.Color.Gold;
            str5.ForeColor = System.Drawing.Color.Gold;
        }
    }
}