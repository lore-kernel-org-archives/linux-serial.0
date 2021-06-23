Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB560C4743C
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 04:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A260E6135A
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 04:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFWEVr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:21:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14246 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWEVr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Jun 2021 00:21:47 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210623041928epoutp02718443c28fc89d46ff5c4e5a36aa90b8~LGyyT_LCt3174931749epoutp02N
        for <linux-serial@vger.kernel.org>; Wed, 23 Jun 2021 04:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210623041928epoutp02718443c28fc89d46ff5c4e5a36aa90b8~LGyyT_LCt3174931749epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624421968;
        bh=ivYKHhc74QfRQJAHaKzxf3IVTmnHm3awg0p01MlhMzY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=EVXbGWN1eem9vqnUmTIa+LxOgCvHG8mjvgtmyonqctFG1PY+CNYwUQXmtoLbziRXb
         pULxPqS57GGTfrgOPJi97gG1YHbXWoLtU1EfqVBZEMjkCrKGzVn3bfd7tYiMEK7roo
         Hvoh+ac9aOe1yTOEb2a1AoQ0eiNctNFukdTsQq0E=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210623041927epcas5p119ef74467ee69c9540c259b1f5546e25~LGyxI1JSm0445704457epcas5p1F;
        Wed, 23 Jun 2021 04:19:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.F3.09595.F46B2D06; Wed, 23 Jun 2021 13:19:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210623041918epcas5p19a5dc3511be08c94fa7d5bef10ec2ea9~LGyo3uyD_0707107071epcas5p1c;
        Wed, 23 Jun 2021 04:19:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210623041918epsmtrp1cd681653c1d88aab857aece4a39480b0~LGyo23H5d1930519305epsmtrp12;
        Wed, 23 Jun 2021 04:19:18 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-0d-60d2b64fcd05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.69.08394.646B2D06; Wed, 23 Jun 2021 13:19:18 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210623041917epsmtip27a04e0604076e78373e2d6207a08a001~LGynWCAIl2396523965epsmtip2c;
        Wed, 23 Jun 2021 04:19:16 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Robin Murphy'" <robin.murphy@arm.com>,
        <krzysztof.kozlowski@canonical.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <1395f98a-4bb3-581c-0b8b-cb23a86d76c3@arm.com>
