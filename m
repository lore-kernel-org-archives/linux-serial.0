Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF9CC2B9F4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961216128A
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFVICM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:02:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33564 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFVICL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 04:02:11 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210622075241epoutp037e2249a34530da8b6ec6ee1440301864~K2DqAL6o30228102281epoutp03e
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 07:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210622075241epoutp037e2249a34530da8b6ec6ee1440301864~K2DqAL6o30228102281epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624348361;
        bh=b2T6MY1kZ9SohFnqiNwSCGWC99b+qKgTnX9g0ikzxy4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SaagilmJU04NfgT1p9x30kLtXqAbRHn/vrcoutfK+Y+s8srA/7yFkj6lN8wkKWy2p
         6XM5omcWH8cn2kgEkUudWgfMl3WCJRqeLZ9S8Ll0/pcL5v5NOr0uUXvIbnCbmu1mqC
         wTjpk7DxjlHcJiXpnmrvmWnB4SYr3cquwsg6roek=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210622075240epcas5p3df72ffba15fb235adbb38455a18cf33b~K2DpMu8Tr2865028650epcas5p3g;
        Tue, 22 Jun 2021 07:52:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.F6.09476.8C691D06; Tue, 22 Jun 2021 16:52:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210622075225epcas5p13270a3a17544fa110af21aaff82ceb84~K2Dbc4heu2192421924epcas5p11;
        Tue, 22 Jun 2021 07:52:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210622075225epsmtrp2e0157be39c97fe9c09a7116858b0408f~K2DbcFLR52613926139epsmtrp2a;
        Tue, 22 Jun 2021 07:52:25 +0000 (GMT)
X-AuditID: b6c32a49-6a1ff70000002504-6f-60d196c8341a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.DB.08394.9B691D06; Tue, 22 Jun 2021 16:52:25 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210622075224epsmtip123273eb378191cff03467278d9b125f7~K2DZ49-Lm1537015370epsmtip1o;
        Tue, 22 Jun 2021 07:52:23 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <kgene@kernel.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <4b2576c1-c986-a4d8-d6cf-661ca056ecee@canonical.com>
