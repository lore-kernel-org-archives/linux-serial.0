Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3891B29A7;
	Wed, 31 Jul 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442321; cv=none; b=dgZqbRoNnjDYtsNFWUJhTaPv3a/0Z81aVUcFvGJyWbEAVUiYWNgYj0w/IEz+zxRxQpfkEgCrc5s2oX3KOHauQ9Ieqky6TB3smyOxKiz2HLBl6oNor5OMNRxGZVb8qzCeRteQlwK803t88IWN56uMc1di7qKA6ZlMPoXQEshQRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442321; c=relaxed/simple;
	bh=J8+0BdMzW9w3bgW56LnCnV3YtGAu/FpwNHdrhS881jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS/aY16ZtUCTQKZhphlco3nQzc5+sJRmajD5IDrroMlw7bssI58dC9Gj2+KYnhKRkgqKIo1SU2FOVgKiCeTC73o4ohKcWDjwsbuoB2WxJM8PffdRHf4NP6PzVVTt2q5q7VQgkk4ZFWesnX6dpD2+3N/UPfPcuuxcguiWqo5NMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT1yLF3M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT1yLF3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08061C116B1;
	Wed, 31 Jul 2024 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722442321;
	bh=J8+0BdMzW9w3bgW56LnCnV3YtGAu/FpwNHdrhS881jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bT1yLF3MLMnjlPktS2xNQUG0NSi9QpaEuz0h2gSeBZ23PHnm1pSeKmK/1CkDZ9xtS
	 ve9nt5W1DNyUviXe5q5x1BPU/phHj7EiKCeJff/pM/N8cPjQswof626nwS3sa7i7Ia
	 JM0sqSr8UkzcsLC5on9tgjf+/e15+IglVeyGPktU2NMXzygxoTe0FJDi/wM9OA6wdv
	 weT4/Z/KzU5PXLghYcLJyys2VXBGV70ivl6AasWG+TErA0QG5oVNKTF4WTQbMMtYFb
	 +2EXZJddlvF5JkrMmOMYFatbSx26zo/HKwgAGCDqTeTdUhzV08jTd+OMNMV1ejAt7s
	 XlcxRZutSM7AA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sZBvv-000000003n0-23B7;
	Wed, 31 Jul 2024 18:12:12 +0200
Date: Wed, 31 Jul 2024 18:12:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stsp <stsp2@yandex.ru>, linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <ZqpiWy81owgsdscR@hovoldconsulting.com>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
 <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
 <2024072401-obtain-heap-6d8d@gregkh>
 <ZqDdDPF_N9tcbu_S@gondor.apana.org.au>
 <ZqDeTlq-1NP3dne_@gondor.apana.org.au>
 <2024073111-probe-endanger-cc8c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024073111-probe-endanger-cc8c@gregkh>

[ For some reason I never received Herbert's replies so I didn't see
  them until today. ]

On Wed, Jul 31, 2024 at 12:25:43PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2024 at 06:58:22PM +0800, Herbert Xu wrote:
> > On Wed, Jul 24, 2024 at 06:53:00PM +0800, Herbert Xu wrote:
> > > On Wed, Jul 24, 2024 at 12:15:39PM +0200, Greg KH wrote:
> > > >
> > > > -ENOTTY is the documented result of invalid ioctl arguments sent, I am
> > > > pretty sure POSIX requires this somewhere.  So this was fixing a
> > > > requirement here...
> > > 
> > > POSIX does not specify this at all:
> > > 
> > > https://pubs.opengroup.org/onlinepubs/9699919799/functions/ioctl.html
> > 
> > In fact it says:
> > 
> > If an underlying device driver detects an error, then ioctl() shall fail if:
> > 
> > [EINVAL]
> > The request or arg argument is not valid for this device.
> > 
> > [ENOTTY]
> > The file associated with the fildes argument is not a STREAMS device that accepts control functions.
> > 
> > Of course this is all moot since POSIX only specifies ioctl(2)
> > for STREAMS devices, but this patch in question is literally
> > going against the woring here.
> 
> That's going to be going against a lot of existing kernel code then.
> -ENOTTY is the default action of almost all ioctl handlers when the
> command is not a valid one, sorry.

This has been discussed at length before, and Linus made it clear that
ENOTTY is the right errno for unsupported ioctls, for example, here:

	https://lore.kernel.org/lkml/BANLkTi=6W0quy1M71UapwKDe97E67b4EiA@mail.gmail.com/

The tty code has been returning this since 2012 and commit bbb63c514a34
("drivers:tty:fix up ENOIOCTLCMD error handling") except for a few cases
that were missed and that I fixed up in 2021.

If this breaks real applications me may need to revert to EINVAL for the
affected ioctls however. Apparently, dosemu hasn't been
updated since 2013, but it looks like it indeed expects EINVAL for
unsupported TIOCMBIC.

Johan
