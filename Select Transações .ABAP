

***** Diego Gozer
***** Deals Tabelas Transação Financeira:





&---------------------------------------------------------------------*
*&      Form  READ_VTBFHA
*&---------------------------------------------------------------------*

form read_vtbfha.

* deal (VTBFHA)
  read table gl_tab_tables with key name = 'VTBFHA'
       into gl_str_tables.
  select * from vtbfha into table gl_tab_vtbfha
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBFHA

*&---------------------------------------------------------------------*
*&      Form  READ_VTBFHAZU
*&---------------------------------------------------------------------*
form read_vtbfhazu.

* activity (VTBFHAZU)
  read table gl_tab_tables with key name = 'VTBFHAZU'
       into gl_str_tables.
  select * from vtbfhazu into table gl_tab_vtbfhazu
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBFHAZU

*&---------------------------------------------------------------------*
*&      Form  READ_VTBFHAPO
*&---------------------------------------------------------------------*
form read_vtbfhapo.

* flows (VTBFHAPO)
  read table gl_tab_tables with key name = 'VTBFHAPO'
       into gl_str_tables.
  select * from vtbfhapo into table gl_tab_vtbfhapo
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBFHAPO

*&---------------------------------------------------------------------*
*&      Form  READ_VTBFHAPO_UNFIXED
*&---------------------------------------------------------------------*
form read_vtbfhapo_unfixed.

* unfixed flows (VTBFHAPO_UNFIXED)
  read table gl_tab_tables with key name = 'VTBFHAPO_UNFIXED'
       into gl_str_tables.
  select * from vtbfhapo_unfixed into table gl_tab_vtbfhapo_unfixed
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBFHAPO_UNFIXED

*&---------------------------------------------------------------------*
*&      Form  READ_VTBFINKO
*&---------------------------------------------------------------------*
form read_vtbfinko.

* condition (VTBFINKO)
  read table gl_tab_tables with key name = 'VTBFINKO'
       into gl_str_tables.
  select * from vtbfinko into table gl_tab_vtbfinko
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBFINKO

*&---------------------------------------------------------------------*
*&      Form  READ_VTBAFINKO
*&---------------------------------------------------------------------*
form read_vtbafinko.

* alternative condition (VTBAFINKO)
  read table gl_tab_tables with key name = 'VTBAFINKO'
       into gl_str_tables.
  select * from vtbafinko into table gl_tab_vtbafinko
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBAFINKO

*&---------------------------------------------------------------------*
*&      Form  READ_VTBKORES
*&---------------------------------------------------------------------*
form read_vtbkores.

* correspondence (VTBKORES)
  read table gl_tab_tables with key name = 'VTBKORES'
       into gl_str_tables.
  select * from vtbkores into table gl_tab_vtbkores
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTBKORES

*&---------------------------------------------------------------------*
*&      Form  READ_VTIFHA
*&---------------------------------------------------------------------*
form read_vtifha.

* shortcut solution deactivated, works only for OTC-Options with 'one' UL
*  select single rfha from vtiof into gl_underlying
*         where orfha = p_rfha.                          "#EC CI_NOFIELD
  select single optnr from vtiof   into gl_optnr
         where orfha = p_rfha.                          "#EC CI_NOFIELD
  select        rfha  from vtiofzu into table gl_tab_underlying
         where optnr = gl_optnr.                        "#EC CI_NOFIELD

* underlying (VTIFHA)
  read table gl_tab_tables with key name = 'VTIFHA'
       into gl_str_tables.

  loop at gl_tab_underlying into gl_underlying.
  select * from vtifha into table gl_tab_vtifha
           where bukrs = p_bukrs
             and rfha  = gl_underlying.
  endloop.
*  gl_str_tables-eintraege = sy-dbcnt.
  DESCRIBE TABLE gl_tab_vtifha lines gl_str_tables-eintraege.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTIFHA

*&---------------------------------------------------------------------*
*&      Form  READ_VTIFHAZU
*&---------------------------------------------------------------------*
form read_vtifhazu.

