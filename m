Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4734A3E;
	Tue, 17 Jun 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166505; cv=none; b=ZRIkdG8zqfVSp2zl7iaXt+L433/mB+gmIuSS0sXpIYkBSM5/PFQ7hCxJrm14T53nMuXFHn88jLtZN/VbT6IQYa09QEPT7Xiz1NmZOGM4jCvP7GwrcqxcbmF3vJ1q1ky9hCjYVHS0cQZo0g4zxeFWfGviNrvyOR7pMDfIpwIjZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166505; c=relaxed/simple;
	bh=gqSvXtD/LeDvjmtzmU0yBYcCrTeP+69NZfXtKjQMzwQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BstC/oomfU2Hl4rp58iS6SpS3OM8e6TJcVu4NNSCulj6GKRielg30urRHiCG7phoInM6nEQL8F8opt4YdYMVtLKRVPkWmn8ZNM3Ul1ve4z/s0O3CCZ5lYT1MV9MiBZG8ic2HSaemSNb4KZ+auRQgUWEmeW/fneeND0mXbevw9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5CEE092009C; Tue, 17 Jun 2025 15:21:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 56B6892009B;
	Tue, 17 Jun 2025 14:21:40 +0100 (BST)
Date: Tue, 17 Jun 2025 14:21:40 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/33] serial: 8250: drop DEBUG_AUTOCONF() macro
In-Reply-To: <2025061733-pushy-croon-08da@gregkh>
Message-ID: <alpine.DEB.2.21.2506171341570.37405@angie.orcam.me.uk>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-30-jirislaby@kernel.org> <alpine.DEB.2.21.2506171216090.37405@angie.orcam.me.uk> <2025061733-pushy-croon-08da@gregkh>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Jun 2025, Greg Kroah-Hartman wrote:

> > > DEBUG_AUTOCONF() is always disabled (by "#if 0"), so one would need to
> > > recompile the kernel to use it. And even if they did, they would find
> > > out it is broken anyway:
> > >   error: variable 'scratch' is used uninitialized whenever 'if' condition is false
> > 
> >  This is removing useful debugging aids.
> 
> How can it be "useful" if it's broken and no one has ever reported that?

 It's broken in a trivial way and would be fixed by a competent developer 
in no time.  If no one has reported the breakage, it means no one has used 
this code in a way that would trigger it, e.g. -Wno-error in effect would 
mask the compilation issue.  I'm fairly sure I used this code while making 
changes to the OxSemi Tornado backend a couple of years ago.

> >  The issue with compilation is related to commit 3398cc4f2b15 ("serial: 
> > 8250: Add IIR FIFOs enabled field properly"), which removed the assignment 
> > of IIR to `scratch' (although a path did exist before it that bypassed the 
> > assignment anyway), and can be trivially fixed by bringing the assignment 
> > back and moving the debug statement next to it.
> 
> So it's been broken for over 2 years and no one has asked for it to be
> fixed?

 Well, what can I say beyond the obvious?  That debugging a mature driver 
doesn't happen all the time?  This would typically happen when adding a 
new chip-specific backend, and I don't think new variants of 8250-style 
serial ports appear that often nowadays.

 You can argue one can insert these debug statements back if they need it, 
but someone already made this effort years ago, so why waste it?  To save 
a handful of source lines?  It doesn't seem a good justification to me.

> >  I agree that "#if 0" isn't very useful as it requires patching the source 
> > to activate; changing it to "#ifdef DEBUG" would make more sense nowadays.
> 
> No, dynamic debugging is the proper solution, not build-time stuff.  If
> you really need/want this, add it back in that way, not this old-style
> "let's rebuild the whole kernel" type of thing.  This isn't the 1990's
> anymore :)

 There's no need to rebuild everything, handing CFLAGS_8250_port.o=-DDEBUG 
to `make' only causes the named object to be recompiled.  I use it all the 
time, also to pass other compilation flags if needed (call me outdated if 
you prefer).

 Any kind of run-time selectable debugging would bloat the kernel binary 
unnecessarily for everyone, for the corner case of driver development or 
debugging.  Unless made optional at configuration or build time, but then 
we're back to the "1990's solution" with little to no gain over the local 
CFLAGS override.

 And if working on a piece of code, then rebuilding it sooner or later 
seems inevitable anyway, so what's the deal?

  Maciej
