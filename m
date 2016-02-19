From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 2/5] ACPI: parse SPCR and enable matching console
Date: Fri, 19 Feb 2016 13:47:54 +0300
Message-ID: <56C6F2DA.3020002@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
 <1455559532-8305-3-git-send-email-aleksey.makarov@linaro.org>
 <56C64366.2070702@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C64366.2070702@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

Thank you for review.

On 02/19/2016 01:19 AM, Peter Hurley wrote:
> On 02/15/2016 10:05 AM, Aleksey Makarov wrote:

[..]

>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index a126a60..459ab54 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/serial_core.h>
>>  #include <linux/delay.h>
>>  #include <linux/mutex.h>
>> +#include <linux/acpi.h>
>>  
>>  #include <asm/irq.h>
>>  #include <asm/uaccess.h>
>> @@ -2654,8 +2655,17 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>>  		spin_lock_init(&uport->lock);
>>  		lockdep_set_class(&uport->lock, &port_lock_key);
>>  	}
>> -	if (uport->cons && uport->dev)
>> -		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
>> +
>> +	/*
>> +	 * Support both open FW and ACPI access to console definitions.
>> +	 * Both of_console_check() and acpi_console_check() will call
>> +	 * add_preferred_console() if a console definition is found.
>> +	 */
>> +	if (uport->cons && uport->dev) {
>> +		if (!acpi_console_check(uport))
>> +			of_console_check(uport->dev->of_node, uport->cons->name,
>> +					 uport->line);
> 
> of_console_check() is not a good model for enabling a console.
> It's a hack with several shortcomings (and bugs) that is tolerated here
> because of its broad applicability to a wide range of platforms and drivers.

It's definitely not the best code I saw but there is no bugs.

> I specifically added console matching to enable exactly this kind of
> console-selection-via-firmware. Please use that facility.

I described why this does not work (except you insist on having 
new made up names for all types of SPCR consoles) in the reply to another your message.

Thank you
Aleksey Makarov

> Regards,
> Peter Hurley
> 
> 
>> +	}
>>  
>>  	uart_configure_port(drv, state, uport);
>>  
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 06ed7e5..ea0c297 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1004,4 +1004,14 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
>>  #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
>>  #endif
>>  
>> +struct uart_port;
>> +#ifdef CONFIG_ACPI_SPCR_TABLE
>> +bool acpi_console_check(struct uart_port *uport);
>> +#else
>> +static inline bool acpi_console_check(struct uart_port *uport)
>> +{
>> +	return FALSE;
>> +}
>> +#endif
>> +
>>  #endif	/*_LINUX_ACPI_H*/
>>
> 
