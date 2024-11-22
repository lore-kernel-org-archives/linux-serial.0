Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D933189F43;
	Fri, 22 Nov 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308278; cv=none; b=NGuyOcY42EYa6Q2lt51RCD1GWNp1IDmStG8db5gMIwHywlKgXmZ9hd6SLmFubzzjWrfEhICGfumPHkoXB0XbRyh45xFUgn4CZGA6MaAshqWwgZk/cv4RTWOIOGxrHnQqHQ4mszQfvcV2uwZMrfcMz0hgnJbe0oag8izTOEuImNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308278; c=relaxed/simple;
	bh=HjFl3Oj6q9LDqx8ujmWl/zaen/dx9B0zKKpUssZ/+yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnJpkmYGGapoUIwKk7ueBRv/BKgVd5HncYIst6xEFnwctooxnjTp0JNvpzbq3CZsan3gNFFISdI9/1rUy0qCGLsxw626Iyh70vXl5wn83FeM6BsGkK5F33iSYaPHrbaeDgN+gLUJSQSk0D9uhLG/+o2wGva63SUPd+V8C3W3blc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbTSlCsB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbTSlCsB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea1e605193so2164758a91.0;
        Fri, 22 Nov 2024 12:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732308276; x=1732913076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RNsPdMG2oW5mX4YcRyTduEGbHWZOLSJxPYLHyQ64sGM=;
        b=gbTSlCsBMD7zMPfSbPsVWCEFl9L8gULvO1FlC7wH01bNEsSdUPNJFH+ZTbxKwqCsPi
         DRO/EcIlnaf98uN0WZiAdTioUVcQVhd8XsvBoj22HgblByYB7cSmO0SrpeLcwnrONhvX
         7imhIfR65lFIO3uhAJJ8qnTPoaMIUeYF2FQ9DfB39nfKl6wvpNEfGGdJv2VELkhHifXp
         N43maB0DBVeQPHL9lU5iIRLWmqO1aRJLu3w5tcU6SuPo/YNzOzV1oO++/ghkMOeWaGTV
         GFjp5K1QkfBy73ZPrXdr3oBsuxr77DT4f6ylkX6aVHL4FKM1QnrrKZh+y6hfqogeuqPX
         wG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732308276; x=1732913076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNsPdMG2oW5mX4YcRyTduEGbHWZOLSJxPYLHyQ64sGM=;
        b=GFaVn9aJ0qN/+wNhYivtvjuGAekS23JxGwXTcTh+aVCHSACMgeobfuLcotC2rSzn9e
         YvRzi3kTRzxJ76Idl3PrYKjqUTvIcqkSoM6npc653LTM0DMiZAIK5zJ5X4FJpJG4snaS
         xAXZVdH4Up57bmpg5JIm0FecvaxnCpqxqhm+9VFzpSY0nadQ09rpZyeT1I2VQIUdx2Qs
         T0U85Xh20vqr8rfPkreLX6tJQDki27a38qw/dt0pFP/vaYNC34BZLX3H0CDuBLvPEg4M
         BrlZkk8DaL5mQqZWLOTpOGilI/xaNgozZ4UZFFhGFfrJy6atESr9Yuh/u0WtHKn6tFbJ
         0bVg==
X-Forwarded-Encrypted: i=1; AJvYcCUSvdLkiJAOqmnlgUJ3rMsdA7QQkYYNREARxKfNhiImjzqpGO8KGBvHgEbdk0vwTNgLeYSfbN1arqcsJMAe@vger.kernel.org, AJvYcCWuOqjFMjsZ6eNwUp715e+ZFMfnaYqccTtIYXqC4mun8/mNKK9wJo+HTKoC5ds+iPXLoJ/e/mqE0cjuNwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fZfj9AqGSzj4WK6H091HKA76YN/plXf+EopPnYDpapK8D/Ex
	iLTizat1D8ApR7Srq2Rheus4Ng+I8XpkXs8RQHv7h9OVwDgHOaOqFEkK0Q==
