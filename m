Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D47397E73;
	Fri, 17 Jul 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285603; cv=none; b=oddA6HTU0Y07vc2q5tgSqRx00EfQQBx5uFW03mZxsWkPaFkjh/SNCnKiFeN1OmHSeXWGu+ZJjEJToVb88yp8hviWbffTZoHJ0hnk1F/H0dbk1TPItbxAWRpS5cd5EcaWzTYl9NqAI8FY++5no7cYknForO5rnQa5Aw+ePfhyCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285603; c=relaxed/simple;
	bh=GKN5VVcuBqCXrjhhKcfbQ84IekZUa2rtK02AObXtkmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPFbTI8qbFSwQtL0U8JGLOVFIcnEymvAzRj41r9P8tnOMRLzK6n8QtS87wqWKQzc70EsCtvN0yopaDAW2EoJuT/uptn/y3To4dZpAn/Q2wvygs7YIArUiRfy3Qv7lL6Bo7G34x1EXyYZU4sOqLxtWs0NqSV4DgeKnQr8VEHLAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdX8dyO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdX8dyO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629F71F000E9;
	Fri, 17 Jul 2026 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285601;
	bh=40g+KPjHxOh7egIEMtuae1UAJa3qXshJTrSRlAwhF14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FdX8dyO2DkaWQE9CrHUdUw3/9wu+4qHTLjBi1FSGOv1bWvGW46gc8xnG5TdU7wN5G
	 3Mmviy46CxGwLXYyYoSbnHyJRTOioD0kJ4unfD/eABnq9W/zbfHc25i7kveVNxUq5Q
	 vr6oVCrSU6/0Lk2ccPiD5pnlGtsUTwaV3G48iL3s=
Date: Fri, 17 Jul 2026 12:53:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: jirislaby@kernel.org, socketcan@hartkopp.net,
	linux-serial@vger.kernel.org, mkl@pengutronix.de,
	linux-can@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Message-ID: <2026071718-yearbook-bloated-48ce@gregkh>
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

Ah, but look at the review at:
	https://sashiko.dev/#/patchset/20260716064719.1401892-1-yun.zhou@windriver.com
which says:
	Does unlocking the semaphore while the ldisc pointer is NULL introduce a UAPI
	break for concurrent operations?

	If a concurrent process calls read(), write(), or poll() during this unlocked
	window, it can enter tty_ldisc_ref_wait() in drivers/tty/tty_io.c. Because the
	semaphore was unlocked here, tty_ldisc_ref_wait() will successfully acquire
	the read lock but observe tty->ldisc as NULL.

	This causes the reader to immediately return EOF or -EIO, potentially
	aborting userspace applications unexpectedly during a line discipline
	transition.

Is that not true?

thanks,

greg k-h
