Return-Path: <SRS0=IIB/=BU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3AEC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD84E204EC
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nhUOsUEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHJQ1B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:27:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40009 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgHJQ1B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Aug 2020 12:27:01 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200810162658epoutp020f3871ef45d38a7d7bb0cc1764000237~p9OeT0Eq12113221132epoutp02K
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2020 16:26:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200810162658epoutp020f3871ef45d38a7d7bb0cc1764000237~p9OeT0Eq12113221132epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597076818;
        bh=ptZOgpVbF6eQHas1jtOfrmf/YiQY4pvHcwkzbECIhTc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nhUOsUEY4hviNMOIwj5E5x80mpEm3bATJ/3dhgX2GhywYLnotpSfeVjAqs4Vzkgr7
         gBJ/iqCApZy65uQyj7lZc43ErbBkb77+E0OBmu16P9YJ9jHrtnaFfec8Lfn3ShzlbK
         8h2JXPDeMNsQvS38eRByAKL5UPOYODOFopXFDDvs=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200810162657epcas5p236aa40cc34312a8d53505e8cab9d2264~p9Odw3Cj63127031270epcas5p2E;
        Mon, 10 Aug 2020 16:26:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.03.40333.155713F5; Tue, 11 Aug 2020 01:26:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200810162656epcas5p35f781d0077e0601b2695008a2cdde430~p9Oc5tDkJ2454724547epcas5p3J;
        Mon, 10 Aug 2020 16:26:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200810162656epsmtrp20278ab2535dd0b56cfe17febe2605fe4~p9Oc4__Ay1329513295epsmtrp2J;
        Mon, 10 Aug 2020 16:26:56 +0000 (GMT)
X-AuditID: b6c32a4a-991ff70000019d8d-ff-5f317551bc69
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.08.08382.055713F5; Tue, 11 Aug 2020 01:26:56 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200810162654epsmtip13bec11bce90df16e9534de2331415e25~p9OapymMf0342003420epsmtip1X;
        Mon, 10 Aug 2020 16:26:54 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Tamseel Shams'" <m.shams@samsung.com>, <kgene@kernel.org>,
        <krzk@kernel.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200810030021.45348-1-m.shams@samsung.com>
Subject: RE: [RFT PATCH v5] serial: samsung: Removes the IRQ not found
 warning
Date:   Mon, 10 Aug 2020 21:56:52 +0530
Message-ID: <003c01d66f33$1065a380$3130ea80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLjq31EwYjle3qnolStvtfndV72lwF+iMNMpwsaERA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmpm5gqWG8QdduLYvmxevZLKZs+MBk
        0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZnFncy25xt3UxuwOnx6ZVnWwe++euYffYvKTe
        o2/LKkaP9Vuusnh83iQXwBbFZZOSmpNZllqkb5fAlXH9+TqWgmtiFaveTGdvYPwo0sXIySEh
        YCJx7l0naxcjF4eQwG5GieaN39kgnE+MEl8/9EBlvjFKvJ+8gQ2mZcKdx8wgtpDAXkaJ75N1
        IIreMEpMeDuTCSTBJqArsWNxG9goEYFWRomzDx6AOcwCkxklPj48wApSxSlgKbFvzy12EFtY
        IEBi26/bLCA2i4CqxKObN8FqeIFqThzaD2ULSpyc+QSshllAW2LZwtfMECcpSPx8ugyohgNo
        m5XE91YOiBJxiaM/e5hB9koILOWQ2H7gOVS9i8S1Q3+g3hGWeHV8CzuELSXx+d1eNpA5EgLZ
        Ej27jCHCNRJL5x1jgbDtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKpVJZrfXYXq
        lJaY2N3NCmF7SKw8tINtAqPiLCR/zULy1ywkD8xCWLaAkWUVo2RqQXFuemqxaYFRXmq5XnFi
        bnFpXrpecn7uJkZwitLy2sH48MEHvUOMTByMhxglOJiVRHjt7urHC/GmJFZWpRblxxeV5qQW
        H2KU5mBREudV+nEmTkggPbEkNTs1tSC1CCbLxMEp1cBU1H510x815jtvHZpvrrz08kn5wgiN
        3x+P6h72uvQpNMCy8MwHk6UGHmeeb/Ftvzf3VeH89IA2hbhDsoG/9LhX6Uz8wrExwub6LE+t
        OtN/olvEhfZWvT+64psSa9WNPPUAv7esRy8nm8xiKZlX82v2zsfKUvPZ/E2Und3Wr249rK9o
        HPe7TEvEx9zuxyUzu0Ufvs+f0fyi6l7LtHs7T62y8N5nPtNsnlq+Q5B48Imzjq8XMs6/84kh
        I0ereIfLEoveLzP7bvKeajCcePKVzlVn6fMnedpW7OqfbTbpqGnPvMXmRw7tSnx/+dzkX213
        We9O+GKglcFaJ7thv+uijV+mqbllrRL3zJLguqxvWFmgqcRSnJFoqMVcVJwIACbMdy3AAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnG5AqWG8QcsZHYvmxevZLKZs+MBk
        0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZnFncy25xt3UxuwOnx6ZVnWwe++euYffYvKTe
        o2/LKkaP9Vuusnh83iQXwBbFZZOSmpNZllqkb5fAlbHxWFrBVKGKhnWb2BsYf/B1MXJySAiY
        SEy485i5i5GLQ0hgN6PEnGUrmCES0hLXN05gh7CFJVb+e84OUfSKUWLLyUNgCTYBXYkdi9vY
        QBIiAt2MEv2XfoA5zAJTGSWOTWiAmtvFKHHzzjwmkBZOAUuJfXtugbULC/hJfN32AWwfi4Cq
        xKObN1lBbF6gmhOH9kPZghInZz5hAbGZBbQleh+2MsLYyxa+hrpVQeLn02VA9RxAZ1hJfG/l
        gCgRlzj6s4d5AqPwLCSTZiGZNAvJpFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiONi3NHYzbV33QO8TIxMF4iFGCg1lJhNfurn68EG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4bhQvjhATSE0tSs1NTC1KLYLJMHJxSDUzLw+6pqPadXSbd9tiZ9/CUw+trjE7o/OTPvpkx
        PfPc1mm1Hh9iXteUujlXmHsUTH+woSzTyOCa15Hll7YW8P1a1epxM6/38gLxM/KBZ5MLvSs8
        3oa9qEr5mZCz07/bxOnmP71MXxWV1dUr3971OtguNWHCH+ElOvaFt/duYE4Rfjd1w6RFSU/j
        K06HTXm8l61KU8Wo4Vve7pCggwYLfKNfKBgffHTug9Njk987Hnk47WF7sz7WLfBxkdi2E0nm
        OTI/T5ld6POTW7vzsvJ/i5knPV+uXvTJKqqTee7aa3m/AosDW//dsN2+dW3dUTOWSTX/WHq2
        /AlcdKxPRSv20troM34PBD9vKPO5uHd1s+ROJZbijERDLeai4kQA0kbT1iUDAAA=