* underlying activity (VTIFHAZU)
  read table gl_tab_tables with key name = 'VTIFHAZU'
       into gl_str_tables.
  loop at gl_tab_underlying into gl_underlying.
  select * from vtifhazu into table gl_tab_vtifhazu
           where rfha = gl_underlying.
  endloop.
*  gl_str_tables-eintraege = sy-dbcnt.
  DESCRIBE TABLE gl_tab_vtifhazu lines gl_str_tables-eintraege.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTIFHAZU

*&---------------------------------------------------------------------*
*&      Form  READ_VTIFHAPO
*&---------------------------------------------------------------------*
form read_vtifhapo.

* underlying flows (VTIFHAPO)
  read table gl_tab_tables with key name = 'VTIFHAPO'
       into gl_str_tables.
  loop at gl_tab_underlying into gl_underlying.
  select * from vtifhapo into table gl_tab_vtifhapo
           where rfha = gl_underlying.
  endloop.
*  gl_str_tables-eintraege = sy-dbcnt.
  DESCRIBE TABLE gl_tab_vtifhapo lines gl_str_tables-eintraege.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTIFHAPO

*&---------------------------------------------------------------------*
*&      Form  READ_VTIFINKO
*&---------------------------------------------------------------------*
form read_vtifinko.

* underlying condition (VTIFINKO)
  read table gl_tab_tables with key name = 'VTIFINKO'
       into gl_str_tables.
  loop at gl_tab_underlying into gl_underlying.
  select * from vtifinko into table gl_tab_vtifinko
           where rfha = gl_underlying.                  "#EC CI_NOFIRST
  endloop.
*  gl_str_tables-eintraege = sy-dbcnt.
  DESCRIBE TABLE gl_tab_vtifinko lines gl_str_tables-eintraege.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTIFINKO

*&---------------------------------------------------------------------*
*&      Form  READ_VTIAFINKO
*&---------------------------------------------------------------------*
form read_vtiafinko.

* underlying alternative condition (VTIAFINKO)
  read table gl_tab_tables with key name = 'VTIAFINKO'
       into gl_str_tables.
  loop at gl_tab_underlying into gl_underlying.
  select * from vtiafinko into table gl_tab_vtiafinko
           where rfha = gl_underlying.
  endloop.
*  gl_str_tables-eintraege = sy-dbcnt.
    DESCRIBE TABLE gl_tab_vtiafinko lines gl_str_tables-eintraege.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_VTIAFINKO

*&---------------------------------------------------------------------*
*&      Form  READ_TRIAT
*&---------------------------------------------------------------------*
form read_triat.

  data: l_bearer_id  type tb_ira_bearer_id.

* interest adjustment (TRIAT)
  call function 'FTR_IRADJ_TRIA_BEARERID_BUILD'
    EXPORTING
      pi_bukrs    = p_bukrs
      pi_rfha     = p_rfha
    IMPORTING
      pe_bearerid = l_bearer_id
    EXCEPTIONS
      others      = 4.
  if sy-subrc <> 0.
*   don't care
  endif.
  read table gl_tab_tables with key name = 'TRIAT'
       into gl_str_tables.
  select * from triat into table gl_tab_triat
           where bearer_id = l_bearer_id.                "#EC CI_NOFIRST
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_TRIAT

*&---------------------------------------------------------------------*
*&      Form  READ_REFON
*&---------------------------------------------------------------------*
form read_refon.

  data: l_objnr  type refon-objnr.

* references between object numbers (REFON)
  select single objnr from vtbfha into l_objnr
         where bukrs = p_bukrs
           and rfha  = p_rfha.
  call function 'TB_REF_OBJECTS_GET'
    EXPORTING
      imp_objnr = l_objnr
    TABLES
      t_refon   = gl_tab_refon
    EXCEPTIONS
      others    = 0.
* if sy-subrc <> 0.
*   don't care
* endif.
  read table gl_tab_tables with key name = 'REFON'
       into gl_str_tables.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_REFON

*&---------------------------------------------------------------------*
*&      Form  READ_TRDT_TRDBUSTRANS
*&---------------------------------------------------------------------*
form read_trdt_trdbustrans.

