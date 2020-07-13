Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A5C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30F1217BA
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JVkNM8cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGNA5a (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:57:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40577 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgGNA53 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 20:57:29 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200714005726epoutp022a2fe3910fd5fc5c4a64248f702d0276~heIL2Kptw0250002500epoutp02W
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 00:57:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200714005726epoutp022a2fe3910fd5fc5c4a64248f702d0276~heIL2Kptw0250002500epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594688246;
        bh=M82KTQ34xlsoe98Owtp5RPP10GSPNATgF5vm5BQ+yU8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JVkNM8cK6WdzhsJtJeAf/Q591r9578YlW4zEkJN/piiHJ1dD+G6rj3QyRgyLL0Spm
         V0V1Ll9INi6Btdt3J4CX+4BKjnwYEmw5Xd7ZP+DPc1f+0Z/ap3O3fy1Yg5wO8rNhEB
         rRbWyq4fD1Hero4E3ItSn1x0KjN0qbvMhbgjVkTs=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200714005726epcas5p3fce7b5a3b0c89e9a80c677c4f2adc515~heILK3E9e0595905959epcas5p3M;
        Tue, 14 Jul 2020 00:57:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.E5.09703.6F20D0F5; Tue, 14 Jul 2020 09:57:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200713140359epcas5p4d95206230ef6ec19269aa13132c8c8bf~hVNpeuE5m0071100711epcas5p4m;
        Mon, 13 Jul 2020 14:03:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200713140359epsmtrp1a0bb03ce63bf04071b152a7ca69e7c75~hVNpd-bGj2698426984epsmtrp1D;
        Mon, 13 Jul 2020 14:03:59 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-26-5f0d02f6a275
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.BC.08303.FC96C0F5; Mon, 13 Jul 2020 23:03:59 +0900 (KST)
Received: from mshams01 (unknown [107.122.43.244]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200713140357epsmtip1e36519cc00cdf018632777d0a6d21010~hVNnP0ZSB1681216812epsmtip1P;
        Mon, 13 Jul 2020 14:03:57 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <kgene@kernel.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <20200706081307.GA13025@kozik-lap>
Subject: RE: [PATCH v3] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Mon, 13 Jul 2020 19:33:42 +0530
Message-ID: <007301d6591e$74a4b2d0$5dee1870$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ+HCpw/jCCJmkguxc6VRyn8Om3HQIWvFo9AbDj3oanl8co8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmlu43Jt54g3UNHBYP5m1js2hevJ7N
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8aDWTfZCi7zVTx6P4m1gfE5dxcjJ4eE
        gInE6t13mbsYuTiEBHYzSmx/2M0C4XxilJjXtAvK+cwoseN+GxNMy8xzn1lAbCGBXYwSl79Z
        QNjPGSWu/TQDsdkEdCUmHWxjBrFFgOzNN5azgwxiFvjKKHFq6wc2kASngL7E0gtT2EFsYYF4
        iSNL5gDZHBwsAqoShzdLg4R5BSwlzr7fwwhhC0qcnPkEbC+zgLbEsoWvmSHuUZD4+XQZK8Qu
        J4m7n/4zQdSIS7w8egRsr4TAUg6JvgOH2SEaXCTWbO9mg7CFJV4d3wIVl5J42d8GZedLzJ+3
        CmpBhcTKC2+gbHuJA1fmsIDcySygKbF+lz5EWFZi6ql1UHv5JHp/P4GGFa/EjnkwtqLE/939
        UOPFJd6tmMI6gVFpFpLXZiF5bRaSF2YhbFvAyLKKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10v
        OT93EyM4RWl57WB8+OCD3iFGJg7GQ4wSHMxKIrzRopzxQrwpiZVVqUX58UWlOanFhxilOViU
        xHmVfpyJExJITyxJzU5NLUgtgskycXBKNTAl2ip4C9//x6u5KVWawyv526Gp24U4+P/bqyke
        8MiYxCvz8XF7S2h3kPvSWbxP566w2Hw8w16mJftyuarD9U+vNQWus7t+jzHSCf/6lU1xpUIu
        y6HZvucD7nFHWhn0t2+/wyBhdXSVgJ9BzO/bE1st4maZmAjJP9KxZp5ZU9L33lQzIn1V8a4/
        pu9T614p8sgKRPJJ3FG2Snn24pNe0b2tp7bPVW1f4Kz/42OZ/tPIJ2m3WVZUCzv6iF59wO35
        s/b1ikXlnEffZP82e3CezeIZvxa7WfSkhpyiHMEoz/qS1zKzTi7v3Oi9mjl35ddUfeniLUkz
        Cnx2CSum8V2/JN6x+/gBhv4si7zMuWcslViKMxINtZiLihMBhkAbAMADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO75TJ54g1e/DC0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALYoLpuU1JzMstQifbsErowF0/4zFuzlq7i3uJ29gfEidxcjJ4eE
        gInEzHOfWUBsIYEdjBIfziRCxMUlpv3azwhhC0us/PecvYuRC6jmKaPEzxknwBJsAroSkw62
        MYPYIkD25hvLwYqYBf4ySrxpucgG0bGWUeLijcdMIFWcAvoSSy9MYQexhQViJba9mQS0moOD
        RUBV4vBmaZAwr4ClxNn3exghbEGJkzOfgF3HLKAt0fuwlRHGXrbwNTPEdQoSP58uY4U4wkni
        7qf/TBA14hIvjx5hn8AoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
        89L1kvNzNzGCY01LawfjnlUf9A4xMnEwHmKU4GBWEuGNFuWMF+JNSaysSi3Kjy8qzUktPsQo
        zcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwenVANTV2dQ9z4hvrruU9Mcn2RlqU+8bqI1afOE
        Z88V6xafX6b2VGBJS4LI3o6Tq/fqNies+TndWFqf206P68uyqfstNI96Tqy7W6qXambhmbjl
        /rQoG7bCxHnl68Sn8MqmdIp2rJtZnBSk4a7oYPPY+zjTnRXugQZuLzj3rF34OipdaoWirbr2
        K4V665f3i+IC9xtyTjVWU9eqKzzUei9rlt+ysD+HTfTvsS+5vL2Dc9Ok1UEHOBq/blipu/u3
        cdyOCgMmntrWiGbR3m3tW85/ztCYGfCyvX9N26xGO8MSAQs26ZtibTsM+URUKoNmpuV+iJz7
        5K970flPDzMVd8gseeq9bF1bsB53ecfLK82yckosxRmJhlrMRcWJAOYenXwkAwAA
X-CMS-MailID: 20200713140359epcas5p4d95206230ef6ec19269aa13132c8c8bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4
References: <CGME20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4@epcas5p2.samsung.com>
        <20200704140646.66528-1-m.shams@samsung.com>
        <20200706081307.GA13025@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > In few older Samsung SoCs like s3c2410, s3c2412 and s3c2440, UART IP
> > is having 2 interrupt lines.
> > However, in other SoCs like s3c6400, s5pv210, exynos5433, and
> > exynos4210 UART is having only 1 interrupt line. Due to this,
> > =22platform_get_irq(platdev, 1)=22
> > call in the driver gives the following warning:
> > =22IRQ index 1 not found=22 on recent platforms.
> >
> > This patch re-factors the IRQ resources handling for each platform and
> > hence fixing the above warnings seen on some platforms.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > ---
> > Removed the logic of irq_cnt and directly using
> > s3c24xx_serial_has_interrupt_mask() to check for number of interrupt
> > lines.
> >
> >  drivers/tty/serial/samsung_tty.c =7C 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 6ef614d8648c..8a955f3d8975 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -1908,10 +1908,13 =40=40 static int s3c24xx_serial_init_port(str=
uct
> s3c24xx_uart_port *ourport,
> >  	else =7B
> >  		port->irq =3D ret;
> >  		ourport->rx_irq =3D ret;
> > -		ourport->tx_irq =3D ret + 1;
> > +		if (s3c24xx_serial_has_interrupt_mask(port))
> > +			ourport->tx_irq =3D ret;
>=20
> Hi,
>=20
> I don't understand: Why do you assign here the same interrupt as RX?
>=20
> Best regards,
> Krzysztof
>=20
Hi Krzysztof,
I was assigning the same interrupt to Tx and Rx for UART, which have one in=
terrupt line,=20
but ourport->tx_irq is never used for those UART's. So, leaving it as it wa=
s.
The change now is using platform_get_irq_optional () instead of platform_ge=
t_irq ()
to avoid false-positive error.

Thanks & Regards,
Tamseel

