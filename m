Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640065;
	b=cHKL6q4b5E1Rq23J6mfNd5HAIuFdSs+uDbW6mgiW5TM41lO4BjO46dlCngT86x6bUszT
	 enpXJpQAvIOnmlqryg/Ke+XQjgvEQoSO2JoZDntpM60xsQqvSQ2/TeKQ0WxmMVw702S6i
	 /Nv7NJ4XtGfzMcxr0XaavgAedbdW9Yj/mXK1C11MpNFrLnjZizy2DNvdBX8MjjGgARVyE
	 3JhklGirVUrtdEK8OlQ+RdtH/hIg5yXEC6zW4+TD7zkQm9gV4O7jiGF9EHtdvC3XDzaE9
	 V8glMs5SaiZuW+5O6ZDB/IJ3is7h7jNhN0f5yIMqqVQQTGEKqDgfA8Z3SIx3hqJSeWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640065;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=3ilS53cVgDiLeeXsr23MPVxO4sxG3qd4lTAwsjvkdXE=;
	b=3DP69TwVBNW7F5UEzFLrTISzVkT0cUOTwCMXbdhey7L71yXKT2/2fysujtBngC56jWIN
	 m1EYudvH/hi57qSxjFFLOH4/RGOt/yVR3jpkuGqBb36VjiXWogQGZ3zximztzRBOqDf7f
	 lBlBRmf7KJY+HOE1+3DgvqR8s/N4Xk9jzbiqiUDmZHZxdpZbztxGaPAtGcnGD/omBU2Qk
	 vpyQ+qFANhqvyW2HVgaR1dti0GwXwwTkvbMlGMIPJXfuTlc69eg3di30wgeFAdypAvb3A
	 mDJNwRvPv851913XnzdWE74M457Su7clhRkXzEJz45SKW9goS9B/m3NOYeR7FTu/Wcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3649E606A31B;
	Thu, 22 Oct 2026 03:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3649E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 024E892009C; Thu, 22 Oct 2026 05:34:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id F1D0792009B;
	Thu, 22 Oct 2026 04:34:21 +0100 (BST)
Date: Thu, 22 Oct 2026 04:34:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@arndb.de>
cc: Arnd Bergmann <arnd@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
In-Reply-To: <215c694e-bb97-4c21-ae5b-308c03e21611@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2610220418380.22065@angie.orcam.me.uk>
References: <20261019090017.430425-1-arnd@kernel.org> <alpine.DEB.2.21.2610210422160.22065@angie.orcam.me.uk> <alpine.DEB.2.21.2610210500560.22065@angie.orcam.me.uk> <215c694e-bb97-4c21-ae5b-308c03e21611@app.fastmail.com>
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

On Wed, 21 Oct 2026, Arnd Bergmann wrote:

> >  Or, to self-correct after a few more mind cycles spent on this piece, the 
> > region below `port->iobase' is an expansion of one above, where standard 
> > 8250 registers of the onboard serial port reside.  Which makes even more 
> > sense, to me anyway.
> 
> Good catch, so it should still work the same way it was originally
> designed, though I think it still requires a modified setserial to
> set PORT_RSA, or a boot time argument for autoconfiguration with
> UART_CONFIG_TYPE.

 Well, this is ISA, what do you expect?  We've dropped lots of stuff that 
required perhaps even more complex manual configuration already (QIC-02 
tapes, anyone?).

  Maciej
