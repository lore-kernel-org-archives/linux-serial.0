Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06831C3BE5;
	Wed,  4 Dec 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338265; cv=none; b=kELfzxw+Nt2m55Eimpt3UB9SzVyjEWNOiSGJFyRyQO5cM1tGg2ZiQEcfnN75jGqSbtMvFpwuurXZ0Eny6J1lvSoSeC9FRN3QFjE7aDYlVGMxRZMXf+XMssPF66kkWGiAermci9hNMwoN41vkAokE6FhBFW9nYU6Tp8GVTSirBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338265; c=relaxed/simple;
	bh=K4PB2XLUmcIxAi3+YHqFxH4B6VjMnuYLbo+ef29kQao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4FnPnQ5mYGREeEAiLVaSMweTRVPTsLs+PtK4ZBbi1/4yaskgWuXcLNGBpFDgRYA7Qn8wkAeq6vzvn9oMfPhjD0gd/ixm+NendxZybdsGS5OJOyIbEA5yloO5iYRHrayWtdRMZCu0PlhQFbKad+4R/a23Thudm4TrrhfMh7x0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwLafkfx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwLafkfx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd10cd5b1aso89745a12.2;
        Wed, 04 Dec 2024 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733338263; x=1733943063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y7kJsGop4AJOqXEuTsvuTmAlGKhiu/SHgxfy832mSYc=;
        b=WwLafkfxL+JrJL46W+sIRRzgCSgmfC26WJgKqMvLcT8UXs7HFiGD9nL9zkLbC3ot99
         20q4H52t/9EQWyAf79SoFVFuYopiqU6YWBocnxt69vxdHQB697njjCg5i8QEy0bvLc5Z
         MT/RG1dQueJ+bPogHfe9OyyxpcyZag4P760v0us/UcjhgpEDYwGt+jhxUrt4LjDQhSpX
         Be9Hhj9Vt7QurdnICEDVmrjk+bgKStJwrBC+ur/dUPsjW/Jt31/vburGtMpuD8uh72nM
         dSYbjJP+I9f/ciNXKcbY4jw8bxdfX1XRuxjMryUMju7nOobT8lo8myH1udjWf8oTbrl7
         KHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338263; x=1733943063;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7kJsGop4AJOqXEuTsvuTmAlGKhiu/SHgxfy832mSYc=;
        b=JqlzInHKvfb354hZ3srQ4v7G9YbqIRLXoSSgLnj+aQEyJrbviNmxVc3T3YtxP3mwDH
         lCK3gt0UXUzJhtAnkgNXKt5hG0fBjBQUdbHgMOpApU7YAt4N2SO1nm92rf2A3GkG3Net
         2nBPHpA/dTueBq2v64E3OEq7LJmFFCPR/ID0IRmRy1SOFxT63tToyw+0+epu13USJX6o
         wzthL0MdpFAmOVGokDCf3WYlVY58drrpnsjNq3APSPji3edrjmWb1dfd6FPC5nhy5og/
         maLDsLuF+FjKfZBAYLghixKtJ/gPqBGntkcIdTfPJYpQA3QKFPvQ1e+7aeFYvuQ2nD1V
         0Xhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzrXSUQoQZrLVfp44sozqZizhdvYvpUsLbZecmEc0PoNN6HTNndW05LkuS8n0oKKMuh0wegrDWnSPC9Jfw@vger.kernel.org, AJvYcCVqYD11yGQQM8YKSQR4jnbZZYFtr1SW4Cgg5nIVstGlfwlBbzMsDMeri98EwlFX5/S72trVVYj6BahnWOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrq4HxKIrRNj7pfXiRc8F6tGNjh2cBpCrmrzjqgCXy24OUV+pC
	JT6UHpfST344+2daB1DN8KIHxpxoR/jiryDrp9lpjlb1H1ui7ZF4
X-Gm-Gg: ASbGncsxeLU5FnHkM+EcOq/OOQzcaMEY0cHi1HohZ4OAeoLUnci74gUGMavtXr7EN+e
	uf1OHfiblrZgvaPIMkqPp8uz4qW/tCCGhKedEL1fdFtkOQAM9uTtMYEQWRu7dhN+QMwrMH/q1vf
	DaEPnbchZvv/q31wIkmKVHjBQnGi1viOH3weWUDBMp6iUF1JZZMeUCpchCVxCqAdQclQFHL8sGu
	zpHMQxCNphwIKAQkU16wGbosZTtHZGP7gNmLBmuHNQ08i6FhUapgOXWVwMjOp1f7VaAalOCzsq5
	R2SP0c79ELUbQMePCSn676c=
X-Google-Smtp-Source: AGHT+IEfYfWHnzK36wH6d2DthY1XIzhicxckYkEwIdcpXypHsG42oBiUtS94CbA76gBttXYVk8VUPw==
X-Received: by 2002:a05:6a20:7285:b0:1d9:78c:dcf2 with SMTP id adf61e73a8af0-1e16bef0a05mr9645801637.43.1733338262968;
        Wed, 04 Dec 2024 10:51:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258acb69f5sm2045755b3a.76.2024.12.04.10.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:51:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a7042485-0105-4d5f-9ae4-02f552d05a6a@roeck-us.net>
Date: Wed, 4 Dec 2024 10:51:00 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
References: <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com>
 <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
 <alpine.DEB.2.21.2411251628320.44939@angie.orcam.me.uk>
 <42b1911e-c69b-4f5a-96f2-ab6d4353ea5c@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <42b1911e-c69b-4f5a-96f2-ab6d4353ea5c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 09:54, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 17:54, Maciej W. Rozycki wrote:
>> On Mon, 25 Nov 2024, Arnd Bergmann wrote:
>>
>>>> But the configuration can give less than old_serial_port contains.
>>>> See dozens of the explicit settings in the defconfigs.
>>>
>>> I don't see any of the upstream defconfigs doing this
>>> though, the only ones setting CONFIG_SERIAL_8250_RUNTIME_UARTS
>>> are those that have an empty old_serial_port[].
>>>
>>> Note that SERIAL_PORT_DFNS is only defined on x86, alpha
>>> and m68k (for q40), which are the main PC-like platforms.
>>
>>   May I suggest to call `serial8250_isa_init_ports':
>>
>> 	if (IS_ENABLED(CONFIG_ISA) || IS_ENABLED(CONFIG_ALPHA) ||
>> 	    IS_ENABLED(CONFIG_M68K) || IS_ENABLED(CONFIG_X86))
>>
>> then (or have an equivalent `select' in the relevant Kconfig files)?
> 
> Right, I think that makes sense, but I'm a little worried
> about renumbering or incorrectly configuring the uarts on
> a non-x86 system that might have ISA slots and also register
> a 8250 console.
> 
> E.g. on the RM200, two serial ports get registered on
> MMIO addresses:
> 
> arch/mips/sni/rm200.c:static struct serial8250_platform_data rm200_data[] = {
> arch/mips/sni/rm200.c-  MEMPORT(0x160003f8, RM200_I8259A_IRQ_BASE + 4),
> arch/mips/sni/rm200.c-  MEMPORT(0x160002f8, RM200_I8259A_IRQ_BASE + 3),
> arch/mips/sni/rm200.c-  { },
> arch/mips/sni/rm200.c-};
> 
> so these would become ports ttyS4 and ttyS5 if the first four
> ports get reserved for ISA cards, or disappear when using the
> default CONFIG_SERIAL_8250_NR_UARTS=4.
> 

Any progress ?

Guenter

