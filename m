Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFFC43334
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jul 2022 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGDIL3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGDIL2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB038A6
        for <linux-serial@vger.kernel.org>; Mon,  4 Jul 2022 01:11:26 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220704081124epoutp02b4f6d804ecfacf335013aaccb2c29f39~_kgoEQmbu2018020180epoutp02h
        for <linux-serial@vger.kernel.org>; Mon,  4 Jul 2022 08:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220704081124epoutp02b4f6d804ecfacf335013aaccb2c29f39~_kgoEQmbu2018020180epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656922284;
        bh=oL4tJblcsvNZWmUaGkY2Im4in7mJaN8VsUQa/16RiFA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uaeg9mT8icQVDP6HKVf9rrmf8veTv8TtThmIzK/O2KDrf2e8H7dlPvwUj+0BH0z16
         2ok8HaBJKnGdkgCTJ+Pt99JGAUJnTdgpmq/ZKWINoqqMGuVubEkDl+C01hXe4gy85a
         +SGj8cRO08ecxpTyshxDS+6DGT3396+g8p7Yu8gk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220704081124epcas2p4a2aa4f4b50a6c82d30ed74859e69abc4~_kgnf7omt1536815368epcas2p4j;
        Mon,  4 Jul 2022 08:11:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lbz632s43z4x9Q2; Mon,  4 Jul
        2022 08:11:23 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.9E.09662.BA0A2C26; Mon,  4 Jul 2022 17:11:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220704081122epcas2p396ec6088b20d2ccef8ab1dd50ab202f3~_kgmc7C-f1791317913epcas2p3x;
        Mon,  4 Jul 2022 08:11:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220704081122epsmtrp27edaa609df59465f7984743894e25e41~_kgmcJpS22184521845epsmtrp2j;
        Mon,  4 Jul 2022 08:11:22 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-c3-62c2a0abcb45
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.5E.08802.AA0A2C26; Mon,  4 Jul 2022 17:11:22 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220704081122epsmtip2b563a0936560f9c5422d669912d03ccc~_kgmO7pCy2828328283epsmtip2Y;
        Mon,  4 Jul 2022 08:11:22 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <c7157f50-4739-2365-f394-826ff91637ed@kernel.org>
Subject: RE: [PATCH v2] tty: serial: samsung_tty: support more than 4 uart
 ports
