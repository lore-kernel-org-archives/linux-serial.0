Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB0191F66;
	Wed, 21 May 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826830; cv=none; b=NA6ZOConc0YvGKmHCIRuG4/RCQj3eG0bA3aHniVqPJkKX29P/wayvb2BHMwXA68AagBC+VzpyRUgSu7jFB8WLckk3TE9DXbiR7KdVv7jj4W+tL7ULIOytwgW+g6JXpt7j4w58C/+tm4l2e6TpjYx6BGWM0Mu7vp8gccAuztHnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826830; c=relaxed/simple;
	bh=1tbe7hOaBRnZ6DRnlTl6S/1A0T/boVCPhktEG+J2VnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djGtPvzHLIJ6z1bHg0+2vJyIagLNwySP4I83yZaVlIgqv+NIuHB61FWXXtU33r6BZdrFIJX85EhWGEUgPmrHwsAy2TPDh1LDydQN/JRQ+KUg5x0hjc3GI3zqOUIRFYUGiBuva6ap10SrGx7hZy/w6DllYksvzlf9KQsz4TJdQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KCLALQLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KCLALQLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E7C4CEE4;
	Wed, 21 May 2025 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747826829;
	bh=1tbe7hOaBRnZ6DRnlTl6S/1A0T/boVCPhktEG+J2VnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCLALQLx1g1kLmFk2VhkuOsbZzJBdla48ppeL50+N0JS3BUvvbPiiZ06RJU/U5yTn
	 9O3kNjQzIHsBF8p7/OYXa61ETLDYJtD8VVLA+4OQdMIzw4pL+yKChs05v/9SEABhzg
	 DbI4PHgFhsszObjyk/MPUFLX5zGR1Z/ofxuLCpvM=
Date: Wed, 21 May 2025 13:27:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] n_tty: fix data race in n_tty_poll()
Message-ID: <2025052123-landmark-capitol-effb@gregkh>
References: <20250510163828.21963-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510163828.21963-1-aha310510@gmail.com>

On Sun, May 11, 2025 at 01:38:27AM +0900, Jeongjun Park wrote:
> I found data-race in my fuzzer:
> 
> ==================================================================
> BUG: KCSAN: data-race in n_tty_poll / tty_set_termios
> 
> read to 0xffff8880116b4d14 of 4 bytes by task 5443 on cpu 0:
>  n_tty_poll+0xa4/0x4c0 drivers/tty/n_tty.c:2452
>  tty_poll+0x8f/0x100 drivers/tty/tty_io.c:2208
>  vfs_poll include/linux/poll.h:82 [inline]
>  select_poll_one fs/select.c:480 [inline]
>  do_select+0x95f/0x1030 fs/select.c:536
>  core_sys_select+0x284/0x6d0 fs/select.c:677
> ....
> 
> write to 0xffff8880116b4d08 of 44 bytes by task 14547 on cpu 1:
>  tty_set_termios+0xf9/0x500 drivers/tty/tty_ioctl.c:339
>  set_termios.part.0+0x3bc/0x4d0 drivers/tty/tty_ioctl.c:520
>  set_termios drivers/tty/tty_ioctl.c:454 [inline]
>  tty_mode_ioctl+0x2db/0xa00 drivers/tty/tty_ioctl.c:807
>  n_tty_ioctl_helper+0x4e/0x230 drivers/tty/tty_ioctl.c:986
>  n_tty_ioctl+0x67/0x230 drivers/tty/n_tty.c:2509
> ....
> ==================================================================
> 
> In n_tty_poll() we are doing a read on tty->termios but we are missing
> rwsem lock, which causes a concurrency problem. To fix this, we need to
> add rwsem lock at the appropriate location.

Does this "concurrency problem" actually cause a real issue?

As the tools point out, your change will not work as you will have a
locking deadlock, which makes me wonder how you tested it?

thanks,

greg k-h
