From: John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
Date: Tue, 16 Apr 2013 05:55:38 +0200
Message-ID: <516CCBBA.8000103@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org> <1365845618-16040-2-git-send-email-blogic@openwrt.org> <20130415181402.GA25194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:43649 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935472Ab3DPD7l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 23:59:41 -0400
In-Reply-To: <20130415181402.GA25194@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On 15/04/13 20:14, Greg Kroah-Hartman wrote:
> On Sat, Apr 13, 2013 at 11:33:36AM +0200, John Crispin wrote:
>> In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
>> the iotype to UPIO_RT.
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> ---
>>   drivers/tty/serial/of_serial.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
>> index b025d54..42f8550 100644
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>   		port->regshift = prop;
>>
>>   	port->irq = irq_of_parse_and_map(np, 0);
>> -	port->iotype = UPIO_MEM;
>> +	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
>> +		port->iotype = UPIO_AU;
>> +	else
>> +		port->iotype = UPIO_MEM;
> Why are you putting device-specific things into a generic driver?
> Shouldn't this be able to be described in device tree without relying on
> an vendor-specific test in this driver?
>
> greg k-h
>
>
Hi Greg,

would 'reg-io-type = "au";' sound better to you ?

     John
