Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8045DF6C
	for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804672; cv=none; b=WJMA9FA05IJL0OgvAYIS3z/ZT/XZV39fvQNbgNto5rCNGk0t8zQtB8PCjwERQJqIGLmKibhCPtRktoidlwNTGhYJ+S5ZkPe09QdY5TZxEIK7j1Db0Eh1UQ8zKGgIXVzmFcRhU+w5DbS9N4AuP8aYKr4e0ji5fWN4NwOjUgRnMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804672; c=relaxed/simple;
	bh=I0iDornvDemZBIdlJlUN04we46aNr0QCledKevoHYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnNOCmbBO3tP3ynlQpv3eqct+hHT5xmQK9Id28IYCkuLgpdOLIWZF/ZJ31JrzKpkLARdNawcSkFFbt4EzGqRtTZNumRGr8LxH6jgXbGn4CoqLu5KkqY4dYyNy4+2jZ9ZKfyuSisB+qVTE2kxgb+48JCXJJDp9CnRsayrmaGoEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IjISoDPm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IjISoDPm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f84023916so467360f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784804665; x=1785409465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vvwztE6wT0KuKjuBo21bDNTl67qEBpJJxUw15r+TGU=;
        b=IjISoDPm8AFFIoIqqCmrzavLJ1lqOTxZufZyVJhnFkTznKXfabja4glxJ3n/d4DmWP
         vBju84IhRN2nPgz1Zhd8QddYHeNmUEgJEETSqU+REpbpCIMzAkeW5fK1Q0D/kJfTbwHC
         4Iby50CY+WKX1AfM0Fj2Lgd6paWY/Dh/NEZ79OvJEzaaJ278YjzhiE3N0zRW3mUlcvsg
         SBF4B6zVGUzA1bJWXCyq6ydn80UG/XENbtaDdElfjv9SkK9sIEgSuMCrah+uZt/rUXMG
         V0159pbzHm5tWXWlRnpJgqCqEqCyHzaYSpm5d245/LGtOs61T6wym3ps7FT9RuDVxj+F
         6ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804665; x=1785409465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vvwztE6wT0KuKjuBo21bDNTl67qEBpJJxUw15r+TGU=;
        b=ZFGMOHfUvlE1kjiB5xIxft7nANLv7/y9+BkokL+bUd+jrTWbsyuUZxv0ukZ6edndqF
         5GVVMunA/Bp6kgrW42sZKHJ/AJ25y0vcxNyEVIuDJtPxDxXRDmVhois0bnelByu9hcY8
         AhAcPBis4uMg4734UEOCtWFbuoNveyGQzs9bWbAOOxRA0Y5tMbpdI+po4Pmto85VYTh6
         +2tdx4CVNz5nXSfOCpRXVI7LSZ3R3kRiU+TREL+jn+8LAnviimJrH33wOZHwzHYUVGOE
         RAbelQkmAuiN6wmtC+2aaeE2UoB7jdA0x1LhLsn1//CgZOxtJIiRQXUCfkQEs7LhdKTz
         GN6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpiWlOsqeyRce5fPw6zEd28mEnyxEBwxoyamgab4JCkFtsGOCS2CW98q9A0ZM6OwkZ0wVjvP7tateyeXEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YReqCP712lAf1Qtr28dPH4PSbUO99DnGfqhaYAFBsGcXEl+/
	RgDKOqwda3XnGdJsxZ33K+k2wjRnx67y1DGunL0YDShTrGVhkwnP7Al+n9+gMLIs2PU=
X-Gm-Gg: AR+sD13rvEer0BKfcQRdqCbhJSzbQP9WEVL84WPsRepZBi1LoMWrJiuBrB8yUK4O+vY
	tSHeFTgQM9w4X6tiwBctKrOt8RrwWHDz3/mm7jXJ60XvPbXFCgjdV42UXwFYM5mqAA73NLDUHV4
	+H2O/H3Vc3ru5gLzBiCFSrLx3xWZk82DWY3bEeJZj74fZfj8vvRK+ELdJJ5IVWE/WRJYkrY5Lza
	RgOcfHsVLJGF2y8YhOWL6ugtghUhtfMgg+krJZgbmVIjrTo/EJXvNiLpBx8sf8sMPHCK9KhQ3NL
	VrzAbZkiREtgqa6s1gIKz7EQ1JYVDLLFZKwvIOvu4ytT05dyqt6UE08Q8b21RBTlq/XzTGde1zH
	nwbHpBEg5ufZS2cesuu2a/3hzMZlMwvcTx+QN3IvI+z1h60NezV0tv2W7+RqO1iIrjFSrwBq9sm
	b9P4es