Date:   Mon, 4 Jul 2022 17:11:22 +0900
Message-ID: <004401d88f7d$a6166880$f2433980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDRkcH2GznwYXJwEGvHTEwFXhKgoAI43wpyAKnAJaavZL/psA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmme7qBYeSDJpXiVo8mLeNzaJ58Xo2
        ix0NR1gt3s2Vsdj7eiu7xabH11gtZpzfx2RxZnEvu8XpawvYLc5v83fg8ri+LsBj06pONo87
        1/aweeyfu4bdY/OSeo/Fy3ayefRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCBSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
        pdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjO5LF9kLurkrNt4+z97A+Juji5GTQ0LA
        RGJp11f2LkYuDiGBHYwSkzc/ZoZwPjFKbPl0kxXC+cwo0XDwDVMXIwdYy/t2F4j4LkaJl+vf
        sUE4Lxgldvz/xgwyl01AX+JlxzawbhGBOYwSNxsWsIA4zAIrmSTOfj/PBlLFKWAn8f1zNwuI
        LSwQJLHwyh92EJtFQEVi0uVLYHFeAUuJBwves0PYghInZz4BizMLaEssW/iaGeILBYmfT5ex
        QsRFJGZ3toHFRQScJOac2MIIslhC4ACHxOZFEEMlBFwknu6fzAphC0u8Or6FHcKWkvj8bi8b
        hF0ssXTWJyaI5gZGicvbfkEljCVmPWtnBAUGs4CmxPpd+pBwUZY4cgvqNj6JjsN/2SHCvBId
        bUIQjeoSB7ZPh7pAVqJ7zmfWCYxKs5B8NgvJZ7OQfDMLYdcCRpZVjGKpBcW56anFRgUm8OhO
        zs/dxAhOvVoeOxhnv/2gd4iRiYPxEKMEB7OSCO+qSQeThHhTEiurUovy44tKc1KLDzGaAsN6
        IrOUaHI+MPnnlcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgWmix
        9t8U/c+Rvzn/fj8YV3TgoXthb+DMu48nG5ee3bgia9qUm9mJT1N0VO4Un/sRd3xPpQWvwvK3
        v7IuZX251Hf3eWfbfpcSfR3dJ9qMxvu/CjEEyvmGLbQPlItm+ZH464x0r9tsjpjtxeYn5GZK
        T209deKnbZ7sh+urik+keG2ZOO0PG5dZ6cq3d3/e3u8tIDf7paDx6wSdeczllc8TXmlP+nbr
        SnhSUGaZhohJyXGWSbPFuDlLHoubNAp9e/4tTtQuY+sXnmkOiuyTBJ5IP1m7n3mfd4L/NAO3
        H7e7EnIPhcZNmmrnK2OqV2ZX8Dz6pXRl97Xa4Bnb1/WbpZUuWfvTY+3y6x9yNu/+Fbd8nxJL
        cUaioRZzUXEiAOgY6DtGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO6qBYeSDD5MNbB4MG8bm0Xz4vVs
        FjsajrBavJsrY7H39VZ2i02Pr7FazDi/j8nizOJedovT1xawW5zf5u/A5XF9XYDHplWdbB53
        ru1h89g/dw27x+Yl9R6Ll+1k8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6MHb8/shc846rY
        Pfk/YwPjFY4uRg4OCQETifftLl2MXBxCAjsYJT63LGXsYuQEistKPHu3gx3CFpa433KEFaLo
        GaPEi0kLWUESbAL6Ei87toElRATmMEq8vDaHDcRhFljLJHG3eyUTRMshRonzM/vZQFo4Bewk
        vn/uZgGxhQUCJFqXfAAbxSKgIjHp8iWwOK+ApcSDBe/ZIWxBiZMzn4DFmQW0JXoftjLC2MsW
        vmaGuE9B4ufTZawQcRGJ2Z1tYHERASeJOSe2ME5gFJ6FZNQsJKNmIRk1C0n7AkaWVYySqQXF
        uem5xYYFRnmp5XrFibnFpXnpesn5uZsYwXGopbWDcc+qD3qHGJk4GIGe5GBWEuFdNelgkhBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MZZMvyKh+uL7v
        SeDvGIs+5isqap5NfJLbQ/T4v+7Zx2vjxfPvmfOXrReOHdCfqP49caPKTK+chTZvZ8RUSXHE
        HjSfFSX2+tv0Ev5pq9+lixp7pTzg8tOMm6UZnf5AIVGg+93L9KdGPG8+re56eSr02Jv3W7Qd
        9xVbKcX17my6tU/6Y/Sm1a+eeIXu8i2ftcygPvCyaozPTAH2z02LFXVFatONORXT5SvzWArf
        fpELP6u+bMUT9Z8n5W78F1/ZN9vtDnO18mTrKUfniPw5GBGV7fnI8i5z/gvP2ImTna89lBfx
        vPdEYo3O71L+Qt3AOf7P3zDNSnrhYdU2U1nyS0H5/vdnbSa+7235InOLPTRYiaU4I9FQi7mo
        OBEACYfY3zIDAAA=
X-CMS-MailID: 20220704081122epcas2p396ec6088b20d2ccef8ab1dd50ab202f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17
References: <CGME20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17@epcas2p4.samsung.com>
        <20220629005538.60132-1-chanho61.park@samsung.com>
        <c7157f50-4739-2365-f394-826ff91637ed@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> ...
> > =40=40 -1810,67 +1816,27 =40=40 static const struct uart_ops
> > apple_s5l_serial_ops =3D =7B
> ...
> > +static struct s3c24xx_uart_port s3c24xx_serial_ports=5BUART_NR=5D;
> > +
> > +static void s3c24xx_serial_init_port_default(int index) =7B
>=20
> The opening brace should be on a separate line.

Oh, I missed this. Thanks for your review.
I'll make a separate patch to fix this.

>=20
> > +	struct uart_port *port =3D &s3c24xx_serial_ports=5Bindex=5D.port;
> > +
> > +	spin_lock_init(&port->lock);
> > +
> > +	port->iotype =3D UPIO_MEM;
> > +	port->uartclk =3D 0;
> > +	port->fifosize =3D 16;
> > +	port->ops =3D &s3c24xx_serial_ops;
> > +	port->flags =3D UPF_BOOT_AUTOCONF;
> > +	port->line =3D index;
> > +=7D
> >
> >   /* s3c24xx_serial_resetport
> >    *
> > =40=40 -2186,6 +2152,8 =40=40 static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >   	=7D
> >   	ourport =3D &s3c24xx_serial_ports=5Bindex=5D;
> >
> > +	s3c24xx_serial_init_port_default(index);
>=20
> Perhaps pass &ourport->port to the function too -- you'd save the refetch
> there.

&ourport->port will be retrieved by index in the s3c24xx_serial_init_port_d=
efault.
Why do I need to pass it?

+	struct uart_port *port =3D &s3c24xx_serial_ports=5Bindex=5D.port;

Best Regards,
Chanho Park

