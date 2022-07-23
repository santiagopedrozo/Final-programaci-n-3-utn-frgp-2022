<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="Vistas.Registrarse" %>

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
        .auto-style25 {
            width: 270px;
            height: 26px;
        }
        .auto-style17 {
            height: 26px;
            font-size: small;
            width: 691px;
        }
        .auto-style39 {
            font-size: large;
            height: 26px;
            width: 242px;
        }
        .auto-style40 {
            width: 1380px;
            text-align: center;
        }
        .auto-style41 {
            text-align: center;
            width: 753px;
            height: 26px;
        }
        .auto-style42 {
            text-align: center;
            width: 614px;
            height: 26px;
        }
        .auto-style43 {
            width: 574px;
            height: 26px;
        }
        .auto-style44 {
            --bs-navbar-padding-x: 0;
            --bs-navbar-padding-y: 0.5rem;
            --bs-navbar-color: rgba(0, 0, 0, 0.55);
            --bs-navbar-hover-color: rgba(0, 0, 0, 0.7);
            --bs-navbar-disabled-color: rgba(0, 0, 0, 0.3);
            --bs-navbar-active-color: rgba(0, 0, 0, 0.9);
            --bs-navbar-brand-padding-y: 0.3125rem;
            --bs-navbar-brand-margin-end: 1rem;
            --bs-navbar-brand-font-size: 1.25rem;
            --bs-navbar-brand-color: rgba(0, 0, 0, 0.9);
            --bs-navbar-brand-hover-color: rgba(0, 0, 0, 0.9);
            --bs-navbar-nav-link-padding-x: 0.5rem;
            --bs-navbar-toggler-padding-y: 0.25rem;
            --bs-navbar-toggler-padding-x: 0.75rem;
            --bs-navbar-toggler-font-size: 1.25rem;
            --bs-navbar-toggler-icon-bg: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%280, 0, 0, 0.55%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            --bs-navbar-toggler-border-color: rgba(0, 0, 0, 0.1);
            --bs-navbar-toggler-border-radius: 0.375rem;
            --bs-navbar-toggler-focus-width: 0.25rem;
            --bs-navbar-toggler-transition: box-shadow 0.15s ease-in-out;
            position: relative;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            width: 1340px;
            left: 0px;
            top: 0px;
            height: 57px;
        }
    </style>
</head>
<body style="height: 344px; width: 1073px;overflow-y:visible; background-image:url(https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixlib=rb-1.2.1&w=1080&fit=max&q=80&fm=jpg&crop=entropy&cs=tinysrgb);background-size:100%;background-repeat:no-repeat;">
    <form id="form1" runat="server">
        
        <div class="auto-style44" style="background-color: #e3f2fd; margin-right:30px;margin-left:30px; border-radius:20px;margin-top:10px;">
         <table class="auto-style40">
            <tr>
                <td class="auto-style39">
                    &nbsp;<asp:ImageButton ID="imgBtn_Logo" runat="server" Width="83px" Height="51px" ImageUrl="~/ImagenesHeader/Logo.png" OnClick="imgBtn_Logo_Click" formnovalidate/>
                </td>
                <td class="auto-style42">
                    <asp:Label ID="lblNombreUsuario" runat="server"></asp:Label>
                </td>
                <td class="auto-style41">
                    &nbsp;</td>
                <td class="auto-style17">
                    <asp:HyperLink ID="hlUsuario" runat="server" ForeColor="Black">[hlUsuario]</asp:HyperLink>
                </td>
                <td class="auto-style43">
                    &nbsp;</td>
                <td class="auto-style25">
                    <asp:ImageButton ID="imgBtn_Carrito" runat="server" Width="45px" style=";" ImageUrl="~/ImagenesHeader/changuito.png" formnovalidate/>
                </td>
            </tr>
        </table>
            </div>

            <div class="card text-center" style="margin-left:440px;margin-right:100px;margin-top:100px; left: -1px; top: -30px;">
                <div class="card-header">
                    Registro </div>
                <div class="card-body font-monospace" style="background-color: #e3f2fd;" >
                    <div class="form-floating mb-3">
                        <input id="txtNombre" runat="server" class="form-control" placeholder="name@example.com" type="text" required />
                        <label for="floatingInput" style="siz">
                        Nombre</label>
                    </div>

                   <div class="form-floating mb-3">
                        <input id="txtApellido" runat="server" class="form-control" placeholder="name@example.com"  type="text" required/>
                        <label for="floatingInput" style="siz">
                        Apellido</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input id="txtDni" runat="server" class="form-control" placeholder="name@example.com" type="number" required />
                        <label for="floatingInput" style="siz">
                        DNI</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input id="txtEmail" runat="server" class="form-control" placeholder="name@example.com" type="email" required />
                        <label for="floatingInput" style="siz">
                        Email</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input id="txtContra" runat="server" class="form-control" placeholder="name@example.com" type="password" required/>
                        <label for="floatingInput" style="siz">
                        Contraseña</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input id="txtConfirmarContra" runat="server" class="form-control" placeholder="name@example.com" type="password" required />
                        <label for="floatingInput" style="siz">
                        Confirmar Contraseña</label>
                    </div>

                    <br />
                        <asp:Button ID="btnRegistrarse" runat="server" Text="Registrarse" Width="149px" OnClick="btnRegistrarse_Click" CssClass="btn btn-primary" />
                </div>
                <div class="card-footer text-muted">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </div>

        </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:CompareValidator ID="cvContras" runat="server" ControlToCompare="txtContra" ControlToValidate="txtConfirmarContra" Font-Bold="True" Font-Size="X-Large" ForeColor="Red">Las contraseñas no coinciden!</asp:CompareValidator>
            <br />
    </form>
</body>
</html>
