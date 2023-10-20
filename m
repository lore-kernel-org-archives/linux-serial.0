Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52622CDB474
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 07:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376396AbjJTHlV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHlU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 03:41:20 -0400
Received: from mail.venturelinkbiz.com (mail.venturelinkbiz.com [51.195.119.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881AD51
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:41:19 -0700 (PDT)
Received: by mail.venturelinkbiz.com (Postfix, from userid 1002)
        id F25FA46FF5; Fri, 20 Oct 2023 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkbiz.com;
        s=mail; t=1697787677;
        bh=JBV4b8UUo1MSngn/QBoedt1Dv52bT8rWeq4R22MtJMs=;
        h=Date:From:To:Subject:From;
        b=K9nO7grTsGY6ae8385WfWhdLAXV85EUGIMuvSv+ZkF8AfbkbyATrQemPyY8W0TyEZ
         tb66mg0gJsraPG7AjAwSfEqi7DILgVlYskQkaBmSbHRSA/5brzJcnDpzn/TdG0TLXo
         1vF8mVoxnHf0kkiMpqjCflzFsKMuOqyFRV9B+GlnNKIOIMiZQIkDP2O9tJhmfsS+VC
         ug6RgCdSMEZOgTCkMx+QLp8PrvonMuqzV/QnfeSSFEqbg4BbjmJNQkPgs+T+Z4VcXl
         KJdtkEKuoqdeYTNUgS2F/6bSgoHoXugymhDJvh4yg+9twTvs20tNEvP+dE+653N+B/
         NvvGsBfwgW7kw==
Received: by mail.venturelinkbiz.com for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 07:40:57 GMT
Message-ID: <20231020064500-0.1.35.8mg0.0.rbb6b94er8@venturelinkbiz.com>
Date:   Fri, 20 Oct 2023 07:40:57 GMT
From:   "Michal Rmoutil" <michal.rmoutil@venturelinkbiz.com>
To:     <linux-serial@vger.kernel.org>
Subject: =?UTF-8?Q?Efektivn=C3=AD_sledov=C3=A1n=C3=AD_a_optimalizace_v=C3=BDroby_pro_va=C5=A1i_spole=C4=8Dnost?=
X-Mailer: mail.venturelinkbiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dobr=C3=A9 r=C3=A1no,

m=C3=A1te mo=C5=BEnost sledovat stav ka=C5=BEd=C3=A9ho stroje a v=C3=BDro=
bn=C3=ADho procesu z kancel=C3=A1=C5=99e, konferen=C4=8Dn=C3=AD m=C3=ADst=
nosti nebo dokonce z domova =C4=8Di na cest=C3=A1ch =E2=80=93 na va=C5=A1=
em telefonu?

Poskytujeme rychle implementovateln=C3=BD a snadno pou=C5=BEiteln=C3=BD n=
=C3=A1stroj, kter=C3=BD zachyt=C3=AD i n=C4=9Bkolikasekundov=C3=BD mikrop=
rostoj a okam=C5=BEit=C4=9B p=C5=99epo=C4=8D=C3=ADt=C3=A1 vyu=C5=BEit=C3=AD=
 stroje v kontextu dan=C3=A9 v=C3=BDrobn=C3=AD zak=C3=A1zky.

Kdykoli vid=C3=ADte stav objedn=C3=A1vky a jste informov=C3=A1ni o p=C5=99=
=C3=ADpadn=C3=A9m sn=C3=AD=C5=BEen=C3=AD efektivity. Syst=C3=A9m s=C3=A1m=
 analyzuje data a p=C5=99ipravuje cenn=C3=A9 reporty, co=C5=BE oper=C3=A1=
tor=C5=AFm umo=C5=BE=C5=88uje soust=C5=99edit se na v=C3=BDrobn=C3=AD c=C3=
=ADl.

C=C3=ADl je jednoduch=C3=BD: jeden pohled =E2=80=93 cel=C3=A1 tov=C3=A1rn=
a. =C4=8Cek=C3=A1m na odpov=C4=9B=C4=8F, jestli vid=C3=ADte mo=C5=BEnost =
vyu=C5=BEit=C3=AD takov=C3=A9ho n=C3=A1stroje ve va=C5=A1=C3=AD firm=C4=9B=
=2E


Pozdravy
Michal Rmoutil
