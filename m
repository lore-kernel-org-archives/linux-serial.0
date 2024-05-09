Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D32D528;
	Thu,  9 May 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236267; cv=none; b=aIcPTvybErnHcNiZeGpNVZb5H9uzbsY806+JNELy4FsZoZ4v0x/hXzhwiQXUZi5n9M9JvNHYdxHE2vZQov5K9vhu+ylGs4Z5XX8ERg7GRzlvXghTR/OwLRldS+mFAwpGwcH0mYJc+p16ytXgRUZ/P+mdQMpfOX4OYA5WPLYBdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236267; c=relaxed/simple;
	bh=sR91nbWIRwOyq6K9ElyuyadwZV3hd1M+0aO46y81gUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk5Di5Ptmw/qOZ2BbnIjVt6JXZxohPdFknftw6xN8Ynn0nlvkObLDsYAEeJAcusfw602Tifqo6nOLChP6ACzI4dOp/V7Pw6OM+gJBv9gRmC+usBT8TE2OFNt3Jy5oJKKbtNuaW/nFk7XnVHjhrFed8vpKaUnzXAkOKEAQe2sCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso416372f8f.1;
        Wed, 08 May 2024 23:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236263; x=1715841063;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwtvTU9dGUsxu7W/GoS4WNvaRYIcCkqPS/0Zbq6tVQ8=;
        b=qCGjzBEdIXKHbK+p07WfseF01GyGzb/gLkx0cPzTkQRZ7S8yum0PXdtfCOOKR3m6ay
         MfTHaH9i9MsjbBmojo6+TFQlGsFTMImH6ipCtB27whXysly6OUoTcLj5uSLrvPzfsSSs
         rWGEQouo8IxzLu3jcyXuDOEl4bjE1mOld7SoopLJehu/twd3CkgVgJr+YY8KJjLQs58N
         Qe7liUDmDKGnYFzGEltCYY7+GjJ/P4vc8CoJR0l81kAddxvRkR9hCHB4GCZ2BDvsJgHO
         I+6XOXxCfgiFpSWzH3FDyFvq80KL0kYz1tmx2O/DziKBacXoKj3NEnkjAnibJSSC6GsB
         GiEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZcFBDnpeSHa5TuTic2f3Gc6b5mbjBB6Z3QSmrI6FAT3TAnWCwXLlY6WdgElBkzN+SRN33dAZ/Hf+OYKq8XOS4YqyJaGr+5Pwu2Noz
X-Gm-Message-State: AOJu0YxYPw76aadJ6pQv4q4SojrwpmRXJNxS1OsNz5T2xMavF/7YCWa7
	H9BAUhMD/9XVscgkcG+vIZ4KJfJPo7eY7tplpLD56q1mt0XL8qxo
X-Google-Smtp-Source: AGHT+IGBHtp5fkttoPxbAN5MSJVlWFzCxprEicfYj7+RDXM7lxtsi5BISTb6L83Noc0GVY5FtQ86ag==
X-Received: by 2002:a5d:4571:0:b0:34a:cc2:1a34 with SMTP id ffacd0b85a97d-34fca2448b7mr3367482f8f.42.1715236263404;
        Wed, 08 May 2024 23:31:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc83sm794033f8f.16.2024.05.08.23.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 23:31:02 -0700 (PDT)
Message-ID: <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org>
Date: Thu, 9 May 2024 08:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Justin Stitt <justinstitt@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
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
In-Reply-To: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06. 05. 24, 20:55, Justin Stitt wrote:
> Using the signed overflow sanitizer with syzkaller produces this UBSAN
> report:
> 
> [   31.304043] ------------[ cut here ]------------
> [   31.304048] UBSAN: signed-integer-overflow in ../drivers/tty/vt/vt.c:309:19
> [   31.304055] -2147483648 + -1073741824 cannot be represented in type 'int'
> [   31.304066] CPU: 1 PID: 3894 Comm: syz-executor Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [   31.304073] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   31.304077] Call Trace:
> [   31.304080]  <TASK>
> [   31.304083]  dump_stack_lvl+0x93/0xd0
> [   31.304177]  handle_overflow+0x171/0x1b0
> [   31.304186]  scrollfront+0xcb/0xd0
> [   31.304196]  tioclinux+0x3cc/0x450
> [   31.304205]  tty_ioctl+0x7fc/0xc00

The rest of the stack trace can be trimmed:

> [   31.304212]  ? __pfx_tty_ioctl+0x10/0x10
> [   31.304219]  __se_sys_ioctl+0xe0/0x140
> [   31.304228]  do_syscall_64+0xd7/0x1b0
> [   31.304236]  ? arch_exit_to_user_mode_prepare+0x11/0x60
> [   31.304244]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> [   31.304254] RIP: 0033:0x7fc3902ae539
> [   31.304263] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 8
> [   31.304282] RSP: 002b:00007ffc8a457998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   31.304289] RAX: ffffffffffffffda RBX: 00007fc3903e2f80 RCX: 00007fc3902ae539
> [   31.304293] RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000003
> [   31.304297] RBP: 00007fc39030d496 R08: 0000000000000000 R09: 0000000000000000
> [   31.304300] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [   31.304304] R13: 0000000000000800 R14: 00007fc3903e2f80 R15: 00007fc3903e2f80
> [   31.304310]  </TASK>
> [   31.304371] ---[ end trace ]---
> 
> This is caused by the scrollback_delta overflowing. Historically, the
> signed integer overflow sanitizer did not work in the kernel due to its
> interaction with `-fwrapv` but this has since been changed [1] in the
> newest version of Clang; It being re-enabled in the kernel with Commit
> 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow sanitizer").
> 
> Note that it would be difficult to reproduce this bug in a non-fuzzing
> scenario as it requires inputting tons of scroll inputs via keyboard
> before the scheduled console callback has had a chance to update.
> Nonetheless, let's saturate scrollback_delta so it stays clamped to
> integer bounds without wrapping around.

And what is actually broken, given signed overflow is well defined under 
the -fwrapv wings?

> [1]: https://github.com/llvm/llvm-project/pull/82432
> 
> Closes: https://github.com/KSPP/linux/issues/351
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: I am using Kees' SIO tree as a base:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v6.8-rc2/signed-overflow-sanitizer
> ---
>   drivers/tty/vt/vt.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9b5b98dfc8b4..b4768336868e 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -308,7 +308,14 @@ static inline void scrolldelta(int lines)
>   	/* FIXME */
>   	/* scrolldelta needs some kind of consistency lock, but the BKL was
>   	   and still is not protecting versus the scheduled back end */
> -	scrollback_delta += lines;
> +
> +	/* saturate scrollback_delta so that it never wraps around */
> +	if (lines > 0 && unlikely(INT_MAX - lines < scrollback_delta))
> +		scrollback_delta = INT_MAX;
> +	else if (lines < 0 && unlikely(INT_MIN - lines > scrollback_delta))
> +		scrollback_delta = INT_MIN;
> +	else
> +		scrollback_delta += lines;

NACK, this is horrid.

Introduce a helper for this in overflow.h if we have none yet.

thanks,
-- 
js
suse labs

