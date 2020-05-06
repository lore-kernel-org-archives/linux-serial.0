Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB2C38A2A
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 23:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC9320746
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 23:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QwwzYHcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEFXFb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 19:05:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43242 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgEFXF2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 19:05:28 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200506230524epoutp02cd50c9655b22f81f5819902e0db4bed2~Mku8yAwHh3065430654epoutp02U
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 23:05:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200506230524epoutp02cd50c9655b22f81f5819902e0db4bed2~Mku8yAwHh3065430654epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588806324;
        bh=nmHW3hqfsceJoD/TfyBfmBuJRD/79Pt15nGHE8W3KWU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QwwzYHcvnmSl4tJSrv7qIJGZ9sCzl4D9yNY7ep2uITclPweo67agdRipPqWnCHzwA
         gJiy4LMgrVQtZVKO8hF5S3WAdbAHaK+OT/ruH3RKh/WbMNcXsKpV+ZvNJff52QVV70
         0O90egQXhQMY2uzT9kJovxVeMoaDwKNXY71HkG0o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200506230524epcas2p492966ea9e85735a13051d58f8134d0c2~Mku8bwa5M0647206472epcas2p4b;
        Wed,  6 May 2020 23:05:24 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49HXHj5v88zMqYkb; Wed,  6 May
        2020 23:05:21 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C3.04704.1B243BE5; Thu,  7 May 2020 08:05:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200506230521epcas2p4936c698d7dad36716631189b4f532ac1~Mku5sAPIJ3166131661epcas2p4a;
        Wed,  6 May 2020 23:05:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506230521epsmtrp1a1151a35072f8f8c7f34df5cad53d740~Mku5rJwFE0959009590epsmtrp1T;
        Wed,  6 May 2020 23:05:21 +0000 (GMT)
X-AuditID: b6c32a46-811ff70000001260-3d-5eb342b1fbaa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.FA.25866.1B243BE5; Thu,  7 May 2020 08:05:21 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.155.199]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200506230521epsmtip2bb6ba760297dcd1241768add21aea2d3~Mku5cYFfL1363413634epsmtip2B;
        Wed,  6 May 2020 23:05:20 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>
