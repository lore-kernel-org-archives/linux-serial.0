Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0A39E9CF;
	Sat, 30 May 2026 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136745; cv=none; b=Fy5YhDPhGLpiQMk4nVjurKmUzyEn+a3rVsDtObiGoLM7p2n+/c/X6hBglIMubemq69P/tmzBkYi0zOtoRC32GdAD5NnIhjsHBXyRKjEqRqt6ZzakRQDabB0UvCNMe8Nd0AR7+/XAPI/U2gpYY2CCmPvL7n4Pi9sZ3ayKX6bE37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136745; c=relaxed/simple;
	bh=3rNocUaeG/vh3hn+sDDfL+yXYgSl+tVYHm5nJDpA8qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfAHeEYOlxr2OKPZ+ODiYdM+YaX+jNHv8+EizPFQ4P4tCZxzfNZ2oDUtWXU0PhkSW8IWMzzlHfdTqC5hEjcDQyGDrp32ykN7SSXon0vJqf8BoPes4ip3aQFV+NrTkAKw/UpDMGgKb8me4X5iwJx+ukJ3V+0x7uxipOCoKGXQ/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TdX7ATjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TdX7ATjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C141F00893;
	Sat, 30 May 2026 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780136744;
	bh=cFeS5ZghyqtLcvpjiqm8Lf4ksDZz0Ai1X1bJYSK/WDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TdX7ATjL+JjHILUuCxvkBh0D90EOmmzLV8D/d4Wwvxp1EEdipUcU95CCk0lpoWa0o
	 mdIoV/6qOldP0BT0rASI6N80Fu+bzrCstE0Y3qQRlRhAc58YZfz+6vgfc6kFvOgu5r
	 8/39CUZ6W+KOjOHkP8FZNXMpCEJet/78yKghk6qk=
Date: Sat, 30 May 2026 07:21:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] serial: mxs-auart: fix probe error paths and clock
 handling
Message-ID: <2026053046-bonanza-bobcat-6ed1@gregkh>
References: <20260528230616.186792-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528230616.186792-1-rosenp@gmail.com>

On Thu, May 28, 2026 at 04:06:16PM -0700, Rosen Penev wrote:
> Sashiko reported three pre-existing bugs in the mxs-auart driver:
> 
> - For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
>   prepared/enabled it, leaving register accesses in probe at risk of
>   faulting if the bootloader had gated the clock.
> - The error path and remove function used pdev->id instead of
>   s->port.line to clear the auart_port[] slot.  For DT-probed devices
>   pdev->id is -1, causing an out-of-bounds write and leaving a dangling
>   pointer in the array.

This feels like it should be a different patch, and not burried in this
change, right?

> - The probe error path called iounmap() while the IRQ was still
>   registered. An interrupt during that window would dereference the
>   unmapped membase.
> 
> All of this is a consequence of using mixed devm and non devm. Instead
> of working around these issues, go full devm so that everything can be
> cleaned up properly.

Are you sure that devm and irq code is going to work properly?  That's
always a very tricky code path, was this tested with the hardware to
ensure it still works on teardown correctly?

thanks,

greg k-h
