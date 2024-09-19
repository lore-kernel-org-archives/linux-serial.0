Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC1DDC9
	for <linux-serial@vger.kernel.org>; Thu, 19 Sep 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758133; cv=none; b=eiBj7dmQTZcELZnztHzYDzyHdthbyz0IWLSUsG5DNGnfeUdtS4Q+1jPfLFIKCmBRWP3iIHqfzv/RUeYDmT5KFCoN2GrcJUI0SS68CTPQBue5Gr2KKyDKlAZM7cU3W6uvK9O6JRvB1quNykqJ+tX2DzXLe4PYkQMSrBGsZ2+deJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758133; c=relaxed/simple;
	bh=YpUk7QNqAoJUkAbDvBnTy3VZp3BINGaqpAaOyQTJMqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGsJNQ4gnA0OCiK5qL2QkkdZJD+ERSoHc9V6xbZxNeXX2ZEaJN8CWJl9Fi0LTvJj1nyXbXoQ6pNFCY1Qhf3roBjy9FlEWdU4gxeherMCqX+NS/8ddZLTGXGtOcqETMiOSfJkd9vm6gCpPFaYzLrJFdrfo3QfMdcwOuWEtdBE/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V5gxiNxS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V5gxiNxS"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so1187149e87.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Sep 2024 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726758129; x=1727362929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCm2GzzK+q+0wa6+stISbobtFnZrzd/LjiQZU2jYSWs=;
        b=V5gxiNxSUp0+xSFLz7LiQtg8HtpnxGvBDU6aE60/CbhUQJGbC9PJxvG0fhFf8xX5RR
         4vDdyE78H9xK1yBV1Cz2duZ2j6h1OXFbsFS+/Dc8GiH4gcdKBts4b/JGdBaSSWWgzOdp
         Hra/oo8hbgMwbPuVT9D2Ygj5H2oXluxgJ0Kaa950UNyHYTwpzS/1ST1RvoaQyGo25Tl0
         wKY0xLkPSzUi3331n7tA+odUTQS66VnjN6NoPFOaHsxd32iQA1uHvu+r6EX6FE6FejwM
         2JLFATCDfa4eibeq3ywoAfmSOuEpdrnMfGyLq4m2ygTskI9nPeoKWdn2n9SXGxgpysRN
         cINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758129; x=1727362929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCm2GzzK+q+0wa6+stISbobtFnZrzd/LjiQZU2jYSWs=;
        b=s5Ee6ta3wZvxkXgOmSYjP7qBRg/ydlX4jsD1+ixD9lLIhOt934wgWVFzACdCwwmQs5
         OfJiGOuvGk8jc90H+O2hM6xZrt3YLkbUnEQbO5k9GwGZOEEWfPgWg+8TbUocgmloR5ed
         VbjBsP8qeuiiaU8osnyyQzt7gpI2z2c/jqvQ8IAnkQZmj87TvgGFcxpfu5m3DEDx3vyz
         Zk1AwoByiMYEclvhcry7ZcBJ9kYWvb8Jty1MI2bNRjJ/tQ2AKakUDwx0JqKpVAcTf/UR
         LcqpvqwNbuHs8uNNJgtwkREoUaBvuW7hSx9aD5vwaa0PnPipbH0iOlytueef0NJEejpK
         8iEg==
X-Forwarded-Encrypted: i=1; AJvYcCWnna4i0Z9UWArHkuNcp0MaV9rJZZWkNlG1plYN/UU+tAdFpvyMaR2iSuETHVnXFqncOxO0OuKJBc4O0a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtBlkdfmKOnc3SgEDgJWS571tANc2TSieMu07gj3vRi0CXBh4
	DzfPFZJ3jABOgA6Jvkti74ZRVkd1DL/uIWWUzAOb6F4PMoK5VoKf2g/XDDF15Xs=
X-Google-Smtp-Source: AGHT+IFRQsoIHdcvjt2JIpniZeK8k6MPo4O04rrl7ltLpXb2c258J/bIcA534MWSbuTQYrLAiz5l1Q==
X-Received: by 2002:a05:6512:3b0e:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-53678fb731bmr14420533e87.9.1726758128411;
        Thu, 19 Sep 2024 08:02:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef978besm1958074a91.57.2024.09.19.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 08:02:06 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:01:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 1/4] serial: 8250: Split out IER from
 rs485_start_tx()
