<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="HomeMp.aspx.cs" Inherits="Vistas.HomeMp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/3c33daaf69.js" crossorigin="anonymous"></script>   
    <link href="EstilosCssVistas/homeMain.css" rel="stylesheet" />
    <link href="EstilosCssVistas/Filtros.css" rel="stylesheet" />
    <link href="EstilosCssVistas/Buscadorr.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            
        <div class="HeaderBuscador">
            <ul >
                <li><asp:TextBox ID="txtBusqueda" runat="server" Width="350px" height="28px" placeholder="Buscador"></asp:TextBox></li>
                <li><asp:LinkButton ID="lbBuscar" CssClass="LogosBuscador" runat="server" text="<i class='fa-solid fa-magnifying-glass'></i>" OnClick="lbBuscar_Click" ></asp:LinkButton></li>
            </ul>
        </div>
    
        <div class="main">
            <div class="Filtros">
                <div class="precios">
                    <h5>Rango Precios</h5>
                    <div class="preciosBloque">
                        <asp:TextBox CssClass="prBlock" ID="txtMinimo" runat="server" Width="83px" TextMode="Number" placeholder="Mínimo"></asp:TextBox>
                        <asp:TextBox CssClass="prBlock" ID="txtMaximo" runat="server" Width="83px" TextMode="Number" placeholder="Máximo"></asp:TextBox>
                        <asp:LinkButton ID="LinkButton1" CssClass="prBlock" runat="server" text="<i class='fa-solid fa-magnifying-glass'></i>" OnClick="lbBuscar_Click" ></asp:LinkButton>
                    </div>
                </div>

                <div class="categorias">
                    <h5>Categorías</h5>
                    <asp:DropDownList ID="ddlCategorias" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategorias_SelectedIndexChanged"  Width="180px"> </asp:DropDownList>
                </div>

                <div ID="SubCatDiv" class="Subcategorias" runat="server" visible="false"> 
                    <h5>SubCategorías</h5>
                    <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSubCat_SelectedIndexChanged" Width="180px" > </asp:DropDownList> <br />
                </div>
                        
                <asp:Button ID="btnQuitar" runat="server" OnClick="btnQuitar_Click" Text="Quitar filtros"  CssClass="btn btn-primary" />               
            </div>

            <div class="ProdDiv" >
                <div ID="MsgErrorRsniaDiv" class="alert alert-danger" runat="server" visible="false"  >
                    <strong>Error</strong> 
                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                
                <asp:ListView ID="lvProductos" runat="server"  GroupItemCount="3" >
                    <EmptyDataTemplate>
                        
                    </EmptyDataTemplate>

                    <EmptyItemTemplate>
                        <td runat="server" />
                    </EmptyItemTemplate>

                    <GroupTemplate>
                        <tr id="itemPlaceholderContainer" runat="server">
                            <td id="itemPlaceholder" runat="server"></td>
                        </tr>
                    </GroupTemplate>

                    <ItemTemplate>
                        <td runat="server" class="ItemTemplate">
                            <ul >
                                <div class="Nombre">
                                    <li><asp:Label ID="Nombre_ProductoLabel" cssclass="NombreText" runat="server" Text='<%# Eval("Nombre_Producto") %>' width="70%" Font-Size="13px"></asp:Label></li>
                                </div>
                                <li><asp:ImageButton ID="imgProducto" cssclass="img" runat="server" Height="120px" ImageUrl='<%# Eval("UrlImagen_Producto") %>' Width="120px"  CommandArgument='<%# Eval("Id_Producto") %>' CommandName="seleccionProductoDetalle" OnCommand="imgProducto_Command" /></li>
                                <li>
                                    <span>$</span>
                                    <asp:Label ID="lblPrecio" cssclass="text" runat="server" Text='<%# Eval("Precio_Producto") %>'  />
                                </li>
                                <li><asp:Button ID="lbAgregarAlCarrito" CssClass="Boton" runat="server" CommandArgument='<%# Eval("Id_Producto") %>' CommandName="ProductoCarrito" OnCommand="btnAgregarAlCarrito_Command" text="Agregar al carrito" OnClick="lbBuscar_Click" ></asp:Button></li>
                            </ul>
                        </td>
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
                        </table>
                    </LayoutTemplate>
            </asp:ListView>
        </div>
</div>
</asp:Content>
