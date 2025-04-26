CLASS zcl_ztest_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_ztest_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.

    METHODS sflightset_get_entity
        REDEFINITION .

    METHODS sflightset_create_entity
        REDEFINITION .

  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZTEST_DPC_EXT IMPLEMENTATION.

  METHOD sflightset_get_entity.
    IF it_key_tab IS NOT INITIAL.
      DATA(lv_carrid) = it_key_tab[ name = 'Carrid' ]-value.
      DATA(lv_connid) = it_key_tab[ name = 'Connid' ]-value.
      DATA(lv_fldate) = it_key_tab[ name = 'Fldate' ]-value.
      SELECT SINGLE *
      FROM sflight
      WHERE carrid = @lv_carrid
        AND connid = @lv_connid
        AND fldate = @lv_fldate
      INTO @er_entity.
    ENDIF.
  ENDMETHOD.

  METHOD sflightset_create_entity.
    DATA lw_entity TYPE zcl_ztest_mpc_ext=>ts_flight.
    TRY.
      io_data_provider->read_entry_data( IMPORTING es_data = lw_entity ).
      INSERT INTO sflight VALUES lw_entity.
    CATCH /iwbep/cx_mgw_tech_exception.
    ENDTRY.
  ENDMETHOD.


ENDCLASS.