Message-ID: <Zuw83ZyzeKxA6RmE@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-2-john.ogness@linutronix.de>
 <ZumWuketXcGQNw49@pathway.suse.cz>
 <84ldzproiy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ldzproiy.fsf@jogness.linutronix.de>

On Wed 2024-09-18 17:10:53, John Ogness wrote:
> On 2024-09-17, Petr Mladek <pmladek@suse.com> wrote:
> > Sigh, I am trying to review this patch but I am not familiar with the
> > code. Feel free to ignore me when the questions are completely off.
> 
> I appreciate you researching where the code came from. I made my changes
> based on what I see the code doing now.
> 
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >>  void serial8250_em485_start_tx(struct uart_8250_port *up)
> >>  {
> >>  	unsigned char mcr = serial8250_in_MCR(up);
> >>  
> >> +	/*
> >> +	 * Some chips set the UART_LSR_DR bit even when UART_IER_RDI is
> >> +	 * disabled, so explicitly mask it.
> >> +	 */
> >>  	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> >> -		serial8250_stop_rx(&up->port);
> >> +		up->port.read_status_mask &= ~UART_LSR_DR;
> >
> > This change is related to disabling UART_IER_RDI but we do not longer
> > disable it in this code path.
> 
> Correct. It will be disabled in the new wrapper
> serial8250_em485_start_tx(). For the console write() callback, RDI is
> already being disabled (IER is cleared). It will not use the wrapper.
> 
> > Why do we need to do it here, please?
> 
> Because the console write() callback also needs to clear LSR_DR. That
> part of the callback needs to stay.
> 
> > Why is it needed only in the em485-specific path, please?
> 
> Only RS485 deals with controlling TX/RX directions.
> 
> > On one hand, the comment talks about UART_LSR_DR and UART_IER_RDI
> > so seems to be relater.
> 
> I do not know if the LSR_DR modify is strictly necessary. I am just
> preserving the existing behavior (and related comment). The disabling of
> IER_RDI will still happen (via wrapper or explicitly as in the console
> write() callback).
> 
> >>  static bool start_tx_rs485(struct uart_port *port)
> >>  {
> >> @@ -1585,7 +1600,7 @@ static bool start_tx_rs485(struct uart_port *port)
> >>  	if (em485->tx_stopped) {
> >>  		em485->tx_stopped = false;
> >>  
> >> -		up->rs485_start_tx(up);
> >> +		serial8250_rs485_start_tx(up);
> >
> > If I get this correctly then this keeps the existing behavior when
> >
> >     up->rs485_start_tx == serial8250_em485_start_tx
> 
> Correct.
> 
> > Is this always the case, please?
> 
> Yes.
> 
> > Can start_tx_rs485() be called for the 8250_bcm2835aux.c driver?
> 
> Yes.

IMHO, the answer "Yes" to both last questions can't be valid.
The 8250_bcm2835aux driver does:

static int bcm2835aux_serial_probe(struct platform_device *pdev)
{
	[...]
	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
	[...]
}

As a result, the 1st "Yes" was not correct:

	up->rs485_start_tx != serial8250_em485_start_tx

and this patch would change the behavior for the 8250_bcm2835aux driver.
Before, start_tx_rs485() called directly:

	up->rs485_start_tx(up);

Newly, it would call:

	void serial8250_rs485_start_tx(struct uart_8250_port *up)
	{
		if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
			serial8250_stop_rx(&up->port);

		up->rs485_start_tx(up);
	}

It means that it could call serial8250_stop_rx() even when it was not
called by the original code.

And SER_RS485_RX_DURING_TX seems to be checked even in
drivers/tty/serial/8250/8250_bcm2835aux.c. So, it looks like it
might be (un)set even for this driver.

Or is this code path prevented in start_tx_rs485()? I mean that
em485->tx_stopped could never be true for the 8250_bcm2835aux
driver?

But I see

	static int bcm2835aux_serial_probe(struct platform_device *pdev)
	{
		[...]
		up.port.rs485_config = serial8250_em485_config;
		up.port.rs485_supported = serial8250_em485_supported;
		[...]
	}

=> It looks like even bcm2835aux driver could have the em485 thing.
   But it obviously wanted to something special in
   up->rs485_start_tx().

It looks to me that the change might either cause regression.
Or it would deserve a comment unless the validity is obvious for people
familiar with the code.

Best Regards,
Petr
