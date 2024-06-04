Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BA144D2E
	for <linux-serial@vger.kernel.org>; Tue,  4 Jun 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506293; cv=none; b=gPuHz0DQZeZmoM0NzpWxOdzqc5dqZwLUe98TVp2P8N4qUG9JXd5AiRziqI7Ttm4gUDpaUmUUkYOdM//E0FnNJTy3bmzz5pG6F9mCJbNWoEXyAPitfQwlhqREF1HmwzFobR4LbQO2ZPMS3wEbp0X1DhKo8xunKL4RM78LzhvgqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506293; c=relaxed/simple;
	bh=wFXmRvaYN39Y38/uhX81xTt2b/XpDZwa9KK2+1Okj/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEK5+FZ4obtcMmJfMds9mH0BIkgkTPGq1Des8SEThl5jpvsRtxyCDay52XR7psO1Z8wb6X6rZA1u+yzBZFBBpzsnDQ0hVl+zMROiVIBuxUUidngf5yE7BqYlI++yAuVkAwdQhCib+xBha/VPvjX9/tUz5vozuY0fDRGhHIhfELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0eKXqI2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0eKXqI2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso3842712b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2024 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717506292; x=1718111092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKNxwUDIw+ztmPJxdmPnbCQgYBjvk+0A0Y7/Sg6UaVQ=;
        b=l0eKXqI2MDJ7u7M6LPVRiEhh6YWzpkSa5efW95fiascVpccphKY21uhDaWxR+Z47D+
         xEsqDa3zIMy8p1jtH/7QGx7nlWyTKoGxEYLfPUoFKbxwUjllLRfThInbF0RgTSLoXYbJ
         Iqs7pDNO8rSvGuLdqFCmhogljObuLfwP9x8vzoN5yzf3F0rUXOfr/ZmhK5YReY6lQrJu
         cFtIvYJT1YDt2ISsKhvtzV7b6tdgbW1sDcTdhjDBBWzSlPD6OlMaV6jibtz+ns3bxAnu
         MQ+LVLNZENqr/15At0JYzJRNbefMy6hgF/GokSoWrOnQsJeg1MeZ6MrL0fKCZM5bQphd
         QxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506292; x=1718111092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKNxwUDIw+ztmPJxdmPnbCQgYBjvk+0A0Y7/Sg6UaVQ=;
        b=f2zZoM83lRXT+Q+9AAyx7SgMR1izZN3+JOm/OQ1MCVpR+LFkX3wg+IHr7DPbbTk6gG
         xDAoZzNaiy2q+57UWH7CREhRQCmASNIpvNYUHjKlqhkW8YxddzTxPZQsNQHrqhxSxtVa
         jOZ947D5atojvkWXghcUiAHZ0nczg8FvP0kTuqOHAYIdOJybbpYo5VraIRfu4a0cpMjT
         T8vQItuKzPTQITMDWU3i1GuljTRxQncSbtfZhhQcZ0uXtNOnxxqkwYrsXEOrNaEsXiXY
         d/hK8IA9BAGsiqpcT6npkZPavsOBAtXOPvEH0iB7XdfA1Vp/Vq+eVwVgkQnks9kktYfC
         BlLA==
X-Forwarded-Encrypted: i=1; AJvYcCXyRGyenP0lXZczaDliP6okkxAKTtT0wgr8xedNBcu3fi1N3BaItRmJZwbNZ+E9CJ6czzzYlfPL/P7OkfnxrMViRqu++0MIssIbArSs
X-Gm-Message-State: AOJu0Yy95jumi5DVL9flSNC+VuXWXRk9aa13VRBZzIHVupVIkwq9ETeG
	+464VtGuXniknoFfvdo1/QUgSv8Yz7PCwx7+3to0wuv4QDPcq/BJPvwxF1zEbVwKd4YFyjgzlxd
	uOakmTzHNW6I//cyiEtUcSdMnfEDOzhYB
X-Google-Smtp-Source: AGHT+IFYJebxHNZm1mNj5fUQLIQ+L/7M7QlonYMXBE15UjBlm+7L7g1rWbTMMb+Nok/GxkERKV82QTrRGYtHqz6Xr0g=
X-Received: by 2002:a17:90b:19cf:b0:2c1:b92a:f385 with SMTP id
 98e67ed59e1d1-2c1dc5d371fmr10937782a91.46.1717506291480; Tue, 04 Jun 2024
 06:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519193109.122466-1-doug@schmorgal.com> <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
 <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
 <20d56279-2598-4a3e-9984-729199d8e67d@schmorgal.com> <f7d2289a-2992-470b-97e3-187386ec3f5d@schmorgal.com>
In-Reply-To: <f7d2289a-2992-470b-97e3-187386ec3f5d@schmorgal.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 4 Jun 2024 15:04:40 +0200
Message-ID: <CAOiHx=mVSp4v0bxCW4HQ8SJUQ_7JN_8HMWvoB4-CR2mKtxTjaA@mail.gmail.com>
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
To: Doug Brown <doug@schmorgal.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, 2 Jun 2024 at 19:24, Doug Brown <doug@schmorgal.com> wrote:
>
> Hi Jonas,
>
> >> On Mon, 20 May 2024 at 08:41, Jiri Slaby <jirislaby@kernel.org> wrote:
> >>>
> >>> Perhaps, it should be reverted and the affected driver should just pass
> >>> UART_TX_NOSTOP instead?
> >>>
> >>>>        uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
> >>>>                true,
> >>>>                serial_out(up, UART_TX, ch),
> Does the bcm63xx_uart driver work correctly if 7bfb915a597a is reverted
> and UART_TX_NOSTOP is used instead?
>
> I was able to further confirm on hardware (BeagleBoard) that omap-serial
> is also broken after 7bfb915a597a. I'm trying to figure out how to
> safely revert it while also allowing bcm63xx to continue to work properly.

So I went through all users of uart_port_tx(_limited()), and
expectedly most do just disable the IRQ (or do nothing) in their
stop_tx() call back.

The notable exceptions I could identify are:

- bcm63xx_uart: disables the emitter as well
- mxs-uart: disables the emitter (introduced and uses UART_TX_NOSTOP)
- sprd_serial: stops alls dma transfers as well
- atmel_serial: stops dma and disables emitter as well

I suspect sprd_serial and atmel_serial to not work properly with the
old behavior, but I have no devices where I could test this.

There are a few more exceptions in those that do not use
uart_port_tx(_limited()), like I've seen drivers blocking in stop_tx()
until the FIFO is empty. Not sure if that is expected.

The quick solutions for bcm63xx_uart to either pass UART_TX_NOSTOP
[1], or make stop_tx() (and start_tx()) not touch the emitter (or
revert the uart_port_tx_limited() usage).

Regardless of the chosen quick fix, it feels like stop_tx() is the
wrong thing to use for uart_port_tx(), and just happened to do the
right thing for the majority or drivers. But the correct function
(something along "done submitting tx") also doesn't exist.

But I'm no maintainer for tty/serial, nor do I have much (intimate)
knowledge there. This is just from looking at it from the outside, and
my thoughts may very well be wrong.

[1] https://lore.kernel.org/lkml/20240225151426.1342285-1-jonas.gorski@gmail.com/

Best Regards,
Jonas
