Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BC2571A8;
	Mon, 24 Feb 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427734; cv=none; b=jfgroYXg7/hZPTu2JSuO5vnDD/7Cyh4JdLlJr73L//WTU/yeG530K+/a14lIMgQEa3FIQX3vFtP9B4H4/NDvUSou15H4NgVvOIJYPevStsIPcewdzlTa3TebQe7y+1mqfJtMItH6X0IX0rlSDVHCIjONVodlXR9pkMd1ux9f3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427734; c=relaxed/simple;
	bh=Tgn7peBqN2VM1Ze2bisvsGu7LNFyMbwIrns9GBl0ZSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3mgEw/phHMRIfrU6feMa/Rk0DOfpUF6vVfN0AjHIeWvVJf8zn81QvOSybUnenUWoAj7ydU64l/lb1iuawUJr1Xp1bg3RNQ5lkvYnWT+6u3xS5ER7OQ2s1M2P1iccY+7lpN/4Nsa90rNaMzgvmfmcEwhJtvLO75Q3z3nDZB55gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stjZ3gTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stjZ3gTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4EAC4CED6;
	Mon, 24 Feb 2025 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427733;
	bh=Tgn7peBqN2VM1Ze2bisvsGu7LNFyMbwIrns9GBl0ZSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=stjZ3gTOe+EWOC/JzdLx0KlFB9zJrfhPGJIdd8rPBTJKC7okUkzYL/O35M8yZozkQ
	 w5aFxmwKD1wdXpFNC1Tjpu9c8rRIvLu2XBvZi8qtskCc7sPsPOj2yZDaUyndwRXz8P
	 vyXTq/TCVvTylPZXgM0bxKtxUUyxF+ICklPYvg1nYLqyhN7yg0563bMMGPSKq38vCz
	 DLwR3UWnHxMXdiOnEX3FNv3b34vufwZgzUeTTNzKNnAV+BBL6g6BqNiaLqTIOpqNQJ
	 5EfO1lqOgiMmBzCSdS9OmJ4W8haMpzvfTNJ3DuZkz73ORzaN4VhGiXWQlNolUk7Q3l
	 3zrKpy3HGUUdw==
Message-ID: <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
Date: Mon, 24 Feb 2025 21:08:50 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: More than 256/512 glyphs on the Liinux console
To: Alan Mackenzie <acm@muc.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh> <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh> <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
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
In-Reply-To: <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 02. 25, 19:22, Alan Mackenzie wrote:
> Hello, Greg.
> 
> On Sun, Feb 23, 2025 at 08:47:53 +0100, Greg Kroah-Hartman wrote:
>> On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
>>> On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> 
> [ .... ]
> 
>>> But I think you are also asking why I use the console at all.  That's
>>> a fair question which I'll try to answer.
> 
>> I'm not disputing using the console, it's the vt layer that I'm talking
>> about.  The DRM developers have the long-term goal of getting rid of
>> CONFIG_VT which will remove a ton of mess that we have overall.
>> DRM-based consoles should provide the same functionality that a vt
>> console does today.  If not, please let them know so that the remaining
>> corner cases can be resolved.
> 
> Does a DRM based console exist at the moment?  I spent quite some time
> looking for it yesterday, but found nothing.

I didn't read the thread, but are you looking e.g. for kmscon?

-- 
js
suse labs