Subject: RE: [PATCH] serial: samsung: use dma_ops of DMA if attached
Date:   Tue, 22 Jun 2021 13:22:22 +0530
Message-ID: <007901d7673b$8a758d10$9f60a730$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGDfL5lNG5rzFQPe+FwbDp9GpLyVQGDsg9dAbmelg0Cc6DxagIMN/A2q4mTjPA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmpu6JaRcTDHo3S1kceH+QxeLBvG1s
        Fs2L17NZTNnwgcmi//FrZouNb38wWWx6fI3V4vKuOWwWM87vY7I4s7iX3YHLY1ZDL5vHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CVcfTORdaCDXYVcx6c
        Y2pg3GXUxcjJISFgIrFqw2SWLkYuDiGB3YwSzXcOsUM4nxglGvadYoNwvjFKfLrwlQWmZd/F
        d4wQib2MEo86nkI5zxglfj5ZyQhSxSagKzHpYBszSEJEoI1RYnpDBxOIwyxwhlHi8eLJTCBV
        nAKOEo++dgDN5eAQFnCRuDXDGyTMIqAqseznNLB1vAKWEqf/vGSGsAUlTs58AhZnFtCWWLbw
        NTPESQoSP58uYwWxRQT8JH7/vc8OUSMu8fLoEbCHJAQOcEjsmHiFFaLBRaJhdQsbhC0s8er4
        FnYIW0ri87u9UPF8ifnzVkEtqJBYeeENlG0vceDKHLCbmQU0Jdbv0ocIy0pMPbWOCWIvn0Tv
        7ydMEHFeiR3zYGxFif+7+6FWiUu8WzGFdQKj0iwkr81C8tosJC/MQti2gJFlFaNkakFxbnpq
        sWmBYV5quV5xYm5xaV66XnJ+7iZGcPLS8tzBePfBB71DjEwcjIcYJTiYlUR4X2RfTBDiTUms
        rEotyo8vKs1JLT7EKM3BoiTOu5T9UIKQQHpiSWp2ampBahFMlomDU6qBybgwVF+s6/Fr73s6
        Mc8nd9rb+ihvva+jUNxRvTIuP5Fjms2iWQsdv+QlFZ1J3C0ecWud28cu4anfXlV5/prVNP+u
        yE6Xc3LKJiu6tVSfPkk2/bT5xq70HT8vpPrfkZp7Y+eN5leKjvWG2oIzeQ+r1HHv3yUoyCf1
        iG+3QQ/j5YAPHE/lqprnbArnL1683OSh5aejbtX1TL8kJZ7vuiTBtbFHaXXdpOkLVtt9XMhw
        keHC6tWv52axhK1bPE3i0D1lrdOZc7teTWvK6Mt+IhXfKRnE0bbb4Y7FhMSnVlbr38b6Vmy+
        wOi16N3T20yr5N5s/3g8z0O+5vnKRcIfeZLV9/3TnO/D4X3vY9tZIe4WDiWW4oxEQy3mouJE
        AKIOTsTNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO7OaRcTDO5MVrU48P4gi8WDedvY
        LJoXr2ezmLLhA5NF/+PXzBYb3/5gstj0+BqrxeVdc9gsZpzfx2RxZnEvuwOXx6yGXjaPTas6
        2Tz2z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6APYrLJiU1J7MstUjfLoEr4+6NCUwFV2wrrqy9
        zdLAeMmwi5GTQ0LARGLfxXeMXYxcHEICuxklepddZ4VIiEtM+7WfEcIWllj57zk7RNETRom7
        x3ezgyTYBHQlJh1sYwZJiAh0MUqsvXoCbBSzwAVGie6jN6BaFjFJ3F24jRmkhVPAUeLR1w6W
        LkYODmEBF4lbM7xBwiwCqhLLfk5jAbF5BSwlTv95yQxhC0qcnPkELM4soC3R+7CVEcZetvA1
        M8R5ChI/ny4DO1tEwE/i99/77BA14hIvjx5hn8AoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY1BLcwfj9lUf9A4xMnEwHmKU4GBWEuF9kX0xQYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmP403+9Mq6zvl
        1UrWCTNJ3ljplP5h741bsTqRXfKuZ9w72xS3LHB6mOR8+ugJMbbnx723sUys4z5art4karfO
        R7332KqmBYIvWn9tmcx+ZPvF2acfJbc9ddj83X3Bp4aasDt2/3k/35juwLg6yaSNz2VD8eeJ
        oe8V/Yo7f11z7Vd8+vpc6Z57ObEsm/tu/32wRn3ZrK3r188Je1C22O3inlbBNW1MnK8nafqV
        NW7d2FwcZKfy/bXEDK+OE1e2iQvG6PE3rzw64aDUJrsQMe6ZTjOerTx05+7rNZabXlc+2mSd
        JPjw1hqnW5HTdXenJ+TPDLPf+cHF4fi7TaaRrhO3Sbe/nyNaKLX3rFeSsNPpTCWW4oxEQy3m
        ouJEACewtQUwAwAA
X-CMS-MailID: 20210622075225epcas5p13270a3a17544fa110af21aaff82ceb84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210621044517epcas5p187affa518a18a3d019deb0c189cd8396
References: <CGME20210621044517epcas5p187affa518a18a3d019deb0c189cd8396@epcas5p1.samsung.com>
        <20210621044916.41564-1-m.shams@samsung.com>
        <8935a448-04b7-91ce-203a-9f0d7e377052@canonical.com>
        <004f01d766a0$567b9860$0372c920$@samsung.com>
        <4b2576c1-c986-a4d8-d6cf-661ca056ecee@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > Hi,
