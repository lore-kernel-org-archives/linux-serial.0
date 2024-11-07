Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF631DFE24
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972927; cv=none; b=C6UTT+fz7uq3oqfOJJx/rRf3+G1lmdy151XB4OVOyF/rPnL9P2/8yNQsdLCa1LEywhD4NKXdGXonsEtAGttKHaTNdY4DeGdfWHePsyiOnRYTt42or9ObWrlCtvzMPl2kgLd98rk+o8T1uDx91n1KYUt/yysZXsyttSslPc47q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972927; c=relaxed/simple;
	bh=KLeNQrgv+o3rYnlDMLvncS+HRdvUzAW11TSK42Ey3J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZHENw68rJWHhDE3iwQ+j1NdUjPmXl6LCCTKz2vQJHCVogQoGCc0tXaVUmOutriuHPue0kvRsnu+4tJvrF9smGFj4YbjswhqS1RlybHfQzt7ylJHjwjiqp30DiVF1FFO60sLZHoHgwb6grjYbyhNqdA40Bm5mjrsrjhAmPX7rW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JDISLK73; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JDISLK73"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155afca99so10543025e9.1
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 01:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730972922; x=1731577722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qH39OpB04YQMGjmwysxcgD5clAdHREKSJmPbc07NDTM=;
        b=JDISLK73PegeEA/n6e3uWJIq25kdLvtlK9Z8i8Bb6AWJDV9rqdNdu8tkkP8PPzEN7k
         3i/0Gl7XshF22gySw3AAubfXG+RTUfQpHkOGDIP0ECb++npSOYeXr2QZeNSvDRcd6K//
         YFnWXLba231Dn3R/ys+0uSWCc16demxTf48xchIGwiDnNICjHqYv+knUPUKDbHd694en
         7VJVK09xiRantks1+a8WD1gpv4jB3b3KNRNMTIJDUFYI/kbFYVyix14yucCliz71avVv
         msfECKcah9nN1VCrTmhVwItyIB44SqEyvtPzWpNnM3Zn4jsGZ4m85cdLe37ybA5ys733
         fVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972922; x=1731577722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH39OpB04YQMGjmwysxcgD5clAdHREKSJmPbc07NDTM=;
        b=AXkqo9YD7kIT+6XxElhWuEWNtsDPWkX5lfFrPjonBII8MI+xGG3SR2Kua4N2fh8WS/
         QjbN2weDcncT2ilVZQ2B6M7L20dPxf6AHlHADbH6bIBksPZ2AejayQiyoeU2f6BuNEtq
         KFEtnm97eB4l+d3Td+tdLRi3tT4Wm6DjJDtqe/lrGLU9OEsp7W5no2sfgKYxUXe7WUd8
         FAq/j4tvHbsA53S2/jercjn/eobN86cAzfwS+tnEofXTThkF/r66F1Pm9p2CO4i027JB
         5K/H2g+b2jKMzwfGBMKoT7b0NULVqkBopb9Wp8LdiLD/mXecmgXcMTSJOmIZvgrYAVPL
         eYUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3iYZsoZBCVirjNGzu2auNfzd5tdaxsTKqrXkXUkxdD6hV4tjSLU1maP+72RPAOHP6r2xuiTa6tlk7Stk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GVC5he6O9JicyqEnJaN9VSk5WAowTsWLZPRVNvQ30hkMPTvf
	s1N37wIa/qHBsO4SRrhzWTd/u4AgvMQ5HgOC676F0wZp5N0iV2pKXzZQ8NJUzaI=
X-Google-Smtp-Source: AGHT+IERSo6gE9pNqp7UNc9W4ckkQ4wbQlQ1ZigpZoNbDIFN3eckLzhsXBXEez6JI7/4XGGjYnVgDw==
X-Received: by 2002:a05:600c:500f:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-432b382ab55mr5868365e9.7.1730972922523;
        Thu, 07 Nov 2024 01:48:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709f3fsm55878425e9.32.2024.11.07.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:48:42 -0800 (PST)
Date: Thu, 7 Nov 2024 10:48:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
Message-ID: <ZyyM99jtCao_VmBU@pathway.suse.cz>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-6-john.ogness@linutronix.de>
 <ZxupiKSSpZlyKhz-@smile.fi.intel.com>
 <848qu8nyzo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848qu8nyzo.fsf@jogness.linutronix.de>

On Mon 2024-10-28 14:28:35, John Ogness wrote:
> On 2024-10-25, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> +/*
> >> + * Only to be used directly by the console write callbacks, which may not
> >> + * require the port lock. Use serial8250_clear_IER() instead for all other
> >> + * cases.
> >> + */
> >> +static void __serial8250_clear_IER(struct uart_8250_port *up)
> >>  {
> >>  	if (up->capabilities & UART_CAP_UUE)
> >>  		serial_out(up, UART_IER, UART_IER_UUE);
> >
> >>  		serial_out(up, UART_IER, 0);
> >>  }
> >>  
> >> +static inline void serial8250_clear_IER(struct uart_8250_port *up)
> >> +{
> >> +	__serial8250_clear_IER(up);
> >
> > Shouldn't this have a lockdep annotation to differentiate with the
> > above?
> 
> Yes, but the follow-up patch adds the annotation as a clean "revert
> patch". I can add a line about that in the commit message.
> 
> >> +static void serial8250_console_byte_write(struct uart_8250_port *up,
> >> +					  struct nbcon_write_context *wctxt)
> >> +{
> >> +	const char *s = READ_ONCE(wctxt->outbuf);
> >> +	const char *end = s + READ_ONCE(wctxt->len);
> >
> > Is there any possibility that outbuf value be changed before we get
> > the len and at the end we get the wrong pointer?
> 
> No. I was concerned about compiler optimization, since @outbuf can
> become NULL. However, it can only become NULL if ownership was
> transferred, and that is properly checked anyway. I will remove the
> READ_ONCE() usage for v4.

I agree that we do not need READ_ONCE() here.

Just to be sure that I understand it correctly.

The struct nbcon_write_context passed by *wctxt should be created on
stack of the caller. Only this process/interrupt context could change
it.

Namely, it might happen when nbcon_enter_unsafe() fails. It is done
later in this function by the code:

	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire_nobuf(wctxt);

and this function does not access *s or *end after this code.

Other CPUs could not change the structure in parallel

   => READ_ONCE() is not needed.


Just for completeness. The buffer could not disappear.
wctxt->outbuf always points to a static buffer.

Also the content of the buffer could not change if we read it only
after successful nbcon_enter_unsafe(). Only the panic CPU is allowed
to takeover the ownership in this case and it would use another static
buffer.

Best Regards,
Petr

PS: I do not have anything more to add for this patch. It seems to
    work work as expected.
