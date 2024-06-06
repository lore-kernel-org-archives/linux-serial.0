Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B6FC02
	for <linux-serial@vger.kernel.org>; Thu,  6 Jun 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698350; cv=none; b=N80RQwE4d3Rv5CTT5ZP2i6Tp4M6HPAwttUIjMLiId/942kON4N+67Uj6U8AicqzeZAaWoaKcx0AfR3Z0+31hHQRyRIS3ocb8I+9aGRdeW4G126WArvZ9KDOXhUryfNKhMrV9rxmvp2MWpsonxHNqIktbFeBtkEnTWYVDWqF1rDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698350; c=relaxed/simple;
	bh=gCj3Vlj0qU6Lpsy9oSFTpXWU4JEuaUj+Chyk30mOTu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBM4jqL5UzXXosNj8p7QwordgLthRGSRDO3Z/CmvF45w7w50iPPbFeAhwz3H4CHTu3NZMwuZtqkhyNaZy5lq72AvVmIZV+5vaqwLYuS436bjEkxYkEqqofAsaFHvkIhFRdKmxNrDGZ4LbrJUZR8+qFPo2lMMgL+jOV+ND3eSZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=JAQ0Bvxf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="JAQ0Bvxf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f2e3249d5eso2195855ad.3
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2024 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717698348; x=1718303148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLSb2hjypAsHGdsIQL+DaybMyTAuRzQ0qjbEdPf3ZHw=;
        b=JAQ0BvxfizXOk5BuaAwKxZwsRZ57+LAf9G1RAZsfVTCQPuSOy1FSKM/WgjGzfgWQLc
         s2SN93X5IWZj7xvP5mT1qs64VwMf/atG25C5p6t9NW/dzAHQKQggt5LDL2B7Ut5Xk229
         FG2iEG07t9mD3BZguW5PHIViHVXM8powu4zSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698348; x=1718303148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLSb2hjypAsHGdsIQL+DaybMyTAuRzQ0qjbEdPf3ZHw=;
        b=eX9KfTjqCQjnoq1P7joeK6UhWr9Hs/DQOFr82YLuvBUdoYqDQdUEoPKAzQ2NaDQTRJ
         4A9I1XzxpyOYUWcLP4KcK1d25yq3DDLeGBUkxHkRdRJpRSq+p6avpioTTxTThmgP0rM9
         eEAcPAJAehfmV99KCV1v3U4SYlzxVo0IOkYdINusyfPVSgICO5F2xSeBK03/xT7nmRlT
         U08ouv2EYW2wspJmbqeFhfBX7udtmwIwe7J1e/EnbKO4hXh9CoSc3/NJyJBeiypbXEbA
         klM8os0oXb7faeuqieM8cNAdsMQUt9pNjOPMBbKQUUGhzZ+IzuXUIlgayejhW0VH+Y6w
         gbMg==
X-Forwarded-Encrypted: i=1; AJvYcCWadG00K1rIXOEoJ49i722R88i+s4J9yMVY6vLeFzcnWGIST0mmmGZwrjr5VFNW0jzWDGcbC4sTZT01CYgwcxDC1ovD/21MeJKu7RCe
X-Gm-Message-State: AOJu0Yw+dWlgkS2KU+Yez2+d1AtdBW2du0CMrzVR8nS70QAYP+YSvRAh
	EnYXaG7mni3OsQ7JkgKhTG1Kbg6E2+CaYDXyN7wg2FI4KMCFtpP0RvGNvxPlaBDmSedhGnzd2TV
	BbLzSdg==
X-Google-Smtp-Source: AGHT+IGOqHP880AZ0K6Vri0cdxrrMPSdEyAMZMLwDmnXejDbFNN3scvM1VcULEQlZul3ezHPHhxtrA==
X-Received: by 2002:a17:902:d4d2:b0:1f5:e635:21eb with SMTP id d9443c01a7336-1f6d0221838mr5091155ad.0.1717698347917;
        Thu, 06 Jun 2024 11:25:47 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd75ef63sm18410295ad.4.2024.06.06.11.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 11:25:47 -0700 (PDT)