> >
> >>
> >> Hi,
> >>
> >> Thanks for the patch.
> >>
> >> On 21/06/2021 06:49, Tamseel Shams wrote:
> >>> When DMA is used for TX and RX by serial driver, it should pass the
> >>> DMA device pointer to DMA API instead of UART device pointer.
> >>
> >> Hmmm, but why DMA device pointer should be used?
> >>
> >>>
> >>> This patch is necessary to fix the SMMU page faults which is
> >>> observed when a DMA(with SMMU enabled) is attached to UART for
> transfer.
> >>>
> >>> Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> >>> Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
> >>> ---
> >>>  drivers/tty/serial/samsung_tty.c =7C 60
> >>> +++++++++++++++++++++++++-------
> >>>  1 file changed, 48 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/samsung_tty.c
> >>> b/drivers/tty/serial/samsung_tty.c
> >>> index b923683e6a25..5bdc7dd2a5e2 100644
> >>> --- a/drivers/tty/serial/samsung_tty.c
> >>> +++ b/drivers/tty/serial/samsung_tty.c
> >>> =40=40 -284,8 +284,13 =40=40 static void s3c24xx_serial_stop_tx(struc=
t
> >>> uart_port
> >> *port)
> >>>  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >>>  	struct circ_buf *xmit =3D &port->state->xmit;
> >>>  	struct dma_tx_state state;
> >>> +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >>>  	int count;
> >>>
> >>> +	/* Pick dma_ops of DMA device if DMA device is attached */
> >>
> >> You mention here and further comments =22dma_ops=22. I don't see you
> >> changing the DMA ops, but the device. It's quite confusing. I think
> >> you meant a DMA device shall be passed to DMA API?
> >>
> > Yes, DMA device should be used for DMA API because only the DMA device
> > is aware of how the device connects to the memory. There might be an
> > extra level of address translation due to a SMMU attached to the DMA
> > device. When serial device pointer device is used for DMA API, the DMA =
API
> will have no clue of the SMMU attached to the DMA device.
>=20
> Thanks, this should be in commit msg.
>=20
Sure, will add this in commit msg.
> >
> >> Second question: you write that DMA devices should be used if DMA is
> >> attached and in the code you follow such pattern a lot:
> >>
> >>> +	if (dma && dma->tx_chan)
> >>> +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >>> +
> >>
> >> Are you trying to say that if DMA is not attached, UART device should
> >> be used? If DMA is not attached, how are the DMA operations used then?
> >>
> > If DMA is not attached, this part of code related to dma_engine or DMA
> > API do not get called. There will not be any DMA operations at all.
>=20
> Now I get it. The =22When=22 in your description followed by multiple com=
ments =22if
> DMA device is attached=22 confused me that you expect to use UART device =
for
> DMA operations if DMA is not attached...
>=20
I will change the comments, to avoid this confusion.
> >
> >>>  	if (=21ourport->tx_enabled)
> >>>  		return;
> >>>
> >>> =40=40 -298,7 +303,7 =40=40 static void s3c24xx_serial_stop_tx(struct
> >>> uart_port
> >> *port)
> >>>  		dmaengine_pause(dma->tx_chan);
> >>>  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >>>  		dmaengine_terminate_all(dma->tx_chan);
> >>> -		dma_sync_single_for_cpu(ourport->port.dev,
> >>> +		dma_sync_single_for_cpu(dma_map_ops_dev,
> >>>  			dma->tx_transfer_addr, dma->tx_size,
> >> DMA_TO_DEVICE);
> >>>  		async_tx_ack(dma->tx_desc);
> >>>  		count =3D dma->tx_bytes_requested - state.residue; =40=40 -324,15
> >> +329,19
> >>> =40=40 static void s3c24xx_serial_tx_dma_complete(void *args)
> >>>  	struct circ_buf *xmit =3D &port->state->xmit;
> >>>  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >>>  	struct dma_tx_state state;
> >>> +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >>>  	unsigned long flags;
> >>>  	int count;
> >>>
> >>> +	/* Pick dma_ops of DMA device if DMA device is attached */
> >>> +	if (dma && dma->tx_chan)
> >>> +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
>=20
> Example is this one - you use here =22if=22 suggesting there is =22else=
=22. So what is the
> else condition? There is none...
>=20
> >>>
> >>>  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >>>  	count =3D dma->tx_bytes_requested - state.residue;
> >>>  	async_tx_ack(dma->tx_desc);
> >>>
> >>> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> >>> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
> >>>  				dma->tx_size, DMA_TO_DEVICE);
> >>>
> >>>  	spin_lock_irqsave(&port->lock, flags); =40=40 -408,7 +417,11 =40=40=
 static
