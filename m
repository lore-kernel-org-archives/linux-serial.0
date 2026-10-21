Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792554781;
	b=jU7AVUuMdxBha1y8YSDWctodiMTwYNuUksDlH98gddpXPRaZWLqbYoDA8L6AsVP8Wfdo
	 iSICV1ArYlWFbk7J02No31KMbh7DoBCVrYTVHILsN50eEVzR9e056D3vfTh3KB/XhfJF1
	 LByCTSGfS0Emp3stqPRvA+prI2ibYD10SwdQ4PrYXVR5eMo9AjpAQEyvWuH15cvIgfwTE
	 A4a/xNDb87e+LRobrRCGyrVqRKrs0UWwG2UJjCRwZAMAJ9AjkXS+kG76fIrNptzGF5va3
	 /+YAPSU9rx/nE4DFVOxl2lG3O/njY7G/Y+yguVwj0fZ2rAqWH7AUkns/nlCdAKdUrjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554781;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=r1pyaMZcSDb9xlJBMts2HD8xT3tbxzqJoTwCDu3NnwQ=;
	b=0IUhJ//0fwdc4z0uz4PzLOBcf7ZT0ExqQCZtwA+aGSLIl+OJiKu1hb3l0npkl//ekns8
	 8XPa3Kk1KQdD46tf9fiKW+zKp1TGrkFygCxnqeKARmtL4dr0Y/yqkkBaOIohuv/EPEhwp
	 rTVyvZsS13Eqs+Fkm4kqzyrkQivab+Iv2bc9fgtaud9Bd1rcYIGGsvoRynXz4K8G3WCN1
	 aedOo6h958ENMsEPRR9UOQN4mqbSryoWdoU8JsDwe4t7zxVCkP9eZMJ5BGg2HDoxcuHja
	 mVBBGP9Z0+z82kJQamziD7fVZNcPBbGM/9fMdr/BHZTRAnorc5Jg8mKX70grw9/lqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87537606A31A;
	Wed, 21 Oct 2026 03:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87537606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 660E692009C; Wed, 21 Oct 2026 05:52:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 62C6792009B;
	Wed, 21 Oct 2026 04:52:51 +0100 (BST)
Date: Wed, 21 Oct 2026 04:52:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
In-Reply-To: <20261019090017.430425-1-arnd@kernel.org>
Message-ID: <alpine.DEB.2.21.2610210422160.22065@angie.orcam.me.uk>
References: <20261019090017.430425-1-arnd@kernel.org>
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

On Mon, 19 Oct 2026, Arnd Bergmann wrote:

> The driver defines an I/O port base address of -8 (negative eight),
> which should always get refused by request_region on all architectures
> for being outside of the valid resource range.

 For completeness only since I have nothing to do with this hardware: it 
does not appear to me that the negative offset ought to cause any refusal.  
In rsa8250_request_resource() we currently have:

	start = UART_RSA_BASE << port->regshift;
	start += port->iobase;
	size = 8 << port->regshift;

	if (!request_region(start, size, "serial-rsa"))
		return -EBUSY;

so the only peculiarity is that the 8-byte region requested is actually 
below `port->iobase', presumably relative to standard ISA serial port port 
I/O locations of 0x3f8, 0x2f8, 0x3e8, 0x2e8, possibly not to clash with 
conventional ISA serial port devices where also present in a system (for 
simplicity assuming that `port->regshift' is 0; adjust the calculations 
accordingly if not).  So offhand nothing wrong here and please consider 
discarding the paragraph.

  Maciej
