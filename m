Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443444499A1;
	Fri,  7 Aug 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083649; cv=none; b=ASu+qxd0Ss1Z4v99EZ6cYV9PQUJY/KljQgN7KUbbKcdKlpOkyOozPQ0uzy3fjEAQT0zO8GD1Cw1cAIimwrHJljT7K/qxBZt4jG3QkM4WZOr7ZVAl+S8Dtayxpk7JP/jHARh0duNcCJ/HSVSbbuBhmzUYwoI7FqXkN07ZikzoHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083649; c=relaxed/simple;
	bh=ahvekBiyrsV4wHna4Lm5XwYna0DMqITaqz6I3tbqrOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMf+ae7Lre+zhBIQeqjyGGi6BB3Om3CoSNsAhUkcK3X9lwnvIYCe4lP7dV9z3ZQ7k0ubt+NOUswqu3AsRs9vY4F6oLvernRCLWphcBEJupxsw2v2vsrrtjB3zyyXTaBsa6z4nLZcrY+EBJFGe5MwuVljYjyPJ6Lu6uDhHXiHnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEZYYU17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEZYYU17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCA31F000E9;
	Fri,  7 Aug 2026 06:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786083647;
	bh=WBiMZ8pzjZSVHdpaZWaDZ2AQMrPpC80FXLt4yLoy/jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UEZYYU17Zo2rR4PnEiAAHykPCfPaXPMyT9ka727ehmcyQHzg0ETtAtQHyZ8MYMMdW
	 colIRlvqZwcYDTf5qGnWoVPtde/6DY8VTt659NN1vkcUr4XFTPDF+W/iOpPvJTH8nf
	 k7CO0Cg81yRsn88Ev47mQjHw93i5Ep85WA0hmKYjRw2c2Xi0geTtPBd323yo/sLoCu
	 PomY8okSqvPX4xaXyD67ntkKrk7h8uU7HU+n9YXyNxzc9zGwDrNLhzWTLm3XdYkJu/
	 8SfFntkCKiGXgxuLVro0ts+3oD2TtSFjznrRl5vlV9coTaj+dW9UJG1fHLA6M39bQp
	 05UB8Zu2cnayQ==
Message-ID: <ebc16b69-ac5b-44b9-a7df-f1363bd87b08@kernel.org>
Date: Fri, 7 Aug 2026 08:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: core: Fix a NULL pointer dereference in
 uart_parse_earlycon()
To: Greg KH <gregkh@linuxfoundation.org>,
 Xiaochun Li <lixiaochun@open-hieco.net>
Cc: john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260806061011.9007-1-lixiaochun@open-hieco.net>
 <2026080638-waged-tactical-005d@gregkh>
 <2d73c05e-8e5c-43bd-b6f1-a9a97b8631bd@open-hieco.net>
 <2026080605-claim-unmade-e05c@gregkh>
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
In-Reply-To: <2026080605-claim-unmade-e05c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06. 08. 26, 9:29, Greg KH wrote:
> On Thu, Aug 06, 2026 at 03:10:26PM +0800, Xiaochun Li wrote:
>> Panic log below:
>>
>> [    0.000000] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [    0.000000] #PF: supervisor read access in kernel mode
>> [    0.000000] #PF: error_code(0x0000) - not-present page
>> [    0.000000] PGD 0 P4D 0
>> [    0.000000] Oops: Oops: 0000 [#1] SMP NOPTI
>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc6 #5 PREEMPT(lazy)
>> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.q4
>> [    0.000000] RIP: 0010:strncmp+0x1a/0x40
>> [    0.000000] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 85 d2 74 24 31 c0 eb 0d 84 c9
>> [    0.000000] RSP: 0000:ffffffff82c03df0 EFLAGS: 00000246
>> [    0.000000] RAX: 0000000000000000 RBX: ffffffff82c03e20 RCX: ffffffff82c03e20
>> [    0.000000] RDX: 0000000000000005 RSI: ffffffff82acb7a1 RDI: 0000000000000000
>> [    0.000000] RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000001
>> [    0.000000] R10: 00000000ffffffea R11: ffffffff82c5cb20 R12: ffffffff82c03e30
>> [    0.000000] R13: ffffffff82c03e2c R14: 0000000000000001 R15: 0000000000014770
>> [    0.000000] FS:  0000000000000000(0000) GS:ffff8882b4460000(0000) knlGS:0000000000000000
>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.000000] CR2: 0000000000000000 CR3: 0000000002c30000 CR4: 00000000000000b0
>> [    0.000000] Call Trace:
>> [    0.000000]  <TASK>
>> [    0.000000]  uart_parse_earlycon+0x27/0x140
...
> Odd that this hasn't come up in the decades since it has been present :)

Everyone follows the documentation :P.

-- 
js
suse labs