* persistent distributor business transaction (TRDT_TRDBUSTRANS)
  read table gl_tab_tables with key name = 'TRDT_TRDBUSTRANS'
       into gl_str_tables.
  select * from trdt_trdbustrans into table gl_tab_trdt_trdbustrans
           where company_code = p_bukrs
             and deal_number  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_TRDT_TRDBUSTRANS

*&---------------------------------------------------------------------*
*&      Form  READ_TRDT_FLOW
*&---------------------------------------------------------------------*
form read_trdt_flow.

* persistent distributor flows (TRDT_FLOW)
  read table gl_tab_tables with key name = 'TRDT_FLOW'
       into gl_str_tables.
  select * from trdt_flow into table gl_tab_trdt_flow
           where company_code = p_bukrs
             and deal_number  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_TRDT_FLOW

*&---------------------------------------------------------------------*
*&      Form  READ_PAYRQ
*&---------------------------------------------------------------------*
form read_payrq.

  data: l_str_vtbfhapo  type vtbfhapo,
        l_tab_vtbfhapo  type table of vtbfhapo.

* payment requests (PAYRQ)
  select * from vtbfhapo into table l_tab_vtbfhapo
           where bukrs = p_bukrs
             and rfha  = p_rfha
             and prkey <> ''.
  loop at l_tab_vtbfhapo into l_str_vtbfhapo.
    select * from payrq into table gl_tab_payrq
             where keyno = l_str_vtbfhapo-prkey.
  endloop.
  read table gl_tab_tables with key name = 'PAYRQ' into
  gl_str_tables.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_PAYRQ

*&---------------------------------------------------------------------*
*&      Form  READ_BKPF
*&---------------------------------------------------------------------*
form read_bkpf.

  data: l_dbcnt  type sy-dbcnt.

* accounting document header (BKPF)
  loop at gl_tab_vtbfhapo into gl_str_vtbfhapo.
    if gl_str_vtbfhapo-belnr <> ''.
      select * from bkpf into table gl_tab_bkpf
            where bukrs = p_bukrs
              and belnr = gl_str_vtbfhapo-belnr
              and gjahr = gl_str_vtbfhapo-gjahr.
      l_dbcnt = sy-dbcnt.
    endif.
    if gl_str_vtbfhapo-belnr2 <> ''.
      select * from bkpf into table gl_tab_bkpf
               where bukrs = p_bukrs
                 and belnr = gl_str_vtbfhapo-belnr2
                 and gjahr = gl_str_vtbfhapo-gjahr.
      l_dbcnt = sy-dbcnt + l_dbcnt.
    endif.
  endloop.
  sort gl_tab_bkpf by bukrs belnr gjahr.
  delete adjacent duplicates from gl_tab_bkpf.
  read table gl_tab_tables with key name = 'BKPF'
       into gl_str_tables.
  gl_str_tables-eintraege = l_dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_BKPF

*&---------------------------------------------------------------------*
*&      Form  READ_BSEG
*&---------------------------------------------------------------------*
form read_bseg.

  data: l_dbcnt  type sy-dbcnt.

* accounting document segment (BSEG)
  loop at gl_tab_bkpf into gl_str_bkpf.
    select * from bseg into table gl_tab_bseg
             where bukrs = p_bukrs
               and belnr = gl_str_bkpf-belnr
               and gjahr = gl_str_bkpf-gjahr.
    l_dbcnt = sy-dbcnt.
  endloop.
  read table gl_tab_tables with key name = 'BSEG'
       into gl_str_tables.
  gl_str_tables-eintraege = l_dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.

endform.                    " READ_BSEG

*&---------------------------------------------------------------------*
*&      Form  READ_FDT1
*&---------------------------------------------------------------------*
form read_fdt1.

* cash management forecast (FDT1)
  read table gl_tab_tables with key name = 'FDT1'
       into gl_str_tables.
  select * from fdt1 into table gl_tab_fdt1
           where bukrs = p_bukrs
             and rfha  = p_rfha.
  gl_str_tables-eintraege = sy-dbcnt.
  modify gl_tab_tables index sy-tabix
         from gl_str_tables.
