Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486282863;
	Thu, 23 May 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491261; cv=none; b=oQnT8U8ESj7pDdIMcdcHEAEGQYnGCF3uY/wsXh4DOy1Dh47TXlP/XqBIzRg1eMLK4T10CTZMKUC5N612IF2hHr1870SDJXWtVdCJ5uqqVjgX9IyKjirIVbF099uwvsRAl8agCaVBI0qQgHVgVe9W1qjkpF5pqsxYbc7hN/KV/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491261; c=relaxed/simple;
	bh=+GCeN/jo7eoSFDnUBe7tntlCDggiKvh21C5SNpgJbYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH23zQFlffVCo/shWaAPkzDxOEscMsZe3aVsu7gvV/a0KNU37I9C2xRC4hLkOe704r6BeLLMjtq20yoFcWrUeQjQN1INLTE8FzxPBjwaoJLtoQXtuPwTEcDwWOsOhoCFVoVH2izOD7LMU+YF7fG0PM7okbT1jkGOWkyAS5VqWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XldZwpbS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XldZwpbS"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8003D1F9AE;
	Thu, 23 May 2024 21:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716491249;
	bh=TYtQOlvMF01mPFBxmTMKcXxJEYwS36/9vjWSr5mXPRE=; h=From:To:Subject;
	b=XldZwpbSH70Q6hOhDnJsERiJ3RzOlrmyNpswlvcmCCqddPdpgRfWLkRuQp4oijP++
	 itoxUy2C3Hsp2RZJJNl3OhUtFcWF01Y6HtjfeL30qT6kkRet1mJbOdfyKRvIiokc52
	 wOWdFHSSkTtcF3UhPrwldOLuHiOJmL0um7zq1Qt6890Gg4UpgwcEIbAuTb4QkFG5eE
	 5eB8rzV5pLNKKkWHoaJX3cUNS7lX67MgR2YqS3Zyn7cgz+GLhB/IH9ID5SE0q3We9s
	 SHVhzkB8eohl5lHa1SDE8z342tLRWsEGSTiSGRQmb6x7opTYdoo0p3Z2Kdb1Di1sFg
	 7njipTMcb8LSg==
Date: Thu, 23 May 2024 21:07:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] serial: 8250: omap: Add am62 wakeup support
Message-ID: <20240523190724.GA31756@francesco-nb>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>

Hello Markus,

On Thu, May 23, 2024 at 09:58:14AM +0200, Markus Schneider-Pargmann wrote:
> Hi,
> 
> to support wakeup from Partial-IO using serial pins of mcu_uart0 and
> wkup_uart0, this series adds a new pinctrl state 'wakeup' in which
> specific wakeup flags are set on these pins. Partial-IO is a poweroff
> state of the SoC in which only a few pingroups are partly powered.
> 
> If the user enabled wakeup from the serial port, the pinctrl state is
> selected on shutdown. For another deep sleep state, which is comparable
> with suspend to memory, the same pinctrl state is selected on suspend as
> well.
> 

...

> 
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff

Confused ... Why the CAN? This is about the UART.

Francesco

