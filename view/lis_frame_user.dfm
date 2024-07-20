inherited ListFrameUser: TListFrameUser
  inherited Lb_Lista: TLabel
    Caption = 'Nome do Usu'#225'rio'
    ExplicitWidth = 82
  end
  inherited pnl_Lista: TPanel
    inherited DBLCB_Lista: TDBLookupComboBox
      KeyField = 'id'
      ListField = 'name_company'
    end
  end
  inherited Qr_Lista: TFDQuery
    SQL.Strings = (
      'Select distinct u.id, en.name_company, ma.email '
      'from tb_user u '
      '  inner join tb_entity en on (u.id = en.id ) '
      '  inner join tb_entity_has_mailing ehm '
      '  on (ehm.tb_entity_id = en.id) '
      '  and (ehm.tb_mailing_group_id = :tb_mailing_group_id) '
      '  inner join tb_mailing ma on (ehm.tb_mailing_id = ma.id ) '
      '  inner join tb_institution_has_user i '
      '  on (u.id = i.tb_user_id) '
      'where (i.active =:active) '
      'order by en.name_company ')
    ParamData = <
      item
        Name = 'TB_MAILING_GROUP_ID'
        DataType = ftWideString
        ParamType = ptInput
        Value = 'F03F8E47-6D7B-4DF7-8581-92CD36616FD4'
      end
      item
        Name = 'ACTIVE'
        DataType = ftWideString
        ParamType = ptInput
        Value = 'S'
      end>
  end
end
