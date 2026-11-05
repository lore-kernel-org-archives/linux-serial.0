Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875064;
	b=Acm5xdya/ZFT/Rpw1Bb11pjtZGn+jwRHnMOZf0dQTxZ/xwq5owXQ811PuxTi+1nsDXd6
	 ltjArYHSgAOolA2sNUqatL2XBY0UMn+MnvjtLD41krnIhDHwggmZcN849KJkFvQ0gMW5c
	 8aie27v8FWW/jv0cdfM5J+yV9wl25KAAGTxPEROgQPRT2qG2pzElGO8hQAMrAo6D0qfBV
	 BaYUet/NDXfXE0OPq/WH+5Ko/ErSHXmDCn9bAFU+ZoWC3ZqGnRrXtphHgm2EmI61v4L0h
	 J0QFGajPNh+7zAFZe0WsuE6d1AGzGUmKOOXDYkKQczy0Rcos2CMYz1DM7ppfOPD1NNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iMozJrqsbJNaYrQWQl7LXiR3L3jpnB4n+AT37MLrLIc=;
	b=bnlExu3TVpWTFVw0LZui6+WzM/y079yTLY0PHYOg82w2Th36+S1KIwfk/s61jQ8+6k39
	 ip9yKeWPQBwOtGw2LLF0hLbLTb6+ZWz7eyIiXwYm+wjlhiM+cYZu0EtI+Xkp9BBV5CrGR
	 OTRCyjCXJUyyhU4uITElWlCx1D0GT90oaRjpO2dVN6iWdjC9kmHukq+93qJJ6dAcMOHLP
	 8VUI0uOzKVIuyN/et3CLDnF43iottu0JwoStY87rK2kQLz2X77BNZgOB7MkCpJUATX6SV
	 mzMOKv7d67/kCckn80TAt4WZNIGLptYvKu8WZ5XsKwICDHDS8iEryd+OMKPfP2kBF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="eCrLt/kn";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419E606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B419E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eCrLt/kn
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dee593f18so1337904f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793875062; x=1794479862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMozJrqsbJNaYrQWQl7LXiR3L3jpnB4n+AT37MLrLIc=;
        b=eCrLt/kntCWnUUNfiv9bUfAm+A88uOltZ1w6tss4vTBJcS/hskO6e/QIOmRTqChifH
         mRGyZp2ZyfcInYuXz4dyUcDpOficKP+3E9gjZp2hVYA64ExBcr0a/dbN92KqMUHOdggO
         btAF0n8KiaxK/6i/WOj9eqBeSoHCC/6zlSrCUhYklYPi0cM5g0kepecf+bUY7nXS3tf9
         aqpIZbiT99h/CNOnY3efy5s24pjVWk96loP79KQXJdoMESNJpGso68odyz/1FXneTPBq
         5nEKGGWz6SF8N9rEv40vUxEikpbb4gAFFgMEC9Jld0nv1BdVBf47XqAffI+MSGenLgJF
         V6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875062; x=1794479862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMozJrqsbJNaYrQWQl7LXiR3L3jpnB4n+AT37MLrLIc=;
        b=jkqVFxdjxaVrh2r4rSI9SIg11Z0BP06aH2q/gAgNjfXN0a4lKh/HfPWPfmtQBOEEbv
         eD4S8TpD3jp2eMgCDKix3OWCdJ5Hzk/HyBIX7JtidAuGE/AlZ0cLWOixd1U8IEIhLlg/
         cPmmyvCq2cSnHMb+pudMPm3Qu1VzO3zkSTWFiYq34CPJaIU0DcwhuDjaPkZlykiyGTWC
         kfTOYXcgKDZYHYyfB1lOYR7q2fvqxrySivKNWichSROiEkNvssWJM6e7F1gqen4pQUlA
         MqnfQwMgfoHUSZEtyt8YkO+QJZc/SPm2or/CHEce1Hg3AzY73P3FXpCeApAaGEP9MhwA
         9JHA==
X-Forwarded-Encrypted: i=1; AKwUvBzRPJZ1hC2X/fsDfoHtRr7a9j0pcmC94cy3nZ+eKCcU9HqdUCesKllSz84cBDCQaYbg/msI6AIrp+foaeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZrMvOgp8ZuMdqzfnah+ttWFhp8KGFFVIKHekb9IMPwkh1S+qO
	rAf/1R6Wy6YPUxkq3y28YzD30JpgJP1t7gTG61KBfoEoI4jEkrIh3+VErbkqKDf1aT8=
