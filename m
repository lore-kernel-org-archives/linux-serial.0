Return-Path: <SRS0=S7Zs=76=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB1C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AEE20C09
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g15sK8fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQRIQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:08:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52032 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQRIP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jun 2020 13:08:15 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200617170812epoutp03d939e07e281b89afd26853b3075f9666~ZY9D1Jrpd0457204572epoutp03M
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2020 17:08:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200617170812epoutp03d939e07e281b89afd26853b3075f9666~ZY9D1Jrpd0457204572epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592413692;
        bh=8uegeGaZQaXzOszaS/XO+h1hPJdbqLK/6+7/IxX9QPk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=g15sK8fOD3w4KJNmtjBxHErPstHjksqLtMEXx0r2rSgdTYAj8rmm03bkoBSsA7ulo
         HAiwj6oJOtvxIz07Tdj766S7zvd4GyIPtd/uq5IeCAC3xJueu0owdtw//jlC+YZazr
         F/msr4G6Cnw3lUr4H8pR8acd+X0+XCv9NMr/udac=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200617170811epcas5p4b3769a525def33d34ae8e9fadcf56672~ZY9DUx7FO0730007300epcas5p41;
        Wed, 17 Jun 2020 17:08:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.A0.09703.BFD4AEE5; Thu, 18 Jun 2020 02:08:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200617170810epcas5p3ea5ed916115df0f5e5908ad81b2b7b53~ZY9CPAygZ1441714417epcas5p3x;
        Wed, 17 Jun 2020 17:08:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200617170810epsmtrp1f826008bae2346c4157b9e7fb37b1e40~ZY9COS6mE0839208392epsmtrp1k;
        Wed, 17 Jun 2020 17:08:10 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-95-5eea4dfb862e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.9B.08382.AFD4AEE5; Thu, 18 Jun 2020 02:08:10 +0900 (KST)
