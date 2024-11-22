Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A761DF275;
	Fri, 22 Nov 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295258; cv=none; b=gViT45TK55zPo5lTAkXU9uAS9Xrd6CGnPePjx0McLCyf7NYwafyjHHyKIj8J/NIBS3vsNq0i33SVfXFHcCKkZmw3TFI9SMBHEJW6lh+TZm/BWKfkQbKuDuanSWuoUn/Z98DFAs+XZiTX0SHgkJwTTtR875anKmV2Mp+eIsSp4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295258; c=relaxed/simple;
	bh=MepBEeqi86REzF4Piw/RMtxF9q/67f9BaMHFsebimAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA4xsuPN4wHJwU+T32HE8zVqiw2XanVpX/Ms43vWwpvR6csnWmm6z33FMxJ86aBNP0O0MPM/GyQodACh0imK2lnDsBCxyppqiyf7vX/x6N/mjdeiFKf/GWOSC/jguF0IiKp6eq7GIDKxISsJ04RIgaoc6zF3AT/CwuYXGCuzvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRMxCFMo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRMxCFMo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21271dc4084so23241415ad.2;
        Fri, 22 Nov 2024 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732295256; x=1732900056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=euz7Qt5oB+ObQldsMDnUpp7M7zBEDLVD6Rc8OH5eZ+s=;
        b=TRMxCFMoukzh31koNe5rk0O/+FTjJQiqy+i/qRYd52G/+h6Mx9byh431739IDKcLOU
         z9stRJFBGnKvrZFuQriI0IwsGgBYM10Rw57o+8rDXbBR/yKl0ppyVg3NksCTPWNQYcei
         vvL/9QyU7iS0c+1aCueAAZQ+Wz7qM1KmdVq7sYHfl4C35pcttYkPHnrnIfeqDcHqbl2K
         MbdBKVaP1LaNDIYbhjGDjie6/fXZAMToCjX5ZIGZYEufOwFkk5H2atJbJX+07ZKnLThd
         AGBDiUo2Ud+CVDW1eLUDdreKUyHwMciJOelHcmTO5+r0Z1tx39/oOJL7XGYttpRuyNFe
         KQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295256; x=1732900056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euz7Qt5oB+ObQldsMDnUpp7M7zBEDLVD6Rc8OH5eZ+s=;
        b=pZYQHAbz9rvaapvJMJfam6thdYzUZrVmDeor0vS3A36LUbDwRAVHamj1ts3AbKPiLl
         INUcaJCWoZrvm+WpwIQsWOzKSgThUnT0O0oABkEd+vAu0hcYEDomu8Ltt2W1oBNmXzT0
         0W5JkSn313fxPZSBq4SM8XhayswuTH7Esni7fJVf8/+ewXY4CMiodeDsPUOtHtG1P/pm
         wIaZaYwSMZC2F2lWI8GabaNXvAx6+mPj2e64P8VgKD+vERWonkZHxlomvuolHpRvhqph
         PWs8xTOiujPq9uDi1/6gvNclM5iarGe8bAXVO9//1fTeQGPQCPkHVF4mEI7TXIc3rJY3
         HWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRpOI+B+gpYVx4NB4Dc4Igen85NZsRJMbQjnM/8rxjpd9oNATmU8qOBJuy9MRiJrnUI80IghIHsmqzl7Dz@vger.kernel.org, AJvYcCWAIClt/BI/nwQ0HfSOoc2Kp46vzPz3WWoYztTOgXC9lz+SzFGkw84DMZOR6DXHDYKM/BbYUp2sEpC+hqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9ZFG7Rq/0yl2G1cUoJOjqNJTLbTzDls7FHIygJ6oAzU5lI/z
	pvPys65S9Q09jZ6QBpaR0SDDt2FkDLaDL0Xznpj5nK3vPm5TTPG3
X-Gm-Gg: ASbGnct1uWD6Qyszj+igKBuMWl/v/L2kOTQIKIoM/LiQc25uS3Qrlp6b6id9+sgfbbL
	QxYiWWOYnmuf9Ves4+Wse5jnJgE+1WniIa1FkKCnBoYqBU+amMO46Qnql++Em/ag1xEHuSohGS2
	6m5iJhztX9af2Wcq72LcR69dRcRVSgoXxp2QaLLZCUn4QNUrNYVyEHKtsy0OutSet0odY1LV5Qs
	tmwPw51WcL/w5jsoTyVrzVDb4ghpuK0e0XhUcoskTcVt5VyMt2iYpwmk4UbSaLqnYa9QzBiK2zl
	sEaZ20nm13tFR1Rr0qCrn1E=
X-Google-Smtp-Source: AGHT+IG2HcqI4+uC/VHmIW1bxR0A2dYvK8stBzYhGJaJDY0GmcYfxwGCVqck/s9L6tJgM4SyNWkXew==
X-Received: by 2002:a17:902:da8b:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-2129f5e73c9mr43043855ad.23.1732295256329;
        Fri, 22 Nov 2024 09:07:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba29d9sm18595165ad.59.2024.11.22.09.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 09:07:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <92c2c05a-be0d-4017-a766-62832668512d@roeck-us.net>
Date: Fri, 22 Nov 2024 09:07:33 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 07:35, Niklas Schnelle wrote:
> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
>> On Fri, Apr 05, 2024 at 05:29:24PM +0200, Niklas Schnelle wrote:
>>> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
>>> compile time. We thus need to add HAS_IOPORT as dependency for those
>>> drivers using them unconditionally. For 8250 based drivers some support
>>> MMIO only use so fence only the parts requiring I/O ports.
>>>
>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ...
>>> @@ -422,10 +443,12 @@ static void set_io_from_upio(struct uart_port *p)
>>>   	up->dl_write = default_serial_dl_write;
>>>   
>>> +	default:
>>> +		WARN(1, "Unsupported UART type %x\n", p->iotype);
>>
>> So, according to this patch, the serial uart on microblaze, nios2,
>> openrisc, xtensa, and possibly others is not or no longer supported.
>>
>> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x1a8/0x22c
>> Unsupported UART type 0
>>
>> Any special reason ?
>>
>> Guenter
> 
> So according to the warning the p->iotype is 0 which is UPIO_PORT.
> For UPIO_PORT the switch above the WARN would pick io_serial_in() and
> io_serial_out() as handlers. These use inb() respectively outb() to
> access the serial so I don't see how they would work with !HAS_IOPORT
> and it most definitely won't work for s390.
> 
> Now for Microblaze Kconfig says to select HAS_IOPORT if PCI so I'd
> assume that it can use inb()/outb() and maybe the PCI requirement is
> not correct if this isn't a PCI device and it used to work with
> inb()/outb()? For nios2, openrisc, and xtensa they don't select
> HAS_IOPORT so either it really won't work anyway or they should select
> it. Can you tell us more about the devices involved where you saw this?
> 

This is seen when booting the affected architectures with qemu.

Logs:

https://kerneltests.org/builders/qemu-microblaze-master/builds/327/steps/qemubuildcommand/logs/stdio
https://kerneltests.org/builders/qemu-nios2-master/builds/314/steps/qemubuildcommand/logs/stdio
https://kerneltests.org/builders/qemu-openrisc-master/builds/301
https://kerneltests.org/builders/qemu-xtensa-master/builds/311/steps/qemubuildcommand/logs/stdio

Guenter

