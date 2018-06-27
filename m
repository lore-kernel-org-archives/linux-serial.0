From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to
 zero again
Date: Wed, 27 Jun 2018 16:19:46 +0200
Message-ID: <05e553c2-202b-0b4b-8b88-60e330c80fa3@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
 <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
 <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
 <20180627100917.GA20940@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627100917.GA20940@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 27.6.2018 12:09, Greg Kroah-Hartman wrote:
> On Tue, Jun 19, 2018 at 10:09:05AM +0200, Michal Simek wrote:
>> On 6.6.2018 14:41, Michal Simek wrote:
>>> Writing zero and NULLs to already initialized fields is not needed.
>>> Remove this additional writes.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>> Changes in v2:
>>> - new patch - it can be sent separately too
>>>
>>>  drivers/tty/serial/xilinx_uartps.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>>> index 8a3e34234e98..5f116f3ecd4a 100644
>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>> @@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
>>>  
>>>  	/* At this point, we've got an empty uart_port struct, initialize it */
>>>  	spin_lock_init(&port->lock);
>>> -	port->membase	= NULL;
>>> -	port->irq	= 0;
>>>  	port->type	= PORT_UNKNOWN;
>>>  	port->iotype	= UPIO_MEM32;
>>>  	port->flags	= UPF_BOOT_AUTOCONF;
>>>  	port->ops	= &cdns_uart_ops;
>>>  	port->fifosize	= CDNS_UART_FIFO_SIZE;
>>>  	port->line	= id;
>>> -	port->dev	= NULL;
>>>  
>>>  	/*
>>>  	 * Register the port.
>>>
>>
>> Alan, Rob, Greg: Any comment about this RFC?
> 
> I rarely review RFC patchesets as obviously you don't think it is good
> enough to be submitted "for real" :)

There is one missing minor part but I want to review concept first
because I didn't find any driver which is using this style.

> If you think this is all good, great, please resend it without the RFC
> and it will end up in my queue.

I will definitely do it but please look at the concept itself because I
would like to use this with at least 3 other drivers.

Thanks,
Michal
