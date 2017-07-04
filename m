From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 4 Jul 2017 09:01:24 +0200
Message-ID: <e1601aa2-6eaf-7212-369f-9c67a3159f64@collabora.com>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <20170703181738.xyxtwe246cfrkyd7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170703181738.xyxtwe246cfrkyd7-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello,


Le 03/07/2017 à 20:17, Uwe Kleine-König a écrit :
> Hello Greg,
>
> I'm a bit disappointed that you didn't drop this patch. At the time I
> sent my review it was still in your tty-testing branch and now it's part
> of your pull request for 4.13-rc1 (as commit
> a3015affdf76ef279fbbb3710a220bab7e9ea04b). :-|
>
> I'm still convinced that this patch is wrong in its current form.
>
> Best regards
> Uwe
>
> On Thu, Jun 29, 2017 at 08:26:18PM +0200, Uwe Kleine-König wrote:
>> Cc: += devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>
>> On Wed, Jun 28, 2017 at 12:15:14PM +0200, Romain Perier wrote:
>>> From: Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>
>>>
>>> The size of the DMA buffer can affect the delta time between data being
>>> produced and data being consumed. Basically the DMA system will move
>>> data to tty buffer when a) DMA buffer is full b) serial line is idle.
>>> The situation is visible when producer generates data continuously and
>>> there is no possibility for idle line. At this point the DMA buffer is
>>> directly affecting the delta time.
>> This doesn't look like a hw property but a configuration item. Also I
>> don't understand the problematic case. The i.MX is sending continuously
>> and then doesn't receive bytes until the DMA buffer is full? What is the
>> DMA buffer? You don't mean the FIFO here, do you?

by DMA buffer, I mean the size of the RX FIFO. Data will be moved to tty
when the FIFO
is full or the serial line is idle. Now suppose you have an important
work load and the serial line is never idle,
with the current size of the DMA buffer (PAGE_SIZE) you might introduce
latencies between data being produced and data being consumed.


We could also modify dma_rx_callback(), but this current solution is
less intrusive, imho.

Regards,
Romain

>>> The patch will add the possibility to configure the DMA buffers in DT,
>>> which case by case can be configured separately for every driver
>>> instance. The DT configuration is optional and in case missing the
>>> driver will use the 4096 buffer with 4 periods (as before), therefore no
>>> clients are impacted by this change.
>>>
>>> Signed-off-by: Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>
>>> Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/serial/fsl-imx-uart.txt    |  2 ++
>>>  drivers/tty/serial/imx.c                           | 25 +++++++++++++++-------
>>>  2 files changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
>>> index 574c3a2..e6b5724 100644
>>> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
>>> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
>>> @@ -9,6 +9,7 @@ Optional properties:
>>>  - fsl,irda-mode : Indicate the uart supports irda mode
>>>  - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
>>>                    in DCE mode by default.
>>> +- fsl,dma-size : Indicate the size of the DMA buffer and its periods
>> This is a sparse description, just from reading that I don't understand
>> what it does.
>>  
>>>  Please check Documentation/devicetree/bindings/serial/serial.txt
>>>  for the complete list of generic properties.
>>> @@ -28,4 +29,5 @@ uart1: serial@73fbc000 {
>>>  	interrupts = <31>;
>>>  	uart-has-rtscts;
>>>  	fsl,dte-mode;
>>> +	fsl,dma-size = <1024 4>;
>>>  };
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index bbefddd..7327477 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -186,6 +186,11 @@
>>>  
>>>  #define UART_NR 8
>>>  
>>> +/* RX DMA buffer periods */
>>> +#define RX_DMA_PERIODS 4
>>> +#define RX_BUF_SIZE	(PAGE_SIZE)
>> These names should include "DEFAULT" in their name now to fit their new
>> semantic.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
