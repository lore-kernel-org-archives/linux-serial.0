Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227041DED76;
	Fri, 22 Nov 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296159; cv=none; b=U6DgzCNv7vKmwsT6vc88TARQQDN3D7h3xVYSMPIissQmrBvi4Jnrj0a0JzAaz7qV5zWaRtYHLDGaas4TapVJjZ2DrRUVji+9+sNc7Hy53GJW5E3B7BVuiPSbmcajr5VFc+Ibkck4flDkaNi6yxxNxRGITZD3AdemrU61ucOBmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296159; c=relaxed/simple;
	bh=XvLr5P5NugzlIS/rOVJcx/D8enKr3QtFHsbb1M/iEnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHpp2hkVe865hDteGdpbafDawGi1gbKMA8VoulnseKvfd6K9pcTuOGGygdn1BwMsoCjyg00gwOYvZVELpyB3gjKw+7+8rmO8LqVF9rSnv150F3YiUZp3Mo+9HAmgxe225YsSOve6HN7ysapdwF76zWQRY2FAo3+PwSCp6YoEQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjXPmSSM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjXPmSSM"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2070281a12.2;
        Fri, 22 Nov 2024 09:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732296157; x=1732900957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TQJ/B4r3iQFWXhpebGudazQsNTgXQ2hlQcmR6SYXxwU=;
        b=NjXPmSSMiBtUg5KqhJMIKswSw/5HTBiwRrEiS3X5OxFhXlTSTSCJppggMR0d7iYo1k
         6yfeqH/aY5kgUQCBPWF5arkrTqB6FbLAksDVftNyR0WJwkEMO/zKfeiiBzzuskV2b1wm
         xIAJMAAEN669edc+nlf8gV/du2kBbtRhLmJy8U7QUoYWylFOqKNVWXC3qx41EUgN2kec
         OM/TTRWRsyzhqPK1Lr1xit1B3+g/0f7ZT7JH4SkazyM2MrD1YV4q54mUKhGUj9k8Mvm1
         HPTc8rnJL5nE05PDUFYqkqoxbQjoWTog7Ilc11ob44qiWK1ASRsUYKHRcDWxJWyfluXg
         yVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296157; x=1732900957;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQJ/B4r3iQFWXhpebGudazQsNTgXQ2hlQcmR6SYXxwU=;
        b=mDcb11XAt/WXeNN44jS6wpKX08nKhuBIprttS0cWE7Yieau6wZUNXyaqNHVlF+i/G8
         n1DaYjHOCLenKQDT6P3B35fJLxaVLM0bvY5xS/TUl9v1lTr/KFgkfiOH6DJUDV4hgkuE
         jKxbAkKz9uCyA5FLLyi5DpbVYtfj6QpNwD6GNUKU65IjNC11KKUS5ZrbRdfHnLXTmvaE
         9gfZOk9fjojyaRvVpQqKihk5dRujNgQvOQECqly8gmXIrjqeOUedpAciLTimol6g8o2/
         7OrhIiKYqwrMz3tbPJscrZZ/+2uzErDRONFTN/1BhFTX92t7kkjzoPMdOlKkiJOBX6gD
         TKrg==
X-Forwarded-Encrypted: i=1; AJvYcCW5IBIynEoVn71yXJFX7LsC+f0FCPncK7BNLcbatBLlRNx1kOeGviID69S/GdV6tcQ82rIuN9mNPbCAugy+@vger.kernel.org, AJvYcCXyN9/o3Gb/pW/sDi7ZKgUM5mgmS6Y8bxvLfWiAsV0YpJ7B5NtAUtCCbCLpvAra5q0roibtZn5E10gQXJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCS7cVM39LdygxykMxRp7JLFSjeo2T3cdi/MonxCN9L/ITUnWG
	6m4tDTr18C0h9k23Qqzf9eMz1TCYsmTg58rIhyCjJcDfHRU7bq6oa7pvlw==
X-Gm-Gg: ASbGncvaVVsKKOb/2WIIz+GxtvZXZmSj5hAGDCYYSviuk2QAml6Kb5hAfaj5s19p0/l
	ljKhai+q3Og628SIUAB+HKhBJdmtAGR2PR3/fMl9HWBKXFRBP0lahJuqakxh22k0ANEGG4IaF6B
	x3kXl7H0bX3vBhvHZR6fzASLwuCDnXA829fH8T4LtmKtLy4i6awUB87vtjZCYKHcRpUhvhWuJsk
	8TOzI7FCgEtwQg99o/sK8K6QfrO2ag3I1xgT5Y9Ii0GXPaNRPwfRDqT4D4J30F/IYX45pab44I5
	eaXWOi7ABsu7WbVy2mbX95Y=
