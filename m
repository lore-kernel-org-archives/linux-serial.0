Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793516113;
	b=49PKDGD0vwnoWg/vADHz7vxHCzoFMkojABZg37Xh+yZW5XRL+jrV+XtpQWfUnP7Cnr8m
	 ZPfAEqTeSlvkMz1dF78+zq5o9Z/WWRkNxH3tatt1R1qK3GF4jY5atwnmH+I5xqBYmBP3b
	 Y6CKp6ApZUY1u3kjFjYsBUSg/3Z2J32qAG4vu6uwr4nJ8nzUhEpdPpa0wlFlZfndivd+g
	 InRE9m4VtN3hMfpeYZMcvkS4umuxj0BXrMypIr4dzLL3JLCVIz6oaIncEMOBfJp99fyVL
	 7QD6c458Mk0RSUTUI6XtSvykHv+IxkYGys7QQrGrW9F2gVQih1WiDauPwE5GbL0GcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793516113;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/CKMfN/Si2/MEVvjJNq4BneqQPomvixJjOeTTGaMj7g=;
	b=rEQSfedjPZYOG124BhpCTo1+GAxjDwcL0qibCZlT2XROgW18TKO20t2gWAiAh5l2STz/
	 zzy7bMhzBK1IRgmYlPua636cZdMFDI7bZf8Q8AY+Wmu2IjvfCb6qJ6IaLVQC3KMjvmIZ6
	 bW5hrBWkqpPgCW3wpCtUelc7CCtCyOS+Pds8gvZLHR0I1Mtxmm1mJtws7iSRyZsjHBN+m
	 cxCPhJJsV9AF308drnIFCfTv9Aput8PxukfNMgF6ptkdc1g0vY6Vs3ErUgQQChozGxKAv
	 sK1iClSmWbHBnIzuIv9NsaWbWA5XjWCg5Syg+KhwWpX4QOjA9lHZbrJ6MpumGD+/pUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNmpdYnP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A6606A324;
	Sun,  1 Nov 2026 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNmpdYnP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE121F000C1;
	Sun,  1 Nov 2026 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793516112;
	bh=/CKMfN/Si2/MEVvjJNq4BneqQPomvixJjOeTTGaMj7g=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=MNmpdYnP8TP4JE8vbUYIdIM5RyMZz69DBcL0ha3TXCQ+QdUHHqB4BnBPRKEbKDMOz
	 fJidJZtowX9mzBRcmp2jnSiFpbXzUevNmSZma9aALdWXj/TbQwtqDbI6B67oyj2Rah
	 fK+92Jo6jc5IO6uA6ZQ7nWW6+x53mzwsrXaiayo5QvFbInMRjDzF2+ZDsJ9r3EHwON
	 3w1L0b9H047IxD9WsN36c6jkIWmlIGXkfqTxVtEHMmF3HlKJNDd0a+89iA6Lc8+qFg
	 kl1OBkkN0JibBLjyhr3UQV1CYXVHPcy01L9VrnK4cBoBbzCXGqFH01RMLUq2QuNpCk
	 eNaRggcXTKuLQ==
Message-ID: <0f0cb164-8871-4030-8430-b41dc7dc37c2@kernel.org>
Date: Sun, 1 Nov 2026 07:55:09 +0100
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
Subject: Re: [PATCH v2] tty: serial: mvebu-uart: use device_get_match_data()
To: Bramwel Barack <bramwelbarack89@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20261030183332.23834-1-bramwelbarack89@gmail.com>
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
In-Reply-To: <20261030183332.23834-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 10. 26, 19:33, Bramwel Barack wrote:
> Modernize the driver by replacing the legacy of_match_device() call
> with the modern device_get_match_data() helper API. This cleans up
> the boilerplate code by extracting the match driver data configuration
> directly.
> 
> Consequently, drop the explicit inclusions of <linux/of_device.h> and
> <linux/of_platform.h> as they are no longer required by the driver.
> This allows us to also remove a now-redundant forward declaration and
>   drop the problematic of_match_ptr() macro wrapper.
...
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 33ea496c93b2..1e980dd26465 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
...
> @@ -919,7 +914,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	/* Get controller data depending on the compatible string */
> -	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
> +	mvuart->data = (struct mvebu_uart_driver_data *)device_get_match_data(&pdev->dev);

Perhaps remove the cast too?

thanks,
-- 
js
suse labs
