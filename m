Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07244228CA9;
	Sun, 15 Mar 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773557892; cv=none; b=f02dzwtw+1Zm0M+kPl8csWae/T0mIUksuhXogaHVmyU0F30NNZVxwW+omWCMBoUw3dw4Mi2GjMdb0MkJbtQZcXhfXFgx5WHkgOCKx98k/dR3KqD/eHfNyzwhW5/l+kj2DhJa5XmG4BVauHraibxKWB1v4+7Dxvi0YHyRhmsYi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773557892; c=relaxed/simple;
	bh=xbyEnXpRIITOclYYWapQ/bu/0K7k82mxcwgv2kc6TH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNzWnqoZIUSzmzUejlo73ShtiQOJEFQ/XgdMy+9BeymQE3/e0QSA1dkSyaViJr1SoEKuhQJRGMs+tVSmAri1l6De4ehRqwZ0XdcjFhXPL4GK+GAMhVFGqjafC/ORjyXviZKLYRrVnL6lAfbsqqvmSJLVFTg9tMbdjqz/ud8nziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrcqcWs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrcqcWs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261A6C4CEF7;
	Sun, 15 Mar 2026 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773557891;
	bh=xbyEnXpRIITOclYYWapQ/bu/0K7k82mxcwgv2kc6TH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zrcqcWs5a1vTKftkCbjISaq2fNu5kSVf2jpL0XTT/UOe9F8mhDc6BCJKzdrZ99ITh
	 ABYmspnc37x8EFORTqV7MBzu/sLuSaA6G0rD5riSQZ+hr9Cq0cpbjGU62AXApSD91+
	 x3M0UZoUjdu0R0Pcni66DF2YxDlyo4Empe3nAcgc=
Date: Sun, 15 Mar 2026 07:57:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] n_tty: add null check for tty->link in packet mode
Message-ID: <2026031501-recolor-runaround-0ed5@gregkh>
References: <20260314221044.148442-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314221044.148442-1-osama.abdelkader@gmail.com>

On Sat, Mar 14, 2026 at 11:10:44PM +0100, Osama Abdelkader wrote:
> Add null check for tty->link before dereferencing in n_tty_read and
> n_tty_poll. When the pty master closes, tty->link can be NULL while
> the slave is still reading, causing a null pointer dereference.

How can that happen?

> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/tty/n_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index e6a0f5b40d0a..dc04b87364f6 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -2232,7 +2232,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
>  	add_wait_queue(&tty->read_wait, &wait);
>  	while (nr) {
>  		/* First test for status change. */
> -		if (packet && tty->link->ctrl.pktstatus) {
> +		if (packet && tty->link && tty->link->ctrl.pktstatus) {
>  			u8 cs;
>  			if (kb != kbuf)
>  				break;
> @@ -2444,7 +2444,7 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
>  		if (input_available_p(tty, 1))
>  			mask |= EPOLLIN | EPOLLRDNORM;
>  	}
> -	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
> +	if (tty->ctrl.packet && tty->link && tty->link->ctrl.pktstatus)

What happens if link changes right after you test it?  Where is the
lock?

And what changed to cause this to show up now?

thanks,

greg k-h