X-Gm-Gg: AYBFou0H0T8tMmRH0gb2Wgvw+GFH6TBePPt4PnhWX9G3Vwa/ILwNcCrHD35nuRyHoRO
	P7CyWZYuV7UmyRSsWGy+kJWj5Xm6n6QTgye+5J2ZTiPFigzea5pxqq9Jio1Jn1sNrIG40QT0yp0
	YCRYwkucxYHb5oryKXAg9g4Nm11Nn5tPPQn+Nz9BxdySgh+euBUhjHPxUHOrADu8+Y22nbpzAOX
	cFrlqe2zR99plBnXBczK7dPs0eYJwvXJW+tVkm1Baji19GRPIw8JKFUljuUORyuf7tvBdrPayzY
	iRi92rSipKfULQrBvvFnXfpLLuAtGm3aiAebkNBxKyKGPzxBMjpkMysmQt6133J/RrksbeFmS1X
	m+KZ4pIGqKpArL0rnLgnizb6CILYTCX55M274ikAp8MsiLrYiuFdUhmoi/VdSoAInRMSteQe1cd
	yEuxJ0qrzsr4Ago0z4wVnYN9CH/ATAXI4N36Mefyeg2g1vKkL8J6SfSKEAMRl45T5k7DdMmTKVS
	/Q+soroTE7j/M54eprBwzBK0U295j8JFPuzK75N/XJTYqk2R5L+baFZ4m3bCkBbBc8VOKmBdVG0
	/1SHettilZpHeTkcVRaXpaOKXDSOdw==
X-Received: by 2002:a05:6000:4713:b0:491:da8f:7276 with SMTP id ffacd0b85a97d-491da8f74bcmr1528879f8f.26.1793875061989;
        Thu, 05 Nov 2026 02:37:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8734sm9717303f8f.20.2026.11.05.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:37:41 -0800 (PST)
Date: Thu, 5 Nov 2026 11:37:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>, kernel-team@meta.com
Subject: Re: [PATCH] serial: amba-pl011: touch the watchdogs in write_atomic()
Message-ID: <auxcc43USXjFxBeI@pathway.suse.cz>
References: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>

On Wed 2026-11-04 02:35:51, Breno Leitao wrote:
> In emergency context, such as WARN(), nbcon prints the pending records
> through write_atomic() with preemption disabled.
> 
> On arm64, WARN()  can run with IRQs masked, so the whole backlog is
> printed with IRQs off as well.
> 
> Commit 9bd18e1262c0 ("printk/nbcon: Restore IRQ in atomic flush after
> each emitted record") does not help here, as it only restores the
> caller's IRQ state between records.
> 
> pl011_console_write_atomic() busy-waits on the UART for every
> character, and at 115200 baud it prints about 11.5KB per second.
> Flushing a few hundred kilobytes outlasts the hard lockup threshold
> (10 seconds by default), so the printing CPU is reported, or the
> machine panics with hardlockup_panic set. See [1].
> 
> The 8250 driver avoids this by calling touch_nmi_watchdog() while it
> polls the transmitter. Do the same in pl011_console_write_atomic(),
> once per record.
> 
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/all/87wlqtxb14.fsf@jogness.linutronix.de/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

See a comment below.

> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -41,6 +41,7 @@
>  #include <linux/sizes.h>
>  #include <linux/io.h>
>  #include <linux/acpi.h>
> +#include <linux/nmi.h>
>  
>  #define UART_NR			14
>  
> @@ -2734,6 +2735,9 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
>  	struct uart_amba_port *uap = amba_ports[co->index];
>  	unsigned int old_cr = 0;
>  
> +	/* An atomic flush may print a long backlog with IRQs disabled. */
> +	touch_nmi_watchdog();
> +

I would personally touch the watchdog at the end before returning from
the function because it still could spend some non-trivial time
in this function.

But I do not have strong opinion about it. AFAIK, there is no official
recommendation. Some callers do it before and some after the delay.

And it should not make a real-life difference because a single
pl011_console_write_atomic() should not trigger the watchdog report.
The problem is when it is called many times in an atomic context.

So that it probably does not matter after all. It is a matter
of taste...

Feel free to keep it as is.

>  	if (!nbcon_enter_unsafe(wctxt))
>  		return;

Best Regards,
Petr