Cc:     "'Kukjin Kim'" <kgene@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <1b230724-c87b-aa28-f850-ecdeb0542dba@samsung.com>
Subject: RE: [PATCH v10 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Thu, 7 May 2020 08:05:20 +0900
Message-ID: <010b01d623fa$d0f26130$72d72390$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFl2PsmRe3/s9lzyUQ9PcEeehh2AH96kRjAjcc4uIB42yit6eMAdEA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhe5Gp81xBht3GFhsnLGe1aJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtwemxa1cnmsX/uGnaPzUvq
        Pfq2rGL0WL/lKovH501yAWxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQv0ihNz
        i0vz0vWS83OtDA0MjEyBKhNyMnZt3cRasEy1YuXyE+wNjBtluxg5OSQETCRePr3P2sXIxSEk
        sINRYtHOD+wQzidGidfTuhkhnM+MEhu3NTLCtFz/MJcNIrGLUeLe6QdQLS8ZJbbuP8gEUsUm
        oCtxefETIJuDQ0TARuL2K3WQGmaBPUwSHb9/gcU5BewltizTBCkXFgiXWP7zBdgCFgEViasH
        vzKDlPAKWEo8uB8EEuYVEJQ4OfMJC4jNLKAtsWzha2aIexQkfj5dxgpiiwi4SfxZ+J4VokZE
        YnZnGzPIWgmBlRwSzY1H2UFmSgi4SMw+zAbRKyzx6vgWdghbSuJlfxuUXS+xr20iO0RvD6PE
        zw9PWSESxhKznrUzgsxhFtCUWL9LH2KkssSRW1Cn8Ul0HP4LtYlXoqNNCKJRTWLdtxdMELaM
        xJqnu9gnMCrNQvLYLCSPzULywCyEXQsYWVYxiqUWFOempxYbFRghR/UmRnBy1XLbwbjknM8h
        RgEORiUe3gPLNsUJsSaWFVfmHmKU4GBWEuHl+bExTog3JbGyKrUoP76oNCe1+BCjKTDYJzJL
        iSbnAxN/Xkm8oamRmZmBpamFqZmRhZI47ybumzFCAumJJanZqakFqUUwfUwcnFINjCa8XWYS
        hbf6fC2viH74UvEia/azwBUxsz6I5LYXyYvrzdyz/E9fqWKxRH3rvoeB69XOVf05Htf5welH
        Lcea2Q9P8+YFpU6YcvD8zVtadXozU7ZxOJY2x35LurXI7O/WgnVbZp/4xtV3/wfrH2aWLbfF
        botVSZke/3haVzD+gUuG/BqvlzdnXlBiKc5INNRiLipOBAC0XziyxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXnej0+Y4g+kt7BYbZ6xntWhevJ7N
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV0bn5XuMBUtVKv6s2MPawLhOpouRk0NC
        wETi+oe5bF2MXBxCAjsYJV7872GHSMhITHixhBnCFpa433KEFaLoOaNE79d1TCAJNgFdicuL
        nwDZHBwiAjYSt1+pg4SZBQ4xSZyalwxR/4VR4lNHCyNIDaeAvcSWZZogNcICoRK3Vn5hBLFZ
        BFQkrh78ygxSwitgKfHgfhBImFdAUOLkzCcsECO1JXoftjLC2MsWvoY6TUHi59NlrCC2iICb
        xJ+F71khakQkZne2MU9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnF
        pXnpesn5uZsYwXGmpbWDcc+qD3qHGJk4GA8xSnAwK4nw8vzYGCfEm5JYWZValB9fVJqTWnyI
        UZqDRUmc9+ushXFCAumJJanZqakFqUUwWSYOTqkGpoLnxwwNqpqrEtfZdHcnX9C+sIH14s+G
        5T9UFgju8GZoEv3yPVFZ9HXv5ihL800hX3/c4AtQm3/+xvfyR21mCzwt7/yfdWBn0rUNrEE9
        XfeZIqwPH1aZ1pNxLCfihUfgceeo4uX73160776b2ng125BNsExTJWx1hbfnXoOWRXlTONfx
        di1Nrom7vPHlyqaSx/9PbJoS6/rehtV1T3Tlw0bviIvsXAtt2a4GWi+ft3iabsaeIAd+V7/q
        MGVH21dGoXqmD7jOlgQzPgrqnymXkvJ84yr9HmHTWgeOp7u6Sj6c21XnGLiATfnuys+NZxnr
        L59bsKNZ2z3DWObbgt9TVHiPXFlga3XQhS/tzn1+JZbijERDLeai4kQA1g95VSIDAAA=
X-CMS-MailID: 20200506230521epcas2p4936c698d7dad36716631189b4f532ac1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb
References: <20200506080242.18623-1-hyunki00.koo@samsung.com>
        <CGME20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb@epcas2p4.samsung.com>
        <20200506080242.18623-3-hyunki00.koo@samsung.com>
        <1b230724-c87b-aa28-f850-ecdeb0542dba@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/6/20 8:03 PM, Bartlomiej Zolnierkiewicz wrote:
> On 5/6/20 10:02 AM, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
>=20
> Krzysztof has asked this previously but I couldn't find the answer in
> previous mails:
>=20
> Do you plan to upstream support for these newer SoCs?
>=20
> If not (i.e. this code is only to support Android GKI) then the code you =
are
> adding now may be removed at any time later during cleanups (due to
> lack of the in-kernel users).
>=20
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk=40kernel.org> Tested on Odroid
> > HC1 (Exynos5422):
> > Tested-by: Krzysztof Kozlowski <krzk=40kernel.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c =7C 62
> > ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 57 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 326b0164609c..6ef614d8648c 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -154,10 +154,33 =40=40 struct s3c24xx_uart_port =7B  =23define
> > portaddrl(port, reg) =5C
> >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> >
> > -=23define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
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
> > -=23define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port,
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
> >  /* Byte-order aware bit setting/clearing functions. */ =40=40 -1974,7
> > +1997,7 =40=40 static int s3c24xx_serial_probe(struct platform_device
> *pdev)
> >  	struct device_node *np =3D pdev->dev.of_node;
> >  	struct s3c24xx_uart_port *ourport;
> >  	int index =3D probe_index;
> > -	int ret;
> > +	int ret, prop =3D 0;
> >
> >  	if (np) =7B
> >  		ret =3D of_alias_get_id(np, =22serial=22); =40=40 -2000,10
> +2023,27 =40=40 static
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
> > +		=7D
> > +	=7D
> > +
> >  	if (ourport->drv_data->fifosize=5Bindex=5D)
> >  		ourport->port.fifosize =3D ourport->drv_data-
> >fifosize=5Bindex=5D;
> >  	else if (ourport->info->fifosize)
> > =40=40 -2587,6 +2627,18 =40=40
> module_platform_driver(samsung_serial_driver);
> >   * Early console.
> >   */
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
> >  struct samsung_early_console_data =7B
> >  	u32 txfull_mask;
> >  =7D;
> > =40=40 -2612,7 +2664,7 =40=40 static void samsung_early_putc(struct
> uart_port *port, int c)
> >  	else
> >  		samsung_early_busyuart(port);
> >
> > -	writeb(c, port->membase + S3C2410_UTXH);
> > +	wr_reg_barrier(port, S3C2410_UTXH, c);
> >  =7D
> >
> >  static void samsung_early_write(struct console *con, const char *s,
> >
Hi
We don't have plan to upstream for new SOCs yet,
This code is only to support Android GKI,=20
But it should not be not removed=20

