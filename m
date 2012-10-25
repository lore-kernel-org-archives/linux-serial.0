From: Vinod Koul <vkoul@infradead.org>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 25 Oct 2012 11:37:52 +0530
Message-ID: <1351145272.7077.8.camel@vkoul-udesk3>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
	 <1351074456-25863-3-git-send-email-b32955@freescale.com>
	 <1351138689.5263.68.camel@vkoul-udesk3>  <5088D336.7040206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46428 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2JYG4h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 02:56:37 -0400
In-Reply-To: <5088D336.7040206@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, lauri.hintsala@bluegiga.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

On Thu, 2012-10-25 at 13:50 +0800, Huang Shijie wrote:
> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8825=E6=97=A5 12:18, Vinod Koul =E5=86=
=99=E9=81=93:
> >
> >> +
> >> +static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
> >> +{
> >> +	struct dma_async_tx_descriptor *desc;
> >> +	struct scatterlist *sgl =3D&s->tx_sgl;
> >> +	struct dma_chan *channel =3D s->tx_dma_chan;
> >> +	u32 pio;
> >> +
> >> +	/* [1] : send PIO. Note, the first pio word is CTRL1. */
> >> +	pio =3D AUART_CTRL1_XFER_COUNT(size);
> >> +	desc =3D dmaengine_prep_slave_sg(channel, (struct scatterlist *)=
&pio,
> >> +					1, DMA_TRANS_NONE, 0);
> > this seems like a hack. API expects a scatterlist as argument.
> > Same thing about direction, NONE doesnt mean anything for dma trans=
fer.
> It's not a hack. this DMA descriptor is used to set the registers.
> Please see the code in drivers/dma/mxs-dma.c:mxs_dam_prep_slave_sg().
yes it is, and also an abuse of the api.
prep_slave_sg() expects a scatter list and you are passing something
else and using DMA_TRANS_NONE to do that, which makes no sense!!!

If you have to setup your registers you need to setup based on what API=
s
passed you and not by abusing.

> >> +	if (!desc) {
> >> +		dev_err(s->dev, "step 1 error\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* [2] : set DMA buffer. */
> >> +	sg_init_one(sgl, s->tx_dma_buf, size);
> >> +	dma_map_sg(s->dev, sgl, 1, DMA_TO_DEVICE);
> >> +	desc =3D dmaengine_prep_slave_sg(channel, sgl,
> >> +			1, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >> +	if (!desc) {
> >> +		dev_err(s->dev, "step 2 error\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* [3] : submit the DMA */
> >> +	desc->callback =3D dma_tx_callback;
> >> +	desc->callback_param =3D s;
> >> +	dmaengine_submit(desc);
> >> +	dma_async_issue_pending(channel);
> >> +	return 0;
> >> +}
> >> +
> >>
> >> +static bool mxs_auart_dma_filter(struct dma_chan *chan, void *par=
am)
> >> +{
> >> +	struct mxs_auart_port *s =3D param;
> >> +
> >> +	if (!mxs_dma_is_apbx(chan))
> >> +		return false;
> >> +
> >> +	if (s->dma_channel =3D=3D chan->chan_id) {
> >> +		chan->private =3D&s->dma_data;
> > dont use chan->private. You need to dmaengine_slave_config API
> please see the drivers/dma/mxs-dma.c:mxs_dam_alloc_chan_resoures().
>=20
> The mxs-dma driver uses ->private to store the channel interrupt numb=
er.
And which it should not be doing. private is not supposed to be used fo=
r
passing info. If it is generic add to slave config.

--=20
Vinod Koul
Intel Corp.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
