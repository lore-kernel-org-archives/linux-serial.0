Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8A31F98D;
	Fri, 12 Jun 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258523; cv=none; b=AIsJ7rth2L0q6y32EI5RArAPGI4PGjE4DaBZzTYqs5nYyoKf6tM32zVmZzc9QCgeAajY30CQRUf6dgEDMrAeDi/UMrEUBlKeaX1PWc/sFtQfoSL8HslPiBdCSZharktFsCNsD3smUOg7ySXlBSDVMJRnvZ5kK+VPY2yvgGYjfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258523; c=relaxed/simple;
	bh=o+M7RwBbr1LFRtHGNk4UFVF4qNoQPMPwE9rLzA0WhSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN1TCGlGp9fAQWwaZk0L65ARWFLonZFC6O6lOCYcLVVHB+jbK6JKAeUzYveg/YjiaZWBqhD0alioSEnToTkA6oZTevnNOR1x0QU1ZkcnOSQ2bc/9wQMgf6B9Zz4wYVjF+Jn0gE9tW2FfUpWnYl1yGZHlVRLT+VHEWuvbAIB0SF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yUcfWXbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUcfWXbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2941F000E9;
	Fri, 12 Jun 2026 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781258521;
	bh=7dyNWlwP1aKlfUGJFVIw5acIokp4Nh5Z0UZK3PAu7sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yUcfWXbrZEvOzT5TSF+C/JAOoOJyEfgNJT9273oBE2FFnbsYfv2BDqxvJhGn3PFEd
	 spqviJSMW2XP/Jn5pqug3YTwq+4dSzDD06akjIrMcIfFRnyEKu3L5/8HUqQOXdG6u3
	 cS3lFAljFuw84K3+CxhufqvpNuiSFet82mk1cyM0=
Date: Fri, 12 Jun 2026 12:01:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] tty: serial: core: fix NULL pointer deref in
 uart_resume_port()
Message-ID: <2026061238-utmost-amusement-4664@gregkh>
References: <20260608165223.70148-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608165223.70148-1-bestswngs@gmail.com>

On Mon, Jun 08, 2026 at 09:52:17AM -0700, Weiming Shi wrote:
> uart_resume_port() looks up the tty device child with device_find_child()
> and passes the result straight to device_may_wakeup(). device_find_child()
> returns NULL when the port has no matching tty device child,

How can that happen in a real system?  Have you triggered this before,
if so, what hardware does it?

> and
> device_may_wakeup() dereferences dev->power.can_wakeup, so a NULL tty_dev
> faults. uart_suspend_port() already guards the same call with
> "tty_dev && device_may_wakeup(tty_dev)"; the resume path does not.
> 
>  Oops: general protection fault, probably for non-canonical address
>  KASAN: null-ptr-deref in range [0x148-0x14f]
>  RIP: 0010:uart_resume_port (pm_wakeup.h:84 serial_core.c:2477)
>   serial_pnp_resume (8250/8250_pnp.c:522)
>   pnp_bus_resume (drivers/pnp/driver.c:234)

Is this a real oops, or a made up one?

> Mirror the NULL guard from uart_suspend_port(). put_device(tty_dev)
> already tolerates a NULL argument, so only the device_may_wakeup() call
> needs the check; the non-NULL path is unchanged.
> 
> Fixes: b3b708fa2780 ("wake up from a serial port")
> Reported-by: Xiang Mei <xmei5@asu.edu>

Where was this reported?

Why isn't this cc: stable?  And why hasn't anyone tripped over it in the
past 19 years?

thanks,

greg k-h
