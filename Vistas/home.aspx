<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Vistas.home" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
 <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <style type="text/css">
        .auto-style1 {
            width: 1266px;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            font-size: medium;
        }
        .auto-style4 {
            font-size: large;
        }
        .auto-style6 {
            text-align: center;
            width: 98px;
        }
        .auto-style7 {
            text-align: center;
            width: 120px;
        }
        .auto-style8 {
            width: 100%;
        }
        .auto-style29 {
            height: 233px;
            width: 508px;
            text-align: center;
        }
        .auto-style34 {
            font-size: small;
        }
        .auto-style38 {
            height: 382px;
        }
        .auto-style48 {
            text-align: center;
            width: 744px;
        }
        .auto-style49 {
            text-align: center;
            width: 115px;
        }
        .auto-style51 {
            text-align: center;
            width: 115px;
            height: 59px;
        }
        .auto-style52 {
            text-align: center;
            width: 744px;
            height: 59px;
        }
        .auto-style53 {
            text-align: center;
            width: 120px;
            height: 59px;
        }
        .auto-style54 {
            text-align: center;
            width: 98px;
            height: 59px;
        }
        .auto-style55 {
            font-size: medium;
            height: 59px;
        }
    </style>
</head>
<body style="overflow-y:visible; background-image:url(https://static.vecteezy.com/system/resources/previews/007/162/580/original/gradient-abstract-background-smooth-soft-and-warm-bright-tender-blue-cian-violet-gradient-for-app-web-design-web-pages-banners-greeting-cards-illustration-design-free-vector.jpg);background-size:100%;background-repeat:no-repeat;">
    <form id="form1" runat="server" class="auto-style38">
        
<div class="auto-style44" style="background-color: #e3f2fd; margin-right:30px;margin-left:30px; border-radius:20px;margin-top:10px;">

            <table class="auto-style1">
            <tr>
                <td class="auto-style51">
                    <asp:ImageButton ID="imgBtn_Logo" runat="server" Width="82px" Height="74px" ImageUrl="~/ImagenesHeader/Logo.png" />
                </td>
                <td class="auto-style51">
                    <asp:Label ID="lblNombreUsuario" runat="server"></asp:Label>
                    <br />
                    <strong>
                    <asp:HyperLink ID="hlFuncionesAdmin" runat="server" NavigateUrl="~/Admin.aspx" Visible="False">Funciones Admin</asp:HyperLink>
                    <br />
                    <asp:HyperLink ID="hlReporteVentas" runat="server" EnableViewState="False" NavigateUrl="~/Reportess.aspx" Visible="False">Reporte ventas</asp:HyperLink>
                    </strong>
                </td>
                <td class="auto-style52"><strong>
                    <asp:Label ID="lblBuscar" runat="server" CssClass="auto-style4" Text="Buscar articulo: "></asp:Label>
                    </strong>
                    <asp:TextBox ID="txtBusqueda" runat="server" Width="145px"></asp:TextBox>
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" Width="74px" OnClick="btnBuscar_Click" CssClass="btn btn-primary"/>
                    <strong>&nbsp;&nbsp;
                    <asp:Button ID="btnQuitar" runat="server" OnClick="btnQuitar_Click" Text="Quitar filtros" Width="125px" CssClass="btn btn-primary"/>
                    </strong>
                </td>
                <td class="auto-style53"></td>
                <td class="auto-style54"><strong>
                    <asp:HyperLink ID="hlUsuario" runat="server">[hlUsuario]</asp:HyperLink>
                    <br />
                    </strong>
                    <asp:LinkButton ID="lbCerrarSesion" runat="server" OnClick="lbCerrarSesion_Click" OnClientClick="return confirm('¿Esta seguro que quiere cerrar sesión?')" Visible="False">Cerrar sesión</asp:LinkButton>
                </td>
                <td class="auto-style55">
                    <asp:ImageButton ID="imgBtn_Carrito" runat="server" Height="59px" Width="75px" OnClick="imgBtn_Carrito_Click" ImageUrl="~/ImagenesHeader/changuito.png" />
                </td>

            </tr>
            <tr>
                <td class="auto-style49">
                    &nbsp;</td>
                <td class="auto-style49">
                    <asp:Label ID="lblIniciarSesion" runat="server"></asp:Label>
                </td>
                <td class="auto-style48">
                    <strong>
                    <asp:Label ID="lblPrecio3" runat="server" Text="Precio" CssClass="auto-style4"></asp:Label>
                    </strong>
                    <br />
                    <asp:TextBox ID="txtMinimo" runat="server" Width="80px" TextMode="Number" placeholder="Mínimo"></asp:TextBox>
