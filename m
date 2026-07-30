Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD083446BEB;
	Thu, 30 Jul 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428427; cv=none; b=ttU3e5Ki8jpKyay1E5rHQkGlETMKt3YIm3NsGqej5RoNYTDrAHIFkH6XJ39Qiu4D6xVHlFGfpaHNclRsYSrKZatMKvusKS6+tGtfypGr+MmQt5sQpGoV43H5vK8KsYCCdLMJ+JuDO6VdWaFLVAkA/oEMvAMBefcpHs1p6QFEaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428427; c=relaxed/simple;
	bh=7kQaVcZWAjdDsBUtk2x0Tjc/P794gFThT6IdoYljb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAin1hiPghWxKqiXx4a8N5+WURdX9hdnk43IcJEU19VFuMg+BsTrMf06JL5m1qyOOdXR1TiNhDwxCnJuBjfCBSk/RgDd2AbXuZFGrjiq90lkJEBFkXaI1mjASN4VOhGYaN/y6Rn4qpV3/4mGLfuZKmsrM4PiTrJCQDhDXiWsTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5kdi3HH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5kdi3HH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24211F000E9;
	Thu, 30 Jul 2026 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428426;
	bh=/4oNgarC/98qWuR+AyyaCO3AdfMypG6g5lOZJYx7xdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z5kdi3HHzVN7keKI/1OQL1XgX8LCdqgEaENqjpq716OxVTwgbG+4EVwLa1Tfy2E2c
	 Cn/aRwi5BlSI9R5T9egDLSXXiQJs2M+5Uh+UrnhtMUUDuWleaD3wn6VdSVOM4rdFYi
	 7M3k5kR1xynJir3FheJW+1dMiSQowz8kvwJZDkHE=
Date: Thu, 30 Jul 2026 16:50:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: jirislaby@kernel.org, socketcan@hartkopp.net,
	linux-serial@vger.kernel.org, mkl@pengutronix.de,
	linux-can@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Message-ID: <2026073027-nervy-imposing-0068@gregkh>
References: <20260724084648.3879356-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724084648.3879356-1-yun.zhou@windriver.com>

On Fri, Jul 24, 2026 at 04:46:48PM +0800, Yun Zhou wrote:
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
>  - tty->ldisc is set to NULL during the window. tty_ldisc_ref_wait()
>    waits for the transition to complete. tty_ldisc_ref() returns NULL
>    which callers already handle.
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

Sashiko has some comments:
	https://sashiko.dev/#/patchset/20260724084648.3879356-1-yun.zhou@windriver.com
are they correct?

thanks,

greg k-h
