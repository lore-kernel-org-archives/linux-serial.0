From: Nandor Han <nandor.han@ge.com>
Subject: Re: EXT: Re: [PATCH RFC 1/4] dma: imx-sdma - reduce transfer latency
 for DMA cyclic clients
Date: Fri, 1 Jul 2016 17:59:30 +0300
Message-ID: <57768552.6060407@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
 <0ed1e0027f135e9c88d7ac094ca807c7dc8f6713.1465456639.git.nandor.han@ge.com>
 <20160628143426.GB14945@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160628143426.GB14945@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: =Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 28/06/16 17:34, Vinod Koul wrote:
> On Thu, Jun 09, 2016 at 03:16:30PM +0300, Nandor Han wrote:
>> Having the SDMA driver use a tasklet for running the clients
>> callback introduce some issues:
>>    - probability to have desynchronized data because of the
>>      race condition created since the DMA transaction status
>>      is retrieved only when the callback is executed, leaving
>>      plenty of time for transaction status to get altered.
>>    - inter-transfer latency which can leave channels idle.
>>
>> Move the callback execution, for cyclic channels, to SDMA
>> interrupt (as advised in `Documentation/dmaengine/provider.txt`)
>> to (a)reduce the inter-transfer latency and (b) eliminate the
>> race condition possibility where DMA transaction status might
>> be changed by the time is read.
>>
>> The responsibility of the SDMA interrupt latency
>> is moved to the SDMA clients which case by case should defer
>> the work to bottom-halves when needed.
>
> Both of these look fine. Please change the patch titles to dmaengine: xxxx
>
> Are these going to be merged thru dmaengine tree or serial one?
>

I will send soon a V2 where I will fix the titles. If you are OK with 
all the patchset it can be merged to dmaengine tree, otherwise probably 
goes to serial one.

Let me know which is the best option.

Thanks,
    Nandor

>>
>> Signed-off-by: Nandor Han <nandor.han@ge.com>
>> ---
>>   drivers/dma/imx-sdma.c | 36 ++++++++++++++++--------------------
>>   1 file changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index 0f6fd42..e497847 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -654,12 +654,6 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
>>   	writel_relaxed(val, sdma->regs + chnenbl);
>>   }
>>
>> -static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
>> -{
>> -	if (sdmac->desc.callback)
>> -		sdmac->desc.callback(sdmac->desc.callback_param);
>> -}
>> -
>>   static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>   {
>>   	struct sdma_buffer_descriptor *bd;
>> @@ -678,13 +672,25 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>   			sdmac->status = DMA_ERROR;
>>
>>   		bd->mode.status |= BD_DONE;
>> +
>> +		/*
>> +		 * The callback is called from the interrupt context in order
>> +		 * to reduce latency and to avoid the risk of altering the
>> +		 * SDMA transaction status by the time the client tasklet is
>> +		 * executed.
>> +		 */
>> +
>> +		if (sdmac->desc.callback)
>> +			sdmac->desc.callback(sdmac->desc.callback_param);
>> +
>>   		sdmac->buf_tail++;
>>   		sdmac->buf_tail %= sdmac->num_bd;
>>   	}
>>   }
>>
>> -static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
>> +static void mxc_sdma_handle_channel_normal(unsigned long data)
>>   {
>> +	struct sdma_channel *sdmac = (struct sdma_channel *) data;
>>   	struct sdma_buffer_descriptor *bd;
>>   	int i, error = 0;
>>
>> @@ -711,16 +717,6 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
>>   		sdmac->desc.callback(sdmac->desc.callback_param);
>>   }
>>
>> -static void sdma_tasklet(unsigned long data)
>> -{
>> -	struct sdma_channel *sdmac = (struct sdma_channel *) data;
>> -
>> -	if (sdmac->flags & IMX_DMA_SG_LOOP)
>> -		sdma_handle_channel_loop(sdmac);
>> -	else
>> -		mxc_sdma_handle_channel_normal(sdmac);
>> -}
>> -
>>   static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>>   {
>>   	struct sdma_engine *sdma = dev_id;
>> @@ -737,8 +733,8 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>>
>>   		if (sdmac->flags & IMX_DMA_SG_LOOP)
>>   			sdma_update_channel_loop(sdmac);
>> -
>> -		tasklet_schedule(&sdmac->tasklet);
>> +		else
>> +			tasklet_schedule(&sdmac->tasklet);
>>
>>   		__clear_bit(channel, &stat);
>>   	}
>> @@ -1739,7 +1735,7 @@ static int sdma_probe(struct platform_device *pdev)
>>   		dma_cookie_init(&sdmac->chan);
>>   		sdmac->channel = i;
>>
>> -		tasklet_init(&sdmac->tasklet, sdma_tasklet,
>> +		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
>>   			     (unsigned long) sdmac);
>>   		/*
>>   		 * Add the channel to the DMAC list. Do not add channel 0 though
>> --
>> 2.8.3
>>
>
