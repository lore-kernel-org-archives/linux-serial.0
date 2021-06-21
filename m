Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD8C48BE5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBB61289
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFUOSa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:18:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13288 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOSa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 10:18:30 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210621141613epoutp01400ef6797c0152e680d370fe01f1d1fe~KnpP2GYT11143711437epoutp015
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 14:16:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210621141613epoutp01400ef6797c0152e680d370fe01f1d1fe~KnpP2GYT11143711437epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624284973;
        bh=5mtjQHdXnhJ2AVAxsLrE6LAdwW1kWEOQb0XSgth4DZo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sYRYSEyu+Y6Hg2Nyrk2Qrn6vs/lLAPy3WGUrwQ4FfONV4lTCQCvSHB/uKV2dSKYmW
         czUtm1AZLiO+sR88/+dLP+RG/mKVAnMvFIOVjzEq0ykQGFEvF2P0w9o1gZM0Z0iLOd
         TmZTB6wLnkCVHvYdLYhuPpBLvlrrtuF4Y47swTmE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210621141613epcas5p3853e29e71838ca2aa6988def9256e887~KnpPGLftj0234202342epcas5p3B;
        Mon, 21 Jun 2021 14:16:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.55.09452.C2F90D06; Mon, 21 Jun 2021 23:16:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210621132126epcas5p431c3967a6f5afd9559aa58cac9632c57~Km5aNKdez2707427074epcas5p48;
        Mon, 21 Jun 2021 13:21:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210621132126epsmtrp1fa9c88034271caf18b991a015d3e8833~Km5aMXMGH3059930599epsmtrp1F;
        Mon, 21 Jun 2021 13:21:26 +0000 (GMT)
X-AuditID: b6c32a4b-43fff700000024ec-ef-60d09f2ce64c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.94.08394.65290D06; Mon, 21 Jun 2021 22:21:26 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210621132124epsmtip13bf9bf6b5df514d49057bf3f19670ac6~Km5Yq_k-Q2762727627epsmtip1E;
        Mon, 21 Jun 2021 13:21:24 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <kgene@kernel.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <8935a448-04b7-91ce-203a-9f0d7e377052@canonical.com>
