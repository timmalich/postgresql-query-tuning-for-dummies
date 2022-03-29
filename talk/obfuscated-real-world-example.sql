/* real query, only obfuscated to sample schema */
select distinct on ( this_.id ) this_.id                          as y0_,
                                assignedconinfo1_.shopsy_shopsyID as y1_,
                                assignedconinfo1_.shopsy_NAME     as y2_,
                                assignedus2.id                    as y3_,
                                assignedus2_.uid                  as y4_,
                                assignedus2_.uid_UPPER            as y5_,
                                assignedus2_.GIVENNAME            as y6_,
                                assignedus2_.SURNAME              as y7_,
                                assignedus2_.phonenumber          as y8_,
                                assignedus2_.MOBILE               as y9_,
                                assignedus2_.email                as y10_,
                                assignedus2_.workmail             as y11_,
                                this_.selling_date                as y12_,
                                this_.last_payment                as y13_,
                                assignedus2_.superuser            as y14_,
                                assignedus2_.initialpassword      as y15_,
                                shopscope4_.name                  as y16_,
                                shopscope4_.id                    as y17_,
                                shopscope4_.street                as y18_,
                                shopscope4_.postalcode            as y19_,
                                shopscope4_.city                  as y20_,
                                shopscope4_.country_code          as y21_,
                                shopscope4_.url                   as y22_,
                                shopscope4_.mobile                as y23_,
                                shopscope4_.type                  as y24_,
                                customers_scop5_.scope_id        as y25_,
                                customers_scop5_.description     as y26_,
                                homeshop3_.NAME                   as y27_,
                                homeshop3_.id                     as y28_,
                                homeshop3_.email                  as y29_,
                                homeshop3_.mobile                 as y30_,
                                homeshop3_.url                    as y31_,
                                homeshop3_.city                   as y32_,
                                homeshop3_.street                 as y33_,
                                homeshop3_.postalcode             as y34_,
                                homeshop3_.country_code           as y35_,
                                homeshop3_.type                   as y36_,
                                assignedus2_.DEPARTMENTNUMBER     as y37_
from sales this_
         inner join contact_info assignedconinfo1_ on this_.contact_info_id = assignedconinfo1_.id
         inner join USERS assignedus2_ on this_.users_id = assignedus2.id
         inner join shops homeshop3_ on assignedus2_.homeshop_ID = homeshop3_.id
         inner join products products_i6_ on assignedus2.id = products_i6_.EMPLOYEES_ID
         inner join shops products_i7_ on products_i6_.shop_id = products_i7_.id
         left outer join shopsscope shopscope4_ on this_.shops_id = shopscope4_.id
         left outer join customers_er_contacts customers_scop5_ on this_.shopsy_customers__shopsy_scope_id = customers_scop5_.id
