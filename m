From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [2/3] serial: 8250: Add new port type for TI
 DA8xx/OMAPL13x/AM17xx/AM18xx
Date: Thu, 22 Dec 2016 12:16:46 -0600
Message-ID: <97641ab2-ba78-7186-db62-57b3bd76243f@lechnology.com>
References: <1482265384-715-3-git-send-email-david@lechnology.com>
 <306c9ce3-4003-84b9-fd0f-34232399f1aa@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <306c9ce3-4003-84b9-fd0f-34232399f1aa-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 12/22/2016 09:21 AM, Franklin S Cooper Jr wrote:
>
>
> On 12/20/2016 02:23 PM, David Lechner wrote:
>> This adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx. These
>> SoCs have standard 8250 registers plus some extra non-standard registers.
>>
>> The UART will not function unless the non-standard Power and Emulation
>> Management Register (PWREMU_MGMT) is configured correctly. This is
>> currently handled in arch/arm/mach-davinci/serial.c for non-device-tree
>> boards. Making this part of the UART driver will allow UART to work on
>> device-tree boards as well and the mach code can eventually be removed.
>>
>> Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
>> ---
>>  drivers/tty/serial/8250/8250_of.c   |  1 +
>>  drivers/tty/serial/8250/8250_port.c | 22 ++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h    |  3 ++-
>>  include/uapi/linux/serial_reg.h     |  8 ++++++++
>>  4 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
>> index d25ab1c..5281252 100644
>> --- a/drivers/tty/serial/8250/8250_of.c
>> +++ b/drivers/tty/serial/8250/8250_of.c
>> @@ -332,6 +332,7 @@ static const struct of_device_id of_platform_serial_table[] = {
>>  		.data = (void *)PORT_ALTR_16550_F128, },
>>  	{ .compatible = "mrvl,mmp-uart",
>>  		.data = (void *)PORT_XSCALE, },
>> +	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
>>  	{ /* end of list */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, of_platform_serial_table);
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index fe4399b..ea854054 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -273,6 +273,15 @@ static const struct serial8250_config uart_config[] = {
>>  		.rxtrig_bytes	= {1, 4, 8, 14},
>>  		.flags		= UART_CAP_FIFO,
>>  	},
>> +	[PORT_DA830] = {
>> +		.name		= "TI DA8xx/OMAPL13x/AM17xx/AM18xx",
>> +		.fifo_size	= 16,
>> +		.tx_loadsz	= 16,
>> +		.fcr		= UART_FCR_DMA_SELECT | UART_FCR_ENABLE_FIFO |
>> +				  UART_FCR_R_TRIG_10,
>> +		.rxtrig_bytes	= {1, 4, 8, 14},
>> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>> +	},
>>  };
>
>
> Any reason why the fcr and flags fields are changed when compared
> against PORT_16550A?

The AM1808 TRM says to "always enable" the DMA bit. I figured setting it 
now could save someone trouble later if they wanted to add DMA support. 
It does not matter if it is set even if you are not using DMA.

Since we are using the special reset register that resets the state 
machine, setting UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT seems 
redundant.

And in my testing with an AM1808, UART_CAP_AFE is not automatically 
detected even though the chip has this capability, so it needs to be 
manually specified.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