Subject: RE: [PATCH] serial: samsung: use dma_ops of DMA if attached
Date:   Mon, 21 Jun 2021 18:51:23 +0530
Message-ID: <004f01d766a0$567b9860$0372c920$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGDfL5lNG5rzFQPe+FwbDp9GpLyVQGDsg9dAbmelg2rrFi5MA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmlq7O/AsJBsefWVsceH+QxeLBvG1s
        Fs2L17NZTNnwgcmi//FrZouNb38wWWx6fI3V4vKuOWwWM87vY7I4s7iX3YHLY1ZDL5vHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CV0bn7DUvBB7OKTf0v
        WBoYd+p0MXJySAiYSKz6cImli5GLQ0hgN6PE/9N/2SCcT4wSj/YdZ4dwvjFKHLrylhmm5emP
        eVCJvYwSS08fhOp/xiix4+5PdpAqNgFdiUkH25hBEiICbYwS0xs6mEAcZoEzjBKPF09mAqni
        FHCUuNF6AqiKg0NYwEXi1gxvkDCLgKrEvM//GEFsXgFLia5zs1kgbEGJkzOfgNnMAtoSyxa+
        hjpJQeLn02WsILaIgJPE5unb2CFqxCVeHj0CdqqEwA4OiYadL1kgGlwkns7oYIWwhSVeHd/C
        DmFLSbzsb4Oy8yXmz1sFtaBCYuWFN1C2vcSBK3NYQG5mFtCUWL9LHyIsKzH11DomiL18Er2/
        nzBBxHkldsyDsRUl/u/uhxovLvFuxRTWCYxKs5C8NgvJa7OQvDALYdsCRpZVjJKpBcW56anF
        pgXGeanlesWJucWleel6yfm5mxjByUvLewfjowcf9A4xMnEwHmKU4GBWEuG9mXIhQYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvUvZDCUIC6YklqdmpqQWpRTBZJg5OqQamxTvWBYWnf1KaG7rN
        sH7WcY9cp5Tccwb3/jyI+tovU2vmfDn3CoOg0f+eyxs+P6h6cniv5srITIscd9fam6+DV68v
        4Xf+tG3BYel/dhY6LibW2w6keP/V7pqjoxH27/Wn3N/plZsKOCd8dfyYJbNzXfiJd6em6n4+
        vvbN81/atb7meeGnFsZVnpFY2ZfRmy2l+6PomKviDpY1pXve++7NPDvx7RXPjRnHswP2XrbW
        ehAsuKSywnpF65Lqq9snrK7bumXpPYEFwdKuvg7LdJcdu+qttu7OFuegvOB33ttuMM9dK1vn
        cP/T2fclNmWOB867m36+ct71/5djz2YGC5jXRBhusKuofr7Pyare4l+9mRJLcUaioRZzUXEi
        AH6zr2jNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnG7YpAsJBk8/SVgceH+QxeLBvG1s
        Fs2L17NZTNnwgcmi//FrZouNb38wWWx6fI3V4vKuOWwWM87vY7I4s7iX3YHLY1ZDL5vHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CVsbbhKFtBp1nF5z+X
        WRoYb2h3MXJySAiYSDz9MY+9i5GLQ0hgN6PE5FN7mCES4hLTfu1nhLCFJVb+ew5V9IRR4lRr
        GytIgk1AV2LSwTZmkISIQBejxNqrJxhBHGaBC4wS3UdvQLXsZ5Ro2bEdbBangKPEjdYTQC0c
        HMICLhK3ZniDhFkEVCXmff4HVsIrYCnRdW42C4QtKHFy5hMwm1lAW6L3YSsjjL1s4WuoUxUk
        fj5dBnaRiICTxObp29ghasQlXh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsW
        GOallusVJ+YWl+al6yXn525iBMegluYOxu2rPugdYmTiYDzEKMHBrCTCezPlQoIQb0piZVVq
        UX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTEs/lqdP49HaaRTGPLnY
        77Usz5LWP74ZXWUfg8pLTi0/8jdj3+S9wYECq0y97Kbt/nNukVJRVuWcV0pPc50KTm1P4zGq
        8F/GwHrsjzfLv6M+wuJvb/av/r3FNludw0Urz7TpZqFI29Z3sn7a9+xqntoadUfcrljRfjNb
        cFmGy92chTOcDI+q+nOKqDrbpWQ+3/Z0T6L1uxdbXvz9zdI9p3DqmYtsMvNM3M/4yrzI+/vj
        yVzTlmvCjndTm7uF7j+ZPadIIUf59d6eaVc689ddmmDJMi1i7a/3/MZHP+h8yVkwZXPo+fxP
        uyI695/tzn5ldPNkjfvjP238mzPXJOvKaz866DXLusBNYkN7XZWauhJLcUaioRZzUXEiAD2K
        1KMwAwAA
X-CMS-MailID: 20210621132126epcas5p431c3967a6f5afd9559aa58cac9632c57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210621044517epcas5p187affa518a18a3d019deb0c189cd8396
References: <CGME20210621044517epcas5p187affa518a18a3d019deb0c189cd8396@epcas5p1.samsung.com>
        <20210621044916.41564-1-m.shams@samsung.com>
        <8935a448-04b7-91ce-203a-9f0d7e377052@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

>=20
> Hi,
>=20
> Thanks for the patch.
>=20
> On 21/06/2021 06:49, Tamseel Shams wrote:
> > When DMA is used for TX and RX by serial driver, it should pass the
> > DMA device pointer to DMA API instead of UART device pointer.
>=20
> Hmmm, but why DMA device pointer should be used?
>=20
> >
> > This patch is necessary to fix the SMMU page faults which is observed
> > when a DMA(with SMMU enabled) is attached to UART for transfer.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c =7C 60
> > +++++++++++++++++++++++++-------
> >  1 file changed, 48 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index b923683e6a25..5bdc7dd2a5e2 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -284,8 +284,13 =40=40 static void s3c24xx_serial_stop_tx(struct =
uart_port
> *port)
> >  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >  	struct circ_buf *xmit =3D &port->state->xmit;
> >  	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >  	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
>=20
> You mention here and further comments =22dma_ops=22. I don't see you chan=
ging
> the DMA ops, but the device. It's quite confusing. I think you meant a DM=
A
> device shall be passed to DMA API?
>=20
Yes, DMA device should be used for DMA API because only the DMA device is a=
ware of
how the device connects to the memory. There might be an extra level of add=
ress translation
due to a SMMU attached to the DMA device. When serial device pointer device=
 is used
