Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080829;
	b=LtJr4PX+CAzfsZ1vgUycfF8bOINW2cpaOrcPdL9RCByetK2ZPujyttSLHdZLXuZZdjGH
	 AwwU4yE39AUqKLL/gbnl9whvNrZlb6XC8BtaxjIntcGdb4pPIfpnCr+7LBaKzXPR0hRb9
	 gWbSAdXHUIEDkLA3FbtCg2A8c9cmrEuYBsAz/oKsEk5ru8j+TVwCWC27s1seFZ1xlSNbV
	 +fZv4svve1J5sQhCzjz+41/K8i/VQYBFuiiMDFVwWDfU6vP+zJ3MhBa7we+iHvPwPR3Mo
	 CuaGDUit3q7Y/kU9UpmXAzU7o4iSGptSf3E4+9rs28MsjmopNbJilTD0kBiWNzssR2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080829;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8QtKlWLk95ZvjKqf0XgLBO5FmpM2k3k6qlGymHzmlNw=;
	b=IjD1klje/w7WpzKhQ7oUN4ilys0AQL7c8FuVkslORCkIqB/x9VTYsxBDNvgFa9UWAJLQ
	 zGdm1x+nZVsGwVl051X8fmmSCrCE2IAo1j3Ip/pNVj3k3oThus/lA+YNHBdUJDTFR0fm7
	 BKFnY/qaYgzu8+16OGkrt/F1Clsq4w/Y7xVl8ts2WNzEHxtLC1uLnsFQAzyIBY+fSXZwt
	 YoEdTZDg7Eau6Rvz09J6P1MCpfTY4lGR4F+nxleMsXf/SNT2GVU62hMVg7Udh/RSLdWKn
	 jfZuLXVeDe82906oI5Ys8GX337V2DvtBlEV+Kb2G4bWtUR58CGsZ8U7yRKO+7pIioRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VNrMY3q1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444A606A31B;
	Tue, 27 Oct 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VNrMY3q1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB71F01825;
	Tue, 27 Oct 2026 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793080828;
	bh=8QtKlWLk95ZvjKqf0XgLBO5FmpM2k3k6qlGymHzmlNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VNrMY3q1LA+WRx6+JO7hHekEn2N4axAXmzpio5l60y1/+5RWdIYjwr3DvZdRXvDqQ
	 patQh2hvzK6yIQL6g8VsrbgZeIvYMyD8/9hrDv3Nd5+EcwKAojH2jTs0CT2dcGnAYs
	 XUNxPzdbtu4u+V25Jy4y/KPimfPRT25zu4TeWUDQ=
Date: Tue, 27 Oct 2026 07:00:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
Message-ID: <2026102711-venture-amicably-24c7@gregkh>
References: <20261027054304.35543-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261027054304.35543-1-dennylin0707@gmail.com>

On Tue, Oct 27, 2026 at 05:43:04AM +0000, Hungyu Lin wrote:
> set_termios() handles TERMIOS_FLUSH by clearing only the line discipline's
> input buffer. Data already committed to the tty flip buffers can be
> delivered after that flush, leaving old input readable after a successful
> tcsetattr(TCSAFLUSH).
> 
> This can be reproduced with a raw PTY: complete an 8192-byte master write,
> wait until the slave reports 4095 unread bytes, and apply TCSAFLUSH.
> The remaining 4097 bytes are still readable afterwards. Small amounts of
> pending input can also survive if they have not reached the line
> discipline yet.
> 
> Use tty_buffer_flush() with the referenced line discipline to discard both
> receive queues under the existing buffer lock. The helper checks for the
> line discipline's flush_buffer callback itself.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/tty/tty_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 90c70d8d14e3..45cb77185dbb 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -496,8 +496,8 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
>  
>  		ld = tty_ldisc_ref(tty);
>  		if (ld != NULL) {
> -			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
> -				ld->ops->flush_buffer(tty);
> +			if (opt & TERMIOS_FLUSH)
> +				tty_buffer_flush(tty, ld);
>  			tty_ldisc_deref(ld);
>  		}
>  
> -- 
> 2.43.0
> 
> 

What commit id does this fix?  How was this tested?

thanks,

greg k-h
