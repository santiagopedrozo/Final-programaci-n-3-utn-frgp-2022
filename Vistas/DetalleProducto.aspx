<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleProducto.aspx.cs" Inherits="Vistas.DetalleProducto" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title></title>  
    
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 465px;
        }
        .auto-style2 {
            width: 161px;
        }
        .auto-style3 {
            width: 140px;
            text-align: right;
        }
        .auto-style5 {
            width: 333px;
        }
        .auto-style6 {
            width: 332px;
        }
        .auto-style7 {
            width: 333px;
            text-align: center;
        }
        .auto-style8 {
            font-size: x-large;
        }
        .auto-style9 {
            font-size: medium;
        }
        .auto-style13 {
            font-size: large;
        }
        .auto-style14 {
            font-size: small;
        }
        .auto-style15 {
            width: 89px;
            text-align: center;
        }
        .auto-style16 {
            text-align: center;
        }
        .auto-style17 {
            width: 332px;
            text-align: center;
        }
        .auto-style18 {
            width: 333px;
            text-align: left;
            height: 42px;
        }
        .auto-style19 {
            width: 847px;
            text-align: left;
        }
        .auto-style20 {
            width: 333px;
            text-align: left;
            height: 30px;
        }
        .auto-style21 {
            width: 332px;
            text-align: left;
            height: 30px;
        }
        .auto-style22 {
            width: 333px;
            height: 34px;
        }
        .auto-style23 {
            width: 332px;
            height: 34px;
        }
        .auto-style24 {
            width: 332px;
            text-align: left;
            height: 42px;
        }
        .auto-style25 {
            width: 333px;
            height: 23px;
        }
        .auto-style26 {
            width: 332px;
            height: 23px;
        }
        .auto-style27 {
            width: 100px;
            text-align: center;
        }
    </style>
</head>
<body style="background-image: url(https://static.vecteezy.com/system/resources/previews/007/113/054/non_2x/cream-color-brick-wall-texture-background-grunge-brickwork-for-your-design-backdrop-free-photo.jpg);background-size:cover;">
    <form id="form1" runat="server">
       <div class="navbar" style="background-color: #e3f2fd; margin-right:30px;margin-left:30px; border-radius:20px;margin-top:10px;">
        <table class="auto-style19">
            <tr>
                <td class="auto-style2">
                    <asp:ImageButton ID="imgBtn_Logo" runat="server" Width="93px" Height="61px" ImageUrl="~/ImagenesHeader/Logo.png" OnClick="imgBtn_Logo_Click1" />
                </td>
                <td class="auto-style15">&nbsp;</td>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style15"><strong>
                    <asp:HyperLink ID="hlPerfil" runat="server" NavigateUrl="~/MiPerfil.aspx">Perfil</asp:HyperLink>
                    </strong></td>
                <td class="auto-style16">&nbsp;</td>
                <td class="auto-style3">
                    <asp:ImageButton ID="imgBtn_Carrito" runat="server" CssClass="auto-style17" Height="50px" Width="43px" ImageUrl="~/ImagenesHeader/changuito.png" OnClick="imgBtn_Carrito_Click" />
                </td>
            </tr>
        </table>
        </div>
        <table class="auto-style1">
            <tr>
                <td class="auto-style22"></td>
                <td class="auto-style23">&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7">
                    <asp:Image ID="imgProducto" runat="server" Height="250px" Width="250px" />
                </td>
                <td class="auto-style6">
                    <asp:Label ID="lblNombreProducto" runat="server" CssClass="auto-style8"></asp:Label>
                    <br />
                    <asp:Label ID="lblCategoria" runat="server" CssClass="auto-style9"></asp:Label>
                    &nbsp;&gt;
                    <asp:Label ID="lblSubCategoria" runat="server" CssClass="auto-style9"></asp:Label>
                    <br />
                    <br />
                    <span class="auto-style8">$</span><asp:Label ID="lblPrecio" runat="server" CssClass="auto-style13"></asp:Label>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style6">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar al carrito" Width="201px" OnClick="btnAgregar_Click" />
                </td>
            </tr>
            <tr>
                <td class="auto-style25"></td>
                <td class="auto-style26"></td>
            </tr>
            <tr>
                <td class="auto-style18">
                    <asp:Label ID="lblVacio" runat="server" Text="Este producto no cuenta con reseñas" Visible ="false"></asp:Label>
                </td>
                <td class="auto-style24">
                    <asp:Label ID="lblDescripcion" runat="server" CssClass="auto-style13"></asp:Label>
                </td>
            </tr>
            <tr>
                <div id="AgregarReseñaDiv" runat="server">
                <td class="auto-style20">
                    <strong>
                    <asp:Label ID="lblAgregarReseña" runat="server" CssClass="auto-style13" Text="Agregar reseña"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtReseña" runat="server" Height="42px" Width="299px" ValidationGroup="reseña"></asp:TextBox>
                    <br />
                    </strong>
                    <asp:RequiredFieldValidator ID="rfvReseña" runat="server" ControlToValidate="txtReseña" CssClass="auto-style14" ErrorMessage="campo reseña vacio" ValidationGroup="reseña"></asp:RequiredFieldValidator>
                    <strong>
                    <br />
                    calificación (0-5): <asp:TextBox ID="txtPuntuacion" runat="server" TextMode="Number" Width="52px" ValidationGroup="reseña"></asp:TextBox>
                    <br />
&nbsp;</strong><asp:RangeValidator ID="rvPuntuacion" runat="server" ControlToValidate="txtPuntuacion" ErrorMessage="ingresar entre 0 y 5" MaximumValue="5" MinimumValue="0" ValidationGroup="reseña" CssClass="auto-style14"></asp:RangeValidator>
                    <strong>
                    <br />
                    </strong>
                    <asp:RequiredFieldValidator ID="rfvCalificacion" runat="server" ControlToValidate="txtPuntuacion" CssClass="auto-style14" ErrorMessage="Campo puntuación vacio" ValidationGroup="reseña"></asp:RequiredFieldValidator>
                    <strong>
                    <br />
                    <br />
                    <asp:Button ID="btnEnviarReseña" runat="server" Text="Enviar Reseña" ValidationGroup="reseña" OnClick="btnEnviarReseña_Click" style="height: 26px" OnClientClick="return confirm('¿Esta seguro que quiere agregar la reseña?')"/>
                    <br />
                    <br />
                    <asp:Label ID="lblErrorReseña" runat="server"></asp:Label>
                    </strong>
                </td>
                </div>
                <td class="auto-style21">
                    <asp:DataList ID="dlResenias" runat="server">
                        <ItemTemplate>
                            Reseña:
                            <asp:Label ID="lblResenia" runat="server" Text='<%# Eval("Contenido_Reseña") %>'></asp:Label>
                            <br />
                            Calificacion:
                            <asp:Label ID="lblCalificacion" runat="server" Text='<%# Eval("Calificacion_Reseña") %>'></asp:Label>
                            <br />
                            Fecha:
                            <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha_Reseña") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
                
            </tr>
        </table>
    </form>
</body>
</html>

