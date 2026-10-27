Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093144;
	b=Ri/iTUNKnByVyDNXOM5vTvYFn84LGECVXNqpl8EgZUNCLbUuNUUZ9SyZYNGcH6rs/Ev2
	 +KI7Ms1ZEMv9Z7OqTS/6YgCz9bDFbP/xzv1zELXUeIAmi6SGowX1/vLVTMLnxDOQyjr8l
	 4jzx7cb2D3Hvf22BxbShXDYnCofQ1glPbuYLFU91/AxvnRiFrkvkO4KbzcUoi1Jd0N1HN
	 626PPbVmDtU6dAm1PejKKC93RZXmQ1+dY/wr3h6rvPY3XYtmnWKtJfEv2SKbwggwavpaL
	 jXu2Rm8VPIK0LmgRGQysDGqJkLPUGf6yTOoptWiUkDYZYCGHKTM1ka1H58w8mRuVitw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093144;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PGLUc6PoI9eQZV15cQ2xkxEEdrT7oJyL2uhKIJClys0=;
	b=azrQHhSJDsoOZ/vLdDYENn9AqWLkbZeR3t5Ow6fDfLBK0TpII4aMs0hy0L399+qWNGjn
	 3ElDU3kjXhP5f8QcgMq7IlhGut/Z6Pz1nn3HzYw9Sj/Vsm1yx0x8GGfk10L6iAANPj20n
	 lN5SKCMCwT0YxealG4sIWZANccxHNnkTJjNzbCv22YZ24yRY48/AWlRTeggFNAH7TsVZb
	 6a7aeWydPmqoPGdgslqmFKKhMZEgwwah6CZHiD6v7/tniXWzi7ZOPTv3LFdcI7XitRVol
	 FdiodSGvFnRLoXLE5C8FYplc9+6bRaHyPGysBNHUDU53S6P4lIxLg1D8Mc1k7ZlMFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oTx8Dg4N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C7606A31B;
	Tue, 27 Oct 2026 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oTx8Dg4N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4211F01825;
	Tue, 27 Oct 2026 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793093143;
	bh=PGLUc6PoI9eQZV15cQ2xkxEEdrT7oJyL2uhKIJClys0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oTx8Dg4NZJVJx1SkbjZCoDSYkgKTHqSydoZGFzNE77MNKWHnXFY8LIgQGRvEuCfhA
	 +QU+YzxE/b7ZT0CCk2JdZR2XNAvySQvEykr0scsFTCtY/sYpjEFBkUDCZpWXz7e+tt
	 gJVhmGIkJaHFBJTNJnAiAGfNTQH8wgQ6eP7MV52E=
Date: Tue, 27 Oct 2026 10:25:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
Message-ID: <2026102704-exploring-tipping-354d@gregkh>
References: <20261027054304.35543-1-dennylin0707@gmail.com>
 <2026102711-venture-amicably-24c7@gregkh>
 <CAGEkeHePGOKXsHg-bqkJH4Dpn=OSxTQx8z5vbjW18uSWHqrpWA@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEkeHePGOKXsHg-bqkJH4Dpn=OSxTQx8z5vbjW18uSWHqrpWA@mail.gmail.com>

On Tue, Oct 27, 2026 at 01:21:20AM -0700, Hungyu Lin wrote:
> > What commit id does this fix?  How was this tested?
> 
> The missing flip-buffer flush is already present in 1da177e4c3f4
> (initial Git import). I could not identify its original introducing
> commit.
> 
> Tested on ARM64 QEMU: an 8192-byte PTY write leaves 4097 stale bytes after
> TCSAFLUSH before the fix, and none afterwards. Built the ARM64 Image and
> 32-bit x86 tty_ioctl.o with GCC 13.3.0, W=1.

So as this is "just how things work" what is going to break with this
change?  Why change this at all at this point in time?  What needs this
fix?

And how was this found and tested?

thanks,

greg k-h
