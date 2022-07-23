<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="iniciarSesion.aspx.cs" Inherits="Vistas.iniciarSesion" %>

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
        .auto-style5 {
            text-align: center;
            width: 139px;
            height: 53px;
        }
        .auto-style14 {
            width: 25%;
            height: 53px;
        }
        .auto-style15 {
            text-align: right;
            width: 214px;
            height: 53px;
        }
        .auto-style16 {
            text-align: center;
            width: 281px;
            height: 53px;
        }
        .auto-style17 {
            text-align: center;
            width: 271px;
            height: 53px;
        }
    </style>
</head>
<body style="background-image: url(https://wallpapercave.com/wp/wp9764093.jpg);background-size:100%;background-repeat:no-repeat; overflow-y:hidden;">
    <form id="form1" runat="server">
        <div class="navbar" style="background-color: #e3f2fd; margin-right:30px;margin-left:30px; border-radius:20px;margin-top:10px;">
         <table class="auto-style18">
            <tr>
                <td class="auto-style14">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtn_Logo" runat="server" Width="90px" Height="66px" ImageUrl="~/ImagenesHeader/Logo.png" OnClick="imgBtn_Logo_Click" />
                </td>
                <td class="auto-style5">
                    <asp:Label ID="lblNombreUsuario" runat="server"></asp:Label>
                </td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td class="auto-style17">
                    &nbsp;</td>
                <td class="auto-style16">
                    <asp:HyperLink ID="hlUsuario" runat="server" ForeColor="Black">[hlUsuario]</asp:HyperLink>
                </td>
                <td class="auto-style15">
                    <asp:ImageButton ID="imgBtn_Carrito" runat="server" Width="45px" style=";" ImageUrl="~/ImagenesHeader/changuito.png" OnClick="imgBtn_Carrito_Click" />
                </td>
            </tr>
        </table>
            </div>
        
            <div class="card text-center" style="margin-left:320px;margin-right:320px;margin-top:100px;">
              <div class="card-header">
                Loggeo
              </div>
              <div class="card-body font-monospace" style="background-color: #e3f2fd;">
                        
                       <div class="form-floating mb-3">
                          <input type="email" class="form-control" id="floatingInput" runat="server" placeholder="name@example.com">
                          <label for="floatingInput" style="siz">Direccion Email</label>
                        </div>
                        <div class="form-floating">
                          <input type="password" class="form-control" id="floatingPassword" runat="server" placeholder="Password">
                          <label for="floatingPassword">Contraseña</label>
                       </div>
                    
                     <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" OnClick="btnIngresar_Click" CssClass="btn btn-primary" style="margin-top:20px;"/>
              </div>
              <div class="card-footer text-muted">
                <asp:Label ID="lblRegistrarse" runat="server" Text="¿no tienes cuenta? Regístrate " CssClass="font-monospace"></asp:Label>
                <asp:HyperLink ID="hlRedireccionRegistro" runat="server" CssClass="font-monospace" ForeColor="Black" NavigateUrl="~/Registrarse.aspx">aquí</asp:HyperLink>
              </div>
            </div>

        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
    </form>
</body>
</html>
