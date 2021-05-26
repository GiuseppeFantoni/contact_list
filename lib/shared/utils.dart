String verifyError(error) {
  var errorMessage = '';

  switch (error) {
    case "invalid-email":
      errorMessage = "Formato de email inválido";
      break;
    case "unknown":
      errorMessage = "Porfavor, verifique o email e senha";
      break;
    case "user-not-found":
      errorMessage = "Usuario não encontrado, crie sua conta";
      break;
    case "wrong-password":
      errorMessage = "Senha inválida";
      break;
  }
  return errorMessage;
}

String verifyErrorCreatAccount(error) {
  var errorMessage = '';
  switch (error) {
    case "email-already-in-use":
      errorMessage = "O email inserido já está em uso";
      break;
    case "weak-password":
      errorMessage = "A senha deve conter no mínimo 6 dígitos";
      break;
    case "invalid-email":
      errorMessage = "Formato de email inválido";
      break;
    case "unknown":
      errorMessage =
          "Porfavor, verifique os campos foram inseridos corretamente";
      break;
  }
  return errorMessage;
}
