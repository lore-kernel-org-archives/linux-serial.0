Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84CBC43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98316206E9
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 07:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ObgiPKWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbgDCHaq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:30:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41621 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbgDCHap (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 03:30:45 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200403073043epoutp01a430988ba1c853f6abdc22565477d846~CPscE47mi1183111831epoutp01-
        for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2020 07:30:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200403073043epoutp01a430988ba1c853f6abdc22565477d846~CPscE47mi1183111831epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585899043;
        bh=DYD+cCL/4Cgh5D8FjOIjDeAKodFAfeMcqzJD7XefJm0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ObgiPKWJtKka1pzoDPWzW54VsxFBpkEbDVCTe7kNfemUjajswHbHz9pCaCHeQ5qEI
         Qa7SzUgeFFSsHT5vlU1oU0xe7nMiSSL3pEy8kqKPQZMlQDRy2Z1hO0Is7mo/1BhqgX
         btCpdgl4sl32yEl75vdNNsDSyIXUGhokDKAPipT4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200403073042epcas2p3976c9561fb127ea3676b1eede28a6f1d~CPsbmeSL41618216182epcas2p3L;
        Fri,  3 Apr 2020 07:30:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48ts6S2hfrzMqYkt; Fri,  3 Apr
        2020 07:30:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.2E.04704.F16E68E5; Fri,  3 Apr 2020 16:30:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200403073038epcas2p220d9fa198f117758f38c999132025839~CPsX38v_j2110321103epcas2p24;
        Fri,  3 Apr 2020 07:30:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200403073038epsmtrp18f10ef202c4f61ec3341b78aaf835e81~CPsXz887c2288322883epsmtrp1F;
        Fri,  3 Apr 2020 07:30:38 +0000 (GMT)
X-AuditID: b6c32a46-811ff70000001260-67-5e86e61fe7cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.6E.04158.E16E68E5; Fri,  3 Apr 2020 16:30:38 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200403073038epsmtip1c7fdb776081eb0604e9d4711f7398509~CPsXmJ7hi0833208332epsmtip1M;
        Fri,  3 Apr 2020 07:30:38 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402135903.GA14861@kozik-lap>
Subject: RE: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Fri, 3 Apr 2020 16:30:38 +0900
Message-ID: <004c01d60989$c5923030$50b69090$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QJJhiU1AnstEDsBfb5gt6bXl1ew
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe+550c4e5zwWTNuj9iKcz+46zmTGNqZWMMfGPKsnlXcrz3P
        Xclm2nDFJG1mXKF2jdBcO8YVMvlRzIo1JlKjH+vHxk2W+iM83XOm/16fz/f93ufH90Nh6ltE
        HJXrcPOCg7MxxHTlvacJSdpF/d79+qHRRexxf4Bgz9eFFWxpzzDGtrXVkWyw5z3OtjdUEOzF
        tkYF+9pfQq6jrMGbpwjr48u1pPVO9TFr4O47pXUkuDAd32Nbk8NzWbyg4R2ZzqxcR3Yys2VH
        xoYMk1lv0BosbBKjcXB2PpnZmJauTc21Sa0wmjzO5pFS6ZwoMrq1awSnx81rcpyiO5nhXVk2
        l8HgWiFydtHjyF6R6bSvNuj1RpOkPGDL+dzbjbsKLYeLBz7ihahmyWkUQwG9CnoCb7HTaDql
        pkMIfOEWXA5+IAhVdEaDUQQNl3z4P0tH8/nowyMEzVfKkBwMIiipGImoCFoL7f5exSTHSnzn
        w3VyUoTRYwgaR1sjohhaBxfqaiOiOfR28LW2YJOspOMhVP8wwiraAqGxLqXMs+Hlpd4IY/Qy
        uFY1jMktaWC87xouF0uFd1XtUU0slJ/yRqYDepiABx2vCdmwEYr+NCOZ58BQ811S5jgYLPVG
        +Rg0estI2XwGwXi4L7qAleDrL5LMlFQhAQINukkEejE8+xitOwuKn06QcloFxV61bFwKt0cH
        FDIvgNq+BvIcYnxTJvNNmcw3ZQLf/1qVSHkTzeNdoj2bF40u49TvDqLIoSamhlB1a1oToinE
        zFRNe3Jyvxrn8sQCexMCCmNiVesvSilVFldwhBecGYLHxotNyCQtvgyLm5vplM7e4c4wmIxm
        s95iYk1mI8vMVwVndOxV09mcmz/E8y5e+OdTUDFxhch99JOibVnCztWvLP72CTsWeFGu3erW
        UcvrZ93YJKb8Hgtvh0TDr8W6/FL1wufCuH9JzWAQvx1Sr+vqNu/bc+Kr+0Hj+80fhPsFRTFn
        K4usZXsnTG/qwstH4jus9dO2ddaU5/9sScn9RlZ9J656dbsDn5937ipJOX7wa77nxpfKIUYp
        5nCGREwQub91XA25vgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnK7cs7Y4g/9nlS2aF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDh8emVZ1sHvvnrmH32Lyk3mP9lqss
        Hp83yQWwRnHZpKTmZJalFunbJXBlvJhyhL3gkHnFxX/8DYzvlLsYOTkkBEwkbh6fwtrFyMUh
        JLCbUeLTgW0sEAkZiQkvljBD2MIS91uOQBU9Z5Q486ePHSTBJqArcXnxEyYQWwTI3nxjOTtI
        EbPAP0aJ5rd3mCE6njBKXPxyA2wsp4C+xLQNa8A6hAUCJCbP38kGYrMIqEjs2LkHbB2vgKXE
        jh/3WCBsQYmTM5+A2cwC2hJPbz6Fs5ctfA11noLEz6fLWCGucJO4uvAyVI2IxOzONuYJjMKz
        kIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIziytLR2MJ44
        EX+IUYCDUYmHl+Fga5wQa2JZcWXuIUYJDmYlEV7HGUAh3pTEyqrUovz4otKc1OJDjNIcLEri
        vPL5xyKFBNITS1KzU1MLUotgskwcnFINjIpXXrcGPHDYONnw9Jc1Xj1RLspH5pZnz3J4/on5
        cgnDdpd91b+bZ86eJPn19fXSdMVZX2t03xi++mwpvWvWel7m4GuGRzpP2dsITp14tF7wH49I
        s3eKUtHH3yd3Gncca6w1/PXm0dndOxuWK3/pjnavXT9LpVDv5d7Fm5c4GSnMrU0yd4gLuKvE
        UpyRaKjFXFScCADt4/hOqAIAAA==
X-CMS-MailID: 20200403073038epcas2p220d9fa198f117758f38c999132025839
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3@epcas2p4.samsung.com>
        <20200402110430.31156-1-hyunki00.koo@samsung.com>
        <20200402135903.GA14861@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 10:59:29PM +0900, Krzysztof Kozlowski
> On Thu, Apr 02, 2020 at 08:04:29PM +0900, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c =7C 78
> > +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 66 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 73f951d65b93..826d8c5846a6 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -154,12 +154,47 =40=40 struct s3c24xx_uart_port =7B  =23define
> > portaddrl(port, reg) =5C
> >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> >
> > -=23define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> > +static unsigned int rd_reg(struct uart_port *port, int reg) =7B
> > +	switch (port->iotype) =7B
> > +	case UPIO_MEM:
> > +		return readb_relaxed(portaddr(port, reg));
> > +	case UPIO_MEM32:
> > +		return readl_relaxed(portaddr(port, reg));
> > +	default:
> > +		return 0;
> > +	=7D
> > +	return 0;
> > +=7D
> > +
> >  =23define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> >
> > -=23define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port,
> > reg))
> > +static void wr_reg(struct uart_port *port, int reg, int val) =7B
> > +	switch (port->iotype) =7B
> > +	case UPIO_MEM:
> > +		writeb_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	=7D
> > +=7D
> > +
> >  =23define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port,
> > reg))
> >
> > +static void write_buf(struct uart_port *port, int reg, int val) =7B
> > +	switch (port->iotype) =7B
> > +	case UPIO_MEM:
> > +		writeb(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel(val, portaddr(port, reg));
> > +		break;
> > +	=7D
> > +=7D
> > +
> >  /* Byte-order aware bit setting/clearing functions. */
> >
> >  static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
> > =40=40 -714,7 +749,7 =40=40 static void s3c24xx_serial_rx_drain_fifo(st=
ruct
> s3c24xx_uart_port *ourport)
> >  		fifocnt--;
> >
> >  		uerstat =3D rd_regl(port, S3C2410_UERSTAT);
> > -		ch =3D rd_regb(port, S3C2410_URXH);
> > +		ch =3D rd_reg(port, S3C2410_URXH);
> >
> >  		if (port->flags & UPF_CONS_FLOW) =7B
> >  			int txe =3D s3c24xx_serial_txempty_nofifo(port);
> > =40=40 -826,7 +861,7 =40=40 static irqreturn_t s3c24xx_serial_tx_chars(=
int
> irq, void *id)
> >  	=7D
> >
> >  	if (port->x_char) =7B
> > -		wr_regb(port, S3C2410_UTXH, port->x_char);
> > +		wr_reg(port, S3C2410_UTXH, port->x_char);
> >  		port->icount.tx++;
> >  		port->x_char =3D 0;
> >  		goto out;
> > =40=40 -852,7 +887,7 =40=40 static irqreturn_t s3c24xx_serial_tx_chars(=
int
> irq, void *id)
> >  		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info-
> >tx_fifofull)
> >  			break;
> >
> > -		wr_regb(port, S3C2410_UTXH, xmit->buf=5Bxmit->tail=5D);
> > +		wr_reg(port, S3C2410_UTXH, xmit->buf=5Bxmit->tail=5D);
> >  		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> >  		port->icount.tx++;
> >  		count--;
> > =40=40 -916,7 +951,7 =40=40 static unsigned int
> s3c24xx_serial_tx_empty(struct
> > uart_port *port)
> >  /* no modem control lines */
> >  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
> > =7B
> > -	unsigned int umstat =3D rd_regb(port, S3C2410_UMSTAT);
> > +	unsigned int umstat =3D rd_reg(port, S3C2410_UMSTAT);
> >
> >  	if (umstat & S3C2410_UMSTAT_CTS)
> >  		return TIOCM_CAR =7C TIOCM_DSR =7C TIOCM_CTS; =40=40 -
> 1974,7 +2009,7 =40=40
> > static int s3c24xx_serial_probe(struct platform_device *pdev)
> >  	struct device_node *np =3D pdev->dev.of_node;
> >  	struct s3c24xx_uart_port *ourport;
> >  	int index =3D probe_index;
> > -	int ret;
> > +	int ret, prop =3D 0;
> >
> >  	if (np) =7B
> >  		ret =3D of_alias_get_id(np, =22serial=22); =40=40 -2000,10
> +2035,29 =40=40 static
> > int s3c24xx_serial_probe(struct platform_device *pdev)
> >  			dev_get_platdata(&pdev->dev) :
> >  			ourport->drv_data->def_cfg;
> >
> > -	if (np)
> > +	if (np) =7B
> >  		of_property_read_u32(np,
> >  			=22samsung,uart-fifosize=22, &ourport->port.fifosize);
> >
> > +		if (of_property_read_u32(np, =22reg-io-width=22, &prop) =3D=3D
> 0) =7B
> > +			switch (prop) =7B
> > +			case 1:
> > +				ourport->port.iotype =3D UPIO_MEM;
> > +				break;
> > +			case 4:
> > +				ourport->port.iotype =3D UPIO_MEM32;
> > +				break;
> > +			default:
> > +				dev_warn(&pdev->dev, =22unsupported
> reg-io-width (%d)=5Cn=22,
> > +						prop);
> > +				ret =3D -EINVAL;
> > +				break;
> > +			=7D
> > +		=7D else =7B
> > +			ourport->port.iotype =3D UPIO_MEM;
> > +		=7D
> > +	=7D
>=20
> I think this still breaks all non-DT platforms (e.g. s3c).
>=20
> Best regards,
> Krzysztof

