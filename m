Return-Path: <SRS0=ea9B=5V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC3C2BA2B
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 21:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960BC20678
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UAJoGgpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDEVlP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:41:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42763 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgDEVlP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Apr 2020 17:41:15 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200405214113epoutp04cc94a9d9415099a64c3e6c4bd719db2b~DClmCZ1zC2854828548epoutp04O
        for <linux-serial@vger.kernel.org>; Sun,  5 Apr 2020 21:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200405214113epoutp04cc94a9d9415099a64c3e6c4bd719db2b~DClmCZ1zC2854828548epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586122873;
        bh=buch2F0cuMmCWkkZuNUcYvZTm7WO7yNvG1+1XYHEp+o=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UAJoGgpbI5lq8ZRE1owND6e1tXuP9k2dCRJYCsWsH+miJS+nFKyk2wOtmfzss+Xyz
         6cjs/d64NbItYYVAiggm0cUJklhI0uloIt4KUP+1YX3stRTa1ZniMyIIwcIAD4jwjK
         JGa4W1RSn0zX8vFkw7l5UA0xihbNjd4zQXel8cW4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200405214112epcas2p37f4571a8c066168382d7f4baa5b10ece~DCllmsKkj1957819578epcas2p3Y;
        Sun,  5 Apr 2020 21:41:12 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48wRtt6FH9zMqYlh; Sun,  5 Apr
        2020 21:41:10 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.4F.04598.6705A8E5; Mon,  6 Apr 2020 06:41:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200405214110epcas2p267b641011ed40d0f99226349846c6997~DCljHSRCs1147711477epcas2p2_;
        Sun,  5 Apr 2020 21:41:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200405214110epsmtrp1fd0b78c1d038d868f9219d1ef4edd83e~DCljGnReb1185611856epsmtrp1b;
        Sun,  5 Apr 2020 21:41:10 +0000 (GMT)
X-AuditID: b6c32a45-eb9ff700000011f6-e3-5e8a507618e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.53.04158.6705A8E5; Mon,  6 Apr 2020 06:41:10 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200405214110epsmtip195d11651e5ff5aa266337470f8f5c3a2~DCli-O18y1144411444epsmtip1P;
        Sun,  5 Apr 2020 21:41:10 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403133457.GA7561@kozik-lap>
