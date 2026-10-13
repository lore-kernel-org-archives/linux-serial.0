Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3134FD279;
	Tue, 13 Oct 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896742; cv=none; b=Zr00xuOxOSSoVB83/Eo16AgH+GbFrCEgCdgOAhN6LccZ0PI55QF2EdofLBDPa63XVJBD4/43YXihzhULvJN6n2ZLIbkZfv2xOyH0eOkazJ5FjCllS0Rs7Tur1ea4y/bNWMW24rJIrwIqimLFqy08SCVfP9jrFVGbkP0YQbMogw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896742; c=relaxed/simple;
	bh=F5yxhJbKKjumT4fACyFlCQGL/U7GrLkSAoxhZTx2Jyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl1v6qwrg7PraCb1pw/Ask56fn+TDG0JtWxxmdPXnbzijfQgvdyJKScva51xgBvbBqugoSba0pICx/oJqexAuYUDFHiIOYzNi75PkcnXL1aKV3evVwMQRUPWYFe60rps7awW59DFzL8hXATO/tkZt25kfbS1htFzSeUKxHEfwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=STYHSLSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="STYHSLSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6E81F000FF;
	Tue, 13 Oct 2026 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791896740;
	bh=CkERZbAiwj3Lr+97EREFqQJN6PRdetvjDEdDHX1pgaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STYHSLSINTCsq/FZh0U6oEIu11rC5TtjkwZD44biexy+hH8mb8OQa1N6qUAvNbv51
	 4d3gUgRR46Bze3UcUw7HtL1uy/406zmoTE+7JFchZXz1N/yY53ueZLVuD7M1qXZO7h
	 JRoNhDqFD3G/W9jpnGgxCHzp6wwYTwzQQf+fnxSE=
Date: Tue, 13 Oct 2026 15:05:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: shatyuka@qq.com
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Message-ID: <2026101305-maritime-wilder-2006@gregkh>
References: <tencent_323D31BEC6A1CD2A843E2E48242C774ECE09@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_323D31BEC6A1CD2A843E2E48242C774ECE09@qq.com>

On Mon, Oct 12, 2026 at 11:17:33PM +0800, shatyuka@qq.com wrote:
> From: Shatyuka <shatyuka@qq.com>

Real name please.

> 
> On SMP, migration can occur inside hvc_dcc_check() during
> device_initcall, so the CPU writing the probe character and the CPU
> reading the TXfull status may not be the same, which can hang the
> system.
> 
> Commit 4419da5d5d4b1788568b ("tty: hvc: dcc: Bind driver to CPU core0
> for reads and writes") cached the DCC availability detected on core 0
> during console_initcall. However, this is not sufficient: if DCC is
> not detected as available and another CPU later calls
> hvc_dcc_check(), the check is not actually performed on core 0.
> 
> Multiple checks are unnecessary: nobody is going to plug/unplug JTAG
> during kernel boot and expect it to work. Cache the return value of
> hvc_dcc_check() from device_initcall and reuse the cached value during
> console_initcall. This avoids complex SMP-related code and ensures the
> result is always from core 0.
> 
> Signed-off-by: Shatyuka <shatyuka@qq.com>
> ---
>  drivers/tty/hvc/hvc_dcc.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index dfc5c9c38f07..fc8dcbce9b5b 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -29,6 +29,9 @@ static DEFINE_SPINLOCK(dcc_lock);
>  static DEFINE_KFIFO(inbuf, u8, DCC_INBUF_SIZE);
>  static DEFINE_KFIFO(outbuf, u8, DCC_OUTBUF_SIZE);
>  
> +/* Cached result of hvc_dcc_check() */
> +static bool dcc_core0_available;

Shouldn't this be per-device?

And how was this tested?

thanks,

greg k-h