Subject: RE: [PATCH v2] serial: samsung: use dma_ops of DMA if attached
Date:   Wed, 23 Jun 2021 09:49:15 +0530
Message-ID: <00ce01d767e6$ef3b0300$cdb10900$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFcRGEZG7b0woiOY60hUFl/qJOGXQI/LuL6AjQJHX+r86pisA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7bCmlq7/tksJBge6FS0OvD/IYvFg3jY2
        i+bF69ks3s2Vsdj49geTxabH11gtLu+aw2Yx4/w+Joszi3vZLQ5+eMLqwOWxZt4aRo9ZDb1s
        HptWdbJ57J+7ht1j85J6j74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4MrYfng5a0GnV8XDq58Z
        GxjvWHcxcnJICJhI9F15wdTFyMUhJLCbUeLd14vMEM4nRolz59ezQjjfGCWm//3FAtPS9X41
        VGIvo8T1+fsYIZxnjBJrvjxnBaliE9CVmHSwDWyWiEAXo8SVhlY2EIdZ4AyjxOPFk5lAqjgF
        rCXef3vNBmILC7hLLHnSDRZnEVCVWNXTzQhi8wpYSpz/socNwhaUODnzCdgdzALaEssWvmaG
        uElB4ufTZWCbRQScJJpm/IKqEZd4efQIO0TNDg6J87/dIGwXifZnT9ggbGGJV8e3QNVISbzs
        b4Oy8yXmz1sFNb9CYuWFN1C2vcSBK3OA5nMAzdeUWL9LHyIsKzH11DomiLV8Er2/nzBBxHkl
        dsyDsRUl/u/uhxovLvFuxRTWCYxKs5B8NgvJZ7OQfDALYdsCRpZVjJKpBcW56anFpgVGeanl
        esWJucWleel6yfm5mxjBqUvLawfjwwcf9A4xMnEwHmKU4GBWEuF91HIpQYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvUvZDCUIC6YklqdmpqQWpRTBZJg5OqQYmMfF9xx7WJYToPDv1vOd6mdrT
        rhiH4xEnZlg5vVOs45t5IMpwpdOXvZo/3kTfd2iW0mubdUU1+IoXT5XD243yf8/XX1nw+lm0
        ksaEfBm54x5ZPF57fJSCFm3eWXKT03lH6oO1J1usij3zjy/ZfsbnucycpY2Tp7UxblBs5bL/
        YDNv8s7raY8fnLzzf2vXCQePnW7lSwOfv5hzsSslLq1sJdd3ffusVYv1vL+W9Ohn77ubMP/A
        Zrb3nHL9HYWL9FI4M//dy/ViMon8zH3zuea82MU5oW8+HtsqLHMtuOTg6T/3rh16F/+Rf8OX
        3wc26FyMy5m7VEh4jndUepaYRnbbEeZpPX+NJnCnZoh9yFtoqcRSnJFoqMVcVJwIANOVoILM
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvK7btksJBj9eqloceH+QxeLBvG1s
        Fs2L17NZvJsrY7Hx7Q8mi02Pr7FaXN41h81ixvl9TBZnFveyWxz88ITVgctjzbw1jB6zGnrZ
        PDat6mTz2D93DbvH5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXx6ckJ9oJPHhUPpp1j
        amA8bdXFyMkhIWAi0fV+NWsXIxeHkMBuRoklbQdYIRLiEtN+7WeEsIUlVv57zg5R9IRR4s3H
        dnaQBJuArsSkg23MIAkRgR5GidP3Z4GNYha4wCjRffQGVMsORomDv/eCzeIUsJZ4/+01G4gt
        LOAuseRJNxOIzSKgKrGqpxushlfAUuL8lz1sELagxMmZT1hAbGYBbYneh62MMPayha+ZIe5T
        kPj5dBnY3SICThJNM35B1YtLvDx6hH0Co/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYs
        MMxLLdcrTswtLs1L10vOz93ECI5BLc0djNtXfdA7xMjEwXiIUYKDWUmE91HLpQQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamOawFjBuWDPph6exgIB3
        YaFsFcsxX8dZWvU8LDdMvi8Ozr0aKOevxDvpR8ArhVfL5zXV9lx6rPl1WwZH1YrktR0ZwrMS
        Tm57wZGe9/Gv3bXtsX8dU8XZdPWlGGb9fMpnd3jbt5r4FZPSpZgPlKtU1t3+bVH6sDckL/ZH
        z+elZ+2XzZ5n3Cbfn1xyOpPh/b99KqLFcVcsbCfzeh9kE5renNl8SIOtsN37O98qw/u6Fc83
        s8zvmLeaOemjzW32Jdfjwlac3jNLgu/PvDOsa/7fFnqc2lg1QWFOu/1it5b3qsIR71UWHXml
        3rkjIKLySufavSa7leZ81dFxl/Pf9J3n7etCLUZedbE3wdM2rly/SomlOCPRUIu5qDgRANlL
        tgswAwAA
X-CMS-MailID: 20210623041918epcas5p19a5dc3511be08c94fa7d5bef10ec2ea9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb
References: <CGME20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb@epcas5p3.samsung.com>
        <20210622035202.5260-1-m.shams@samsung.com>
        <1395f98a-4bb3-581c-0b8b-cb23a86d76c3@arm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


