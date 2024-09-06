Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89617ADEE;
	Fri,  6 Sep 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617406; cv=none; b=p7Lad6kgDUaFjQP4STWwYRKbNC50SNlvxDX1jJy1Xt0gfIBzSPO+SYq1jPuu5japvEePUSVv1D75vcIWPZmRa7s5kXKmTC1tiffVkYdBcb8qgld3hhhdA7fjvNCNaArvwxWF55vRgZreChCIARpOFwfr8uLEYUP6K+tCWN0cuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617406; c=relaxed/simple;
	bh=/iTJMRwabGkJTEcLOCFeWVbhS/YvsaOVjozb4cruuJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfKGsdIRZpGRxuOSANRihKOfDPEpkGXXw0oaDtt7f+raGMCR9Y5p5XV464U/Qj3cq2yw3tZrmUkTSn3Y9LTKNN061VQabOkVstz4rSW+HE0+Jwat762YMsM9PM7fyAoZ8laSdI+mZR5xgCPMXc4S9OKk+s4M+TlXIb0hsF96WME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kObLaD8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kObLaD8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4264DC4CEC4;
	Fri,  6 Sep 2024 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725617405;
	bh=/iTJMRwabGkJTEcLOCFeWVbhS/YvsaOVjozb4cruuJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kObLaD8JBRCM3qcdX/Dxk02cijw7ftyTx38u/60OYuZfsnSHjjeSSXYBrhDQxOXMs
	 tNVNuMaja3IFfYAYmoG+e754GaR5nB+th+7l/rdenUhZXV2jlwnsSvCh+SiWwJwaC+
	 bNPjKVWtYlVC3ukjzFBcxjeUQwj34sKri/xhLQ1M=
Date: Fri, 6 Sep 2024 12:10:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <2024090609-premium-undercut-cce3@gregkh>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134719.142554-2-john.ogness@linutronix.de>

On Thu, Sep 05, 2024 at 03:53:18PM +0206, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> The legacy code is kept in order to easily switch back to legacy mode
> by defining USE_SERIAL_8250_LEGACY_CONSOLE.

define it where?

And ick, having #ifdef like this is rough to maintain, why is it needed?
If this is working well, let's just switch over to the new stuff and not
look back!

thanks,

greg k-h
