From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: mps2-uart: Initialize early console
Date: Tue, 19 Jun 2018 06:01:08 -0700
Message-ID: <da7ba538-a81e-f2d2-d51c-1b39f5b455f0@roeck-us.net>
References: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
 <173551dd-3632-08a6-ec42-2ee416ccb9ad@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <173551dd-3632-08a6-ec42-2ee416ccb9ad@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Murzin <vladimir.murzin@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-serial@vger.kernel.org

On 06/19/2018 02:07 AM, Vladimir Murzin wrote:
> Hi Guenter,
> 
> On 19/06/18 05:54, Guenter Roeck wrote:
>> The early console code for mps2-uart assumes that the serial hardware is
>> enabled for transmit when the system boots. However, this is not the case
>> after reset. This results in a hang in mps2_early_putchar() if the serial
>> transmitter is not enabled by a boot loader or ROM monitor.
> 
> I was under impression that for earlycon there is an assumption/requirement
> that the serial port must already be setup and configured. For instance, I
> see such requirement for pl011. So it looks like boot code's fault not to
> enable serial (for mps2 it needs to setup BAUDDIV as well).
> 

Good to know. Fine with me as well; I wasn't aware that such a requirement
existed.

Guenter

> I'm not against the patch per se, but I'd like to hear if my understanding of
> earlycon requirements is correct or not.
> 
> Cheers
> Vladimir
> 
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/tty/serial/mps2-uart.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
>> index 9f8f63719126..0743a0551ce1 100644
>> --- a/drivers/tty/serial/mps2-uart.c
>> +++ b/drivers/tty/serial/mps2-uart.c
>> @@ -448,6 +448,14 @@ static struct console mps2_uart_console = {
>>   
>>   #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
>>   
>> +static void mps2_early_init(struct uart_port *port)
>> +{
>> +	u8 control = readb(port->membase + UARTn_CTRL);
>> +
>> +	control |= UARTn_CTRL_TX_ENABLE;
>> +	writeb(control, port->membase + UARTn_CTRL);
>> +}
>> +
>>   static void mps2_early_putchar(struct uart_port *port, int ch)
>>   {
>>   	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
>> @@ -469,6 +477,7 @@ static int __init mps2_early_console_setup(struct earlycon_device *device,
>>   	if (!device->port.membase)
>>   		return -ENODEV;
>>   
>> +	mps2_early_init(&device->port);
>>   	device->con->write = mps2_early_write;
>>   
>>   	return 0;
>>
> 
> 