X-Gm-Gg: ASbGncvkVxWgKJxJizO7lSzEYO/4KjE1o14AD0ewI2aiOEecbrhnwnnvd1dWXHGgxKr
	kNAzaeckmPGvTKKqvRKBY0JBbJCkVelGMkoSE3IaIdeWWzBxrcjWxYPzS+zkR5vNZarDfs+NTO1
	dq+o7IvXQ+zMIwMZgdBBXbG8oEJlh2UsPBXHERHldyyR9lrM2ptJlqLAj4FLw3cUamcdLIzncyI
	Gu6l5F1Q9AmEOMzMsdnv9+ix5Yd1Jmcu6cBMxZet28FmoMtTHG/E1TjellAlqABt7N37C5l4VTp
	mfiMu+Pvmdc02KNoy1KNPJc=
X-Google-Smtp-Source: AGHT+IG4NU4UZF0cebWOExJFU97sW6oQwwHPkQIFpcc+f91vpFhUKPVI6wUFjM4lXx9kc1fyeqF/cA==
X-Received: by 2002:a17:90b:4c4b:b0:2ea:77d9:6346 with SMTP id 98e67ed59e1d1-2eb0e22f276mr5083893a91.11.1732308276085;
        Fri, 22 Nov 2024 12:44:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea422sm5563673a91.6.2024.11.22.12.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 12:44:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <791f37f3-2b93-47f1-b0a3-46825c09f222@roeck-us.net>
Date: Fri, 22 Nov 2024 12:44:33 -0800
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 11:24, Arnd Bergmann wrote:
> On Fri, Nov 22, 2024, at 18:22, Guenter Roeck wrote:
>> On 11/22/24 08:31, Arnd Bergmann wrote:
>>> On Fri, Nov 22, 2024, at 16:35, Niklas Schnelle wrote:
>>>> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
>>> So in all four cases, the normal uart should keep working,
>>> and if something tried to start up an ISA style 8250, I
>>> would expect to see the new version produce the WARN()
>>> in place of what was a NULL pointer dereference (reading
>>> from (u8 *)0x2f8) before.
>>>
>>> Since there are so many ways to set up a broken 8250,
>>> it is still possible that something tries to add another
>>> UPIO_PORT uart, and that this causes the WARN() to trigger,
>>> if we find any of those, the fix is to no stop registering
>>> broken ports.
>>>
>>
>> The call chain in all cases is
>>
>> [    0.013596] Call Trace:
>> [    0.013796]  [<d06eb249>] dump_stack+0x9/0xc
>> [    0.014115]  [<d000c12c>] __warn+0x94/0xbc
>> [    0.014332]  [<d000c29c>] warn_slowpath_fmt+0x148/0x184
>> [    0.014560]  [<d04f03d8>] set_io_from_upio+0x70/0x98
>> [    0.014781]  [<d04f0459>] serial8250_set_defaults+0x59/0x8c
>> [    0.015013]  [<d04efa6a>] serial8250_setup_port+0x6e/0x90
>> [    0.015240]  [<d0ae2a12>] serial8250_isa_init_ports+0x32/0x5c
>> [    0.015473]  [<d0ae28a1>] univ8250_console_init+0x15/0x24
>> [    0.015698]  [<d0ad0684>] console_init+0x18/0x20
>> [    0.015926]  [<d0acbf43>] start_kernel+0x3db/0x4cc
>> [    0.016145]  [<d06ebc37>] _startup+0x13b/0x13b
>>
>> That seems unconditional. What is the architecture expected to do to
>> prevent this call chain from being executed ?
> 
> This looks like a bug in drivers/tty/serial/8250/8250_platform.c
> to me, not something the architectures did wrong. My impression
> from __serial8250_isa_init_ports() is that this is supposed
> to initialize exactly the ports in the old_serial_port[]
> array, which is filled only on alpha, m68k and x86 but not
> on the other ones.
> 
> Andy moved this code in ffd8e8bd26e9 ("serial: 8250: Extract
> platform driver"), but I don't think this move by itself
> changed anything.
> 
> serial8250_setup_port() is where it ends up using the
> uninitialized serial8250_ports[index] contents. Since
> port->iotype is not set to anything here, it defaults to
> '0', which happens to be UPIO_PORT.
> 
> The reason it doesn't immediately crash and burn is that
> this is still only setting up the structures for later
> use, but I assume that trying to use console=ttyS0, or
> opening /dev/ttyS0 on the uninitialized port would
> then cause an oops.
> 

All four affected platforms use ttyS0, only it is mmio based,
not io port based.

Guenter

> The bit I'm less sure about is why the
> serial8250_setup_port() function is called here in
> the first place. I assume it does something for
> /some/ architecture, but it's clearly wrong for
> most of them.
> 
>         Arnd

