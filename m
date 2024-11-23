Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AD748A;
	Sat, 23 Nov 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732328058; cv=none; b=tEEJwsNAmkN55TL0Sml1NQ0dIYo80wGnaWysgCuZlhPoTZ/KmRjR2ogGX8LgvAxhbInm9ODBNEUv29nAwYRSku+HgJI3RtXQFicoWorqmA45jib1ebrgaSTjMU2wBAeAO5NbsRFs8+UMI2OXZQ+Ck6G1MPOJg1ZQNpzeRCYfH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732328058; c=relaxed/simple;
	bh=EX4pMqx25HLXNXZjnFJMqrGwghQLt5+EG9kK/bHl8HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEJS4Xlb93bAVu74d0iSlxkq7MCW/b1mWZi9DkUiGTbblf23C18S9ejWiIaguYRflM5bMU7jSvPgKJUFtuxJVDv3ix2BmeyUHYOZKXdM6eOzZ6Ta+0imcl9qFt8fr3XN3S+DJMkNyefLVm/lOzkM62x6QXxljWp0cRQ4rZJysZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2NrwM7e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2NrwM7e"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21263dbbbc4so29240675ad.1;
        Fri, 22 Nov 2024 18:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732328056; x=1732932856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5tm0SQFRalTTa/1kWMTGU16lgeqQakuZDDSuhOCG4NU=;
        b=M2NrwM7eQ18wtJ1sn5yiCsM9Xzq+l2vShH6xClQXmNmIahuvGAe/cDiWmITxuvTdPo
         Sk4+Urx+hWm7AT7MQT1kUciqxUvtuylF1HdQcCpQUPr6rhnn3f58aSU15CoZL7svyYSO
         KiC+LUN/Y/WmQHzJlFAS8bs1hXTzbHG7CxiNf69ZSk22AJ7t9PYuZQwHuMOKN0Pnaekg
         rt+ttZW/UpJtLPD3IW8e1VLYhB+bSrrc+1DBmwesDjpQkAtGN2ICPZrhaowUqi839lyz
         GUnvD0wBrnjBJZR6mhNP7xju8XMyxAws4gGf1wHTvCktrERH4nTzXrbG2LBD95ekJzw8
         B1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732328056; x=1732932856;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tm0SQFRalTTa/1kWMTGU16lgeqQakuZDDSuhOCG4NU=;
        b=pS+VtUkcFVDa1c6Xu930BsLxpgnq7kDjF+btmkbKGFuKHL6mN8h8OHTspGM8SOloyx
         kwzJJ7Or15rrCCw+mdPFZ/MnAQ+fbONVcX2+PbMSEKBgZfvm520b4fRv63PdarGYb34m
         HVcqRQi3jvISJt1Qght6T/TGDiq4g9KMmCZKHMC6JrwjyCF3enFII1OMqo6GrWVvLEmt
         5hqcOF23g1v+RPBfMy3r11WaOCvI6SfNrNemwVDnUlATWU4aDxbzdZvOteK6b646B6NK
         X7VvmcIOdIojb+7bX3GnfJbBPYpi5H8lOSHj+d1eRupbhYsA01J2QNp2pRtw00smiAhz
         VtbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCqvTbHeN+EwT90BdmO/yN24MRAPyITmzqCu1Esvumgd19M2vluqHNgT4/3UHRrp31mq0FR02NzV7BL/o=@vger.kernel.org, AJvYcCV86+D0M/NcdnZi1U+FR5exDPtbbo6lVQYl82MUFdLg30mx2ZGsu6n8VWN/8INgoZFh1zFYRhf+TrEWgO3J@vger.kernel.org
X-Gm-Message-State: AOJu0YzAp76Nfb/0AFpd7ETfa+UnspR6OLkgDTYzQsk1+F518MsrEwZV
	AdxHYuP8xhDDNQz5mgdKKdlAjOVCONijF5YfYaW3G3iUmAlVjUxr
X-Gm-Gg: ASbGncuowgEKmtxors+KKGE7w+OWe/dHcAM7ik0YPPWZEjNYAupJF7tJ4lXVGngt0Ii
	lwB5j/PofmLfO4Ac4S0pue29QlSnNMMvYGOsbYDY0BrrFoXaaF64R9o48niIV+yvqpNCDEfeTx6
	LhozQI8NPXIprYTNEqOykeZx4EEYYIonD5hVXyQzogc2rt13N0GHN6TohF+QJXrpA477qa+cRJc
	QE/zhJ0B9TitXsHpSi2lxHgKXk9fzAxCq7XSs36QyUCELlWlafxrreviWspzlV8cO2BoMSyYZk8
	vf2SR8FSSTDEn+H8iHkd6tA=