&nbsp;&nbsp;
                    <asp:TextBox ID="txtMaximo" runat="server" Width="80px" TextMode="Number" placeholder="Máximo"></asp:TextBox>
                &nbsp;</td>
                <td class="auto-style7"><strong>
                    <br />
                    </strong></td>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style3">
                    &nbsp;</td>
            </tr>
        </table>
        
    </div>

        <table class="auto-style8">
            <tr>
                <td class="auto-style29">
                    
               
                    
                    <br />
               
                    
                    <%--<asp:Button ID="btnCategorias" runat="server" CommandArgument='<%# Eval("Id_Categoria") %>'  Text='<%# Eval("Descripcion_Categoria") %>' Width="189px" CommandName="CategoriaSeleccionada" OnCommand="btnCategorias_Command"/>
                                --%>
                    <div style="margin-right:20px">
                    <strong>
                    <asp:DropDownList ID="ddlCategorias" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategorias_SelectedIndexChanged" style="text-align:center;">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSubCat_SelectedIndexChanged" style="margin-right:-80px">
                    </asp:DropDownList>
                    </strong>
                    </div>

                    <div class="auto-style2" style="margin-left:295px;">
                    
                    <asp:ListView ID="lvProductos" runat="server"  GroupItemCount="3" OnPagePropertiesChanging="lvProductos_PagePropertiesChanging" >
                        <EditItemTemplate>
                            <td runat="server" style="background-color: #ffffff;">Nombre_Producto:
                                <asp:TextBox ID="Nombre_ProductoTextBox" runat="server" Text='<%# Bind("Nombre_Producto") %>' />
                                <br />Precio_Producto:
                                <asp:TextBox ID="Precio_ProductoTextBox" runat="server" Text='<%# Bind("Precio_Producto") %>' />
                                <br />UrlImagen_Producto:
                                <asp:TextBox ID="UrlImagen_ProductoTextBox" runat="server" Text='<%# Bind("UrlImagen_Producto") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                                <br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                                <br /></td>
                        </EditItemTemplate>

                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                <tr>
                                    <td>No se han devuelto datos.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>

                        <EmptyItemTemplate>
                            <td runat="server" />
                        </EmptyItemTemplate>

                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>

                        <InsertItemTemplate>
                            <td runat="server" style="">Nombre_Producto:
                                <asp:TextBox ID="Nombre_ProductoTextBox" runat="server" Text='<%# Bind("Nombre_Producto") %>' />
                                <br />Precio_Producto:
                                <asp:TextBox ID="Precio_ProductoTextBox" runat="server" Text='<%# Bind("Precio_Producto") %>' />
                                <br />UrlImagen_Producto:
                                <asp:TextBox ID="UrlImagen_ProductoTextBox" runat="server" Text='<%# Bind("UrlImagen_Producto") %>' />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                                <br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" />
                                <br /></td>
                        </InsertItemTemplate>

                        <ItemTemplate>
                            <td runat="server" style="background-color: white;color: #333333;" class="auto-style2">&nbsp;<asp:Label ID="Nombre_ProductoLabel" runat="server" Text='<%# Eval("Nombre_Producto") %>' CssClass="auto-style34"></asp:Label>
                                <br />
                                &nbsp;<asp:Label ID="lblPrecio2" runat="server" Text="$ " CssClass="auto-style3"></asp:Label>
                                <asp:Label ID="lblPrecio" runat="server" Text='<%# Eval("Precio_Producto") %>' CssClass="auto-style3" />
                                <br />
                                <br />
                                <asp:ImageButton ID="imgProducto" runat="server" Height="120px" ImageUrl='<%# Eval("UrlImagen_Producto") %>' Width="120px"  CommandArgument='<%# Eval("Id_Producto") %>' CommandName="seleccionProductoDetalle" OnCommand="imgProducto_Command" />
                                <br />
                                &nbsp;<br />
                                <asp:Button ID="btnAgregarAlCarrito" runat="server" Text="Agregar al carrito" Width="160px" CommandArgument='<%# Eval("Id_Producto") %>' CommandName="ProductoCarrito" OnCommand="btnAgregarAlCarrito_Command" Height="34px" CssClass="btn btn-primary"/>
                                <br /></td>
                        </ItemTemplate>

                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                            <tr id="groupPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF">
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>

                        <SelectedItemTemplate>
                            <td runat="server" style="background-color: #E2DED6;font-weight: bold;color: #333333;">Nombre_Producto:
                                <asp:Label ID="Nombre_ProductoLabel" runat="server" Text='<%# Eval("Nombre_Producto") %>' />
                                <br />Precio_Producto:
                                <asp:Label ID="Precio_ProductoLabel" runat="server" Text='<%# Eval("Precio_Producto") %>' />
                                <br />UrlImagen_Producto:
                                <asp:Label ID="UrlImagen_ProductoLabel" runat="server" Text='<%# Eval("UrlImagen_Producto") %>' />
                                <br /></td>
                        </SelectedItemTemplate>

                    </asp:ListView>
                    
                    </div>
                    
                </td>
            </tr>
            </table>
       
    </form>
</body>
</html>