> >>> int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> >>>  	struct uart_port *port =3D &ourport->port;
> >>>  	struct circ_buf *xmit =3D &port->state->xmit;
> >>>  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >>> +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >>>
> >>> +	/* Pick dma_ops of DMA device if DMA device is attached */
> >>> +	if (dma && dma->tx_chan)
> >>> +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >>>
> >>>  	if (ourport->tx_mode =21=3D S3C24XX_TX_DMA)
> >>>  		enable_tx_dma(ourport);
> >>> =40=40 -416,7 +429,7 =40=40 static int s3c24xx_serial_start_tx_dma(st=
ruct
> >> s3c24xx_uart_port *ourport,
> >>>  	dma->tx_size =3D count & =7E(dma_get_cache_alignment() - 1);
> >>>  	dma->tx_transfer_addr =3D dma->tx_addr + xmit->tail;
> >>>
> >>> -	dma_sync_single_for_device(ourport->port.dev, dma-
> >>> tx_transfer_addr,
> >>> +	dma_sync_single_for_device(dma_map_ops_dev, dma-
> >>> tx_transfer_addr,
> >>>  				dma->tx_size, DMA_TO_DEVICE);
> >>>
> >>>  	dma->tx_desc =3D dmaengine_prep_slave_single(dma->tx_chan,
> >>> =40=40 -483,12 +496,17 =40=40 static void s3c24xx_uart_copy_rx_to_tty=
(struct
> >> s3c24xx_uart_port *ourport,
> >>>  		struct tty_port *tty, int count)
> >>>  =7B
> >>>  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >>> +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >>>  	int copied;
> >>>
> >>> +	/* Pick dma_ops of DMA device if DMA device is attached */
> >>> +	if (dma && dma->rx_chan)
> >>> +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> >>> +
> >>>  	if (=21count)
> >>>  		return;
> >>>
> >>> -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> >>> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
> >>>  				dma->rx_size, DMA_FROM_DEVICE);
> >>>
> >>>  	ourport->port.icount.rx +=3D count;
> >>> =40=40 -600,8 +618,13 =40=40 static void s3c24xx_serial_rx_dma_comple=
te(void
> >>> *args)  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port
> >>> *ourport)  =7B
> >>>  	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >>> +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >>>
> >>> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> >>> +	/* Pick dma_ops of DMA device if DMA device is attached */
> >>> +	if (dma && dma->rx_chan)
> >>> +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> >>> +
> >>> +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
> >>>  				dma->rx_size, DMA_FROM_DEVICE);
> >>>
> >>>  	dma->rx_desc =3D dmaengine_prep_slave_single(dma->rx_chan,
> >>> =40=40 -983,6 +1006,7 =40=40 static int s3c24xx_serial_request_dma(st=
ruct
> >>> s3c24xx_uart_port *p)
> >>
> >> Offset of hunks looks here significantly different than mainline. The
> >> patch should be based and tested mainline tree. Which one did you choo=
se as
> base?
> >>
> >> Using my email address not from get_maintainers.pl also suggests that
> >> you don't use anything recent as a base.
> >>
> > I used =22master=22 branch of main linux-next tree as the base.
> > I will rebase on =22tty-next=22 branch of TTY tree and post again.
> >
> > Thanks & Regards,
> > Tamseel Shams
> >
>=20
>=20
> Best regards,
> Krzysztof

Thanks & Regards,
Tamseel Shams