X-Google-Smtp-Source: AGHT+IHNPEOJURJIRVCrCNsVcBMh311NSH5MpoYokAIAPtpMW/jWroEio/jdHCBn388E+wUWDWG3AQ==
X-Received: by 2002:a05:6a20:a120:b0:1db:d9fe:c442 with SMTP id adf61e73a8af0-1e09e49ddcfmr4732071637.23.1732296157229;
        Fri, 22 Nov 2024 09:22:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3fae30sm1889604a12.76.2024.11.22.09.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 09:22:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
Date: Fri, 22 Nov 2024 09:22:35 -0800
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
 linux-kernel@vger.kernel.org
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 08:31, Arnd Bergmann wrote:
> On Fri, Nov 22, 2024, at 16:35, Niklas Schnelle wrote:
>> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
>>> On Fri, Apr 05, 2024 at 05:29:24PM +0200, Niklas Schnelle wrote:
>>>> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
>>>> compile time. We thus need to add HAS_IOPORT as dependency for those
>>>> drivers using them unconditionally. For 8250 based drivers some support
>>>> MMIO only use so fence only the parts requiring I/O ports.
>>>>
>>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ...
>>>> @@ -422,10 +443,12 @@ static void set_io_from_upio(struct uart_port *p)
>>>>   	up->dl_write = default_serial_dl_write;
>>>>   
>>>> +	default:
>>>> +		WARN(1, "Unsupported UART type %x\n", p->iotype);
>>>
>>> So, according to this patch, the serial uart on microblaze, nios2,
>>> openrisc, xtensa, and possibly others is not or no longer supported.
>>>
>>> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x1a8/0x22c
>>> Unsupported UART type 0
>>>
>>> Any special reason ?
>>
>> So according to the warning the p->iotype is 0 which is UPIO_PORT.
>> For UPIO_PORT the switch above the WARN would pick io_serial_in() and
>> io_serial_out() as handlers. These use inb() respectively outb() to
>> access the serial so I don't see how they would work with !HAS_IOPORT
>> and it most definitely won't work for s390.
>>
>> Now for Microblaze Kconfig says to select HAS_IOPORT if PCI so I'd
>> assume that it can use inb()/outb() and maybe the PCI requirement is
>> not correct if this isn't a PCI device and it used to work with
>> inb()/outb()? For nios2, openrisc, and xtensa they don't select
>> HAS_IOPORT so either it really won't work anyway or they should select
>> it. Can you tell us more about the devices involved where you saw this?
> 
> I've tried to have a quick look at the four architectures, here
> is what I see in the sources:
> 
> - on microblaze, the default uart is xlnx,xps-uartlite-1.00.a,
>    and there is no 8250. The PCI code that theoretically supports
>    I/O port access through an ISA bridge (copied from powerpc),
>    but there is currently no code to set up the I/O space window,
>    so in practice the port I/O is just a NULL pointer dereference.
> 
> - nios2 has a 16550 compatible UART listed in the devicetree
>    file, but this uses normal UPIO_MEM registers, not ISA-style
>    I/O ports. There is no support for ISA or PCI.
> 
> - openrisc has no support for port I/O, like on nios2 the
>    16550 style uart is on UPIO_MEM according to the devicetree
> 
> - xtensa manually sets up a UPIO_MEM uart in its board files
>    and in its dts files. The PCI support does have code to
>    hand port I/O, but it looks incorrect to me and either broke
>    at some point or never worked. Most likely this was copied
>    incorrectly from old powerpc or sparc code where it worked.
> 
> So in all four cases, the normal uart should keep working,
> and if something tried to start up an ISA style 8250, I
> would expect to see the new version produce the WARN()
> in place of what was a NULL pointer dereference (reading
> from (u8 *)0x2f8) before.
> 
> Since there are so many ways to set up a broken 8250,
> it is still possible that something tries to add another
> UPIO_PORT uart, and that this causes the WARN() to trigger,
> if we find any of those, the fix is to no stop registering
> broken ports.
> 

The call chain in all cases is

[    0.013596] Call Trace:
[    0.013796]  [<d06eb249>] dump_stack+0x9/0xc
[    0.014115]  [<d000c12c>] __warn+0x94/0xbc
[    0.014332]  [<d000c29c>] warn_slowpath_fmt+0x148/0x184
[    0.014560]  [<d04f03d8>] set_io_from_upio+0x70/0x98
[    0.014781]  [<d04f0459>] serial8250_set_defaults+0x59/0x8c
[    0.015013]  [<d04efa6a>] serial8250_setup_port+0x6e/0x90
[    0.015240]  [<d0ae2a12>] serial8250_isa_init_ports+0x32/0x5c
[    0.015473]  [<d0ae28a1>] univ8250_console_init+0x15/0x24
[    0.015698]  [<d0ad0684>] console_init+0x18/0x20
[    0.015926]  [<d0acbf43>] start_kernel+0x3db/0x4cc
[    0.016145]  [<d06ebc37>] _startup+0x13b/0x13b

That seems unconditional. What is the architecture expected to do to
prevent this call chain from being executed ?

Guenter