Subject: RE: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Mon, 6 Apr 2020 06:41:09 +0900
Message-ID: <000101d60b92$eb97c050$c2c740f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QHXsprVAbJLbnoB7ziKYabh8Myw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmqW5ZQFecwcunRhbNi9ezWUzZ8IHJ
        ov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyOLO4l92Bw2PTqk42j/1z17B7bF5S77F+y1UW
        j8+b5AJYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXrJefnWhka
        GBiZAlUm5GTMWDqVueCZXsX9HScYGxhXq3YxcnJICJhIdM/fyt7FyMUhJLCDUWLy4yZGCOcT
        o8S/MyuZIZxvjBJPGl6yw7S8aTkHldjLKHH5dxcThPOSUWL23SvMIFVsAroSlxc/YQKxRYDs
        zTeWgy1hFvjBKLHv2zlWkASngJ7Ev13HWUBsYYEgidlT/oA1sAioSKzccghsHa+ApcTG1+9Y
        IWxBiZMzn4DVMwtoSyxb+JoZ4iQFiZ9Pl7FCLHOT2PV5OVSNiMTszjawUyUEnrNJ3Pn8jw2i
        wUVizsz5UM3CEq+Ob4H6TUriZX8blF0vsa9tIjtEcw+jxM8PT1khEsYSs561A4OJA2iDpsT6
        XfogpoSAssSRW1B7+SQ6Dv9lhwjzSnS0CUE0qkms+/aCCcKWkVjzdBf7BEalWUg+m4Xks1lI
        PpiFsGsBI8sqRrHUguLc9NRiowJD5OjexAhOqFquOxhnnPM5xCjAwajEw7viRmecEGtiWXFl
        7iFGCQ5mJRFeqV6gEG9KYmVValF+fFFpTmrxIUZTYMBPZJYSTc4HJvu8knhDUyMzMwNLUwtT
        MyMLJXHezdw3Y4QE0hNLUrNTUwtSi2D6mDg4pRoYXffU2a6dO23z1TkGp3vq3fxPFTcJOuzx
        5ZzqKbtNNfbk1DpFTZWnEVfrv84JvmKm+DbgeV66009NH/k2G7UK08kd2k7PLkWcF3QR1N+3
        JkhFUF7EJcip7kCt3/UT86YscZj27+tEqQUzPq18IWY9pffHpvAZqlMfvkv4mztpqo+sHHfC
        7rLvSizFGYmGWsxFxYkAiLXvnb4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnG5ZQFecwbGLHBbNi9ezWUzZ8IHJ
        ov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyOLO4l92Bw2PTqk42j/1z17B7bF5S77F+y1UW
        j8+b5AJYo7hsUlJzMstSi/TtErgy1m3ZzlhwRrfi7cNrrA2ME1W6GDk5JARMJN60nGPuYuTi
        EBLYzSjx/9xGVoiEjMSEF0uYIWxhifstR1ghip4zSsw+c5EJJMEmoCtxefETMFsEyN58Yzk7
        SBGzwD9Giea3d6DGPmaUmHjsKgtIFaeAnsS/XcfBbGGBAIlFK46CrWARUJFYueUQO4jNK2Ap
        sfH1O1YIW1Di5MwnYPXMAtoST28+hbOXLXwNdZ6CxM+ny1ghrnCT2PV5OVSNiMTszjbmCYzC
        s5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4trS0djCe
        OBF/iFGAg1GJh3fFjc44IdbEsuLK3EOMEhzMSiK8Ur1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYxMW0+zBuU1LZzpxlHYJ6wfN6HgWXLmmZytMiyJ
        eUfmON7m/vUjmu/n6p4Owx3ZdxVuTnEIEdHX+Dq/7LNPTI21r8DF9jLBDfuSJ2j6mzLymcR8
        /b9vpvrlyui4p8uF4ionZxjkPM4+KDvzSXCb+ZrVNdn307wjvKeJas6dz9T1xX7SCR7TKiWW
        4oxEQy3mouJEAGaTGiGpAgAA
X-CMS-MailID: 20200405214110epcas2p267b641011ed40d0f99226349846c6997
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
        <20200403111511.10598-1-hyunki00.koo@samsung.com>
        <20200403133457.GA7561@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 10:35:10PM +0900, Krzysztof Kozlowski wrote:
> On Fri, Apr 03, 2020 at 08:15:10PM +0900, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > ---
> > v2:
> > line 954 : change rd_regl to rd_reg in for backward compatibility.
> > line 2031: Add init value for ourport->port.iotype  to UPIO_MEM
> > v3:
> > line 2031: remove redundant init value  for ourport->port.iotype
> > v4:
> > correct variable types and change misleading function name
> > ---
> >  drivers/tty/serial/samsung_tty.c =7C 76
> > +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 64 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 73f951d65b93..bdf1d4d12cb1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -154,12 +154,47 =40=40 struct s3c24xx_uart_port =7B  =23define
> > portaddrl(port, reg) =5C
> >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> >
> > -=23define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> > +static u32 rd_reg(struct uart_port *port, u32 reg) =7B
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
> > +static void wr_reg(struct uart_port *port, u32 reg, u32 val) =7B
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
> > +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> > +=7B
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
> +2035,27 =40=40 static
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
>=20
> I got more thoughts... where is the binding for it? It looked like standa=
rd
> DT property but it is not described in device tree spec.
>=20
> Also, where is the user (DTS) with it? I expect such changes go with the
> user itself... otherwise, next cleanup it will go away.
>=20
> Best regards,
> Krzysztof

Do you think this kind of change is needed?
Do I have to make as a series patches with previous patch?

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/D=
ocumentation/devicetree/bindings/serial/samsung_uart.yaml
index 9d2ce347875b..a57b1233c691 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
=40=40 -29,6 +29,14 =40=40 properties:
   reg:
     maxItems: 1
=20
+  reg-io-width:
+    description: =7C
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    allOf:
+      - =24ref: /schemas/types.yaml=23/definitions/uint32
+      - enum: =5B 1, 4 =5D
+

