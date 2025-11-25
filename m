Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A41E505;
	Tue, 25 Nov 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764049923; cv=none; b=fvopDw67o40LALPiMr7pYr3lcr8CeaXs0qyzYTla2JQSwqjNUrsqpVzBRO0wjMx0ZtL1ZI3cKVMR/1aJ14GSUwQPV2kQdWmjbfpW7IZEaHYXbp1hcfaGNhMgcMCC+rwsYKDCWJyAl/q6lLh06JJXc61KQoxzVLSjOTfq/EaaQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764049923; c=relaxed/simple;
	bh=pX4F3AVSn2oWHyvFNS8b0Z07RFdBON2PvrmWohyfGgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIq9AB4zSaXHZ/Ja2qa0LdZWyW2rQ5V0N6Zdq4GXSBX62r8OyTFbYW6Nnldq0CEoTcI9P4rmElQciPIe6/14WdjYilyUqrJ1awU5sHyKF+LE+5jeMGldcRPc0GVKtS6AhVSM5CcmarfS5QrKzKk8zPhMNma7zwNHkzo8ReFpb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epBnkQyn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epBnkQyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89139C4CEF1;
	Tue, 25 Nov 2025 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764049920;
	bh=pX4F3AVSn2oWHyvFNS8b0Z07RFdBON2PvrmWohyfGgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=epBnkQynSi9+dHHYPjUDqc2ngMiItMNjKRIkkluebnQ9wk+W37ssurQvUsYy7MY7A
	 T6MmZlJ+27dAGPZBJ83C4otWDQHXZDfJ2PQuknZoX3vrGQLITYiLIsyzNq6pUZpfe8
	 eLvT3bwnjsYJwn6G02pz2VZa8ECM/ea27siy273TPL43cvFcLvqTyAw3NilEt9I073
	 XcUl+659pXRlAXnOG3Gfxk2+dK3BnpPkHKvPZtc/TRMVpNGV66gfDqufemGcZojAJn
	 6tMUTemTfO8Ra95/Ijf1mQHTvjBx1w7wcq6020NtjCUb7I5uo7CL3NbX+qCq9y28M/
	 qOv4OZ4Pbu9Kg==
Message-ID: <2fe33f3d-562a-4382-9aef-e50eb5a97772@kernel.org>
Date: Tue, 25 Nov 2025 06:51:57 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tty:tty-next 27/37] drivers/tty/vt/keyboard.c:1712:7: error:
 cannot jump from this asm goto statement to one of its possible targets
To: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202511241835.EA8lShgH-lkp@intel.com>
 <20251124221343.GA2953435@ax162>
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
In-Reply-To: <20251124221343.GA2953435@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 11. 25, 23:13, Nathan Chancellor wrote:
> On Mon, Nov 24, 2025 at 06:25:26PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
>> head:   da218406dd50e0ac96bb383de4edd208286efe70
>> commit: bfb24564b5fd8625ce5c007f274cabdc3b570969 [27/37] tty: vt/keyboard: use __free()
>> config: powerpc-randconfig-002-20251124 (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/config)
>> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/tty/vt/keyboard.c:1712:7: error: cannot jump from this asm goto statement to one of its possible targets
>>                     if (put_user(asize, &a->kb_cnt))
>>                         ^
>>     arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
>>                       __put_user(x, _pu_addr) : -EFAULT;                    \
>>                       ^
>>     arch/powerpc/include/asm/uaccess.h:49:3: note: expanded from macro '__put_user'
>>                     __put_user_size_goto(__pu_val, __pu_addr, __pu_size, __pu_failed);      \
>>                     ^
>>     arch/powerpc/include/asm/uaccess.h:127:10: note: expanded from macro '__put_user_size_goto'
>>             case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;        \
>>                     ^
>>     arch/powerpc/include/asm/uaccess.h:87:2: note: expanded from macro '__put_user_asm_goto'
>>             asm goto(                                       \
>>             ^
>>     drivers/tty/vt/keyboard.c:1736:7: note: possible target of asm goto statement
>>                     if (put_user(asize, &a->kb_cnt))
>>                         ^
>>     arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
>>                       __put_user(x, _pu_addr) : -EFAULT;                    \
>>                       ^
>>     arch/powerpc/include/asm/uaccess.h:53:9: note: expanded from macro '__put_user'
>>                                                                     \
>>                                                                     ^
>>     drivers/tty/vt/keyboard.c:1692:33: note: jump exits scope of variable with __attribute__((cleanup))
>>                     struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
>>                                                   ^
>>     drivers/tty/vt/keyboard.c:1722:23: note: jump bypasses initialization of variable with __attribute__((cleanup))
>>                     void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
>>                                         ^
> 
> Previously reported:
> 
>    https://lore.kernel.org/202509091702.Oc7eCRDw-lkp@intel.com/

Ah, I forgot about this :(.

> My suggested workaround in that thread is still applicable if it would
> be acceptable as a formal patch:
> 
>    https://lore.kernel.org/20250909215342.GA2456480@ax162/

I think it makes sense. Could you post it formally then?

thanks,
-- 
js
suse labs