Message-ID: <986c588e-2a14-4167-8664-95452f1dc38a@schmorgal.com>
Date: Thu, 6 Jun 2024 11:25:45 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org
References: <20240519193109.122466-1-doug@schmorgal.com>
 <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
 <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
 <20d56279-2598-4a3e-9984-729199d8e67d@schmorgal.com>
 <f7d2289a-2992-470b-97e3-187386ec3f5d@schmorgal.com>
 <CAOiHx=mVSp4v0bxCW4HQ8SJUQ_7JN_8HMWvoB4-CR2mKtxTjaA@mail.gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <CAOiHx=mVSp4v0bxCW4HQ8SJUQ_7JN_8HMWvoB4-CR2mKtxTjaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 6/4/2024 6:04 AM, Jonas Gorski wrote:
> Hi,
> 
> On Sun, 2 Jun 2024 at 19:24, Doug Brown <doug@schmorgal.com> wrote:
>>
>> Hi Jonas,
>>
>>>> On Mon, 20 May 2024 at 08:41, Jiri Slaby <jirislaby@kernel.org> wrote:
>>>>>
>>>>> Perhaps, it should be reverted and the affected driver should just pass
>>>>> UART_TX_NOSTOP instead?
>>>>>
>>>>>>         uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
>>>>>>                 true,
>>>>>>                 serial_out(up, UART_TX, ch),
>> Does the bcm63xx_uart driver work correctly if 7bfb915a597a is reverted
>> and UART_TX_NOSTOP is used instead?
>>
>> I was able to further confirm on hardware (BeagleBoard) that omap-serial
>> is also broken after 7bfb915a597a. I'm trying to figure out how to
>> safely revert it while also allowing bcm63xx to continue to work properly.
> 
> So I went through all users of uart_port_tx(_limited()), and
> expectedly most do just disable the IRQ (or do nothing) in their
> stop_tx() call back.
> 
> The notable exceptions I could identify are:
> 
> - bcm63xx_uart: disables the emitter as well
> - mxs-uart: disables the emitter (introduced and uses UART_TX_NOSTOP)
> - sprd_serial: stops alls dma transfers as well
> - atmel_serial: stops dma and disables emitter as well
> 
> I suspect sprd_serial and atmel_serial to not work properly with the
> old behavior, but I have no devices where I could test this.

I see what you mean. Unfortunately I also don't have the ability to test
either of those drivers. It looks like atmel_serial didn't previously
have a stop_tx() anywhere in the code that was refactored to use
uart_port_tx(), so I'm assuming it should also have UART_TX_NOSTOP
added. I'm not confident enough to submit a patch for it though.

sprd_serial prior to the uart_port_tx_limited() refactor was calling
stop_tx() when uart_circ_empty() was true -- in fact it was almost
identical to the pxa driver's code -- so I feel like any bug in there
related to stopping too early would have predated any of these changes.

> Regardless of the chosen quick fix, it feels like stop_tx() is the
> wrong thing to use for uart_port_tx(), and just happened to do the
> right thing for the majority or drivers. But the correct function
> (something along "done submitting tx") also doesn't exist.

That makes complete sense to me.

> But I'm no maintainer for tty/serial, nor do I have much (intimate)
> knowledge there. This is just from looking at it from the outside, and
> my thoughts may very well be wrong.

I'm in the same boat. I wouldn't feel comfortable submitting a large fix
for something like that. There are so many hardware platforms that are
using this code, it seems very intimidating to work on. Thanks for the
analysis, and thanks for linking your previous patch! I'll work on
submitting a quick fix for this at least. I think if we go back to the
approach your earlier patchset used, it will fix the issue I'm seeing on
omap-serial and pxa while also working properly on bcm63xx_uart.

Doug