X-Google-Smtp-Source: AGHT+IEEUTDG1x7QE08+4xA/5EJ+JQcxV8Bd3tAOVdlBof2etNmTJRl2cmvJk/PsOJU8wNtJel6acA==
X-Received: by 2002:a17:903:230d:b0:20c:5cdd:a9e with SMTP id d9443c01a7336-2129fd21f41mr60315745ad.28.1732328056118;
        Fri, 22 Nov 2024 18:14:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c951sm23188185ad.32.2024.11.22.18.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 18:14:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3d1e5e90-4675-4319-9f58-3c3d5b6f4b8a@roeck-us.net>
Date: Fri, 22 Nov 2024 18:14:13 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <791f37f3-2b93-47f1-b0a3-46825c09f222@roeck-us.net>
 <eb1c5d4b-0662-41dd-826c-d3c3cf78de2b@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <eb1c5d4b-0662-41dd-826c-d3c3cf78de2b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 14:51, Arnd Bergmann wrote:
> On Fri, Nov 22, 2024, at 21:44, Guenter Roeck wrote:
>> On 11/22/24 11:24, Arnd Bergmann wrote:
>>>
>>> serial8250_setup_port() is where it ends up using the
>>> uninitialized serial8250_ports[index] contents. Since
>>> port->iotype is not set to anything here, it defaults to
>>> '0', which happens to be UPIO_PORT.
>>>
>>> The reason it doesn't immediately crash and burn is that
>>> this is still only setting up the structures for later
>>> use, but I assume that trying to use console=ttyS0, or
>>> opening /dev/ttyS0 on the uninitialized port would
>>> then cause an oops.
>>>
>>
>> All four affected platforms use ttyS0, only it is mmio based,
>> not io port based.
> 
> Right, so I think the problem is really the 8250_platform.c
> file trying to handle all possible cases on x86 (acpi,
> isapnp, legacy isa) that may define the same UARTs, but
> also trying to handle non-legacy ports with their own
> special cases on other architectures.
> 
> The patch below is a first idea of how we can skip the
> legacy ISA case on architectures that don't define those.
> If this works, we can try to come up with a better way of
> doing that. Ideally all the pre-DT boardfile machines that
> define their own "serial8250" platform_device (with platform_data)
> should use a different identifier the x86-legacy case that
> uses the platform_device (without platform_data). Similarly,
> I think the riscv special ACPI port needs its own trivial
> driver without all the ISA magic.
> 
>        Arnd
> 
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index 66fd6d5d4835..610b31517734 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c

That didn't work.



[    0.005735] Console: colour dummy device 80x25
[    0.006393] BUG: spinlock bad magic on CPU#0, swapper/0
[    0.006459]  lock: serial8250_ports+0x0/0x980, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.007102] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.0-07881-g6206e39999ae #1
[    0.007359] Stack:
[    0.007671] > 00000100 00000000 d09f9e10 d0951c2c
[    0.007765]   d0951c2c 00000000 00000000 d0b06170
[    0.007841]   9003f5ee d09f9e60 00000055 d0dd9900
[    0.007884]   00000000 00000004 d09f9e40 00000000
[    0.007925]   9003f681 d09f9e80 d0dd9900 d08f5924
[    0.007976] > 00000000 d08f5890 ffffffff 00000000
[    0.008019]   906f66b9 d09f9ea0 d0dd9900 00000000
[    0.008059] > 00000000 00000480 00000000 d0a06d74
[    0.008099]   904efe6a d09f9ec0 d0dd9900 00060300
[    0.008139] > 00000000 00000000 00000001 00000000
[    0.008180]   9004368d d09f9ef0 d0aa7238 d7ff70a4
[    0.008220] > d04efe6a 00000000 00000001 00000000
[    0.008260]   00000000 00000000 00000001 00000000
[    0.008301]   90044a84 d09f9f10 d0aa7238 d04efe14
[    0.008340] > d0dd9900 000000c4 d0a06d74 d0a00400
[    0.008381]   90ae6710 d09f9f30 d0aa7238 d0cedea0
[    0.008443] Call Trace:
[    0.008502]  [<d06ed63d>] dump_stack+0x9/0xc
[    0.008624]  [<d003f5ee>] spin_dump+0x4a/0x78
[    0.008677]  [<d003f681>] do_raw_spin_lock+0x1d/0x68
[    0.008727]  [<d06f66b9>] _raw_spin_lock_irqsave+0x41/0x54
[    0.008780]  [<d04efe6a>] univ8250_console_setup+0x56/0x104
[    0.008829]  [<d004368d>] try_enable_preferred_console+0x75/0xf4
[    0.008877]  [<d0044a84>] register_console+0xf4/0x3e4
[    0.008923]  [<d0ae6710>] univ8250_console_init+0x20/0x24
[    0.008970]  [<d0ad44f0>] console_init+0x18/0x20
[    0.009018]  [<d0acfdaf>] start_kernel+0x3db/0x4cc
[    0.009063]  [<d06ee02b>] _startup+0x13b/0x13b

That was xtensa. Others are just silent.

Guenter

