Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBA237A4F;
	Sat,  9 Aug 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751424; cv=none; b=VB0ynQJZfD/YyyUBKIBzOj36nzLP0ye8NBr6tMQJpY3gsahSpAVq8nmINyWWKvszJHZr1OaeIRRqDrTkrLvu59PTZHBAYP23LG4fNGYIOhVLzCBMs4yUEXl9hCWtuy7eiTw18wN8aZi9qsXf0lvcuyZ3iHITlLJ5dXmC6fpuQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751424; c=relaxed/simple;
	bh=1OAKQsTVe7OvCel/EPZf6QTQkSAScXy5cG6EIWY0eGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D62Kx5OTwpN3fE/udsk5Z62wKG5duKhgi87cc5s1loKOIW1KAZFVN2gQ9sT5cIoZ9s93IfyJLT2RIXKfZ8tVmLQPOUKUV9Klz79Udac4SfOPSe1RzXjNveB2TyTmfm5YwJ/q5l6Dy6bZF7DQXiEkofvqEMXirVGKigBT7aes84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxeXbvnu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxeXbvnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AFC4CEE7;
	Sat,  9 Aug 2025 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754751424;
	bh=1OAKQsTVe7OvCel/EPZf6QTQkSAScXy5cG6EIWY0eGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wxeXbvnuhbc/NkEdfQ9E0qwiP7zl+z1lDyJ9XmrEOrqU8fnBTq8lciC4K94erLmfq
	 uY7ew5vNV2uTJSVlCPfd0Rk3FXZ3eR21YGSQnxZhZPhk2t2yd0IHWVjCeud6HeBMyh
	 3Q3yD9rMLQjNcwNpTWQAsYEtUng8xgcAs3YuFxm0=
Date: Sat, 9 Aug 2025 16:57:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
Message-ID: <2025080937-hardly-facial-cde0@gregkh>
References: <aJdf0rAZ5x5klUhX@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJdf0rAZ5x5klUhX@kroah.com>

On Sat, Aug 09, 2025 at 04:48:50PM +0200, Greg KH wrote:
> The following changes since commit 89748acdf226fd1a8775ff6fa2703f8412b286c8:
> 
>   Merge tag 'drm-next-2025-08-01' of https://gitlab.freedesktop.org/drm/kernel (2025-07-31 21:47:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1-2
> 
> for you to fetch changes up to 55a984928bfa30c7877e28f16910e6de1c170f1f:
> 
>   Revert "tty: vt: use _IO() to define ioctl numbers" (2025-08-01 10:42:22 +0200)
> 
> ----------------------------------------------------------------
> TTY revert fix for 6.16-rc1

And, as proof I shouldn't send pull requests a few mere hours after
getting home from a week long vacation, I got the version number wrong
here, it's 6.17-rc1, but the tag and the text all are correct, this
affects your tree now.

So much for being relaxed...

greg k-h
