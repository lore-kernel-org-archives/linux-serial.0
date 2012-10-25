From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 25 Oct 2012 13:50:46 +0800
Message-ID: <5088D336.7040206@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>	 <1351074456-25863-3-git-send-email-b32955@freescale.com> <1351138689.5263.68.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:27579
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753269Ab2JYFzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 01:55:21 -0400
In-Reply-To: <1351138689.5263.68.camel@vkoul-udesk3>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vinod Koul <vkoul@infradead.org>
Cc: vinod.koul@intel.com, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8825=E6=97=A5 12:18, Vinod Koul =E5=86=99=
=E9=81=93:
>
>> +
>> +static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
>> +{
>> +	struct dma_async_tx_descriptor *desc;
>> +	struct scatterlist *sgl =3D&s->tx_sgl;
>> +	struct dma_chan *channel =3D s->tx_dma_chan;
>> +	u32 pio;
>> +
>> +	/* [1] : send PIO. Note, the first pio word is CTRL1. */
>> +	pio =3D AUART_CTRL1_XFER_COUNT(size);
>> +	desc =3D dmaengine_prep_slave_sg(channel, (struct scatterlist *)&p=
io,
>> +					1, DMA_TRANS_NONE, 0);
> this seems like a hack. API expects a scatterlist as argument.
> Same thing about direction, NONE doesnt mean anything for dma transfe=
r.
It's not a hack. this DMA descriptor is used to set the registers.
Please see the code in drivers/dma/mxs-dma.c:mxs_dam_prep_slave_sg().


>> +	if (!desc) {
>> +		dev_err(s->dev, "step 1 error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* [2] : set DMA buffer. */
>> +	sg_init_one(sgl, s->tx_dma_buf, size);
>> +	dma_map_sg(s->dev, sgl, 1, DMA_TO_DEVICE);
>> +	desc =3D dmaengine_prep_slave_sg(channel, sgl,
>> +			1, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +	if (!desc) {
>> +		dev_err(s->dev, "step 2 error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* [3] : submit the DMA */
>> +	desc->callback =3D dma_tx_callback;
>> +	desc->callback_param =3D s;
>> +	dmaengine_submit(desc);
>> +	dma_async_issue_pending(channel);
>> +	return 0;
>> +}
>> +
>>
>> +static bool mxs_auart_dma_filter(struct dma_chan *chan, void *param=
)
>> +{
>> +	struct mxs_auart_port *s =3D param;
>> +
>> +	if (!mxs_dma_is_apbx(chan))
>> +		return false;
>> +
>> +	if (s->dma_channel =3D=3D chan->chan_id) {
>> +		chan->private =3D&s->dma_data;
> dont use chan->private. You need to dmaengine_slave_config API
please see the drivers/dma/mxs-dma.c:mxs_dam_alloc_chan_resoures().

The mxs-dma driver uses ->private to store the channel interrupt number=
=2E

thanks
Huang Shijie
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
