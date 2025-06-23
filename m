Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988392D3238
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702294; cv=none; b=Qa66rq6vBB5PP/EbW66qEnZfLsJgK0dig4+1qIhAxqDYwulYqqyhkF+Xerm2Ynkacj9YzrWqJivlc+UmVNQ1+CwJF2g8ssd5NaxNPipMVZdu0dmQKKJbmiPmTwMzA1ApVO19FcN24GTKWYUVMOnOHA0zfGPa4IV/CDkm0TcHnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702294; c=relaxed/simple;
	bh=rlcBDtIMoGT3V5ey9ZFYpWVUAE/L0LnaqLbwIYm3Sys=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk+mSDbOC58478i1vw21cdrlMRFWNHaL+nNqEaE8adOa5vI1hwRvnS7SqP75hNN5LBng/zbfgSdxnZmqxw+15rc9p0KZkFg4smZ1W+qLN9bW0J3Eoqll9BRZefwrFrwwav+pNUDmC6VgrFXpvpFk6dhvlY5KHXQ10nap6l8nJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 72cc51cd-505d-11f0-a9aa-005056bdfda7;
	Mon, 23 Jun 2025 21:11:13 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Jun 2025 21:11:13 +0300
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/5] serial: 8250: extract serial8250_init_mctrl()
Message-ID: <aFmYwcO9tJ4byxjz@surfacebook.localdomain>
References: <20250623074606.456532-1-jirislaby@kernel.org>
 <20250623074606.456532-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623074606.456532-2-jirislaby@kernel.org>

Mon, Jun 23, 2025 at 09:46:02AM +0200, Jiri Slaby (SUSE) kirjoitti:
> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the mctrl part of this code can be separated into
> serial8250_init_mctrl() -- done now.

...

> +static void serial8250_init_mctrl(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
> +	if (up->port.flags & UPF_FOURPORT) {
> +		if (!up->port.irq)
> +			up->port.mctrl |= TIOCM_OUT1;

I am not sure I understand why it was changed from using port directly to
up->port.

> +	} else
> +		/*
> +		 * Most PC uarts need OUT2 raised to enable interrupts.
> +		 */
> +		if (port->irq)
> +			up->port.mctrl |= TIOCM_OUT2;

Having {} in this branch is also better.

> +	serial8250_set_mctrl(port, port->mctrl);
> +}

...

I specifically left below to point out the original code.

> -	if (port->flags & UPF_FOURPORT) {
> -		if (!port->irq)
> -			port->mctrl |= TIOCM_OUT1;
> -	} else {
> -		/* Most PC uarts need OUT2 raised to enable interrupts. */
> -		if (port->irq)
> -			port->mctrl |= TIOCM_OUT2;
> -	}

-- 
With Best Regards,
Andy Shevchenko


