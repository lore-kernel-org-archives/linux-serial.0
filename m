Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687337F9;
	Mon, 23 Dec 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976623; cv=none; b=iSvCBfCBZN3WpuLHn7f44HeiQCkRHzBsnIOsKuOIL5cc7exYyl0UNEXo+BA3fhT+4I/XRxWOMsysPFJx1VU7kBpsWVPMwS0kZGfVaKCAMZu1qCvAQu8UmYD4VzhHH5YH0KVrSJHRMKg0aAixQHidjDwhuDyrfS3iiJc99YytfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976623; c=relaxed/simple;
	bh=1sVDnCZxNd+IH4vZjOKnIF51C2T6rhb5KOFObEuXL78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMcKA2baG641vPv55XYaKSiimdD5CxJAKt2yXY46phmG6Kg1+vYnAoV9oB67U8YT5wxyipuF8CGaOtilPdNeh/EeJjKsfaIDqXopY6Au6HihYkuUjwESY7uXy2Kbdsu+pRo6zKpISvUZa8HaZSUJnaT/Hgl4S10wrrayO6C07uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SIuJqZv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SIuJqZv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282DC4CED3;
	Mon, 23 Dec 2024 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734976622;
	bh=1sVDnCZxNd+IH4vZjOKnIF51C2T6rhb5KOFObEuXL78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIuJqZv94z0fx/u7Hufjc+p7LUwhXi2TgUdNFA/bREC/e75vcx+RBnNxcF2Kk3LyA
	 Gpkwv1mdoFj1uRH9z41cNmSuwPktb+370+OTiJ2UkTdCPeNL6pm9wq8bJ++2Ep3jV5
	 /KVLQg9aN+kCHRL0EgfYd3iCdOGNyUEbpPHc9zUU=
Date: Mon, 23 Dec 2024 18:56:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gil Pedersen <gpdev@gpost.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/1] tty: respond to TIOCGWINSZ when hung
Message-ID: <2024122329-jockey-delouse-71a7@gregkh>
References: <20241121111506.4717-1-gpdev@gpost.dk>
 <20241121111506.4717-2-gpdev@gpost.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121111506.4717-2-gpdev@gpost.dk>

On Thu, Nov 21, 2024 at 12:12:54PM +0100, Gil Pedersen wrote:
> Userspace libc implementations of the isatty() POSIX system interface
> are currently unable to reliably determine if a fd is really a tty when
> it is hung.
> 
> Specifically glibc libc returns the success status of a TCGETS ioctl.
> This will return an incorrect result when the TTY is hung, since an EIO
> is unconditionally returned. Ie. an isatty() will return 0, wrongly
> indicating that something that definitely is a TTY, is not a TTY.
> 
> Userspace implementations could potentially remap EIO errors to a
> success to work around this. This will likely work in 99.99% of cases,
> but there is no guarantee that a TCGETS ioctl on a non-TTY fd will not
> also return EIO, making the isatty() call return a false positive!
> 
> This commit enables a specific non-driver, non-ldisc, ioctl to continue
> working after the TTY is hung. The TIOCGWINSZ ioctl was chosen since it
> is readonly, and only access tty_struct.winsize (and its mutex), and is
> already used for the isatty() implementation in musl. The glibc
> implementation will need to be updated to use the TIOCGWINSZ ioctl,
> either as a direct replacement, or more conservatively, as a fallback
> test when the TCGETS ioctl fails with EIO.

This is a fun "hack", yes, but now you are encoding an odd "side affect"
into the system that everyone is going to rely on, well, eventually rely
on.  What code needs to be changed in userspace to determine this?

Why not just have a new ioctl that tells you if the tty really is hung
or not?  Why does isatty() need to know this, does POSIX require it?
And if it does, what does it say the ioctl command should be?

thanks,

greg k-h
