class RecuperarClave < ActionMailer::Base
  default from: "HayUnCamino@gmail.com"

  def recuperar_clave_usuario(user)
   @usuario=user
   mail(:to => user.correo, :subject => "Recuperacion de clave HayUnCamino")
  end
end
