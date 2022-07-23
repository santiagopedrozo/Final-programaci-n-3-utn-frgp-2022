
function ValidateInsertProd() {
    if (Page_ClientValidate('AgregarProd'))
        return confirm('¿Desea insertar el producto ingresado?');
    
    return false;
}

function ValidateInsertCategoria() {
    if (Page_ClientValidate('AgregarCat'))
        return confirm('¿Desea insertar la categoría ingresada?');

    return false;
}

function ValidateInsertSubCategoria() {
    if (Page_ClientValidate('AgregarSubCat'))
        return confirm('¿Desea insertar la SubCategoría ingresada?');

    return false;
}

function prueba(Mensaje) {
    alert(mensaje);
}

function Confirm() {
    var confirm_value = document.createElement("INPUT");
    confirm_value.type = "hidden";
    confirm_value.name = "confirm_value";
    if (confirm("Do you want to save data?")) {
        confirm_value.value = "Yes";
    } else {
        confirm_value.value = "No";
    }
    document.getElementById("MensajeConfirmacion").value = "hola";
}

function returnString() {
    document.getElementById("MensajeConfirmacion").value = "Tajuddin";
}








