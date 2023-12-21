Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938F5990C;
	Thu, 21 Dec 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="pgifOCnJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=2Q9t7C2SbakvEAyAANdhIwq7Q4HehUia7VOTnZPPwiY=; b=pgifOCnJRKp+1KXkCqOoMeIv9u
	LcIdf+l31BfdI0vRUkZhsKr7bqtZC3rps8Dx6aYNRki/LvfO6Tp/na2xkN7OfvciIYIISVkruYaOq
	lOmTU93KEZhVF1BxZs69F79xYWoDyggojQFSOr8T7Lj4rXmj0Gk6RnnGmhx+9LdRsLwc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53502 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGM6a-0006rz-0Y; Thu, 21 Dec 2023 11:41:05 -0500
Date: Thu, 21 Dec 2023 11:41:03 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20231221114103.557409e9875a0f2f95eacfb6@hugovil.com>
In-Reply-To: <ZYMNSqFgAhId-lQ2@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-10-hugo@hugovil.com>
	<ZYMNSqFgAhId-lQ2@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 09/18] serial: sc16is7xx: add macro for max number of
 UART ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:50:34 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:53PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add macro to hold the maximum number of UART ports per IC/device.
> 
> ...
> 
> > -	if (count < 0 || count > ARRAY_SIZE(irda_port))
> > +	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
> 
> ARRAY_SIZE() is more robust than this. What if you change to support different
> devices where this won't be as defined?

Hi,
not sure that I understand your point, because SC16IS7XX_MAX_PORTS is
the maximum for all devices supported by this driver. The irda_port
array always has a fixed number of elements set to SC16IS7XX_MAX_PORTS,
even if the device that we are probing has only one port for example.

But I can change it back to ARRAY_SIZE(irda_port) if you want.

> 
> >  		return;
> 
> ...
> 
> > -	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
> > +	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
> >  		return 0;
> 
> Ditto.
> 
> ...
> 
> > +	WARN_ON(devtype->nr_uart > SC16IS7XX_MAX_PORTS);
> 
> Not sure about this, perhaps it's fine.

This check is only there if we add support for a new device and we
incorrectly set nr_uart to an incorrect value, which will cause other
problems anyway, of course :)

This could be removed.

Hugo Villeneuve
