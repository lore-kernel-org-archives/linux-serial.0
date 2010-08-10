From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] serial: Add CONSOLE_POLL support for uartlite
Date: Tue, 10 Aug 2010 13:50:41 +0200
Message-ID: <4C613D11.7080701@monstr.eu>
References: <1281348452-26924-1-git-send-email-monstr@monstr.eu> <4C613C8A.1050600@windriver.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44190 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0HJLur (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Aug 2010 07:50:47 -0400
In-Reply-To: <4C613C8A.1050600@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: jacmet@sunsite.dk, grant.likely@secretlab.ca, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>

Jason Wessel wrote:
> On 08/09/2010 05:07 AM, Michal Simek wrote:
>> CONSOLE_POLL support for uartlite enables
>> KGDB debugging over serial line.
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>>  drivers/serial/uartlite.c |   26 +++++++++++++++++++++++++-
>>  1 files changed, 25 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
>> index caf085d..ce1f3e0 100644
>> --- a/drivers/serial/uartlite.c
>> +++ b/drivers/serial/uartlite.c
>> @@ -322,6 +322,26 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
>>  	return -EINVAL;
>>  }
>>  
>> +#ifdef CONFIG_CONSOLE_POLL
>> +static int ulite_get_poll_char(struct uart_port *port)
>> +{
>> +	while (!(ioread32be(port->membase + ULITE_STATUS)
>> +						& ULITE_STATUS_RXVALID))
>> +		cpu_relax();
>> +
>> +	return ioread32be(port->membase + ULITE_RX);
>> +}
> 
> 
> 
> After kdb was merged, the CONSOLE_POLL API had a subtle change where
> all I/O drivers should return immediately with a return of
> NO_POLL_CHAR in order to allow more than one I/O driver to operate in
> the same poll loop.
> 
> 
> The patch should look like the following for the get_poll_char.
> 
> +static int ulite_get_poll_char(struct uart_port *port)
> +{
> +	if (!(ioread32be(port->membase + ULITE_STATUS)
> +	    & ULITE_STATUS_RXVALID))
> +		return NO_POLL_CHAR;
> +
> +	return ioread32be(port->membase + ULITE_RX);
> +}
> 
> 
> If you agree to the change you can add my SOB.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>

I have no problem with it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
