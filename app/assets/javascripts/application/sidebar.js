// alert('sidebar')

let menuItem = document.getElementById('menuLink1');

menuItem.onclick = function (e) {
    let child = e.target.closest(".pure-menu-children")

    if (child) {
        child.nextElementSibling.classList.toggle("open");
    }
}