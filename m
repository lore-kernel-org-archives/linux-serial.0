Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD031AAE07;
	Thu,  4 Jul 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082963; cv=none; b=euGGUpGjizEqQQZFP5S4FjXNkncajIaz5w2Ksm7geMuhDAKUBO3y8juG68X4yPO+G4rNoxDorF6+jDqlCr3KNsQ/2CQVZM+3gxbqQVVp6IPwudcPy6Pkd8KE4wx+XyxO2/Lvqv69EoNUGiKs9LOTgLE75tHM8ho/wSk7tcu4Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082963; c=relaxed/simple;
	bh=WCn65WDtIvVPfu0INFIGmav3d54/SQMOxRtg1fEBkI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbQJkVy589gELIZM0GI+AMUQvD+moqoyn413+fYJ+ntotbWfH6jyQa5yfPwLshBvYpwal0mQSvTtIXsTXK5Pp3k21lp7iBuT0rHBFGz6eryAhnkTeB9/MCJ20k4XLN4UEQ/321LPPeCS1b3/kQGv87eyGt30JOpIwzvYbe5hmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WdarRZbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WdarRZbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B46C4AF0C;
	Thu,  4 Jul 2024 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720082963;
	bh=WCn65WDtIvVPfu0INFIGmav3d54/SQMOxRtg1fEBkI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdarRZbEP/CYPUxiXF0O8Z4/5Ujz+uZqRYppYk8+5sVqDLwqK5rtI3WN4VOVBUtrt
	 U08K/JUleyte7zPZYhGDCtmrcRuyoXW1xcCwM8Zm3EirR+LXYrpqRvJGUYQ7ybQt6c
	 lKUoIP5V6G7vJdUp//7CKqFISKoo9wnU4vAXo/6Q=
Date: Thu, 4 Jul 2024 10:49:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tuo Li <islituo@gmail.com>
Cc: jirislaby@kernel.org, baijiaju1990@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: fix a possible data race in gsmtty_open
Message-ID: <2024070411-unrevised-sash-927f@gregkh>
References: <20240704082658.189577-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704082658.189577-1-islituo@gmail.com>

On Thu, Jul 04, 2024 at 04:26:58PM +0800, Tuo Li wrote:
> In the function gsmtty_open(), the counter port->count is updated without
> holding the lock port->lock, which may lead to a data race.
> 
> This possible data race is found by an experimental static analysis tool.
> This tool analyzes the locking APIs to deduce locking rules about which
> variable should be protected by which lock. And then the tool checks
> whether a given variable access violates the deduced locking rules, to
> detect data races. The above possible data race is reported, when the tool
> analyzes the source code of Linux 6.2.
> 
> Referring to the function tty_port_open() in tty_port.c:
>   spin_lock_irq(&port->lock);
>   ++port->count;
>   spin_unlock_irq(&port->lock);
>     
> we add a lock/unlock pair to protect the access to port->count, to fix
> this possible data race.
> 
> Fixes: 86176ed90545 ("TTY: n_gsm, use tty_port_install")
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/tty/n_gsm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index be35f7334ecd..b709f1a6bd2d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -4307,7 +4307,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>  	struct gsm_dlci *dlci = tty->driver_data;
>  	struct tty_port *port = &dlci->port;
>  
> +	spin_lock_irq(&port->lock);
>  	port->count++;
> +	spin_unlock_irq(&port->lock);

Open counts are almost never a good idea, especially like this.  Please
fix to use a proper reference count instead which will fix this issue.

Also, you mention kernel 6.2, which is VERY old, especially for this
driver, please redo this against the latest kernel tree which has lots
and lots of fixes for this code in it since that obsolete release.

And finally, as you are using an automated tool, you need to describe it
better, see the documentation for how to do so.

thanks,

greg k-h
