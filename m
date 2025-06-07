Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F6126BFA;
	Sat,  7 Jun 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749279290; cv=none; b=ThERZd0ytFLrJY5FWuIUqm70Z178DZVQ9vYVSwA7ysSQILYKQZtD7NuRHwwGYwxZKkcKbii5MZSR1zokXqfyUvmO+HfGNekrhVV1TNpQkBWxEyz4ovWF3DWZqDTOgXM4IKJKQDXl1SwX0860elXBHoIpL+914ka0RggWXQU74nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749279290; c=relaxed/simple;
	bh=QB03hVP+UjtMb1XR5EAgNqVDYDMA051gUu+cwvKTCps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0yN+meZoYioWsVcC2vQA4jJ1tM2LLVGYZxIwTnI1l+9j/FP/WpuiX9zh5C6YdPFKxkkjMOamXzkKuRLEbQcjwmij9ivaOxpp242w/ruKhXnY+kyp4+bBbK2BiCrSPX1iOW0cJeoZ9fqLj4eO5T86MlQhWbMsxis3lVKyRH2Shk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHR6MCyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHR6MCyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CC9C4CEE4;
	Sat,  7 Jun 2025 06:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749279289;
	bh=QB03hVP+UjtMb1XR5EAgNqVDYDMA051gUu+cwvKTCps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHR6MCyWfV7mJMUZeOJtd7CaYBYW8KqyB5JHCHHPARt6Yr7xC0Y3JBnDk930QxQuO
	 kQ7wzQVB+SZ17ZYtWvTv95lTew/up+Cp1M49mlplVB+FFEdLglkA4DWe+2Mh+iLFyQ
	 7+fC4Pnr1JUYeQKuMdOBXHWJOHx1wD29my/y2gKU=
Date: Sat, 7 Jun 2025 08:54:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.16-rc1
Message-ID: <2025060708-anaconda-usable-5ba5@gregkh>
References: <aEKpKk71YuLPPMZC@kroah.com>
 <CAHk-=wh3sbe9ZU_-q4Et=OWtedfFoB2tsZy_+ssMRZnsjApYhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3sbe9ZU_-q4Et=OWtedfFoB2tsZy_+ssMRZnsjApYhw@mail.gmail.com>

On Fri, Jun 06, 2025 at 12:36:53PM -0700, Linus Torvalds wrote:
> On Fri, 6 Jun 2025 at 01:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Here is the big set of tty and serial driver changes for 6.16-rc1.
> > A little more churn than normal in this portion of the kernel for this
> > development cycle, Jiri and Nicholas were busy with cleanups and reviews
> > and fixes for the vt unicode handling logic which composed most of the
> > overall work in here.
> 
> That series of "revert one series to re-apply the other" looks
> absolutely disgusting.
> 
> I was close to deciding to not pull this at all, because some of it is
> just inexcusably stupid. Lookie here:
> 
>   git diff d066989a3d41..d066989a3d41^^
>   git log -2 --oneline d066989a3d41
> 
> and just stare in wonder at the pure unadulterated garbage.

For some of the patches in the beginning of the series, yes, I could
have tried to figure out which ones matches up and had Nicholas respin
things, or picked through and seen what was identical as you show above.
Using b4 made it easier for me to just revert the original series and
add the new one without digging through them.  In the end, the overall
diff between the two series was not trivial:

$ git diff --stat cb0ce93c8ba6882c591e7776a258cfd483af5717..c2d2c5c0d631f7de9697870e4eec89289177d445
 drivers/tty/vt/Makefile                                             |  29 ++++++++-
 drivers/tty/vt/{gen_ucs_recompose.py => gen_ucs_recompose_table.py} | 122 +++++++++-----------------------------
 drivers/tty/vt/gen_ucs_width.py                                     | 336 ---------------------------------------------------------------------------------------------------------
 drivers/tty/vt/gen_ucs_width_table.py                               | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/ucs.c                                                | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/{ucs_recompose.c => ucs_recompose_table.h_shipped}   |  88 ++++------------------------
 drivers/tty/vt/{ucs_width.c => ucs_width_table.h_shipped}           | 111 +++++------------------------------
 drivers/tty/vt/vt.c                                                 | 101 +++++++++++++++++++-------------
 include/linux/consolemap.h                                          |   4 +-
 9 files changed, 610 insertions(+), 647 deletions(-)

I blame this on me taking the first series too early, and not waiting
for Jiri's review, and defering to Nicholas which he wanted to do as it
being my fault here, not Nicholas's:
	https://lore.kernel.org/all/2EDC209B-7D6B-4EFB-ADD0-58D494D8AF98@fluxnic.net/

Anyway, thanks for taking this, yes, it was a mess, sorry, this was my
mistake.

greg k-h
