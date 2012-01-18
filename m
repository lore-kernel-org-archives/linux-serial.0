From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amba-pl011: clear previous interrupts before
 request_irq
Date: Wed, 18 Jan 2012 11:41:00 +0000
Message-ID: <20120118114100.064e2c8f@pyramind.ukuu.org.uk>
References: <1326796493-16080-1-git-send-email-shreshthakumar.sahu@stericsson.com>
	<20120118100410.GB889@bnru02.bnr.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60356 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab2ARLjy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 06:39:54 -0500
In-Reply-To: <20120118100410.GB889@bnru02.bnr.st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>  	/*
> +	 * Clear previous interrupts before installing interrupt handler
> +	 */
> +	spin_lock_irq(&uap->port.lock);
> +	uap->im = 0;
> +	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	writew(0xffff, uap->port.membase + UART011_ICR);
> +	spin_unlock_irq(&uap->port.lock);

I'm confused why you use spin_lock_irq before you've enabled the IRQ in
the first place but looks fine.

Alan
