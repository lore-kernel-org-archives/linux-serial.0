Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745623;
	b=gpGuCU8+Qr27rV9CXSxWH2bw0HGmUGaEJosN+Sap45Uiz0SqczB50cxh62LEi7+5HNEl
	 FwZWU84WYjqOkmW9AFU+VN5gLQ1fSvIkGJjI2DXkJTbMmgBZVb6ZnGtZfpx1ByrJoxiCd
	 AgYZ8m75td7LgKWrpOYs2etCez+Mo1wWkdzp5KcI61uuNY0RFX+0ASn+YFZjsmCjjs5V2
	 qg3qYK5iJPl7O2KEGf9ThKs9A9fohEME5m9x8FsPDTWgp6Flqc59k+f1hXBTwNk1m6toG
	 9gVUs2qC6OUysxi4107R2abxDbOlsqXPlqZeeD9PPyGlp6pCXOhJ03eHWjiNMel/+Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745623;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CdoKhQZLuMkXckBiKIoEwBUaAVMRBZJL1gI/03P97mw=;
	b=fnfCg7Xa+ahdPnkjAzTErBOMXxlk9j9GXtwQtxpzlNi3HFqciuHCKjpDymclySgNAgqt
	 aRUoJ/yxrPloUFiJvcvO+npFe78eCaUJUHtlGGDTADLeuYpsZe7gEDkvZhXuglaXO+6gu
	 /dnCX9Ow73eL0+NBPSqljfZhHSD4SAzjMEVO6m/J+Bhy75LS4VlEDfEtVPj9stYAmyKnz
	 uit0mhlewVeAZNnfv4yavXl0IGbH/lQxQhXErSrQ9ChLM2zWuYbH6+2HGaOCaZoH3vYPO
	 WllOCtkm0oH61DFrkLY3edMlQ8FJOY0+zZltM3ZNUlu8G2E1gfTxknwkjCFgZQ8jjIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZzUxdOT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B68606A31B;
	Fri, 23 Oct 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZzUxdOT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5DF1F01828;
	Fri, 23 Oct 2026 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792745623;
	bh=CdoKhQZLuMkXckBiKIoEwBUaAVMRBZJL1gI/03P97mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DZzUxdOTgcIRoKA2V+T5Op99DceRrm0cIVtHES2x/nPJgAjZOXUBqSU/GqqdUZrh9
	 wUck6GflVkpi70dn/sM2T2JkmQ9z7uLB1fdBblfLoWTP20px6NYt1qRUGO6L7XQzzC
	 kiLmRbBaXKpY2S4bvWMIYoTLXy/Nl+1NoTW7ffjPDsa1wyg06wOnx6l3s9gadOcIxk
	 RDHXOhXstn1Q/d2iY4StNQyg9QTtSFN9DpY6nKS2n98c1Yn+UuT/GApdAHiKYjmQFg
	 Z062uidBZwGQCyX3tUvHJBAnXb7VLisMEArdeN5f/NQYjc+Jf1xaJwHC47Qcosu7S4
	 i9ittSO4yMBWA==
Message-ID: <c826575e-cc1e-4a9e-880a-9f3deceed895@kernel.org>
Date: Fri, 23 Oct 2026 10:53:40 +0200
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <sashiko-outbox-170897@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <sashiko-outbox-170897@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 10. 26, 8:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] tty: serial: 8250_hp300: NULL pointer dereference on hpdca device removal
> --
> 
> commit f913317bfee3afed5e144530ca60f25858464754
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Date:   Tue Oct 13 06:48:51 2026 +0000
> 
>      serial: 8250: make port operations work on struct uart_8250_port
>      
>      This commit switches the interface of port operations to use
>      struct uart_8250_port instead of the line number, returning the registered
>      port or an ERR_PTR() on failure. It updates all drivers to store the port
>      pointer instead of the line number.
> 
>> diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
>> index 59ec0c7377a1c..e9599c5c2fead 100644
>> --- a/drivers/tty/serial/8250/8250_hp300.c
>> +++ b/drivers/tty/serial/8250/8250_hp300.c
> [ ... ]
>> @@ -177,9 +177,8 @@ static int hpdca_init_one(struct dio_dev *d,
>>   	uart.port.membase = (char *)(uart.port.mapbase + DIO_VIRADDRBASE);
>>   	uart.port.regshift = 1;
>>   	uart.port.dev = &d->dev;
>> -	line = serial8250_register_8250_port(&uart);
>> -
>> -	if (line < 0) {
>> +	uport = serial8250_register_8250_port(&uart);
>> +	if (IS_ERR(uport)) {
>>   		dev_notice(&d->dev,
>>   			  "8250_hp300: register_serial() DCA scode %d irq %d failed\n",
>>   			  d->scode, uart.port.irq);
>>   		return 0;

Am I hallucinating or you do? I have:
   return -ENOMEM;
on that line.

>>   	}
>>   
>>   	/* Enable board-interrupts */
>>   	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, DCA_IC_IE);
>> -	dio_set_drvdata(d, (void *)line);
>> +	dio_set_drvdata(d, uport);
>>   
>>   	/* Reset the DCA */
>>   	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);
> 
> [Severity: High]
> If serial8250_register_8250_port() fails here and returns an ERR_PTR, this
> function logs a warning and returns 0 (success). In this failure path,
> dio_set_drvdata() is skipped, leaving the device's driver data as NULL.
> 
> Because the driver returns 0, the device is considered successfully bound.
> When the device is later removed, hpdca_remove_one() is called:
> 
>> @@ -287,14 +283,13 @@ static int __init hp300_8250_init(void)
>>   #ifdef CONFIG_HPDCA
>>   static void hpdca_remove_one(struct dio_dev *d)
>>   {
>> -	int line;
>> +	struct uart_8250_port *uport = dio_get_drvdata(d);
>>   
>> -	line = (int) dio_get_drvdata(d);
>>   	if (d->resource.start) {
>>   		/* Disable board-interrupts */
>>   		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
>>   	}
>> -	serial8250_unregister_port(line);
>> +	serial8250_unregister_port(uport);
>>   }
>>   #endif
> 
> Will this lead to a NULL pointer dereference?
> 
> If the registration failed during probe, uport will be NULL here. Since
> serial8250_unregister_port() unconditionally dereferences the pointer (e.g.,
> checking uart->em485), passing NULL will cause a kernel panic.
> 
> Should the failure path in hpdca_init_one() return an error code instead of
> 0, or should hpdca_remove_one() check for a valid uport before
> unregistering?
> 
> Note: This replaces a prior bug where passing an uninitialized 0 line number
> caused the driver to erroneously unregister ttyS0 instead of crashing.
> 


-- 
js
suse labs
