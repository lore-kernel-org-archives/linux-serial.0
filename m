Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793024;
	b=fQaATW/nbwcorZFhMnKuxsJ2n18Wgq2wmSGhQex6NeMaKC4xuoI5WwDub9KpNZqrx0LG
	 m7ptxzFIC0ApxmJ0tqhwF1zfOsz19Du14Bae/0GyAp3bpkM+GdFHYBTYJGgVZ+8qLU5qP
	 N2CNqfCCzzYRdibiHdrnE2jMMVNfy62xvPgEaqIrTAUxV7H9LFEcwxZe0Ql0jh+E4WThZ
	 JCbMiW0vFNtPN+poSFrg5XzPA+PxPfHkpjyKNhLubbf1Lgak7nT8FBT7Bgv1EQ8aTPo2F
	 IK/R6yEByQYH6Ir6vkgi1r6ND/RSAzgxrTmAU0Mv42G85cyiaW8xCnsMQwialmHeu4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793024;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b4o1817Od6QsvBUN6ocnTBDfr5xBJ5pwP2S51qw16ak=;
	b=r4QD4BJPOwLv64FJ5cW+x8/Tdq8YeNa//DQB/F6xWvotbSdiRATyOTrKULtdn1D5QBDL
	 7doCnWz7XxJEblFAFgGwO4E39DhgQOr0tuPI/aBRDXDoy7UwRSpIlXJAeL234gWDSRlA0
	 TUpAyARoa5yk7A5W6qoQnmVw9HB/Ihzi8n8MQQaRjx9LxWapURqi5lhNgdKPRKW54PjaA
	 9RTl+gqOiwyDRxCr+kHCLX3I7m0mYFiwZj2Bz6X4i40N4Y8pnxEUQxrt+8IAFNWAzACH/
	 jICRBfeqF4rC3CxlffyC9299oJ2hZMjDZHN8tL1JZvnAJWFZ4BIeeQvzq+1sfKPAyuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TvvrhTYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEC606A328;
	Wed,  4 Nov 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TvvrhTYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB8E1F00919;
	Wed,  4 Nov 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793793023;
	bh=b4o1817Od6QsvBUN6ocnTBDfr5xBJ5pwP2S51qw16ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TvvrhTYBBQf+c3RFjlLTy/vjF/YsnD7BKkoog0WEY5kAQ3ODKxHCJRX8M3WDeoqkp
	 XBkrxXjOM/EGepO4QIS0wl8GAp6SnGzgkTWYwxehHl9Fv6MHDBsg22RmcCp//zrx60
	 O4Q342RO7p4Zf+FEonXGBm59Wet2UJqYk12wdd5k=
Date: Wed, 4 Nov 2026 12:50:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
Message-ID: <2026110448-deftly-hassle-ab16@gregkh>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
 <ausSmrErzTXfKNGU@ashevche-desk.local>
 <ausW1pwp2eBCqVsM@hovoldconsulting.com>
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
In-Reply-To: <ausW1pwp2eBCqVsM@hovoldconsulting.com>

On Wed, Nov 04, 2026 at 12:28:22PM +0100, Johan Hovold wrote:
> On Wed, Nov 04, 2026 at 01:10:18PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 03, 2026 at 10:07:58PM +0000, Maciej W. Rozycki wrote:
>  
> > >  		if (baud == 0)
> > > -			baud = max(min, 9600);
> > > +			baud = (port->hup_speed ?
> > > +				port->hup_speed : max(min, 9600));
> > 
> > Outer parentheses are redundant. Also use Elvis.
> > 
> > 			baud = port->hup_speed ?: max(min, 9600);
> 
> No, don't.
> 
> Don't use the ternary operator at all as it tends to make code less
> readable.

I strongly endorse this.  Write code for people first, compilers second.
? : is not friendly for people.

thanks,

greg k-h