> On 2021-06-22 04:52, Tamseel Shams wrote:
> > When DMA is used for TX and RX by serial driver, it should pass the
> > DMA device pointer to DMA API instead of UART device pointer.
> >
> > This patch is necessary to fix the SMMU page faults which is observed
> > when a DMA(with SMMU enabled) is attached to UART for transfer.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
> > ---
> >   drivers/tty/serial/samsung_tty.c =7C 62 +++++++++++++++++++++++++----=
---
> >   1 file changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 9fbc61151c2e..0c924bb6108e 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -284,8 +284,13 =40=40 static void s3c24xx_serial_stop_tx(struct =
uart_port
> *port)
> >   	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >   	struct circ_buf *xmit =3D &port->state->xmit;
> >   	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >   	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> > +
> >   	if (=21ourport->tx_enabled)
> >   		return;
> >
> > =40=40 -305,7 +310,7 =40=40 static void s3c24xx_serial_stop_tx(struct u=
art_port
> *port)
> >   		dmaengine_pause(dma->tx_chan);
> >   		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >   		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_sync_single_for_cpu(ourport->port.dev,
> > +		dma_sync_single_for_cpu(dma_map_ops_dev,
> >   			dma->tx_transfer_addr, dma->tx_size,
> DMA_TO_DEVICE);
> >   		async_tx_ack(dma->tx_desc);
> >   		count =3D dma->tx_bytes_requested - state.residue; =40=40 -331,14
> > +336,19 =40=40 static void s3c24xx_serial_tx_dma_complete(void *args)
> >   	struct circ_buf *xmit =3D &port->state->xmit;
> >   	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> >   	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >   	unsigned long flags;
> >   	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
>=20
> Clearly you don't need most of these checks, if any. For example here you=
're
> already dereferencing dma->tx_chan unconditionally a couple of lines belo=
w.
>=20
> AFAICS it should simply be a case of hard-coding the correct device for a=
ll of the
> DMA API calls without any of this silly conditional assignment. If it's e=
ven
> possible to reach the point of making a DMA API call when you don't have =
a valid
> DMA channel (and thus it would be pointless anyway), that implies a more
> general issue with the structure of the code which deserves fixing in its=
 own
> right.
>=20
> Robin.
>=20
Yes, this looks like a perfect solution to remove the conditional assignmen=
ts and
instead directly assign the DMA device pointer.

> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> > +
> >   	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >   	count =3D dma->tx_bytes_requested - state.residue;
> >   	async_tx_ack(dma->tx_desc);
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
> >   				dma->tx_size, DMA_TO_DEVICE);
> >
> >   	spin_lock_irqsave(&port->lock, flags); =40=40 -436,6 +446,11 =40=40 =
static
> > int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> >   	struct uart_port *port =3D &ourport->port;
> >   	struct circ_buf *xmit =3D &port->state->xmit;
> >   	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> > +
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >
> >   	if (ourport->tx_mode =21=3D S3C24XX_TX_DMA)
> >   		enable_tx_dma(ourport);
> > =40=40 -443,7 +458,7 =40=40 static int s3c24xx_serial_start_tx_dma(stru=
ct
> s3c24xx_uart_port *ourport,
> >   	dma->tx_size =3D count & =7E(dma_get_cache_alignment() - 1);
> >   	dma->tx_transfer_addr =3D dma->tx_addr + xmit->tail;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma-
> >tx_transfer_addr,
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma-
> >tx_transfer_addr,
> >   				dma->tx_size, DMA_TO_DEVICE);
> >
> >   	dma->tx_desc =3D dmaengine_prep_slave_single(dma->tx_chan,
> > =40=40 -510,12 +525,17 =40=40 static void s3c24xx_uart_copy_rx_to_tty(s=
truct
> s3c24xx_uart_port *ourport,
> >   		struct tty_port *tty, int count)
> >   =7B
> >   	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> >   	int copied;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> > +
> >   	if (=21count)
> >   		return;
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
> >   				dma->rx_size, DMA_FROM_DEVICE);
> >
> >   	ourport->port.icount.rx +=3D count;
> > =40=40 -635,8 +655,13 =40=40 static void s3c24xx_serial_rx_dma_complete=
(void
> *args)
> >   static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
> >   =7B
> >   	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> > +	struct device *dma_map_ops_dev =3D ourport->port.dev;
> > +
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
> >   				dma->rx_size, DMA_FROM_DEVICE);
> >
> >   	dma->rx_desc =3D dmaengine_prep_slave_single(dma->rx_chan,
> > =40=40 -1045,6 +1070,7 =40=40 static int s3c24xx_serial_request_dma(str=
uct
> s3c24xx_uart_port *p)
> >   	struct s3c24xx_uart_dma	*dma =3D p->dma;
> >   	struct dma_slave_caps dma_caps;
> >   	const char *reason =3D NULL;
> > +	struct device *dma_map_ops_dev =3D p->port.dev;
> >   	int ret;
> >
> >   	/* Default slave configuration parameters */ =40=40 -1102,18 +1128,2=
5
> > =40=40 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *=
p)
> >   		goto err_release_tx;
> >   	=7D
> >
> > -	dma->rx_addr =3D dma_map_single(p->port.dev, dma->rx_buf,
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> > +
> > +	dma->rx_addr =3D dma_map_single(dma_map_ops_dev, dma->rx_buf,
> >   				dma->rx_size, DMA_FROM_DEVICE);
> > -	if (dma_mapping_error(p->port.dev, dma->rx_addr)) =7B
> > +	if (dma_mapping_error(dma_map_ops_dev, dma->rx_addr)) =7B
> >   		reason =3D =22DMA mapping error for RX buffer=22;
> >   		ret =3D -EIO;
> >   		goto err_free_rx;
> >   	=7D
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >   	/* TX buffer */
> > -	dma->tx_addr =3D dma_map_single(p->port.dev, p->port.state->xmit.buf,
> > +	dma->tx_addr =3D dma_map_single(dma_map_ops_dev,
> > +p->port.state->xmit.buf,
> >   				UART_XMIT_SIZE, DMA_TO_DEVICE);
> > -	if (dma_mapping_error(p->port.dev, dma->tx_addr)) =7B
> > +	if (dma_mapping_error(dma_map_ops_dev, dma->tx_addr)) =7B
> >   		reason =3D =22DMA mapping error for TX buffer=22;
> >   		ret =3D -EIO;
> >   		goto err_unmap_rx;
> > =40=40 -1122,7 +1155,9 =40=40 static int s3c24xx_serial_request_dma(str=
uct
> s3c24xx_uart_port *p)
> >   	return 0;
> >
> >   err_unmap_rx:
> > -	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
> > +	if (dma->rx_chan)
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> > +	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
> >   			 DMA_FROM_DEVICE);
> >   err_free_rx:
> >   	kfree(dma->rx_buf);
> > =40=40 -1139,10 +1174,12 =40=40 static int s3c24xx_serial_request_dma(s=
truct
> s3c24xx_uart_port *p)
> >   static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
> >   =7B
> >   	struct s3c24xx_uart_dma	*dma =3D p->dma;
> > +	struct device *dma_map_ops_dev =3D p->port.dev;
> >
> >   	if (dma->rx_chan) =7B
> > +		dma_map_ops_dev =3D dma->rx_chan->device->dev;
> >   		dmaengine_terminate_all(dma->rx_chan);
> > -		dma_unmap_single(p->port.dev, dma->rx_addr,
> > +		dma_unmap_single(dma_map_ops_dev, dma->rx_addr,
> >   				dma->rx_size, DMA_FROM_DEVICE);
> >   		kfree(dma->rx_buf);
> >   		dma_release_channel(dma->rx_chan);
> > =40=40 -1150,8 +1187,9 =40=40 static void s3c24xx_serial_release_dma(st=
ruct
> s3c24xx_uart_port *p)
> >   	=7D
> >
> >   	if (dma->tx_chan) =7B
> > +		dma_map_ops_dev =3D dma->tx_chan->device->dev;
> >   		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_unmap_single(p->port.dev, dma->tx_addr,
> > +		dma_unmap_single(dma_map_ops_dev, dma->tx_addr,
> >   				UART_XMIT_SIZE, DMA_TO_DEVICE);
> >   		dma_release_channel(dma->tx_chan);
> >   		dma->tx_chan =3D NULL;
> >

Thanks & Regards,
Tamseel Shams