X-Received: by 2002:a05:6000:22c7:b0:47d:f06d:55bc with SMTP id ffacd0b85a97d-47f8d7606bdmr3306146f8f.40.1784804665030;
        Thu, 23 Jul 2026 04:04:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c631fdsm14173457f8f.28.2026.07.23.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:04:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:04:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v8 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <amH1NfKn-Ypcvedz@pathway.suse.cz>
References: <20260722110925.74387-1-john.ogness@linutronix.de>
 <20260722110925.74387-2-john.ogness@linutronix.de>
 <87v7a7cbze.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7a7cbze.fsf@jogness.linutronix.de>

On Wed 2026-07-22 16:59:09, John Ogness wrote:
> On 2026-07-22, Sashiko wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> >> index 8c241ec7f4f29..7726cca00d364 100644
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -3198,11 +3218,22 @@ void serial8250_set_defaults(struct uart_8250_port *up)
> >>  }
> >>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
> >>  
> >> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
> >> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
> >> +				       struct nbcon_write_context *wctxt,
> >> +				       unsigned int count)
> >>  {
> >>  	unsigned int i;
> >>  
> >>  	for (i = 0; i < count; i++) {
> >> +		/*
> >> +		 * Pass the ownership as quickly as possible to a higher
> >> +		 * priority context. Otherwise, its attempt to take over
> >> +		 * the ownership might timeout. The new owner will wait
> >> +		 * for UART_LSR_THRE before reusing the fifo.
> >> +		 */
> >> +		if (wctxt && !nbcon_can_proceed(wctxt))
> >> +			return;
> >> +
> >>  		if (wait_for_lsr(up, UART_LSR_THRE))
> >>  			return;
> >>  	}
> >
> > Does this leave the hardware state vulnerable to corruption during an
> > emergency console takeover?
> >
> > The serial8250_fifo_wait_for_lsr_thre() function polls the UART_LSR
> > register by calling wait_for_lsr() and modifies up->lsr_saved_flags
> > non-atomically.  Since reading UART_LSR clears hardware error flags
> > (parity, framing, overrun, break), concurrent reads can cause one CPU
> > to consume and lose the flags before the other can observe them.
> >
> > Because serial8250_fifo_wait_for_lsr_thre() is called outside the
> > nbcon_enter_unsafe() block, the nbcon system might grant a safe
> > takeover to an emergency message (e.g. sysrq, panic, or NMI printk)
> > preempting this loop, as it assumes no hardware access is taking
> > place. The emergency writer will then access the same hardware
> > registers concurrently.
> 
> Sashiko is correct. I did not know that the serial_lsr_in() macro (used
> by wait_for_lsr()) updates @lsr_saved_flags! I looked at the other
> serial_lsr_in() call sites and they are all in nbcon unsafe sections.

Yeah, I missed this as well. I would not expect that a function
called serial_lsr_in() would do a write. But it updates the internal
structure....

> The for-loop in serial8250_fifo_wait_for_lsr_thre() should look like
> this:
> 
> 	for (i = 0; i < count; i++) {
> 		/* ... */
> 		if (wctxt && !nbcon_enter_unsafe(wctxt))
> 			return;
> 
> 		if (wait_for_lsr(up, UART_LSR_THRE))
> 			return;
> 
> 		if (wctxt)
> 			nbcon_exit_unsafe(wctxt);
> 	}

LGTM.

> Note that Sashiko already reported [0] this in v7, but I did not look
> deep enough at that comment, thinking Sashiko was misunderstanding nbcon
> ownership. Instead it was me who was misunderstanding. :-/

I was confused as well.

Best Regards,
Petr
