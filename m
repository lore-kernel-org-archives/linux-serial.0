Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511193C3F42;
	Sun, 20 Sep 2026 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881560; cv=none; b=jXeWs4V/+GrdwYujO1rm4hvJNlNkqrzeqD81mzGgcRyvMeJWcTbgDWBKMIMTjTnN80+6tZKbZDbvbhlvIr3mawSNAHICEbOMjC/BV8cfrXEDavQluywEnn5iYSIk9vHJrRrxJAGteSUDY6hJieSMaxDKfm3WvRiv67c4Ur0i8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881560; c=relaxed/simple;
	bh=2FcVlwXazTCbICvrpW2LKqxgOmQjMOl11YWMhdBk8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRlpiGRzAtCvULSV3a7bFI+SXaduAA9kq0Mmf7tooPb1y4YoUrCpm4scOX3tBezUL3aHmSKCwi+iYEPdxo3PARpHqsEVo+CxWZjV5fS0qjSldu6jHLUyYkb52i+yHSz2w6J9KheAeITLIYmFAV6/PEonxotJkTkW8vgIzhuP2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubS0BxV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubS0BxV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB541F000FF;
	Sun, 20 Sep 2026 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789881558;
	bh=ZpuKN4BpPOj101hlet9y/R7+p5hs6ksIDBZ7aInNq3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ubS0BxV6UfNr965j70Kd2m4bDaTmO0/K4gahxU1VzzvhYBDj9jc1+hVoM1N2gy+yw
	 gQwLpLrxIe1SFn6n6YL81xOW46yIvz02BuWVMPj3usa0/j0n4dimdwh9zLht/l3aJy
	 OrNjSV6m2vbsgMwIyrEImI3fYRdjRXncx6IxdkaA=
Date: Sun, 20 Sep 2026 06:17:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: fix 8250 hash_mutex race and
 uart_get_baud_rate() divide-by-zero
Message-ID: <2026092001-judicial-coherence-46a5@gregkh>
References: <20260919222627.3797854-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919222627.3797854-1-benquike@gmail.com>

On Sat, Sep 19, 2026 at 10:26:27PM +0000, Hui Peng wrote:
> Fix two bugs in the serial subsystem:
> 
> 1. In serial8250_Label / serial_link_irq_chain() and
>    serial_unlink_irq_chain() (drivers/tty/serial/8250/8250_core.c), hold
>    hash_mutex across the entire IRQ list manipulation and
>    request_irq()/free_irq() sequence to prevent racing IRQ chain
>    insertions/removals.
> 2. In uart_get_baud_rate() and uart_set_info()
>    (drivers/tty/serial/serial_core.c), avoid unsigned overflow in
>    port->uartclk = new_info->baud_base * 16 and ensure the fallback
>    retry in uart_get_baud_rate() terminates cleanly when no baud rate
>    lies in [min, max].

Then this should be 2 different patches, right?

Please slow down.

thanks,

greg k-h
