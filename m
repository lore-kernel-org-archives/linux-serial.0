From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
Date: Thu, 16 Mar 2017 13:54:57 +0100
Message-ID: <5abf2394-78b5-9b6d-25f6-fe50f5580775@suse.cz>
References: <20170316122653.19930-1-vigneshr@ti.com>
 <051d7223-84d4-b120-f757-abded9c738cb@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <051d7223-84d4-b120-f757-abded9c738cb@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/16/2017, 01:46 PM, Jiri Slaby wrote:
> On 03/16/2017, 01:26 PM, Vignesh R wrote:
>> Using dev_name() as irq name during request_irq() might be misleading in
>> case of serial over PCI. Therefore use a better alternative name for
>> identifying serial port irqs as "serial" appended with serial_index of
>> the port. This ensures that "serial" string is always present in irq
>> name while port index will help in distinguishing b/w different ports.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> Based on top of tty-next.
>>
>>  drivers/tty/serial/8250/8250_core.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index f83b69f30987..78bf621d6827 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -213,12 +213,20 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>>  
>>  		ret = 0;
>>  	} else {
>> +		char *irqname = kmalloc(20, GFP_KERNEL);
>> +		if (!irqname) {
>> +			spin_unlock_irq(&i->lock);
> 
> GFP_KERNEL and spin_lock won't play well together.

And you never free the memory. Given we have struct device, can we use
devm_kmalloc after spin_unlock_irq (you have to check if we cannot
allocate multiple times)?

thanks,
-- 
js
suse labs
