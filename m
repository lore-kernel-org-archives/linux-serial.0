Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261401;
	b=AzV7FchfgHDmhB/591ygpz4iQ2amBS0jXP/dJkHKiYTmrMH8gPnCK5rXZqPhXZEZG3oh
	 igPRvlvXSBkJIEwgkLnUeUx4WeqczV2ZgaAQsalOGCR2CEdYGaMjSK4nNP7gqg9XMH1Tt
	 kdfnT39klXCFGySY8jREFGoBF/GHAfs5z5SyKQP++ZN0l2lWNO+28zC7zOFN7NuTLBATv
	 EqavQa4+xKGmXxqpzZiByfSpy7GpZx0gWcedTAGkWPLcWh4yd0+dxw1xkWsi9vQcCuL1I
	 xmxqVPSI9fcYyclDlIeeCPIPR8rKyMhydd8zGHv+AiY4/HVJKE11tgK8PuF/ecqEQSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lqsKS5fffOfClnlwODzMU4wTU7v1TYqB6Y/mtnJXzQE=;
	b=NI6+gtLiV2r5OWy3+8L9kfvwIefw9A6OyA7J1wIytLy8p+hfxcM96Ry0Sx7RKcCieR/B
	 RAh+iRVlm+yNRbKn/prcUiOsmF32UpXF7AkVAbAelA4frKFLD9AVRbMTXuCcsCQ3iDeVm
	 w7UacuuQF6qSz2LrkwHe+Gtp1DYNU1lmcyq9OEwR8AsveKblPgUZaAulVfsMN0L3+UxYR
	 LXMewpxl+9y3kYuqB588wryAg4W8wqjZ5TlywlvWVWMshRm6cLT3uk4og6vIX1t1nowVN
	 JxcVwkYHL7L97G1h/C3faioBsJMjXT029m4PthwIYToTOxByUyN3dXpBvNxvCw9L2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vvioKGLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC56606A31C;
	Thu, 29 Oct 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vvioKGLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8691F01825;
	Thu, 29 Oct 2026 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793261401;
	bh=lqsKS5fffOfClnlwODzMU4wTU7v1TYqB6Y/mtnJXzQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vvioKGLsoW4C0kAy2u6QKmPd89jB5ST6ddpef+dwgr5KhhwnQ6uXYS8/q0HUkFrLR
	 lzZVVYIZatv9xXRKPegL/TLmIiH5HRYdICjkIpl6CKZUlgQk1fAtlvmSxNHDOy4OFM
	 h4MScMAI79y8J4e9wnJayemu+GZxEWCoQ7QrVc10=
Date: Thu, 29 Oct 2026 09:09:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
Message-ID: <2026102915-trailside-easiest-08fa@gregkh>
References: <20261029002052.54117-1-dennylin0707@gmail.com>
 <2026102957-suitable-gesture-be83@gregkh>
 <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>
 <2026102930-underwire-manmade-8083@gregkh>
 <CAGEkeHfTRiRmb-SpLUZeBkUrmRmq-bHLhD=CWnqsrvpbnymuYQ@mail.gmail.com>
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
In-Reply-To: <CAGEkeHfTRiRmb-SpLUZeBkUrmRmq-bHLhD=CWnqsrvpbnymuYQ@mail.gmail.com>

On Thu, Oct 29, 2026 at 12:52:59AM -0700, Hungyu Lin wrote:
> > Ok, and has it ever reported problems with this rounding error?  This is
> > very old code, changing it needs to be done only if an issue is actually
> > noticed as it might be relied on, right?
> 
> I don't have a report from users of those systems. I found this by
> inspection and reproduced the early timeout using PTYs under QEMU.
> 
> For comparison, FreeBSD's original VMIN/VTIME code keeps the timeout
> in microseconds and rounds the remaining interval up when
> converting to ticks:
> https://github.com/freebsd/freebsd-src/commit/d32198f15b39a0f6dc29229ba4925d67d136956e
> 
> I understand that this doesn't rule out applications depending on the
> existing Linux timing. Would you consider the conversion correction
> worthwhile on that basis?

Unless you can prove that this is causing a problem, I would suggest
leaving this as-is please.  Modifying user-visable behaviour is very
tricky.

thanks,

greg k-h
