Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA213AA2E;
	Sat, 18 Jan 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737189700; cv=none; b=PWej5sAkeWJHs1A6EqYjEjXwf1rtJGWJ07lB16zB1hcrYNxh7yThhaVL7AR26vikQv7V1pk9Xh5XNMR0KtD3MPeZTafR9SjeaDsyGR1AuZ1GrJQ/oXsttsINbG1T5U2mNsI+gl1ObeExlg11dlLA1c2iWlHjzcE44LCTolYKo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737189700; c=relaxed/simple;
	bh=Bca6R0M/Y7OxL42JddjGzDPhG3jUwnWrfRrk3yEBOJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q64cZXwfIenbNPxiOjdZ4nJpM827xodLgFgbPk0+3kQqy89qvPbPEqKC5ZBn9XNMJVOY3z2wFr2BuxN4WhdhWGr76rOVAm47WR/lX3jz8DAMnuvayEINvOex4ssz8Xz+Vy6DZ3wZJ3RT1hwx8ssfO6sBfOJmnIi4w2qJD7LVPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olKkshhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olKkshhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D6BC4CEE4;
	Sat, 18 Jan 2025 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737189699;
	bh=Bca6R0M/Y7OxL42JddjGzDPhG3jUwnWrfRrk3yEBOJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=olKkshhslsJsfhxdMEnuu+9+0bBv+6sq1wB5CjyjTUZGBf8h+9u++u2L4YamwGKfP
	 sn4FmaIhVGvK+FntKh6/bwa+dV9BL/J7QG+X/61fgcM6psqNGYNg0o+I2YwtLHTw1i
	 u9r2YfP2aZvSHTBSkHm2/TRHM2j8oqCJycYC7B6U132H+v2aeI+SYAckhKMGHQDL04
	 cyn99vtG9KKQ9FtLhVyne6K/EwMSkmhGPGuRKkPoHe9VDnGTiHc/snGCarzHG7e+g4
	 nWBjGaUSJFs8vJnPtccd5sxgCB+1g/EI1QZAJPuk2i6257nws9dqClJAI+8nmPSaQx
	 gPgLP+7dn96HQ==
Message-ID: <e87e0d53-834e-4403-983f-0a6169e4224f@kernel.org>
Date: Sat, 18 Jan 2025 09:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: sc16is7xx: Extend IRQ check for negative
 values
To: Greg KH <gregkh@linuxfoundation.org>,
 Andre Werner <andre.werner@systec-electronic.com>
Cc: hvilleneuve@dimonoff.com, andy@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, lech.perczak@camlingroup.com
References: <20250117171822.775876-1-andre.werner@systec-electronic.com>
 <2025011855-ashen-gigantic-f832@gregkh>
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
In-Reply-To: <2025011855-ashen-gigantic-f832@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 25, 8:34, Greg KH wrote:
> On Fri, Jan 17, 2025 at 06:18:22PM +0100, Andre Werner wrote:
>> Fix the IRQ check to treat the negative values as No IRQ.
>>
>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>> ---
>> V2:
>> There are no changes to the patch itself. The previous patch submission
>> had a very weird structure within the discussion thread:
>> https://lkml.org/lkml/2025/1/16/398
>> This is simply a new thread opened for better handling.
>> ---
>>   drivers/tty/serial/sc16is7xx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index 7b51cdc274fd..560f45ed19ae 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   	/* Always ask for fixed clock rate from a property. */
>>   	device_property_read_u32(dev, "clock-frequency", &uartclk);
>>   
>> -	s->polling = !!irq;
>> +	s->polling = (irq <= 0);
>>   	if (s->polling)
>>   		dev_dbg(dev,
>>   			"No interrupt pin definition, falling back to polling mode\n");
>> -- 
>> 2.48.0
>>
>>
> 
> What commit id does this "fix"?

And yet, it's worth noting (in the commit log) that it actually does not 
fix any real problem. It's only a sanity check, right?

-- 
js
suse labs
