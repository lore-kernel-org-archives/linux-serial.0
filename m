Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841117;
	b=42WFtpngg8hq8WpfAHy3oBCHdWRI8a85iVBovR7bfXmcnLYmQa+iQWFtZP5uYxPcCMyK
	 ts+qDL/m9xicT9PcattlnYr45piMuaVU5eDQhx/UFRGjAg3PaqybOlVyimEvuBRBmMTrt
	 b4CmlUevtPdqHc2MODBilndGEMlBtEvgTiF4fRXQyVt4QaBTzVVnshHyQLvJv69OpWVsL
	 ll+YZDcKdb+nXZg+6S3ztrwTbsAf/2DoBkbtzMttkD/L2KivizERksBYKlzy+m27owA1Y
	 84ur2K0TxmHVNYpPspn9elNQOLnpGpqBXDDXxbFw50+6yXVxXtDLkZS2Qmv688V5HvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841117;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=2K5WRQa9KJqYdLOzpGKQx3dx34M+TdiPAHG0oRd/wZs=;
	b=2iFB536mRTJL3bpAwn2HMHio9MYxVmSq71n0NO8I8EvyAycyHBGxpvc9GoSOGAiLoh9K
	 UO2kSUt2nlYs4oouSUYZQbdlvFRf0c2roR1ooBy+7rGrFk9Q0UKKreL1NSu09WO8XpsTU
	 YoOSp4fHH2/XsGDFmwEJcm46xYu36H1lr1BLyfn1btVq+XimXF/jH6YLoYksJWYrYne0b
	 jxV5oCCBqZTerdIK+jAlI04O08xu5gIE5jYW2/PgztvFpbtmMYqpio2lox3KEu6JA9I1z
	 Cq6QQfZWkr65KbqgIn6EK8puTtoSMjFf0zT1wOhpLtH8/8ddcN9/0B13xZj9j/lTskQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05438606A333;
	Thu,  5 Nov 2026 01:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05438606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 58BD59200B3; Thu,  5 Nov 2026 02:11:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 53EA292009E;
	Thu,  5 Nov 2026 01:11:54 +0000 (GMT)
Date: Thu, 5 Nov 2026 01:11:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    Johan Hovold <johan@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
In-Reply-To: <ausSmrErzTXfKNGU@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2611041134370.6502@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk> <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk> <ausSmrErzTXfKNGU@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Nov 2026, Andy Shevchenko wrote:

> > In the unlikely case `port->hup_speed' is zero where the B0 rate has 
> > been requested as the first one since the system boot for a non-console 
> > device, resort to the current default of max(min, 9600).
> 
> All lines above (except the last ones in the paragraphs) have a single trailing
> white space. Usually checkpatch warns at this.

 I've always had that and in probably decades now (I can't recall when it 
was first introduced) I haven't ever seen checkpatch complain about it, 
and `git am' swallows it all anyway.  Tools have been prepared. :)

> >  /**
> > - * uart_get_baud_rate - return baud rate for a particular port
> > + * uart_get_baud_rate_save - return baud rate for a particular port
> 
> Now it also saves it, so
> 
>  * uart_get_baud_rate_save - return and save baud rate for a particular port

 Well, optionally, but since we still have uart_get_baud_rate() too, I'll 
send an update along with v4 so that we don't have two functions with an 
identical summary.

> >  		if (baud == 0)
> > -			baud = max(min, 9600);
> > +			baud = (port->hup_speed ?
> > +				port->hup_speed : max(min, 9600));
> 
> Outer parentheses are redundant. Also use Elvis.

 I have double-checked it with our coding style document and I can see no 
recommendation either way.  FWIW I find it more readable this way, though 
it might be habitual owing to another coding style I use where this is 
actually required.

 Any second opinions, anyone?

 Thank you for your review.

  Maciej