for DMA API, the DMA API will have no clue of the SMMU attached to the DMA =
device.

> Second question: you write that DMA devices should be used if DMA is atta=
ched
> and in the code you follow such pattern a lot:
>=20
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> > +
>=20
> Are you trying to say that if DMA is not attached, UART device should be =
used? If
> DMA is not attached, how are the DMA operations used then?
>=20
If DMA is not attached, this part of code related to dma_engine or DMA API =
do not
get called. There will not be any DMA operations at all.

> >  	if (=21ourport->tx_enabled)
> >  		return;
> >
> > =40=40 -298,7 +303,7 =40=40 static void s3c24xx_serial_stop_tx(struct u=
art_port
> *port)
> >  		dmaengine_pause(dma->tx_chan);
> >  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >  		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_sync_single_for_cpu(ourport->port.dev,
> > +		dma_sync_single_for_cpu(dma_map_ops_dev,
> >  			dma->tx_transfer_addr, dma->tx_size,
> DMA_TO_DEVICE);
> >  		async_tx_ack(dma->tx_desc);
> >  		count =3D dma->tx_bytes_requested - state.residue; =40=40 -324,15
> +329,19
> > =40=40 static void s3c24xx_serial_tx_dma_complete(void *args)
> >  	struct circ_buf *xmit =3D &port->state->xmit;
> >  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >  	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >  	unsigned long flags;
> >  	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >
> >  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >  	count =3D dma->tx_bytes_requested - state.residue;
> >  	async_tx_ack(dma->tx_desc);
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
> >  				dma->tx_size, DMA_TO_DEVICE);
> >
> >  	spin_lock_irqsave(&port->lock, flags); =40=40 -408,7 +417,11 =40=40 s=
tatic
> > int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> >  	struct uart_port *port =3D &ourport->port;
> >  	struct circ_buf *xmit =3D &port->state->xmit;
> >  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >
> >  	if (ourport->tx_mode =21=3D S3C24XX_TX_DMA)
> >  		enable_tx_dma(ourport);
> > =40=40 -416,7 +429,7 =40=40 static int s3c24xx_serial_start_tx_dma(stru=
ct
> s3c24xx_uart_port *ourport,
> >  	dma->tx_size =3D count & =7E(dma_get_cache_alignment() - 1);
> >  	dma->tx_transfer_addr =3D dma->tx_addr + xmit->tail;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma-
> >tx_transfer_addr,
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma-
> >tx_transfer_addr,
> >  				dma->tx_size, DMA_TO_DEVICE);
> >
> >  	dma->tx_desc =3D dmaengine_prep_slave_single(dma->tx_chan,
> > =40=40 -483,12 +496,17 =40=40 static void s3c24xx_uart_copy_rx_to_tty(s=
truct
> s3c24xx_uart_port *ourport,
> >  		struct tty_port *tty, int count)
> >  =7B
> >  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >  	int copied;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> > +
> >  	if (=21count)
> >  		return;
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> >
> >  	ourport->port.icount.rx +=3D count;
> > =40=40 -600,8 +618,13 =40=40 static void s3c24xx_serial_rx_dma_complete=
(void
> > *args)  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port
> > *ourport)  =7B
> >  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> > +
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> >
> >  	dma->rx_desc =3D dmaengine_prep_slave_single(dma->rx_chan,
> > =40=40 -983,6 +1006,7 =40=40 static int s3c24xx_serial_request_dma(stru=
ct
> > s3c24xx_uart_port *p)
>=20
> Offset of hunks looks here significantly different than mainline. The pat=
ch should
> be based and tested mainline tree. Which one did you choose as base?
>=20
> Using my email address not from get_maintainers.pl also suggests that you
> don't use anything recent as a base.
>=20
I used =22master=22 branch of main linux-next tree as the base.
I will rebase on =22tty-next=22 branch of TTY tree and post again.

Thanks & Regards,
Tamseel Shams