Received: from mshams01 (unknown [107.122.43.244]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200617170806epsmtip2e8aa64209a416af5b6427f0b90d27713~ZY8_eTan80225202252epsmtip29;
        Wed, 17 Jun 2020 17:08:06 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Robin Murphy'" <robin.murphy@arm.com>, <kgene@kernel.org>,
        <krzk@kernel.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <027c0955-3246-8c1e-4d0d-053a2a177dc6@arm.com>
Subject: RE: [RFC PATCH] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Wed, 17 Jun 2020 22:38:01 +0530
Message-ID: <000101d644c9$e06bba40$a1432ec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFLyHxHkUNw6bP6pRUtYOiC7jR2QHTNgWiAZJI3VmnY///wA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7bCmpu5v31dxBgeu6Vo8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slsc/PCE1YHLY828NYwem1Z1
        snnsn7uG3WPzknqPvi2rGD3Wb7nK4vF5k1wAexSXTUpqTmZZapG+XQJXxom7Z1kKTgtUPDum
        2MDYytvFyMkhIWAi8bNtF0sXIxeHkMBuRolJS36xQzifGCVuP1/MCOF8Y5RYN+0bO0zLt/V7
        mSESexkl7tz5ClX1nFHi/5ZmJpAqNgFdiUkH28CqRARaGSVaJ80ASzALrGOUaP8hAGJzClhL
        PP+5hxHEFhZIkNi8ZwUziM0ioCrRsXsDWD2vgKXExbndbBC2oMTJmU9YIOZoSyxb+JoZ4iQF
        iZ9Pl7GC2CICThJ7Dz5mhqgRl3h59AjU2Xs4JF7/r4SwXST2rJkOFReWeHV8C5QtJfGyvw3K
        zpeYP28V1PwKiZUX3kDZ9hIHrswBuoEDaL6mxPpd+hCr+CR6fz9hAglLCPBKdLQJQVQrSvzf
        3Q81UVzi3YoprBC2h0T7pamsExgVZyF5bBaSx2YheWAWwrIFjCyrGCVTC4pz01OLTQuM8lLL
        9YoTc4tL89L1kvNzNzGC05aW1w7Ghw8+6B1iZOJgPMQowcGsJMLr/PtFnBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXFepR9n4oQE0hNLUrNTUwtSi2CyTBycUg1M2WmpGkJZx2QCOvMrNXO7kjyV
        frR3H7uUdnaGSqQjWxELe97ndq1XKlsqOH/vUXi+9cKdgqSEr3ONNP97aa+7X1hU2+q9INVm
        Qq+y0YPDHxL+aP+dIWe5t8DF0H+/mUh13qZv7SekfiqovXl+P6uQyej3l/9Bi6ZJ1D4wMKyY
        nNbsuvbo19TvYb4bnJZwrndRj2Hi/npKoKXEOoHtm8Lz7x9eHSuwt5/CpZzymyOi26pnyeuZ
        u471Lmaqv5MmxDmx5LbwAZO3KrMqD77k37LZY8b5yk8nJj+fFJTyeXKwTQqX5JfD/zcHb9vQ
        scBF938y12Fh35XJ5TXxfIyhue/4XI8cjmjxjbkS/j301g0lluKMREMt5qLiRABPF+rlygMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvO4v31dxBocvylk8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slsc/PCE1YHLY828NYwem1Z1
        snnsn7uG3WPzknqPvi2rGD3Wb7nK4vF5k1wAexSXTUpqTmZZapG+XQJXxsRt+1gKZgpUPJzy
        nrmB8TJPFyMnh4SAicS39XuZuxi5OIQEdjNKLJ5ylQkiIS4x7dd+RghbWGLlv+fsILaQwFNG
        iZOHxEFsNgFdiUkH28CaRQS6GSWe/tzNAuIwC2xilPjz7i4TxNidjBIPO5exgrRwClhLPP+5
        B2yssECcxIWdfSwgNouAqkTH7g1gq3kFLCUuzu1mg7AFJU7OfAJWwyygLfH05lM4e9nC18wQ
        5ylI/HwKMV9EwEli78HHzBA14hIvjx5hn8AoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCY1BLcwfj9lUf9A4xMnEwHmKU4GBWEuF1/v0iTog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvjcKFcUIC6YklqdmpqQWpRTBZJg5OqQamap/gE6w8VVVHpeR9
        xeaeve2+U/bRqdveAZ1fbz9ak8g4o1FWe/7vX9XsFwJjvEzmcHJ6qB6Y6CnydMWRztNMDzef
        scg4KW0tZWarKdeQ9vVcx9+Db5ckfrfJneuxSrrXa9m7xXmxFj/9Q4I/Tf+VtsWoUpq99mvp
        amlr42Dt/Ud/KOvorJj2+kvF6W61p618XBsTgoutX7ltuVm/1qXr8FaWgIwplyffKUy9ZKpi
        7Vj33XntDM3Ll/Lzdh9wDvkgYLdVumxfmFaKDWP28vPSTazq4lO/3VRlq/zV/6t59ZXuTxYf
        S9+c3KNSUyQm9OWx5bbXgkq8u+w/XTOLnXBe/Lalwr1Gt8vxB7tf7F6pxFKckWioxVxUnAgA
        UA4NIjADAAA=
X-CMS-MailID: 20200617170810epcas5p3ea5ed916115df0f5e5908ad81b2b7b53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43
References: <CGME20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43@epcas5p4.samsung.com>
        <20200615122609.71884-1-m.shams@samsung.com>
        <027c0955-3246-8c1e-4d0d-053a2a177dc6@arm.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy <robin.murphy=40arm.com>
> Sent: Monday, June 15, 2020 6:43 PM
> To: Tamseel Shams <m.shams=40samsung.com>; kgene=40kernel.org;
> krzk=40kernel.org; gregkh=40linuxfoundation.org; jslaby=40suse.com
> Cc: linux-samsung-soc=40vger.kernel.org; linux-serial=40vger.kernel.org; =
linux-
> kernel=40vger.kernel.org; alim.akhtar=40samsung.com; linux-arm-
> kernel=40lists.infradead.org
> Subject: Re: =5BRFC PATCH=5D serial: samsung: Re-factors UART IRQ resourc=
e for
> various Samsung SoC
>=20
> On 2020-06-15 13:26, Tamseel Shams wrote:
> >   	else =7B
> >   		port->irq =3D ret;
> >   		ourport->rx_irq =3D ret;
> > -		ourport->tx_irq =3D ret + 1;
> > +		if (ourport->info->irq_cnt =3D=3D 1)
> > +			ourport->tx_irq =3D ret;
> > +		else
> > +			ourport->tx_irq =3D ret + 1;
> >   	=7D
> >
> > -	ret =3D platform_get_irq(platdev, 1);
> > -	if (ret > 0)
> > -		ourport->tx_irq =3D ret;
> > +	if (ourport->info->irq_cnt =21=3D 1) =7B
> > +		ret =3D platform_get_irq(platdev, 1);
> > +		if (ret > 0)
> > +			ourport->tx_irq =3D ret;
>=20
> FWIW, if you're not going to do anything in the error case then you may a=
s well
> just call platform_get_irq_optional() unconditionally.
>=20
> Robin.
>=20
My intention behind not using 'platform_get_irq_optional' was that it does =
not prints the error when the 2nd interrupt resource is missing for the old=
er UART's. I am just using it to give information to the user in error case=
. I can use 'platform_get_irq_optional' too.

Thanks & Regards
Tamseel

> > +	=7D
> >   	/*
> >   	 * DMA is currently supported only on DT platforms, if DMA propertie=
s
> >   	 * are specified.
> > =40=40 -2387,6 +2393,7 =40=40 static struct s3c24xx_serial_drv_data
> s3c2410_serial_drv_data =3D =7B
> >   		.name		=3D =22Samsung S3C2410 UART=22,
> >   		.type		=3D PORT_S3C2410,
> >   		.fifosize	=3D 16,
> > +		.irq_cnt	=3D 2,
> >   		.rx_fifomask	=3D S3C2410_UFSTAT_RXMASK,
> >   		.rx_fifoshift	=3D S3C2410_UFSTAT_RXSHIFT,
> >   		.rx_fifofull	=3D S3C2410_UFSTAT_RXFULL,

