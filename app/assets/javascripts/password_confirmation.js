var password = document.getElementById("user_password")
  , confirm_password = document.getElementById("user_password_confirmation");

function validatePassword(){
  if(password.value != confirm_password.value) {
    user_password_confirmation.setCustomValidity("Passwords Don't Match");
  } else {
    user_password_confirmation.setCustomValidity('');
  }
}

user_password.onchange = validatePassword;
user_password_confirmation.onkeyup = validatePassword;
