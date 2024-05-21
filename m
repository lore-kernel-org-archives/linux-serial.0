Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F523749
	for <linux-serial@vger.kernel.org>; Tue, 21 May 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267519; cv=none; b=NvSISTSC/HoHUJvGnmf4JeXTsbD2YFqNmcVvEjuP7EDNakJd7h7+qS/pO/q9LziXmkble/bIymLM9sF4WFu8hktape0GUHhJUKKlK+se1oKBWJ3hqCN+6QW5RntNS2OuvsaUZ7BcffSmqfJ0AL0sTwrHVUM4aJMaTBjmHGTIhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267519; c=relaxed/simple;
	bh=iBDqRyjFozbZojV9Tm6jc2MTkKZ0mPZbydN4si4PcLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSN/u/aaA3WiGOpcOq363O0h7zrzl16TiPmiX1wbqVluoIwFSaYtt5qFkABxwBAAYEbjevt1F4nXlzv6OrF8JqlKBeeJNMhhnln5/WDv+8YUhAMvEbI5WoL8/07DTbrd+8d5TUoxJSd4esR4aIqpsv0Ldr9hsoxsdig8NFxYApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=bGieHdSL; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="bGieHdSL"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b2dd35212fso396571eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 21:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1716267516; x=1716872316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XInF9u3dYy7a1N1IlIxFxMZS6Wpumf8KGKQ/ks5PIPU=;
        b=bGieHdSL1+Iip/OjN5a7CM4fv54VjWBDZtYWIqbJc3p3HiRU1y5s7AduUrs0ZQWLeB
         JkjjhG4AArevMmdaOeIjxKd4v7JjrAsEIvbd4hHbAEbIw+1TH5Op7w/x9qCE8yH4VLFR
         d2QgkbFdABEH7HoXJucLcsOsnncBQki/+OrpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716267516; x=1716872316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XInF9u3dYy7a1N1IlIxFxMZS6Wpumf8KGKQ/ks5PIPU=;
        b=YPtJjmedzNL8c/YymNgd7NkplceW/7KCnVwUCSG4cIeWg2Uma4T7GRAs/+GFtW/M9N
         uORCSHXlx1VMj3cmC6ZrOu6TwdbOXCriZhAt/98gfmvJda+zSnwM/Nu588sViYLsRq0z
         hESDBqG4w82AP6qx8XJwSAi6zQzgWpxr/ktB3m7CPWkoh4PFGnVe95zw+54ldpZ20owu
         fEWgEifdS1defSi4wxoRa/uSZEvaT15X0y8P//Ei3bkz4RxBDmmAENeA9zFHFtkK1y/O
         T3S1ua5r20vK4cAb4GuRxi2RDWz49qqDgLITL/YOpEOG6+g+MxP2fB+hs7NNtQ1QfbUB
         FUDA==
X-Forwarded-Encrypted: i=1; AJvYcCWc7JQ1ZT3+Xm7jNG2bCKC+uYj8MK8a2A7J7G7ha/r4YWWQbU/rwI2KjdeSFV7Q4CcH35XYCSb2ZJoGmbL6Bzth/u6syXqYsyQWU6v3
X-Gm-Message-State: AOJu0YyVX3PVLENloQ4cZ/r+jOY/Dt1OaCVqVnsf9n8tXFmuBTZXB6BM
	mT/VL2Z661vjeYr+CjZCv8pivhvvF/BhiilGapP/0f83fZggIH/5zoVmmmGuQQc=
X-Google-Smtp-Source: AGHT+IFMPZfMCFJRZv0SAyDHFSNN8ECXvgbal9cTdDTLJEPN5Qfd5UUIK9BX6SUNtTGY92Uj3I/eoQ==
X-Received: by 2002:a05:6359:4c92:b0:192:5236:b1d9 with SMTP id e5c5f4694b2df-193bcfe01d5mr2925961755d.2.1716267515429;
        Mon, 20 May 2024 21:58:35 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659cf15526asm7225096a12.45.2024.05.20.21.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 21:58:35 -0700 (PDT)
Message-ID: <20d56279-2598-4a3e-9984-729199d8e67d@schmorgal.com>
Date: Mon, 20 May 2024 21:58:33 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
To: Jonas Gorski <jonas.gorski@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org
References: <20240519193109.122466-1-doug@schmorgal.com>
 <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
 <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas and Jiri,

On 5/20/2024 2:30 AM, Jonas Gorski wrote:
> Hi
> 
> On Mon, 20 May 2024 at 08:41, Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> This does not make sense. If the circ buf is empty,
>> uart_port_tx_limited() should stop the TX already. You simply revert to
>> the state before 7bfb915a597a, but on a per-driver basis.
>>
>> IOW all drivers using the helper would have exactly this issue after
>> 7bfb915a597a.

I tested more, and it appears you are correct, Jiri. I think
7bfb915a597a has broken other drivers too.

For some background on this, after upgrading to 6.9 I observed that
transmits would stop working on my PXA168-based device with the pxa
driver until I caused another UART IRQ to fire, for example by typing a
character in the console. I bisected the problem to 7bfb915a597a.

I don't have a bunch of hardware to test with, but I cobbled together a
way to emulate a BeagleBoard in an old Linaro QEMU branch, and the omap-
serial driver also appears to be affected. Shortly after boot, the UART
just completely hangs and all transmits stop working. I can't even type
a character to recover it like I can with the pxa driver. Reverting
7bfb915a597a fixes the issue.

I think the reason the pxa driver recovers when I type a character is
because it always checks the THRE bit of the LSR in the IRQ handler,
even if the IIR doesn't say there's a TX interrupt ready. (This appears
to be a workaround for an erratum in the PXA serial IP...)

>> Perhaps, it should be reverted and the affected driver should just pass
>> UART_TX_NOSTOP instead?
>>
>>>        uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
>>>                true,
>>>                serial_out(up, UART_TX, ch),

I can't speak for whether that would fix the issue Jonas originally saw,
but it does look like it needs to be reverted because other drivers are
also broken due to this change.

> 1. The kernel doc for uart_ops::stop_tx() says "The driver should stop
> transmitting characters as soon as possible."

Very interesting. I guess the correct behavior depends on the exact
interpretation of "stop transmitting characters as soon as possible".
:-) It looks like, at least for the existing 16550-esque drivers that
are using the helper, they are treating stop_tx() more as a signal to
disable the TX interrupt, but still allow any characters already in the
FIFO to go out.

All I know is, in the PXA UART, I was observing the TX IRQ firing when
we had no data to load in the FIFO, and we weren't disabling the
interrupt. This causes a 16550A-style UART to get hung up because the TX
interrupt never fires again unless you disable it and re-enable it.

Doug