where assignedconinfo1_.id in ($1)
  and ((((((exists(/* criteria query */ select rcen_r2u_.id as y0_
                                        from sales rcen_r2u_
                                                 inner join contact_info rcen_shopsy1_
                                                            on rcen_r2u_.assigned_product_id = rcen_shopsy1_.id
                                        where rcen_r2u_.id = this_.id
                                          and rcen_r2u_.users_id = this_.users_id
                                          and rcen_shopsy1_.worldwideavailable = $2) or
            (exists(/* criteria query */ select rcen_r2u2_.id as y0_
                                         from sales rcen_r2u2_
                                                  inner join contact_info rcen_shopsy2x1_
                                                             on rcen_r2u2_.assigned_product_id = rcen_shopsy2x1_.id
                                                  inner join markavail rcen_marke2_
                                                             on rcen_shopsy2x1_.id = rcen_marke2_.mark_avail_product_id
                                         where rcen_r2u2_.id = this_.id
                                           and rcen_r2u2_.users_id = this_.users_id
                                           and (rcen_marke2_.id is not null and rcen_marke2_.mark_focus = $3)) or
             exists(/* criteria query */ select rcen_r2u3_.id as y0_
                                         from sales rcen_r2u3_
                                                  inner join contact_info rcen_shopsy3x1_
                                                             on rcen_r2u3_.assigned_product_id = rcen_shopsy3x1_.id
                                                  inner join shop_availability rcen_orgav2_
                                                             on rcen_shopsy3x1_.id = rcen_orgav2_.shopav_avail_product_id
                                         where rcen_r2u3_.id = this_.id
                                           and rcen_r2u3_.users_id = this_.users_id
                                           and (rcen_orgav2_.orgav_id is not null and rcen_orgav2_.orgav_central = $4)))) and
           exists(/* criteria query */ select shopsyra_r2u_.id as y0_
                                       from sales shopsyra_r2u_
                                                inner join contact_info shopsyra_rol1_
                                                           on shopsyra_r2u_.assigned_product_id = shopsyra_rol1_.id
                                                inner join shop_to_sales_team globalassi5_
                                                           on shopsyra_rol1_.id = globalassi5_.worldwide_assignable_id
                                                inner join shopadmins shopsyra_adm2_
                                                           on globalassi5_.worldwide_assign_by_id = shopsyra_adm2_.id
                                       where shopsyra_adm2_.id = $5
                                         and shopsyra_r2u_.id = this_.id)) or
          exists(/* criteria query */ select shopsyro_r2u_.id as y0_
                                      from sales shopsyro_r2u_
                                               inner join contact_info shopsyro_rol1_
                                                          on shopsyro_r2u_.assigned_product_id = shopsyro_rol1_.id
                                               left outer join shoptoshopowner ownedby5_
                                                               on shopsyro_rol1_.id = ownedby5_.shop_owned_products_id
                                               left outer join shopadmins shopsyro_rol2_
                                                               on ownedby5_.shop_ownedby_id = shopsyro_rol2_.id
                                      where shopsyro_r2u_.id = this_.id
                                        and shopsyro_rol2_.id = $6)) or
         (((exists(/* criteria query */ select rcen_r2u_.id as y0_
                                        from sales rcen_r2u_
                                                 inner join contact_info rcen_shopsy1_
                                                            on rcen_r2u_.assigned_product_id = rcen_shopsy1_.id
                                        where rcen_r2u_.id = this_.id
                                          and rcen_r2u_.users_id = this_.users_id
                                          and rcen_shopsy1_.worldwideavailable = $7) or
            (exists(/* criteria query */ select rcen_r2u2_.id as y0_
                                         from sales rcen_r2u2_
                                                  inner join contact_info rcen_shopsy2x1_
                                                             on rcen_r2u2_.assigned_product_id = rcen_shopsy2x1_.id
                                                  inner join markavail rcen_marke2_
                                                             on rcen_shopsy2x1_.id = rcen_marke2_.mark_avail_product_id
                                         where rcen_r2u2_.id = this_.id
                                           and rcen_r2u2_.users_id = this_.users_id
                                           and (rcen_marke2_.id is not null and rcen_marke2_.mark_focus = $8)) or
             exists(/* criteria query */ select rcen_r2u3_.id as y0_
                                         from sales rcen_r2u3_
                                                  inner join contact_info rcen_shopsy3x1_
                                                             on rcen_r2u3_.assigned_product_id = rcen_shopsy3x1_.id
                                                  inner join shop_availability rcen_orgav2_
                                                             on rcen_shopsy3x1_.id = rcen_orgav2_.shopav_avail_product_id
                                         where rcen_r2u3_.id = this_.id
                                           and rcen_r2u3_.users_id = this_.users_id
                                           and (rcen_orgav2_.orgav_id is not null and rcen_orgav2_.orgav_central = $9)))) and
           (exists(/* criteria query */ select r2umra_r2u_.id as y0_
                                        from sales r2umra_r2u_
                                                 inner join contact_info r2umra_rol2_
                                                            on r2umra_r2u_.assigned_product_id = r2umra_rol2_.id
                                                 inner join markettoshops r2umra_rol3_
                                                            on r2umra_rol2_.id = r2umra_rol3_.mark_marketassignableshopsys_id
                                                 inner join shops r2umra_org1_
                                                            on r2umra_r2u_.shop_scope_id = r2umra_org1_.id
                                        where r2umra_r2u_.id = this_.id
                                          and r2umra_r2u_.users_id = this_.users_id
                                          and r2umra_rol3_.mark_ass_by_id = $10
                                          and r2umra_rol3_.shopassignablein_id = r2umra_org1_.shop_market_id) or
            exists(/* criteria query */ select r2umra_r2u_.id as y0_
                                        from sales r2umra_r2u_
                                                 inner join contact_info r2umra_rol1_
                                                            on r2umra_r2u_.assigned_product_id = r2umra_rol1_.id
                                                 inner join markettoshops r2umra_rol2_
                                                            on r2umra_rol1_.id = r2umra_rol2_.mark_marketassignableshopsys_id
                                        where r2umra_r2u_.id = this_.id
                                          and r2umra_r2u_.users_id = this_.users_id
                                          and r2umra_r2u_.shop_scope_id is null
                                          and r2umra_rol2_.mark_ass_by_id = $11))) and
          exists(/* criteria query */ select umra_r2u_.id as y0_
                                      from sales umra_r2u_
                                               inner join USERS umra_user1_ on umra_r2u_.users_id = umra_user1.id
                                               inner join products umra_users2_
                                                          on umra_user1.id = umra_users2_.EMPLOYEES_ID
                                               inner join shops umra_secor3_ on umra_users2_.shop_id = umra_secor3_.id
                                               inner join market umra_marke4_
                                                          on umra_secor3_.shop_market_id = umra_marke4_.id
                                               inner join markettoshops umra_shopsya5_
                                                          on umra_marke4_.id = umra_shopsya5_.MARK_shopsyASSIGNABLEIN_ID
                                      where umra_shopsya5_.mark_ass_by_id = $12
                                        and umra_r2u_.id = this_.id
                                        and umra_r2u_.users_id = this_.users_id))) or
        exists(/* criteria query */ select r2uhs_br2user_.id as y0_
                                    from sales r2uhs_br2user_
                                             inner join USERS r2uhs_user1_ on r2uhs_br2user_.users_id = r2uhs_user1.id
                                             inner join products r2uhs_user2_
                                                        on r2uhs_br2user_.products_id = r2uhs_user2_.id
                                             inner join shops r2uhs__ on r2uhs_user2_.shop_id = r2uhs__.id
                                             inner join market r2uhs_mark4_ on r2uhs__.shop_market_id = r2uhs_mark4_.id
                                             inner join shoptohelpdesk troublesho11_
                                                        on r2uhs_mark4_.id = troublesho11_.help_troubleshootedmarkets_id
                                             inner join shopadmins r2uhs_adm5_
                                                        on troublesho11_.troubleshooterid = r2uhs_adm5_.id
                                    where r2uhs_adm5_.id = $13
                                      and r2uhs_br2user_.id = this_.id)) or
       (((exists(/* criteria query */ select rcen_r2u_.id as y0_
                                      from sales rcen_r2u_
                                               inner join contact_info rcen_shopsy1_
                                                          on rcen_r2u_.assigned_product_id = rcen_shopsy1_.id
                                      where rcen_r2u_.id = this_.id
                                        and rcen_r2u_.users_id = this_.users_id
                                        and rcen_shopsy1_.worldwideavailable = $14) or

/* query would have been evan longer, but statement was truncated ..................................... * * * * * * * *
             (exists(/* criteria query */ select
   .....................................................................................................
           */