Thank you for your comment.
I  hope ourport->port.iotype  is initialized by below table for non-DT plat=
forms

1662 static struct s3c24xx_uart_port                                       =
 =20
1663 s3c24xx_serial_ports=5BCONFIG_SERIAL_SAMSUNG_UARTS=5D =3D =7B         =
         =20
1664         =5B0=5D =3D =7B                                               =
         =20
1665                 .port =3D =7B                                         =
     =20
1666                         .lock           =3D __PORT_LOCK_UNLOCKED(0),  =
   =20
1667                         .iotype         =3D UPIO_MEM,                 =
   =20
1668                         .uartclk        =3D 0,                        =
   =20
1669                         .fifosize       =3D 16,                       =
   =20
1670                         .ops            =3D &s3c24xx_serial_ops,      =
   =20
1671                         .flags          =3D UPF_BOOT_AUTOCONF,        =
   =20
1672                         .line           =3D 0,                        =
   =20
1673                 =7D                                                   =
   =20
1674         =7D,                                                          =
   =20
1675         =5B1=5D =3D =7B                                               =
         =20
1676                 .port =3D =7B                                         =
     =20
1677                         .lock           =3D __PORT_LOCK_UNLOCKED(1),  =
   =20
1678                         .iotype         =3D UPIO_MEM,                 =
   =20
1679                         .uartclk        =3D 0,                        =
   =20
1680                         .fifosize       =3D 16,                       =
   =20
1681                         .ops            =3D &s3c24xx_serial_ops,      =
   =20
1682                         .flags          =3D UPF_BOOT_AUTOCONF,        =
   =20
1683                         .line           =3D 1,                        =
   =20
1684                 =7D                                                   =
   =20
1685         =7D,

