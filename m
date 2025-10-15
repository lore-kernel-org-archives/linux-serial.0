Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E127467D;
	Wed, 15 Oct 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509129; cv=none; b=LKpzCKDGMJQr6CM7Ab5xYiSW4RrdiSDO+lafmMUI7IcrbbAkLRm7HfKZmGb8g46DhO1XQeu5q7f0z7/ab50xZ+ltk3CDfvJgxx/TbWE4Pk8Mjqmkd7/L+y+5gXup+AJ0fHEa1VAtaJIfcvz+Tgga/JME7hErWoQhjXv8U/YlkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509129; c=relaxed/simple;
	bh=DZF1ndhiUAR/WGmgBw5roqEhlUKaFpXC0/Hq0pMgxvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU57K2oPjWfzrmL/6hBnHXmKFoYMh+dOJbBGW5BdMrmYt9VLgErVcD1wtsnCKfTGRY9S0rOQ+ZbM0LjUyEYT7R/5Gzxvs6c/wCaoWlNcncfIAfxCc0T4pFynNm5l6EPTDhkhV8Ma8rZB7LYlTVHIJ27iwu7nHHbezEq+y16kJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2a47GvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2a47GvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C824AC4CEF9;
	Wed, 15 Oct 2025 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760509127;
	bh=DZF1ndhiUAR/WGmgBw5roqEhlUKaFpXC0/Hq0pMgxvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t2a47GvCC4giD+p4QyoA+z/aI+GrrlVChjRRbuPfvgp148Oj17vUBPEC9fofuSUA6
	 iGgL8tzglzkrLdJwRC19LYuGAsXyAViyPXkNnkfTUBGTSXmMtD7B8bISk6tar8plfl
	 ayxYHWxwIqpM/yrR0056Vj0uOOiiu8Bcn74CCL3QW+AS1aGPBcH2vTRd9K/Yl7PCIT
	 hx9zxvcEhKvW5PTs+7r1Z84bgC+z1imm1c1S5bPCgD4bnJvgQtO4TGxvqRqUP0eiQF
	 xB/WSgMGh208yb2b43ztvaBK4fVOTana+awcFwhFib/mHBN3Anr94O5KMwPqakgMVo
	 ogjpoAfvINBxA==
Message-ID: <0cc09ea7-d4f7-4e1c-9cd0-bf310faba217@kernel.org>
Date: Wed, 15 Oct 2025 08:18:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
To: Bagas Sanjaya <bagasdotme@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>, Tomas Mudrunka
 <tomas.mudrunka@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
 <87wm4xbkim.fsf@trenco.lwn.net>
 <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>
 <aO7mnXCajeIdUYON@archie.me>
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
In-Reply-To: <aO7mnXCajeIdUYON@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 10. 25, 2:11, Bagas Sanjaya wrote:
> On Tue, Oct 14, 2025 at 10:57:45AM -0700, Randy Dunlap wrote:
>>
>>
>> On 10/14/25 7:55 AM, Jonathan Corbet wrote:
>>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>>
>>>> /proc/sysrq-trigger documentation states that only first character is
>>>> processed and the rest is ignored, yet it is not recommended to write
>>>> any extra characters to it. The latter statement is contradictive as
>>>> these characters are also ignored as implied by preceding sentence.
>>>>
>>>> Remove it.
>>>>
>>>> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
>>>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>> ---
>>>>   Documentation/admin-guide/sysrq.rst | 4 +---
>>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
>>>> index 9c7aa817adc72d..63ff415ce85d66 100644
>>>> --- a/Documentation/admin-guide/sysrq.rst
>>>> +++ b/Documentation/admin-guide/sysrq.rst
>>>> @@ -77,9 +77,7 @@ On other
>>>>   On all
>>>>   	Write a single character to /proc/sysrq-trigger.
>>>>   	Only the first character is processed, the rest of the string is
>>>> -	ignored. However, it is not recommended to write any extra characters
>>>> -	as the behavior is undefined and might change in the future versions.
>>>> -	E.g.::
>>>> +	ignored. E.g.::
>>>
>>> I'm not sure this is right - there is a warning here that additional
>>> characters may acquire a meaning in the future, so one should not
>>> develop the habit of writing them now.  After all these years, I think
>>> the chances of fundamental sysrq changes are pretty small, but I still
>>> don't see why we would take the warning out?
>>
>> but the following paragraph says:
>>
>> 	Alternatively, write multiple characters prepended by underscore.
>> 	This way, all characters will be processed. E.g.::
>>
>> 		echo _reisub > /proc/sysrq-trigger
>>
>> so it is confuzing.
> 
> I guess the whole "On all" description can be rewritten like:
> 
> Write a single character to /proc/sysrq-trigger, e.g.::
> 
> <snipped>...
> 
> If a string (multiple characters) is written instead, only the first character
> is processed unless the string is prepended by an underscore, like::
> 
> <snipped>...

Some kind of, yes. So Either:
* you write no underscore and a character -- the rest is ignored and you 
should not write more than one.
* you prepend underscore and write more of them -- all are processed.

thanks,
-- 
js
suse labs
