Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077C43D4FD;
	Fri, 25 Sep 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314468; cv=none; b=k03qhohs211h9xSwBb/j5KIrZQBYwNXH9uJ9KCIw9vwux6UZbaeQadLKqh/xarhAff4/vNLyEi+8g1KTRSrfz67L8xy8oLR16UD5PB3WEgi3Q0A35drMLTRoMsM+rL9+qzkKpXG9lKLh+JcltL2DPu8bkS5mii/tIm0AEhxu4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314468; c=relaxed/simple;
	bh=LbpmQwG4eSE8HnRC/kPz/tuqdnXSZJrx1Pv46QRmb9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx7gdyxB+8uSNbZ/HTc6BY2TUgvQiVOLfex0d6xGSeIFmrw/oo5YNcY4OkEuWFhJQ+l2Sk+xvzE5Q6JRgev/brb/Vgyutu5E1Bi0MKufr7GkFGXNJufLllnDjtihPfc03PAz7MQynOt8N8iIK+vUPWMxmKVFSCoPWcRLXLsZf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L8Q3vfz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L8Q3vfz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5200D1F00898;
	Fri, 25 Sep 2026 05:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314467;
	bh=8zzICicSr3ntC0JiYlfp5Zs65sdMNqRjV4S+blinW1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8Q3vfz1v2JiJ91i08SGpDP8nFjlF8xoURgiV3N4iYgqRdSucVcV6du9XLjwvvL2y
	 gJjkZf3OsU53jMQT29mSZNIjujTF6pzclokoHOA1Gi7a+5YS5Bxk/shjaWb1aqYUBG
	 G7kwfcMbWpXEFm2P7JuLebIfupmPib90TJtR1ubU=
Date: Fri, 25 Sep 2026 07:34:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Putko <igorpetindev@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
Subject: Re: [PATCH] serial: core: shut down initialized port on removal
Message-ID: <2026092502-staple-surgery-df48@gregkh>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924192224.3175-1-igorpetindev@gmail.com>

On Thu, Sep 24, 2026 at 10:22:24PM +0300, Igor Putko wrote:
> When a serial port configured as a console is opened and subsequently
> closed, tty_port_shutdown() skips invoking port->ops->shutdown() because
> port->console is true. As a result, tty_port_initialized() remains true
> and the port's interrupt handler stays registered in the irq subsystem.
> 
> If the underlying device is later unbound or removed (e.g. via sysfs
> unbind), serial_core_remove_one_port() unregisters the console, frees
> uport->name with kfree(), and clears state->uart_port without ever
> shutting down the port or freeing its IRQ. Consequently, the irqaction
> remains linked in the genirq descriptor with action->name pointing to
> freed memory.
> 
> When another device later requests the same IRQ line, __setup_irq()
> encounters the stale action, detects a flags mismatch, and attempts to
> print old->name in pr_err(), triggering a KASAN use-after-free read:

How can a different device request the same irq line on a real device?

How was this all tested, with "fake" devices?

thanks,

greg k-h
