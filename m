From: John Crispin <john@phrozen.org>
Subject: Re: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from
 OF
Date: Thu, 21 Mar 2013 17:59:45 +0100
Message-ID: <514B3C81.5040001@phrozen.org>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org> <1359111008-9998-2-git-send-email-blogic@openwrt.org> <514A153D.8020608@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:49741 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab3CURDY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 13:03:24 -0400
In-Reply-To: <514A153D.8020608@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

On 20/03/13 20:59, John Crispin wrote:
> On 25/01/13 11:50, John Crispin wrote:
>> In order to make serial_8250 loadable via OF on Au1x00 and Ralink
>> WiSoC we need
>> to default the iotype to UPIO_AU.
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> ---
>> drivers/tty/serial/of_serial.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/serial/of_serial.c
>> b/drivers/tty/serial/of_serial.c
>> index e7cae1c..72e9743 100644
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -97,7 +97,11 @@ static int of_platform_serial_setup(struct
>> platform_device *ofdev,
>> port->regshift = prop;
>>
>> port->irq = irq_of_parse_and_map(np, 0);
>> +#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
>> + port->iotype = UPIO_AU;
>> +#else
>> port->iotype = UPIO_MEM;
>> +#endif
>> if (of_property_read_u32(np, "reg-io-width",&prop) == 0) {
>> switch (prop) {
>> case 1:
>
> Hi Greg,
>
> i have the impression that this patch got lost somewhere on the way to
> linus. I can see the 1/2 got merged with 3.9-rc1. 2/2 is missing however
>
> Thanks for you help,
>
> John


Hi Greg,

please ignore this patch, I will send a better one without #ifdef'ery 
for 3.10. There are 2 other fixes to make the serial work for another 
SoC I that will get merged in 3.10. I will put all 3 patches into a new 
series

	John
