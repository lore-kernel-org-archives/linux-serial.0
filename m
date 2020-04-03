Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DFC2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6B02073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RT1gv5ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDCKTh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:19:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13681 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390597AbgDCKTg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 06:19:36 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200403101934epoutp011371a102430e2eb779e2b4bf5d0f6cdb~CR-3FA3g82552925529epoutp01m
        for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2020 10:19:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200403101934epoutp011371a102430e2eb779e2b4bf5d0f6cdb~CR-3FA3g82552925529epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585909174;
        bh=eTptNHCPGOilNHW1sYrUCropOS7u8CusvrQXpKeUFgs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RT1gv5gaSbsx+hM0wk8TllUqqVktkRRM/xfQ25ZGJ1bil3OcWyJevEKUGaJsbaeNM
         3HNjX5j8IUSf1YmP2xAoMkhKI8tRwkyjwDlYuQHa3AoXuA4Qyy+0TTq1Yubyldavcv
         5VtRHM7dgrb6Mqnr112/HKkjraKGjiVA2dcEF79k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200403101933epcas2p390c6ec32c7b8cb37ac0246c60be74f9f~CR-2qx-Ny1967219672epcas2p3f;
        Fri,  3 Apr 2020 10:19:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.190]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48twsH4sBBzMqYkZ; Fri,  3 Apr
        2020 10:19:31 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.67.04598.3BD078E5; Fri,  3 Apr 2020 19:19:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200403101930epcas2p142837d679a3e7a9e3eb11c2c1ea9792c~CR-0ABDFf1040610406epcas2p1i;
        Fri,  3 Apr 2020 10:19:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200403101930epsmtrp19a630bfad8e9ed97b8e02389b2a2e239~CR-z8j0M01547015470epsmtrp1b;
        Fri,  3 Apr 2020 10:19:30 +0000 (GMT)
X-AuditID: b6c32a45-eb9ff700000011f6-5d-5e870db3eda5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.5B.04158.2BD078E5; Fri,  3 Apr 2020 19:19:30 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200403101930epsmtip2b09e3b4a12fd05e28b8e971f2148529f~CR-z0jih_1447814478epsmtip24;
        Fri,  3 Apr 2020 10:19:30 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403075122.GA9358@kozik-lap>
Subject: RE: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Fri, 3 Apr 2020 19:19:30 +0900
Message-ID: <005501d609a1$5cbbbb40$163331c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QJJhiU1AnstEDsBfb5gtwEN9w2NAuyyasumt/H/gA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGO7vb3dVa3KbVy/paNzM0tF1rdi2NQotREVJUEOG66EFH+2p3
        itofCtb8KCsrwZaBZRRJpKmZjdLUwD7EGWZoQWVqZIOyIlOhj7tdI//7nfd9Ht73OedQhLqG
        1FAmqxM7rLyZIYPlTR0RXFSDqjBFN/E0jCuoriW583VjMu70kI/gvN46JVc/9FLB9XoqSa7C
        2yLjuqpLlZspQ31NMWlovXRTaWi4mmeobeyTG77XL01WHDDHZ2A+DTu02JpqSzNZ0xOYHXuM
        iUZ9rI6NYuO49YzWyltwApO0Mzlqm8ksrsJos3hzplhK5gWBWbMp3mHLdGJthk1wJjDYnma2
        s6w9WuAtQqY1PTrVZtnA6nQxelF5yJxxrKeftH9ls0vybxD56O3KEhREAb0OvvW9IEtQMKWm
        mxGc+vGGkA7fEPz4+R75VWp6HMEXz5F/Dq9rYtrxAMEJb5FCOowiOOcrDjhIOgp6q4dlfg4V
        uaH/utIvIugJBC3j3Qp/I4iOhtI/dwKiEHo3uLsfE36W02Hw/GNdgFV0HNTcf09KPA+eXBiW
        +5mgV8O1yz5CWkkLkyPXFNKwfeBtHpNJmlC4WOwK5AHaR0JBa5NSMiRBVblXLnEIfOpsnK5r
        YPS0a5rzoMVVppTMJxFMjo0opMZacH8oFGNS4oQIqPWs8SPQK+DRq+nd5kJRxy+lVFZBkUst
        GcPh1vhHmcSL4eaIR3kGMe4ZydwzkrlnJHD/n1WF5DVoAbYLlnQsxNjZma9djwL/NHJrM6ro
        3tmOaAoxc1Sz2o6nqBV8lpBjaUdAEUyoakuFWFKl8Tm52GEzOjLNWGhHevHiywjN/FSb+Out
        TiOrj4mN1cXpOX1sDMcsVDXMHjioptN5Jz6MsR07/vlkVJAmHy3n7BEDYVdSw4YIbkXh9rPO
        FOPRVUvqZrdqsoe6bo/iqd5zPcOVo5bXbNJq3PSuPbika8Gq5Y/bHq4rKEyO85Uz+YOn8Oe8
        5qDzuZd8S+f0/5m4uzl63r1Fvz2NsMtUxm+ZWrZXCF+035O9sUo2uPJZZ2PinhDacuaAehAb
        TA/CGbmQwbORhEPg/wK2ZbDjvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvO4m3vY4g03b1C2aF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDh8emVZ1sHvvnrmH32Lyk3mP9lqss
        Hp83yQWwRnHZpKTmZJalFunbJXBl9M+4wVhwx6DiytIj7A2MR1S6GDk5JARMJM63/WDrYuTi
        EBLYzSgxcVEXG0RCRmLCiyXMELawxP2WI6wQRc8ZJVb07GYCSbAJ6EpcXvwEzBYBsjffWM4O
        UsQs8I9RovHnZKixW5gkdpxdCTaWU0BPovf/VrAOYYEAicnzd4LFWQRUJC6+2AC2jlfAUmLV
        nkdsELagxMmZT1hAbGYBbYmnN5/C2csWvoY6T0Hi59NlrBBXhEmc3/GBCaJGRGJ2ZxvzBEbh
        WUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcW1paOxhP
        nIg/xCjAwajEw8twsDVOiDWxrLgy9xCjBAezkgiv4wygEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV75/GORQgLpiSWp2ampBalFMFkmDk6pBkaDJeefXjrnanjez2l3j42e9Pbj6o0CCkEcvnP0
        TLleKPd87g12Xio8q/DPnmXbD/6d8CNkcu7MDvXnfutkrTYsvyue0uuUVdzy69Q5q9L2f/aH
        3d8+M4lbxOt44ORHlQi3z26Cfxt3LpJ+cvh2gEpa+If07OfL3+wSVdh5Wa1unQ63VrubUr0S
        S3FGoqEWc1FxIgB5MaCvqQIAAA==
