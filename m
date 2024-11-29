Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB9155345;
	Fri, 29 Nov 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876297; cv=none; b=HCs2WqGtT/H3nQEhLi+QNIHUK+pt3v0i2Qn3rJCUg4FplovxSXIqBB64S7cwtrEI6fCzBk+yWYXHM6LTnkzCVSQMX8WV7kC8TzBjYliXMtmH5P8QnBHe86pB6uyLk1YEmyu8KInr49aF6S+30kz16TCnjxxn6G2rrwNSSlD81Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876297; c=relaxed/simple;
	bh=MUdsKdFNC83pwHZ9ib2CZlfuQfxhnj+kbQUat1E5wE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riaEJlvaFl98Gmti1DUnx6mHh2eJwJCO3rmTMq9pidrQqiacSVKJXKT/kba27ZbcmMiI1RP49zRs+uPYhKz3Fthh6FmnrfEyHDRpStY62XmmbeCNctIToU/GKWDZlChnRxDHAdg6OZKiJ90sdmhotoXd8Xm9AFtDB53fCZWUyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+m9uV1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+m9uV1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0785BC4CECF;
	Fri, 29 Nov 2024 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732876296;
	bh=MUdsKdFNC83pwHZ9ib2CZlfuQfxhnj+kbQUat1E5wE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+m9uV1/FgmolhDcHAXkd3PB7YHfVq83UHqoh2AsOOZhVg14P0nyh/sy1ZbP3IOpl
	 dU2sierdu9d30cBDAXYCWERvGlW9iEhGTslZ04JvT3r3+AQB+Lf4gtbrYqRFlTq/Nl
	 fdajsldQZc1lqtnAGiCxkHT3YbIUcNy7l4lbQNqM=
Date: Fri, 29 Nov 2024 11:31:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
Message-ID: <2024112952-headphone-vastness-3814@gregkh>
References: <Z0lCihhE75lE9Zjd@kroah.com>
 <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>

On Fri, Nov 29, 2024 at 08:58:28AM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, Nov 29, 2024 at 5:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:
> >
> >   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1
> >
> > for you to fetch changes up to b5a23a60e8ab5711f4952912424347bf3864ce8d:
> >
> >   serial: amba-pl011: fix build regression (2024-11-16 09:52:55 +0100)
> >
> > ----------------------------------------------------------------
> > TTY / Serial driver updates for 6.13-rc1
> 
> [...]
> 
> > All of these have been in linux-next for a while with no reported
> > issues.
> 
> Oh, how do I love this boilerplate...

I hand-craft that every time :)

> > Claudiu Beznea (1):
> >       serial: sh-sci: Clean sci_ports[0] after at earlycon exit
> 
> "BUG: spinlock bad magic"
> https://lore.kernel.org/all/CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7Lrqv5dWZWYA@mail.gmail.com/

Ah, yes, sorry, missed that.  I assumed that it would be fixed soon, do
you want me to revert it instead?

thanks,

greg k-h
