Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E03B5E15
	for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869833; cv=none; b=OBaNMOA8iU8sTx8RY4mHk4Ug6ouvuGDUY/z85OWOEevjTXUZQuuYOUK0kpjzTwty690lq0BWmD125RsxUs3apYzP3GxI1pLuni0/TgLnYKGkrqrN1Cg7rBFMkJFrf+sMTKN/SvNgqJHY3V8w4DLuqLpI1ABWCou9JU5bqJGt1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869833; c=relaxed/simple;
	bh=zrNpt13d8mWO1ikNV+6uuzTk1kkI+7bXUTYR2i2NI+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TraZ3D0+jS0ZIEzvb2GzWmM2vXYYJK4qeKb3CEZUBon4Q4J0no+552RwPZMb+ZF+K7JjKqVL1cHJKUg3+VICxewgMXQFVOp8OnDRB8hHGfHcHzW9vs/dJVkLiceAltZxcDe5hDNnEQNUvD/b4GWof3EkKCfx/BueSehsEgxn6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpARfSRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpARfSRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8B71F00A3A;
	Wed, 27 May 2026 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869832;
	bh=sQHsSZ1SXImQkdqzjqlCayAOH4gz7jXzYoJoJf/5QnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mpARfSRbAcTZIeUbL9Zc3cZmV+EjxTBIpCoNM9aIGvZu/oXrw9IvthBuvzKR8Gb75
	 F/MGokwKZVgPMpFe4FPz7RwK+4lOaeLZa1sz1rfu7HYgzjmdD/tXtGS7iIdA0uj7UF
	 yc7f+ZB6l8gSrKpLvHeUlxE6MB/DT87UDnukgg3c=
Date: Wed, 27 May 2026 10:16:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty] tty: n_gsm: fix use-after-free in gsm_queue vs
 gsm_cleanup_mux race
Message-ID: <2026052743-probation-anything-aa72@gregkh>
References: <20260526102924.3174-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526102924.3174-1-kipreyyy@gmail.com>

On Tue, May 26, 2026 at 06:29:24PM +0800, Zhenghang Xiao wrote:
> gsm_queue() reads gsm->dlci[address] into a local pointer in the
> flush_to_ldisc workqueue without any lock. Concurrently,
> gsm_cleanup_mux() (triggered by GSMIOC_SETCONF ioctl) frees DLCIs under
> gsm->mutex — which the receive path never holds. The cached pointer in
> gsm_queue() becomes dangling, and the subsequent dlci->data() call
> dereferences freed memory.
> 
> Fix this by:
> 1. Checking gsm->dead at the start of gsmld_receive_buf() to reject
>    frame processing after cleanup has begun.
> 2. Moving tty_ldisc_flush() before the DLCI release loop in
>    gsm_cleanup_mux(). tty_ldisc_flush() acquires the tty buffer lock
>    (buf->lock), which serializes against any in-flight flush_to_ldisc
>    work. After it returns, in-flight receive processing has completed,
>    and subsequent calls see gsm->dead and return early.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---
>  drivers/tty/n_gsm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Cool, how did you test this?


> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b..8322fffbaeba 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3156,12 +3156,18 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
>  		gsm_unregister_devices(gsm_tty_driver, gsm->num);
>  		gsm->has_devices = false;
>  	}
> +	/*
> +	 * Flush the ldisc before releasing DLCIs. tty_ldisc_flush() waits
> +	 * for any in-flight flush_to_ldisc work to complete via buf->lock,
> +	 * and the gsm->dead check added to gsmld_receive_buf() rejects any
> +	 * future receive processing. This ensures gsm_queue() cannot access
> +	 * a DLCI being freed.
> +	 */
> +	tty_ldisc_flush(gsm->tty);
>  	for (i = NUM_DLCI - 1; i >= 0; i--)
>  		if (gsm->dlci[i])
>  			gsm_dlci_release(gsm->dlci[i]);
>  	mutex_unlock(&gsm->mutex);
> -	/* Now wipe the queues */
> -	tty_ldisc_flush(gsm->tty);
>  
>  	guard(spinlock_irqsave)(&gsm->tx_lock);
>  	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
> @@ -3604,6 +3610,9 @@ static void gsmld_receive_buf(struct tty_struct *tty, const u8 *cp,
>  	struct gsm_mux *gsm = tty->disc_data;
>  	u8 flags = TTY_NORMAL;
>  
> +	if (gsm->dead)
> +		return;
> +

What prevents dead from changing right after you test this?

thanks,

greg k-h