X-CMS-MailID: 20200403101930epcas2p142837d679a3e7a9e3eb11c2c1ea9792c
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
        <004c01d60989$c5923030$50b69090$@samsung.com>
        <20200403075122.GA9358@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 4:51:29PM +0900, Krzysztof Kozlowski
> On Fri, Apr 03, 2020 at 04:30:38PM +0900, Hyunki Koo wrote:
> > On Thu, Apr 02, 2020 at 10:59:29PM +0900, Krzysztof Kozlowski
> > > On Thu, Apr 02, 2020 at 08:04:29PM +0900, Hyunki Koo wrote:
> > > > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > > >
> > > > This is required for some newer SoCs.
> > > >
> > > > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > > > ---
> > > >  drivers/tty/serial/samsung_tty.c =7C 78
> > > > +++++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 66 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/samsung_tty.c
> > > > b/drivers/tty/serial/samsung_tty.c
> > > > index 73f951d65b93..826d8c5846a6 100644
> > > > --- a/drivers/tty/serial/samsung_tty.c
> > > > +++ b/drivers/tty/serial/samsung_tty.c
> > > > =40=40 -154,12 +154,47 =40=40 struct s3c24xx_uart_port =7B  =23defi=
ne
> > > > portaddrl(port, reg) =5C
> > > >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> > > >
> > > > -=23define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> > > > +static unsigned int rd_reg(struct uart_port *port, int reg) =7B
> > > > +	switch (port->iotype) =7B
> > > > +	case UPIO_MEM:
> > > > +		return readb_relaxed(portaddr(port, reg));
> > > > +	case UPIO_MEM32:
> > > > +		return readl_relaxed(portaddr(port, reg));
> > > > +	default:
> > > > +		return 0;
> > > > +	=7D
> > > > +	return 0;
> > > > +=7D
> > > > +
> > > >  =23define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> > > >
> > > > -=23define wr_regb(port, reg, val) writeb_relaxed(val,
> > > > portaddr(port,
> > > > reg))
> > > > +static void wr_reg(struct uart_port *port, int reg, int val) =7B
> > > > +	switch (port->iotype) =7B
> > > > +	case UPIO_MEM:
> > > > +		writeb_relaxed(val, portaddr(port, reg));
> > > > +		break;
> > > > +	case UPIO_MEM32:
> > > > +		writel_relaxed(val, portaddr(port, reg));
> > > > +		break;
> > > > +	=7D
> > > > +=7D
> > > > +
> > > >  =23define wr_regl(port, reg, val) writel_relaxed(val,
> > > > portaddr(port,
> > > > reg))
> > > >
> > > > +static void write_buf(struct uart_port *port, int reg, int val) =
=7B
> > > > +	switch (port->iotype) =7B
> > > > +	case UPIO_MEM:
> > > > +		writeb(val, portaddr(port, reg));
> > > > +		break;
> > > > +	case UPIO_MEM32:
> > > > +		writel(val, portaddr(port, reg));
> > > > +		break;
> > > > +	=7D
> > > > +=7D
> > > > +
> > > >  /* Byte-order aware bit setting/clearing functions. */
> > > >
> > > >  static inline void s3c24xx_set_bit(struct uart_port *port, int
> > > > idx, =40=40 -714,7 +749,7 =40=40 static void
> > > > s3c24xx_serial_rx_drain_fifo(struct
> > > s3c24xx_uart_port *ourport)
> > > >  		fifocnt--;
> > > >
> > > >  		uerstat =3D rd_regl(port, S3C2410_UERSTAT);
> > > > -		ch =3D rd_regb(port, S3C2410_URXH);
> > > > +		ch =3D rd_reg(port, S3C2410_URXH);
> > > >
> > > >  		if (port->flags & UPF_CONS_FLOW) =7B
> > > >  			int txe =3D s3c24xx_serial_txempty_nofifo(port);
> > > > =40=40 -826,7 +861,7 =40=40 static irqreturn_t
> s3c24xx_serial_tx_chars(int
> > > irq, void *id)
> > > >  	=7D
> > > >
> > > >  	if (port->x_char) =7B
> > > > -		wr_regb(port, S3C2410_UTXH, port->x_char);
> > > > +		wr_reg(port, S3C2410_UTXH, port->x_char);
> > > >  		port->icount.tx++;
> > > >  		port->x_char =3D 0;
> > > >  		goto out;
> > > > =40=40 -852,7 +887,7 =40=40 static irqreturn_t
> s3c24xx_serial_tx_chars(int
> > > irq, void *id)
> > > >  		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info-
> > > >tx_fifofull)
> > > >  			break;
> > > >
> > > > -		wr_regb(port, S3C2410_UTXH, xmit->buf=5Bxmit->tail=5D);
> > > > +		wr_reg(port, S3C2410_UTXH, xmit->buf=5Bxmit->tail=5D);
> > > >  		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > > >  		port->icount.tx++;
> > > >  		count--;
> > > > =40=40 -916,7 +951,7 =40=40 static unsigned int
> > > s3c24xx_serial_tx_empty(struct
> > > > uart_port *port)
> > > >  /* no modem control lines */
> > > >  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port
> > > > *port) =7B
> > > > -	unsigned int umstat =3D rd_regb(port, S3C2410_UMSTAT);
> > > > +	unsigned int umstat =3D rd_reg(port, S3C2410_UMSTAT);
> > > >
> > > >  	if (umstat & S3C2410_UMSTAT_CTS)
> > > >  		return TIOCM_CAR =7C TIOCM_DSR =7C TIOCM_CTS; =40=40 -
> > > 1974,7 +2009,7 =40=40
> > > > static int s3c24xx_serial_probe(struct platform_device *pdev)
> > > >  	struct device_node *np =3D pdev->dev.of_node;
> > > >  	struct s3c24xx_uart_port *ourport;
> > > >  	int index =3D probe_index;
> > > > -	int ret;
> > > > +	int ret, prop =3D 0;
> > > >
> > > >  	if (np) =7B
> > > >  		ret =3D of_alias_get_id(np, =22serial=22); =40=40 -2000,10
> > > +2035,29 =40=40 static
> > > > int s3c24xx_serial_probe(struct platform_device *pdev)
> > > >  			dev_get_platdata(&pdev->dev) :
> > > >  			ourport->drv_data->def_cfg;
> > > >
> > > > -	if (np)
> > > > +	if (np) =7B
> > > >  		of_property_read_u32(np,
> > > >  			=22samsung,uart-fifosize=22, &ourport->port.fifosize);
> > > >
> > > > +		if (of_property_read_u32(np, =22reg-io-width=22, &prop) =3D=3D
> > > 0) =7B
> > > > +			switch (prop) =7B
> > > > +			case 1:
> > > > +				ourport->port.iotype =3D UPIO_MEM;
> > > > +				break;
> > > > +			case 4:
> > > > +				ourport->port.iotype =3D UPIO_MEM32;
> > > > +				break;
> > > > +			default:
> > > > +				dev_warn(&pdev->dev, =22unsupported
> > > reg-io-width (%d)=5Cn=22,
> > > > +						prop);
> > > > +				ret =3D -EINVAL;
> > > > +				break;
> > > > +			=7D
> > > > +		=7D else =7B
> > > > +			ourport->port.iotype =3D UPIO_MEM;
> > > > +		=7D
> > > > +	=7D
> > >
> > > I think this still breaks all non-DT platforms (e.g. s3c).
> > >
> > > Best regards,
> > > Krzysztof
> >
> > Thank you for your comment.
> > I  hope ourport->port.iotype  is initialized by below table for non-DT
> > platforms
>=20
> Indeed, you're right. In this case, this else() you added is not needed.
> The default value for non-DT and existing DT platforms will be the same
> (UPIO_MEM).
>=20
> Best regards,
> Krzysztof

Thank you  for your comment.
I will remove  this line also in v3
+		=7D else =7B
+			ourport->port.iotype =3D UPIO_MEM;

