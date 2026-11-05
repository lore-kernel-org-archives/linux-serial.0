Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875370;
	b=sFsHIpoBMIP0B/3GK9XUZCRyyw08VORuRZJQS6WsPZEJhN3BokT1mfaguHZJFFNJ9Nk4
	 usKpGclwQdOT5WMIMeG6TMWMS96a3xzekjmIAADoJXMfBn5WFbN0tnjvQwAF67MfXFRBV
	 S/gNq5HWFvdVZHzQ850o/ebVxkBvF3WIUi/fKS8jvZwKBNTfBZ/qSM2OGiXB/dnTJMWMs
	 S1kp9kYTwFgI3RzUa7oG+Ome1od/0VwxrpJMSu/Rg6BWY6RzKhEFOBlk/Nj3X88KdXvHn
	 m1zX+aEO5iAFgAg38ciFbfRrwXgBQx2Y9AePYKMwoE22Lp+YpkoNgoStwy0gLeULMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875370;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=xJsEvHNke3kUt+HxAZzlLn7jLS79JUH+y0sszEHE6zg=;
	b=Ct6B1HytxaWCDkJF/FV3DXBNJmx8e6kqHRXhapEpTb8EXZ09pqpJVyS0gQ8MBrYwwyit
	 BjNTiUUBrT5uuXFmf/nGyaioRlSNK6sQTgAaH04Ag4xf5NzvEpM6RGGzc8KWh/lxxVsK7
	 SkKrfPVACSFOw3PEMFc+RdkXpsx1Suugb/FPi7HtBpL8B5hYbmM73ib4B0+xn3gfVpllu
	 LPEv/9vTy9SI49bhw/5oFJJMaM7uPS5KXkPlSmcRKcXX3jTf07huFrDcgWxNKDdEVolzQ
	 2eHJ1iQnaZVPgtSqh9XlmP4T9cnZtz/hB0S18wudlZfxIFVh2OQPCNR3JnpRwaXmHWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Z48jCAYJ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F426606D81E;
	Thu,  5 Nov 2026 10:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F426606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Z48jCAYJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xJsEvHNke3kUt+HxAZzlLn7jLS79JUH+y0sszEHE6zg=; b=Z48jCAYJO8VXTY0gKD1qtr2v43
	vLr5dHFHnMkKhvYxfU/oRRiO4NIi03HtF7TZ9ft26QcuuJxvco0HkBmRvxg5rZatQCT1AKhY9fTZo
	bdkYzvV8gc6W56RwOaz+zBse5nyBODXbX/4ytktY7uUmCV4CaZ6B7nlBowz/jyDAq+9cAwUb+UpJS
	NuBhiPxOWOi7Hkz+KZzigcX5ykTGDQeFt2UFHOvyWGmCXU+oolG2rrVVrUE8g+qoSbFgQR+VfsIw1
	22gw7K1U8dM6axBctEUwqQL9Yg7Rc78P1ytHlcqz5AL/+ZxiRHterBLlU/pSepnQaCjxKPqy7FRkC
	k46w7zUw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOuvb-008RQM-1y;
	Thu, 05 Nov 2026 10:42:43 +0000
Date: Thu, 5 Nov 2026 02:42:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Russell King <linux@armlinux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>, kernel-team@meta.com
Subject: Re: [PATCH] serial: amba-pl011: touch the watchdogs in write_atomic()
Message-ID: <auxdWQsUW06CpDGX@gmail.com>
References: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
 <auxcc43USXjFxBeI@pathway.suse.cz>
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
In-Reply-To: <auxcc43USXjFxBeI@pathway.suse.cz>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 11:37:39AM +0100, Petr Mladek wrote:
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/io.h>
> >  #include <linux/acpi.h>
> > +#include <linux/nmi.h>
> >  
> >  #define UART_NR			14
> >  
> > @@ -2734,6 +2735,9 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
> >  	struct uart_amba_port *uap = amba_ports[co->index];
> >  	unsigned int old_cr = 0;
> >  
> > +	/* An atomic flush may print a long backlog with IRQs disabled. */
> > +	touch_nmi_watchdog();
> > +
> 
> I would personally touch the watchdog at the end before returning from
> the function because it still could spend some non-trivial time
> in this function.

Ack, let me move it as you've just suggested, given I have no preference
at all. I will respin it soon.

Thanks for the review,
--breno
