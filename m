Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791705;
	b=sE5oWUG+u7BecKzijwpmjuJnjsiY7UAut2Nj2KsEyuOYuLBycDIntRsKcz1gezC8jODT
	 o4nTOEBN4VhD7DFyoS+IvYchm1Gj+/XOF71TrmJHYw7SZNOnPs6lAVdlhv3ZVNNlQIU4V
	 /aTa+45/yzwKRJoRTjt7FqutBsb48S1fjLzOmAH39apkXqm7l6IfwfluE+xeIMwby6SyW
	 sIPWZM+fCIAB07KUaapHp3YpY9f1kmRERcDyrsL18iM3Ie6gDZyPI46CP2SiTDHoz7WGe
	 FWAkPsMrwDbWLImiHC8sApQVXPIuDnB6IF08fxCpjOXE7yaagVMy5PjNYp+OZe9vtfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791705;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3pWCjooVw0q/IpMWGSgazA9bSaxu/ge4+OXDdrKZltM=;
	b=TgKvBjQdVd0x3S2yB+s1CjkLPwRe3jP4IxOxhVc1shvnl50+mlp/ii73cVvXgP8OoiAG
	 jdd1diaaxrZsP2gqBDHwAzgH4HZ1MwH1j3w38R86HyVbwCfCf4CrpkRkUNTK/w63oH+NL
	 ncwJPD/hClfdxzGEraMavpu5LPeyONCVTA+x6xMiXbFWWAY33dsvgWdeyPhkZrb/XSC7X
	 E+5GUIIAfkDKTNdzcHE54xHyq6SjiEwFvAscDIPPlo03F3oHHfVLEfO6FGrMxoI+G2vzW
	 xYge5IrV05kxq2Du/UWHG1AaaPhlGJVWYZo1v1BNFskgZctVGdwTT3cJKiyxFBgs9mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqubHYce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA3606A326;
	Wed,  4 Nov 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqubHYce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F81F000C1;
	Wed,  4 Nov 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791705;
	bh=3pWCjooVw0q/IpMWGSgazA9bSaxu/ge4+OXDdrKZltM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XqubHYceraAR9Iafr3N7h6UCKyJS3iSZubmetSybSecNol2zEbRRerLhWTa3qjaUd
	 v9ykZ90InCVylvZ5hHzAsqD7euDrcXVNSN51AxoQfXMpsZOUdFFx/FtX/3H3NZacO+
	 V2pRDaNSaRoV0YExZOhVB0tjZy8yxkd+Tco+aenHqDysdl98ZPQlyMf24ZXq/23DGF
	 hdCqi1WkwC9J/Ku/JK9zqlSzCP5Yg2LfdIc5fPSo9s5mvDZT4ENaerXMl/Cve4dikk
	 BASZVbX5TNBxHHM9KsiZ8kPl5w8JtnwPXrtwidjv8ug78dFyz876atQi87reoy/tku
	 jZS5vUuLJ2P1A==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xOZAE-00000007FA8-0uSd;
	Wed, 04 Nov 2026 12:28:22 +0100
Date: Wed, 4 Nov 2026 12:28:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
Message-ID: <ausW1pwp2eBCqVsM@hovoldconsulting.com>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
 <ausSmrErzTXfKNGU@ashevche-desk.local>
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
In-Reply-To: <ausSmrErzTXfKNGU@ashevche-desk.local>

On Wed, Nov 04, 2026 at 01:10:18PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 03, 2026 at 10:07:58PM +0000, Maciej W. Rozycki wrote:
 
> >  		if (baud == 0)
> > -			baud = max(min, 9600);
> > +			baud = (port->hup_speed ?
> > +				port->hup_speed : max(min, 9600));
> 
> Outer parentheses are redundant. Also use Elvis.
> 
> 			baud = port->hup_speed ?: max(min, 9600);

No, don't.

Don't use the ternary operator at all as it tends to make code less
readable.

Johan
