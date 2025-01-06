Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C381728
	for <linux-serial@vger.kernel.org>; Mon,  6 Jan 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179700; cv=none; b=Im7hkC3nXR64suR3aT+75991hwQDsu5K20Lxs9wG1zxJd8mgiEkeIc+2JAGMS9a+Q/mpAN+6GHacWJ/IvH/bgRSpaFuy5aZxZ5u+Z79B0na1qwkN+x5Cdnhzm5n1WD82ssVhXNGUWHAshhB+4N76RygPlM4u3rf1gn+HJJ/jy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179700; c=relaxed/simple;
	bh=HzCwECKMPbPm3yZQ+TTA8/ZnxUJavEy/mJgVrOI9A2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCW0BhO5YH9j6wSh3xBPdZ/X20QqhdxU+u3l2pR0FAf4jIUWodRzNM9GxHE9bbFYG8V3eni1W9iAxk3wqpQ/qFOmK1zgoPG2/AOe2bNvQkNF8mTPVFYcj2D5532u6hLHgm5LSmhR8s6VGaK9rtts80eIcvUsKv1Pzsa2AAi+WkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fQGc2QhU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fQGc2QhU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so144849775e9.1
        for <linux-serial@vger.kernel.org>; Mon, 06 Jan 2025 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736179696; x=1736784496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNx2YaBCkVTFXvj8GvoFFTeweWA/AsfbEa+1+l6TR2s=;
        b=fQGc2QhUwcabe1dwyzh1/nWJkw1jnS/MbeFv7uh/+jCy589ku+xVAo7fZqLd54S9xZ
         UVIiXKRoZk904awR5tlVD7+lubAbmUpkGxGq2VuSlcHG9IxTlraBHGBxIkmsmCaG9GF5
         3sCtc0Txo4MOGeqr0Fh5rQn1CpOUorxo+nmdt+obep/uMeFdQg+RiFzMBN2knwZNyJbK
         LRR5Qsa5nYqmWGMi2AcnALXjchV/ZIvtm0UTwtuJtoJ77pTMNJ8wyIERPQNVM2X4DXg0
         B5G0jIHBxrmFPoYdvAWGCo2OIsFVhTElLm+ABiI1eWHDVQM3oTpdrvK+pYorpZEUq7dK
         004g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179696; x=1736784496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNx2YaBCkVTFXvj8GvoFFTeweWA/AsfbEa+1+l6TR2s=;
        b=cFXgIpGphpWk09y4G+JD3ntQKq8qGVUOx2NPiwAgWPsQKDBIfV1sIdS5ZDsAE/o8+o
         P/Op1TdGghdF92igaH1ik+ONLbtXVNnmbqOUJUS6iOMpdbAKS2pZ8E7IFoxqqiYD2cZ2
         cySYy+V5YQZiOUvFTICUfJvQ6m0AndXqVRxBT/WTwNdrW0fTzPyUfqiTX8LnrY0024FN
         IklHcxoVa6vuVut47UlDqOLOFQtc9kCqvuRtT9iRWpqBTPxywPCSNCTdwruC2xiAOkqy
         /yln/c8ugb6amPceMutzFop8C5jhrx4gAC/3Kab8Uwjv5DwmwMvE4G16hRD7f4BOCDZl
         1Fig==
X-Forwarded-Encrypted: i=1; AJvYcCWBSFh2qgyPtWW2BF4e65qvUR4YvFsvfpPEmVmfod+lgV/UTry4pYf0wFAeqs92ApgmzRiR4K6d5RFRpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymyr4yihoEB02dwjbSwtho6NNYOXZiiX1RL5tIZOWZVYGKk4my
	4GGAvzcaSykaIjWPw82wDZuZrhxV4bIA/WglUWIFOj759WtSB4FI4q7R4NsN+qo=
X-Gm-Gg: ASbGncvAUGJuAJ0YV5P/KOpfdny6BJOZDyRmJmVKOU4rz1wKnuyMSjHg+Yn94Rne95Z
	hO6C4NKtioWZfQg5IIzjC2jP849KGEPV8tEejU4Ol8kRxotd3PBi3pnIwWCIEdKAOIDn/nIg8s3
	edrw9Q22i9Znk2cFtr3RHPLwBTDbdHJ9SwsP+P5nwsxE0/tFwrUZmNTDz3Pg1k4rCRMb2sOPGw3
	1UBF92J3FqUgG3ELsBNDXylLG/9y+uR92/qji2dCyrpxdyCU5c1FMkt1Q==
X-Google-Smtp-Source: AGHT+IHIJLNV7U4yP8Zx4j4ON92Jhq2nTGr+leOp6meyU6yQ2fuUJjgEX2zs5siU/2wF61oWKK8bwQ==
X-Received: by 2002:a05:600c:1d2a:b0:435:330d:de86 with SMTP id 5b1f17b1804b1-4366790d3c0mr554899015e9.0.1736179696410;
        Mon, 06 Jan 2025 08:08:16 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b053e91sm634449185e9.1.2025.01.06.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:08:16 -0800 (PST)
Date: Mon, 6 Jan 2025 17:08:13 +0100
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
	Matt Turner <mattst88@gmail.com>, Tony Lindgren <tony@atomide.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
Message-ID: <Z3v_7f3Oc_A3rAnr@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-6-john.ogness@linutronix.de>
 <Z3gTmicJVLA1tFq5@pathway.suse.cz>
 <84h66exeka.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84h66exeka.fsf@jogness.linutronix.de>

On Sun 2025-01-05 02:03:41, John Ogness wrote:
> On 2025-01-03, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -1406,9 +1416,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
> >>  {
> >>  	unsigned char mcr = serial8250_in_MCR(p);
> >>  
> >> -	/* Port locked to synchronize UART_IER access against the console. */
> >> -	lockdep_assert_held_once(&p->port.lock);
> >
> > We should explain why it is OK to move the assert.
> >
> > IMHO, most poeple would not understand the port lock is needed only
> > for UART_IER manipulation and not for UART_MCR manipulation.
> >
> > We should probably explain that even the UART_MCR manipulation
> > is synchronized either by the port lock or by nbcon context
> > ownership. Where the nbcon context owner ship actually provides
> > synchronization against the port lock in all situations
> > except for the final unsafe flush in panic().
> 
> Correct, although the "except for the final unsafe flush in panic()" is
> the reason that even an nbcon context ownership assert could not be used
> here.

Good point. Well, lockdep should be disabled by debug_locks_off()
before nbcon_atomic_flush_unsafe() is called. I hope that we could
keep the assert.

> > A comment might be enough.
> 
> OK. I will extend the comment at the new lockdep_assert site explaining
> why the port lock is only guaranteed to be held for the toggle_ier==true
> situation.

Thanks.

> >> +	bool			console_line_ended;	/* line fully output */
> >
> > I wonder if the following is better:
> >
> > 	bool			console_line_ended;	/* finished writing full line */
> 
> I would prefer to make it more technically exact. It would require a
> multi-line comment and this header uses 2 different styles for
> multi-line field comments.
> 
> How about:
> 
> 	/*
> 	 * Track when a console line has been fully written to the
> 	 * hardware, i.e. true when the most recent byte written by
> 	 * the console to UART_TX was '\n'.
> 	 */
> 	bool			console_line_ended;

Looks good to me.

Best Regards,
Petr
