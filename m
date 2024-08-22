Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4E17D354;
	Thu, 22 Aug 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335583; cv=none; b=ijxKbVECFGqW5bCeGY3VydFoahYw0Qwyb7d9Fej353JU39bk2ySDoZHLG3EeI34CSCVCFO+0FSH51eoI3v6hfR9rEyV3eG435lodYjPJC0b3Pb/ki6gmhUgs6h+Ur1U660rgI/i11f6lnhcIVC8Lwag7Qu3jCUQrBRpQrQmMxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335583; c=relaxed/simple;
	bh=jE7XT2v0u6+qqax75LFSSR4S5gAkgdZaGcEkPZHLlh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rTBSV73zWU/g3vSCUqCnkU8KnogXO/Tr9AvFeuXNGMbWFlmOw285K+N/llTd/HsLISfXKdZMlXgLRefVgsoYmXqeHYUuYOJXCakKwsgt8KGF9qX/z+2c+SljdhYXy74ycs7X4pbhmC9Y0OKhX+soard3p69RrAk0W/bdFKewY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EKl8FB/3; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EKl8FB/3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C523B20010;
	Thu, 22 Aug 2024 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724335572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jLrdTPqJox7q3LnEDEhorVnWrlGgJLbPOWyHcz1Hts=;
	b=EKl8FB/31jQrsFx8BSsopX+vnf7OPh/lUTLbIED/qGL7UmdnxbFgTt1M4GWFAGBU5H+WvE
	9Oc9VdDQnfIBXVSREVxhiAKjTTW4Ar/pWFqvYyohiRUdtc2eJgvhBoBvzME9r+tzBpMzDj
	ambtg3J+/JeIkxSTi4EYwTlmvi7N2cHND2QMLUJbeTa27Ws1vGQCqO9M5QczivftTlZGVT
	LOZHLv9w0q/SkwMMBMKCv/WE//SYLxgmB1BgQAxAqyk2w+Tjk0nUY+WsSPhDtwBzU7VKKd
	dHay4wNPOSnIJkfkZL+HpR1nlBac8ahHuuw2jUVVHmEGy/NwG4rB0c+M6NX50g==
Message-ID: <d6dedcc9-b4f0-4de4-9d26-ec9c0c9fa4f6@bootlin.com>
Date: Thu, 22 Aug 2024 16:06:11 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel_serial: use the correct RTS flag.
To: Mathieu Othacehe <othacehe@gnu.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240808060637.19886-1-othacehe@gnu.org>
 <20240813-absinthe-plaza-70575e847015@thorsis.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240813-absinthe-plaza-70575e847015@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com



Le 13/08/2024 à 09:59, Alexander Dahl a écrit :
> Hello Mathieu,
> 
> Am Thu, Aug 08, 2024 at 08:06:37AM +0200 schrieb Mathieu Othacehe:
>> In RS485 mode, the RTS pin is driven high by hardware when the transmitter
>> is operating. This behaviour cannot be changed. This means that the driver
>> should claim that it supports SER_RS485_RTS_ON_SEND and not
>> SER_RS485_RTS_AFTER_SEND.
>>
>> Otherwise, when configuring the port with the SER_RS485_RTS_ON_SEND, one
>> get the following warning:
>>
>> kern.warning kernel: atmel_usart_serial atmel_usart_serial.2.auto:
>> ttyS1 (1): invalid RTS setting, using RTS_AFTER_SEND instead
> 
> I've seen this warning already, when migrating a sam9x60 based board
> from LTS kernel 6.1 to 6.6, so thanks for taking care of this.
> 
> I can confirm after applying the patch on top of 6.6.44 the warning is
> gone, and RS-485 communication still works on our platform, so …
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>

Acked-by: Richard Genoud <richard.genoud@bootlin.com>

> 
> Does this deserve a Fixes tag for the change which introduced struct
> serial_rs485 to the atmel serial driver?  Then it should be this:
> 
> Fixes: af47c491e3c7 ("serial: atmel: Fill in rs485_supported")
> 
> Greets
> Alex
> 
>> which is contradictory with what's really happening.
>>
>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>> ---
>>   drivers/tty/serial/atmel_serial.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index 0a90964d6d107..09b246c9e389e 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2514,7 +2514,7 @@ static const struct uart_ops atmel_pops = {
>>   };
>>   
>>   static const struct serial_rs485 atmel_rs485_supported = {
>> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
>> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
>>   	.delay_rts_before_send = 1,
>>   	.delay_rts_after_send = 1,
>>   };
>> -- 
>> 2.45.2
>>
>>
> 

Thanks !