X-CMS-MailID: 20200810162656epcas5p35f781d0077e0601b2695008a2cdde430
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c
References: <CGME20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c@epcas5p1.samsung.com>
        <20200810030021.45348-1-m.shams@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Tamseel,

> -----Original Message-----
> From: Tamseel Shams <m.shams=40samsung.com>
> Sent: 10 August 2020 08:30
> To: kgene=40kernel.org; krzk=40kernel.org; gregkh=40linuxfoundation.org;
> jslaby=40suse.com
> Cc: linux-arm-kernel=40lists.infradead.org; linux-samsung-soc=40vger.kern=
el.org;
> linux-serial=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> alim.akhtar=40samsung.com; Tamseel Shams <m.shams=40samsung.com>
> Subject: =5BRFT PATCH v5=5D serial: samsung: Removes the IRQ not found wa=
rning
>=20
> In few older Samsung SoCs like s3c2410, s3c2412 and s3c2440, UART IP is h=
aving
> 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210, exynos5433, and exynos4210
> UART is having only 1 interrupt line. Due to this, =22platform_get_irq(pl=
atdev, 1)=22
> call in the driver gives the following false-positive error:
> =22IRQ index 1 not found=22 on newer SoC's.
>=20
> This patch adds the condition to check for Tx interrupt only for the thos=
e SoC's
> which have 2 interrupt lines.
>=20
> Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> ---
Tested on exynos7 platform, don=E2=80=99t=20see=20=22=20IRQ=20index=201=20n=
ot=20found=22=20with=20this=20patch=20applied=0D=0AFill=20free=20to=20added=
=20=0D=0ATested-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0ARevi=
ewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20Commi=
t=20message=20is=20changed.=0D=0A>=20=0D=0A>=20Added=20RFT,=20for=20older=
=20platform.=0D=0A>=20=0D=0A>=20Addressed=20Krzysztof's=20review=20comments=
=20=5B1=5D=20=5B1=5D=20->=0D=0A>=20https://lkml.org/lkml/2020/7/21/150=0D=
=0A>=20=0D=0A>=20=20drivers/tty/serial/samsung_tty.c=20=7C=208=20+++++---=
=0D=0A>=20=201=20file=20changed,=205=20insertions(+),=203=20deletions(-)=0D=
=0A>=20=0D=0A>=20diff=20--git=20a/drivers/tty/serial/samsung_tty.c=20b/driv=
ers/tty/serial/samsung_tty.c=0D=0A>=20index=206ef614d8648c..b923683e6a25=20=
100644=0D=0A>=20---=20a/drivers/tty/serial/samsung_tty.c=0D=0A>=20+++=20b/d=
rivers/tty/serial/samsung_tty.c=0D=0A>=20=40=40=20-1911,9=20+1911,11=20=40=
=40=20static=20int=20s3c24xx_serial_init_port(struct=0D=0A>=20s3c24xx_uart_=
port=20*ourport,=0D=0A>=20=20=09=09ourport->tx_irq=20=3D=20ret=20+=201;=0D=
=0A>=20=20=09=7D=0D=0A>=20=0D=0A>=20-=09ret=20=3D=20platform_get_irq(platde=
v,=201);=0D=0A>=20-=09if=20(ret=20>=200)=0D=0A>=20-=09=09ourport->tx_irq=20=
=3D=20ret;=0D=0A>=20+=09if=20(=21s3c24xx_serial_has_interrupt_mask(port))=
=20=7B=0D=0A>=20+=09=09ret=20=3D=20platform_get_irq(platdev,=201);=0D=0A>=
=20+=09=09if=20(ret=20>=200)=0D=0A>=20+=09=09=09ourport->tx_irq=20=3D=20ret=
;=0D=0A>=20+=09=7D=0D=0A>=20=20=09/*=0D=0A>=20=20=09=20*=20DMA=20is=20curre=
ntly=20supported=20only=20on=20DT=20platforms,=20if=20DMA=20properties=0D=
=0A>=20=20=09=20*=20are=20specified.=0D=0A>=20--=0D=0A>=202.17.1=0D=0A=0D=
=0A=0D=0A
