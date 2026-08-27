Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD436C588
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858614; cv=none; b=IJZM8iCi0jyTqyvacbFhM9x/wlKy5xtIhNSuO8hSSGHkwVxU159/8L23tGvLNvcuBXff/81KLVga22Qs0QXxtj1cM315HRQtrp5xMgxEAHt+xe0wZpx990l9XtseeWUWsRKNHt88f5IasCKHPcktvhytoMtPhjvhR5HNQWKNZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858614; c=relaxed/simple;
	bh=sJuobXBSZ212/N11LPCC3AWMDR+8fmUlzrVNIfK4kQg=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=mOg+4Dd1VWXA8tBkfId2ZCJIlTCEZoZgfZ5BD/KMP+EJmXGBJ8afs/uPvji2HFOgbyrw2sogyemy7je8+kpapXnhxPhzAAzWrdJSvmB7oVFpZTwBHfuBV4ddPRw08lqSdXlrdbdqpAWT9z8vYUlPEYQUPrfm/S3iPZuKQfytk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 43829 invoked by uid 3782); 27 Aug 2026 21:23:30 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 21:23:30 +0200
Received: (qmail 31421 invoked by uid 1000); 27 Aug 2026 19:23:29 -0000
Date: Thu, 27 Aug 2026 19:23:29 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <apCOsfuSYkaI8A1r@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022243-street-joylessly-6dfa@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

[ Following a break of ~18 months ]

On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 21, 2025 at 03:35:59PM +0000, Alan Mackenzie wrote:
> > 
> > Dear Linux Maintainers,
> > 
> > The Linux console is currently restricted to 256/512 glyphs, the VGA
> > standard from the 1980s.  I would like that restriction to be lifted, and
> > believe that many other console users would agree.

> First off, why?  What about the move to get rid of the vt code entirely,
> if you do that, can't you get proper glyphs with the drm subsystem?

We talked back then about kmscon.  It doesn't look to me to be a
suitable replacement for the Linux console yet, at least for me anyway,
for quite a few reasons.

> Doing huge changes for a subsystem that almost everyone agrees should
> only be kept around for legacy reasons is a rough undertaking.

> <snip>

> > I would very much like further to develop and to refine this code to the
> > point where it is suitable for inclusion in the mainline kernel.  What do
> > you say?

> Only you can decide what you want to work on.  If you have working
> patches, and submit them so that they can be reviewed, we'll be glad to
> do so.

I've just submitted a series of patches to a few mailing lists and
several people, including yourself.

> But again, you are going to have to answer the reason "why" first.

The main reason I don't like kmscon (yet) is that it has no key bindings
<Alt>-<Fn> to switch to a specific VT (or something analogous).  This
would make it unusable for my current work flow, where I have 20 tty's
running, and switch between them frequently using <Alt>-<Fn> or
<Shift>-<Alt>-<Fn>.

Even though kmscon has been included in some distributions (including
Fedora), I have failed to find any user reviews of it in a web search.
In particular, I'm looking for somebody writing something like "I've
been using kmscon for <n> weeks, and I find it delightful.".

> thanks,

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
