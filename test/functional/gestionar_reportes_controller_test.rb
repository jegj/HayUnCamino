require 'test_helper'

class GestionarReportesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get solicitudes_despachadas" do
    get :solicitudes_despachadas
    assert_response :success
  end

  test "should get solicitudes_pendientes" do
    get :solicitudes_pendientes
    assert_response :success
  end

  test "should get sol_realizadas_cliente" do
    get :sol_realizadas_cliente
    assert_response :success
  end

  test "should get destinos_orde_sol" do
    get :destinos_orde_sol
    assert_response :success
  end

  test "should get facturas_ord_tcan" do
    get :facturas_ord_tcan
    assert_response :success
  end

  test "should get facturas_vig_ven_cobrar" do
    get :facturas_vig_ven_cobrar
    assert_response :success
  end

end
