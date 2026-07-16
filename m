Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE13BB11C;
	Thu, 16 Jul 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188716; cv=none; b=WaxbfX5wRCYjomU3WRDS2pzxat48K3K8EcinFPJKWQUW0F0cqojmebUR7RIz5AronKuHG8WlCOL17FQ8RJN66fdjUTZ2iDGeOzp1K4/HceXBnSEGkdOabqmHX+rFkbqc94uf9UTvts2End1+9Yf0R9UxrnX2Bp+TN72tqQY7b3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188716; c=relaxed/simple;
	bh=DETAK/XdWNA5vfwdagrjglJ8kBtx/fUgC6Qwenu5IC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeBsebYY8BHSFvGuxJuQqQ9X6i3xVKQt3WUeEWeNiIFRgz7W7Y/ziqMlgNqSbetHQZerD9sLssxMCLyg449tBfjP6vW/R/KXnutAQVtH9bLcnQYSyyxxt8gaNywWgGXXeDj35DX3DzUystS1oAYtEdEoKwRNNMj/tzACKG5lYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKOTLEED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKOTLEED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD121F00A3D;
	Thu, 16 Jul 2026 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784188715;
	bh=ne3Ukv1uxkP2pFM8Hep2c/+j1jREZfaqYG+mNHKPZFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKOTLEEDJaklR7ahI5eiPrDILbQFqHAZn0NSEFLOBaE5Xi17Nik2Q/1lLX/XetH/+
	 +8KOKCY8SIY3s9XFEXq8qrKUBF9hjg+u8lnLWJFlZ0zLTK/vzc4iDiPq9aPXx8bDCM
	 krWpKK+/fhK4X/eu5ruRNSHr29mskcarQWcTDFYI=
Date: Thu, 16 Jul 2026 09:57:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: jirislaby@kernel.org, socketcan@hartkopp.net,
	linux-serial@vger.kernel.org, mkl@pengutronix.de,
	linux-can@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Message-ID: <2026071655-steering-cardstock-cd06@gregkh>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716064719.1401892-1-yun.zhou@windriver.com>

On Thu, Jul 16, 2026 at 02:47:19PM +0800, Yun Zhou wrote:
> syzbot reported a circular lock dependency involving tty ldisc_sem and
> the networking rtnl_mutex. The full chain is:
> 
>   rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex
> 
> The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
> discipline .open() callbacks (slcan, slip) call register_netdev() which
> acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
> tty_set_ldisc().
> 
> Fix by moving the .open() call outside the ldisc_sem write lock. The
> ldisc .open() is initialization of the NEW discipline after the old one
> has been closed - there is no need for ldisc_sem protection at this
> point since:
> 
>  - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
>    hangup, or close
>  - tty->ldisc is set to NULL during the window, so concurrent readers
>    (tty_ldisc_ref, tty_ldisc_ref_wait) see NULL and return immediately,
>    which callers already handle as a hangup condition
>  - tty buffer data stays queued until the ldisc is installed
> 
> The sequence becomes:
>   1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc = NULL
>   2. Release ldisc_sem(write)
>   3. Call new_ldisc->ops->open() without ldisc_sem
>   4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
>   5. Release ldisc_sem(write)
> 
> Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  drivers/tty/tty_ldisc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

What commit caused this to be a problem and why have we not seen this in
any real-world usages?


> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 27fe8236f662..248a6995cc53 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>  	/* Shutdown the old discipline. */
>  	tty_ldisc_close(tty, old_ldisc);
>  
> -	/* Now set up the new line discipline. */
> -	tty->ldisc = new_ldisc;
> +	/* Clear tty->ldisc so concurrent readers back off during transition */
> +	tty->ldisc = NULL;
>  	tty_set_termios_ldisc(tty, disc);
> +	tty_ldisc_unlock(tty);
>  
> +	/*
> +	 * Open the new discipline outside ldisc_sem. The ldisc .open()
> +	 * may acquire locks (e.g., rtnl_mutex) that would create circular
> +	 * dependencies if taken under ldisc_sem. tty_lock is still held,
> +	 * preventing concurrent ldisc changes and hangup.
> +	 */
>  	retval = tty_ldisc_open(tty, new_ldisc);

Now you are calling open when previously we were not, are you sure this
isn't going to cause problems?

> +
> +	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);

Why that timeout?

> +
>  	if (retval < 0) {
>  		/* Back to the old one or N_TTY if we can't */
>  		tty_ldisc_put(new_ldisc);
>  		tty_ldisc_restore(tty, old_ldisc);
> +	} else {
> +		/* Success - install new ldisc */
> +		tty->ldisc = new_ldisc;
>  	}

Does open cause anything else to be incremented that you have to clean
up when done that you aren't doing here?

thanks,

greg k-h
