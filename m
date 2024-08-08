Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BC186E25;
	Thu,  8 Aug 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106131; cv=none; b=TZXT6ZHxD5u0zqwTssNWlQ7Nc7J3yJ5NrTx8KjpQoGZ0t5JZIHMwyo2hkdIctoRGTXBo2ORLBmHEAeqp/4/bEGCACA/9qk9aDTFr/2XCdXHoke9Nk0nSCMMjF3uncRbbDh0I0DNQVwfNskY33hazHXOYJ4iFewR6ZlaDZaC3uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106131; c=relaxed/simple;
	bh=WL4iIRRN715jPLHIegzkLvUCR++i9gQ7KUAjS9a4JPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+kN2Mm2eGWOq9FvnYaRS+L3mYITwmkXaKt8keQkTSczjQGX/89dvlqI6DqY2z6LvXnlaS6db1dEVNA5tEw4hZXyJGi8wkNaUjtQXamgiihAWzIOKZYiPDcfWwuHxMtinuI+8E/XG9T+KbMifnKHc+ZQNZHbTKN7DHgh6Vcim6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso254203a12.0;
        Thu, 08 Aug 2024 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723106128; x=1723710928;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdYWVuEmycbO2vOTakIM2XMnfgL7Y/edBOmDpUcN5Wo=;
        b=ETd8A6eHfMweQcU49GdAhxFWyMdFbIJ1QJgv6ysNAufGEFpVyqR2NlZrvhqAEJobED
         61qouhLkK3RLbDDtybYWaIWSIB5YQhhZpj3qDu2bAhI1N7+ymS6y9TblbQEXoAGvABTr
         tSbPwjWRdr23tfefk2Z8Wwp3abnaoW55nHAihU+kxhIRy+Evzcn3+Un48KhARmuZvcIK
         phZ8pAqg1H5kmOQkUVbOCTSBDFwyoGdKZTqHrWMjJrCu6spSRLC2CJrF5581/eIe81Wb
         Fyig2I8zMHMbapKUe8ORblxqXnX7FuKr49M009tfWoSijppIN+te4/YNH604pX8hLbJR
         /L8A==
X-Forwarded-Encrypted: i=1; AJvYcCUX3pMyCt+vG1ikubFQUF/joQS1hZLFEj/UEcq/vLX1ab5OvrvrJdK8UqWve7hPNWTtMhcHaH5YA8kUWzc=@vger.kernel.org, AJvYcCWMhWWr8yFDy4QvS+OFw/XFyG5JIjdczQEiZUvwLsM4zvjV6R6ETch/CANoee8NGOKoTnJ2ot7bzd0CNksML5HjQuk=@vger.kernel.org, AJvYcCX3ez+UphBYWYphswcaIVbtIf1xK//iqmCvz46OnsYV8CIAuqulRen6nXkPupvy/N17XE4qfeKxp65XMmTT@vger.kernel.org
X-Gm-Message-State: AOJu0YxEi7tPqfnjRM64z6ZUruSLfj5mNUhnDp10Q+HvH/pOK4B56Mzw
	0Ufquzvj95lmskOudOg4IdZQUdL+dy4L7MpfQ3pQceqCOUdduOl1
X-Google-Smtp-Source: AGHT+IG2yBZGQoCrRa6isN3rDSiGVzIgqQn+5eZrZDAmUHd1rawM39VifjGbRTrgZJOz0mjPH/n6hg==
X-Received: by 2002:a05:6402:13d3:b0:5a1:f9bc:7f13 with SMTP id 4fb4d7f45d1cf-5bbb235ae4dmr1375124a12.22.1723106127762;
        Thu, 08 Aug 2024 01:35:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d3473dsm401613a12.63.2024.08.08.01.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:35:27 -0700 (PDT)
Message-ID: <6ea8f8fd-97b8-4c47-b042-cb8d64efebad@kernel.org>
Date: Thu, 8 Aug 2024 10:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] tty: serial: samsung_tty: cast the interrupt's
 void *id just once
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240808-samsung-tty-cleanup-v3-0-494412f49f4b@linaro.org>
 <20240808-samsung-tty-cleanup-v3-2-494412f49f4b@linaro.org>
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
In-Reply-To: <20240808-samsung-tty-cleanup-v3-2-494412f49f4b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08. 08. 24, 10:11, André Draszik wrote:
> The interrupt handler routines and helpers are casting the 'void *'
> pointer to 'struct exynos_uart_port *' all over the place.
> 
> There is no need for that, we can do the casting once and keep passing
> the 'struct exynos_uart_port *', simplifying the code and saving a few
> lines of code.
> 
> No functional changes.
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> v3: undo too eager removal of 'const' where unnecessary (Jiri)

LGTM now

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> v2: fix -Wdiscarded-qualifiers, sorry

thanks,
-- 
js
suse labs

