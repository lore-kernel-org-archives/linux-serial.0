Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567047DD4A;
	Wed, 23 Sep 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159860; cv=none; b=WvqXrWQST6gXBmcFsPdPNthrnxZZxJcPnpqi+Dhwi3V+p8Hgx6g6iTM9kiqA7Bdz+xa0dwy4qq24vjFOasCqkEiNjFRfiMvdczM2I23SOCj/Vovks18Xf2JgEyY7+pZ8QgStMG9xLBB8M4lPVBYjZi6QcXz/o+GaIxn4EfkWy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159860; c=relaxed/simple;
	bh=pMLuWqKGUWb9btdDWd3NN9gKczyh9lXOf09UgxX750E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzSPuDUbeY1nIYkLTTauu/wAwuVQ1nLUstLzjj9OT14A/PWBAyfTtHz9JKFFm/YB7irBfgUZTI2tXtqdZZONOrn3lmUgPYyaR91KBUzrbzA4mKX+iB5wZpK/hHgjLyGHWQoqac/NeaAF1aQvF4UhH4q0GO9cccoW5EwIDrjGYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sqild0PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sqild0PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA3A1F000FF;
	Wed, 23 Sep 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159846;
	bh=UGEpnxcaY7vGACZ8I4wSZfGg/FkkOBRrhTwFuklTsb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sqild0PTcP7ODmErNz4Zfs5eUYBX7NuX+EOSMsl0qv/wNCUSEW7/sSOQ28U0SsV0W
	 +EyQ/kBMAX5aW/yyrqvv9U+pSiDDwj4NniX+UvfOYB+GrYm/bRDHOn5U4pBCCSHFt0
	 HjfOmRkvq+FT4Ys7KWQmIZrnhnySfX87fOJi3TFo=
Date: Wed, 23 Sep 2026 12:37:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jirislaby@kernel.org, fseidel@suse.de, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: nozomi: lock tty_icount reads against the IRQ
 update path
Message-ID: <2026092340-disengage-broadcast-3542@gregkh>
References: <20260919192349.272409-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919192349.272409-1-meatuni001@gmail.com>

On Sun, Sep 20, 2026 at 12:23:49AM +0500, Muhammad Bilal wrote:
> receive_flow_control() updates port->tty_icount.{cts,dsr,rng,dcd}
> while interrupt_handler() holds dc->spin_mutex, but ntty_tiocgicount()
> and the TIOCMIWAIT snapshot/compare loop in ntty_ioctl()/
> ntty_cflags_changed() read the same multi-field struct with no lock
> at all. A concurrent update can be observed mid-copy, and KCSAN flags
> the unlocked access.
> 
> Add ntty_get_icount() to snapshot port->tty_icount under
> dc->spin_mutex and use it at all three read sites, matching the lock
> already used on the update side.
> 
> Fixes: 20fd1e3bea55 ("nozomi driver")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/tty/nozomi.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

You forgot an Assisted-by: tag, right?

And how did you test this?


> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index ed99dbc9f990..4b2e224c0aa2 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -1671,10 +1671,23 @@ static int ntty_tiocmset(struct tty_struct *tty,
>  	return 0;
>  }
>  
> +static struct async_icount ntty_get_icount(struct port *port)
> +{
> +	struct nozomi *dc = port->dc;
> +	struct async_icount cnow;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dc->spin_mutex, flags);
> +	cnow = port->tty_icount;
> +	spin_unlock_irqrestore(&dc->spin_mutex, flags);
> +
> +	return cnow;

This is text-book LLM-written code as they do not know how to write
"modern" Linux kernel code.  Please fix.

thanks,

greg k-h
