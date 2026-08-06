Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48D41F5D4;
	Thu,  6 Aug 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013689; cv=none; b=TH72bnVhVwFiFZYy83oRqC3jWloN97ljutLpBdfPx8cj16QGn1DLunVg9QrhJHhKPAuQKvFIcGCZ2g9W8413RknGO5La3ACKeYMfjhyZFyOwEUFvzHp2NmNYeJrh9xmmsYddGlWUz0sSuyNzm74Y4P2qqT/Xx0BOASfq+BcQApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013689; c=relaxed/simple;
	bh=aYNTk2DyqmjHoaJWEdG8hZUEWF+Ex8IU0dNQqNCeytU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OFVVywtxXk+2l6zPikflDa1evunPcy+FVjbmtwV1tCJ0/fzTr+jwA/aCjLkkTwwbBS4aD04TM1l7UJIPM3zXwbQBZHBI/BLgTmCdWvjJWtmeOXGpIFAdQ+Tx9WC6svnc9SB6kq4ybaMx5o3MJ5C7uNztzGVTHSoULuuyGy4U23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A0D7492009C; Thu,  6 Aug 2026 12:54:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9A7DF92009B;
	Thu,  6 Aug 2026 11:54:46 +0100 (BST)
Date: Thu, 6 Aug 2026 11:54:46 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] serial: sb1250-duart: Convert to use a platform
 device
In-Reply-To: <2026071045-turmoil-daytime-f8f8@gregkh>
Message-ID: <alpine.DEB.2.21.2608020045050.55540@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk> <alpine.DEB.2.21.2605241625180.1450@angie.orcam.me.uk> <2026071045-turmoil-daytime-f8f8@gregkh>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jul 2026, Greg Kroah-Hartman wrote:

> > Conversely only starting the console port so late lets the reset code
> > fully utilise our delay handlers, so switch from udelay() to fsleep()
> > for transmitter draining so as to avoid busy-waiting for an excessive
> > amount of time.
> 
> That's a different thing than "convert to a platform device" why are you
> mixing this up?

 With the move of this code to execute past the initialisation of the time 
subsystem (a consequence of converting to a platform device) retaining 
udelay() would introduce a functional bug where this busy loop would hold 
onto the CPU rather than making it available to the scheduler.  The bug 
would then have to be fixed with a separate change.  Perhaps I didn't make 
it clear enough in the change description.

 That said I investigated this situation further and I think this should 
have been implemented differently in 1/6, because pre-3/6 this code is 
executed early enough that even udelay() does not work correctly, since 
BogoMIPS haven't been calculated yet, and consequently line corruption 
remains.  Conversely when this code is executed late, such as in the 
non-console or even modular case, using udelay() is the very same 
functional bug.

 So with the rewrite in v3 I've come up with two variants, one for the 
early-boot case and the other for the late execution case, and then with 
the conversion to a platform device the early-boot case becomes dead code, 
the removal of which hopefully will raise no controversy.

 NB a similar approach should have been taken with commit ca904f4b4235 
("serial: dz: Fix bootconsole message clobbering at chip reset").

> > Since there is one way only remaining to reach sbd_init_port() now, drop 
> > the port initialisation marker as no longer needed and go through the 
> > channel resets unconditionally.
> > 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Cc: stable@vger.kernel.org # needs to use .remove_new for <= 6.10
> 
> The first 3 patches in this series are cc: stable, the rest not, which
> is a mix I don't really know how to handle.  Please break things up into
> series that can go for this release, and those that can wait for the
> next onen (i.e. fsleep() stuff).

 I gather this is because you merge via different trees depending on 
whether a change is to be backported or not, right?  In any case I guess 
the other fix from the set can wait a couple of months until this has 
propagated.  And I'll post the MAINTAINERS update right away.

 Thank you for your review.

  Maciej
