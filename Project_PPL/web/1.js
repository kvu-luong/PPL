$(function () {
    //logo animation
    new WOW().init();
    //scroll header
    $(window).on('scroll', function () {
        var scrollTop = $(window).scrollTop();
        if (scrollTop > 50) {
            $('.navbar-fixed-top').stop().animate({height: "60px"}, 200);
            $('.navbar-nav > li > .dropdown-menu').css("margin-top", "-2px");
        } else {
            $('.navbar-fixed-top').stop().animate({height: "74px"}, 200);
            $('.navbar-nav > li > .dropdown-menu').css("margin-top", "12px");
        }
    });

});

function checkDoctorForm() {
    let doctor = $("#searchDoctor").val();
    console.log(doctor + " value");
    if (doctor === "") {
        alert("Please input doctor that you want to search");
        return false;
    }
}

function validateFormPatient() {
    let  firstName = document.forms["patient"]["firstName"].value;
    let lastName = document.forms["patient"]["lastName"].value;
    let gender = document.forms["patient"]["gender"].value;
    let email = document.forms["patient"]["email"].value;
    let password = document.forms["patient"]["password"].value;
    let confirmPass = document.forms["patient"]["passwordConfirm"].value;

    if(email == ""){
        alert("Please fill your email address!--");
        return false;
    }
    
    let iChars = "~`!#$%^&*+=-[]\\\';,/{}|\":<>?";
    if (firstName != "") {
        for (let index = 0; index < firstName.length; index++) {
            for (let i = 0; i < iChars.length; i++) {
                if (firstName.charAt(index) === iChars.charAt(i)) {
                    alert("First name should not contain special character!");
                    return false;
                }
            }
        }
    } else {
        alert("Please input your first name!");
        return false;
    }
    if (firstName.length > 20) {
        alert("The length of first name should not large than 20.");
        return false;
    }
    //check last name
    if (lastName != "") {
        for (let index = 0; index < lastName.length; index++) {
            for (let i = 0; i < iChars.length; i++) {
                if (lastName.charAt(index) === iChars.charAt(i)) {
                    alert("Last name should contain special character!");
                    return false;
                }
            }
        }
    } else {
        alert("Please input your last name!");
        return false;
    }
    if (lastName.length > 20) {
        alert("The length of last name should not large than 20.");
        return false;
    }
    if (gender == "") {
        alert("You should select gender");
        return false;
    }
    if (password != confirmPass) {
        alert("Password and confirm pass must be the same");
        return false;
    }

}
function validateFormHospital(){
    let firstName = $("#name").val();
    let adminName = document.forms["hospital"]["adminNameH"].value;
    let email = document.forms["hospital"]["emailH"].value;
    let password = document.forms["hospital"]["passwordH"].value;
    let confirmPass = document.forms["hospital"]["passwordConfirmH"].value;

    if(email == ""){
        alert("Please fill in email address!");
        return false;
    }
    if(password == ""){
        alert ("Password can't be empty");
        return false;
    }
    if(confirmPass == ""){
        alert("Confirm password can't be empty");
        return false;
    }
      if (password != confirmPass) {
        alert("Password and confirm pass must be the same");
        return false;
    }
    let iChars = "~`!#$%^&*+=-[]\\\';,/{}|\":<>?";
    if (firstName != "") {
        for (let index = 0; index < firstName.length; index++) {
            for (let i = 0; i < iChars.length; i++) {
                if (firstName.charAt(index) === iChars.charAt(i)) {
                    alert("First name should not contain special character!");
                    return false;
                }
            }
        }
    } else {
        alert("Please input your first name!");
        return false;
    }
    if (adminName != "") {
        for (let index = 0; index < adminName.length; index++) {
            for (let i = 0; i < iChars.length; i++) {
                if (adminName.charAt(index) === iChars.charAt(i)) {
                    alert("Admin name should not contain special character!");
                    return false;
                }
            }
        }
    } else {
        alert("Please input your admin name!");
        return false;
    }
    
}
$(document).ready(function () {
 //check mail exits or not
                    $("#ckmail").click(function () {
                         let email = $("#email").val();
                         let table = $("#table").val();
                         console.log(email +"--"+table);
                        checkmail(email, table);
                    });
                    $("#ckmailHospital").click(function () {
                         let email = $("#emailHospital").val();
                         let table = $("#tableHospital").val();
                         console.log(email +"--"+table);
                        checkmail(email, table);
                    });
                    function checkmail(email, table)
                    {
                        console.log(email);
                        if (email)
                        {
                            $.ajax({
                                type: 'get',
                                url: '../UserServlet',
                                data: {
                                    email_atr: email,
                                    table: table,
                                    action: "checkmail"
                                },
                                success: function (response) {
                                    let result = $.trim(response);
                                    if (result === "no") {
                                        $("#checkshowHospital").html("Can't use it");
                                        $("#emailHospital").val(" ");
                                        //for register patient
                                        $("#checkshow").html("Can't use it");
                                        $("#email").val(" ");
                                        return false;
                                    } else {
                                        $("#checkshowHospital").html("OK");
                                        //for register patient
                                        $("#checkshow").html("OK");
                                    }
                                }
                            });
                        }
                    }

});
 