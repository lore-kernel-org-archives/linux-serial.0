Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570E388E79;
	Mon, 20 Apr 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677168; cv=none; b=tvVakWXSE371lNbmsJQ4fC5OUOfUVwAU1cTNW6tLi0SQzD1LTM+w9xqlTcA+TNH2YCkx+rahiP4CApRwWF67/oBXnExQ7XawHxq4pXZp8L9O3n+tRZkevXgr0lWjsIWMnTfvDEzNqscMUAFP8sjk2tqUzq8GWdOJdrMLGCoAhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677168; c=relaxed/simple;
	bh=B8c1NjBfxsNbcKTld4iNPu3U6L0QYKBECKg6QByuOz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMXBNNOjCPSzirt2sCLZr675cp3gkfMVbRSvqHtpI8fkSY9QCIKMOWUEuBzXnanKly07swEdSIAushflrYN79eUc6ea1JEQGm4GQ+E8YsQPn6EfyfwOLtUA0Pn9fsinhpgeKNkycd6BZSWjMUf3SBMxPvkT7thX4ZYxxVBcADJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TleN1jMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TleN1jMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED96C19425;
	Mon, 20 Apr 2026 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776677167;
	bh=B8c1NjBfxsNbcKTld4iNPu3U6L0QYKBECKg6QByuOz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TleN1jMv6esPWc7NgXRbqypLVxN+fGgxuK1sgvv+Eg6NvkQQsMv85I5PUe9pryTQQ
	 tIHR5d51361Wj0VRrooQe5W6qK8xfJqOvrlj7BzedC5vsLWxJzNV8iXpOAz/nALBR/
	 Lxu/U/q010D3hGRpb+bdlvh/UXrfHw+WOG4cSeqU=
Date: Mon, 20 Apr 2026 11:26:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: fix use-after-free in gsmtty_install
Message-ID: <2026042014-bling-monopoly-4532@gregkh>
References: <20260415024846.2918702-1-hxzene@gmail.com>
 <20260415031731.107667-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415031731.107667-1-hxzene@gmail.com>

On Wed, Apr 15, 2026 at 11:17:31AM +0800, Kito Xu (veritas501) wrote:
> gsmtty_install() reads gsm_mux[] without holding gsm_mux_lock and
> defers mux_get() about 40 lines later. A concurrent gsmld_close() can
> free the mux through gsm_cleanup_mux() -> mux_put() -> kfree(gsm) in
> that window, leading to a use-after-free when gsmtty_install() later
> dereferences the stale pointer.
> 
> race condition:
> 
>          cpu 0                          |            cpu 1
>     gsmtty_install()                    |   gsmld_close()
>     gsm = gsm_mux[mux] // no lock      |
>     // CFS preempts here                |   gsm_cleanup_mux(gsm)
>                                         |   gsm->dead = true
>                                         |   mux_put(gsm)
>                                         |    -> kfree(gsm)
>     gsm->dead           // UAF!        |
>     mutex_lock(&gsm->mutex) // UAF!    |
> 
> KASAN report:
> 
>  BUG: KASAN: slab-use-after-free in gsmtty_install+0x6cf/0x830
>  Read of size 1 at addr ffff88800fd440ac by task poc/170

Do you have this hardware to test with, or was this done in a virtual
machine?

> 
>  CPU: 0 UID: 0 PID: 170 Comm: poc Not tainted 7.0.0-rc7-next-20260410+ #20
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x64/0x80
>   print_report+0xd0/0x5e0
>   kasan_report+0xce/0x100
>   gsmtty_install+0x6cf/0x830
>   tty_init_dev.part.0+0x92/0x4a0
>   tty_open+0x8ab/0x1050
>   chrdev_open+0x1ec/0x5e0
>   do_dentry_open+0x419/0x1260
>   vfs_open+0x79/0x350
>   path_openat+0x212c/0x3a70
>   do_file_open+0x1d2/0x400
>   do_sys_openat2+0xdc/0x170
>   __x64_sys_openat+0x122/0x1e0
>   do_syscall_64+0x64/0x680
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
> 
>  Allocated by task 169 on cpu 0 at 3.824684s:
>  Freed by task 169 on cpu 0 at 3.892012s:
> 
>  The buggy address belongs to the object at ffff88800fd44000
>   which belongs to the cache kmalloc-1k of size 1024
>  The buggy address is located 172 bytes inside of
>   freed 1024-byte region [ffff88800fd44000, ffff88800fd44400)
> 
> Acquire gsm_mux_lock before reading gsm_mux[] and take the refcount
> via kref_get() while still holding the lock, so the mux cannot be
> freed between lookup and refcount increment.
> 
> Fixes: 86176ed90545 ("TTY: n_gsm, use tty_port_install")
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>

Did you test this change out?

Why was one version sent as "RFC" folllowed by this?

> ---
>  drivers/tty/n_gsm.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b..6519f1c92fc5 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -4288,14 +4288,20 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
>  
>  	if (mux >= MAX_MUX)
>  		return -ENXIO;
> -	/* FIXME: we need to lock gsm_mux for lifetimes of ttys eventually */
> -	if (gsm_mux[mux] == NULL)
> -		return -EUNATCH;
>  	if (line == 0 || line > 61)	/* 62/63 reserved */
>  		return -ECHRNG;
> +
> +	/* Acquire gsm_mux_lock to prevent concurrent gsmld_close() from
> +	 * freeing the mux between reading gsm_mux[] and taking a refcount.
> +	 */
> +	spin_lock(&gsm_mux_lock);

Wrong comment style :(

Also, how was this tested, last time this was attempted, lockups
happened, hence the FIXME line.

And why isn't this the irqsave version of the lock?  Why is that not
needed here?  Have you searched the email archives for when this was
attempted in the past?  What has now changed?

>  	gsm = gsm_mux[mux];
> -	if (gsm->dead)
> -		return -EL2HLT;
> +	if (!gsm || gsm->dead) {
> +		spin_unlock(&gsm_mux_lock);
> +		return gsm ? -EL2HLT : -EUNATCH;

Please spell out inline if statements like this.

> +	}
> +	kref_get(&gsm->ref);

Shouldn't this be mux_get() somehow?  Open-coding it like this is
confusing.

thanks,

greg k-h
