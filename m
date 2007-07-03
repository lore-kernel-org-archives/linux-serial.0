From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] genericserial: Remove bogus optimisation check and dead
 code paths
Date: Tue, 3 Jul 2007 16:26:55 +0100
Message-ID: <20070703162655.6a001fdc@the-village.bc.nu>
References: <20070703152021.6eb8013d@the-village.bc.nu>
	<468A5F89.70900@sourcepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56576 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753738AbXGCPUp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 11:20:45 -0400
In-Reply-To: <468A5F89.70900@sourcepoet.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Morten Helgesen <morten@sourcepoet.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 03 Jul 2007 16:39:05 +0200
Morten Helgesen <morten@sourcepoet.org> wrote:

> Alan Cox wrote:
> 
> [...snip...]
> > @@ -75,11 +64,11 @@
> >  	if (! (port->flags & ASYNC_INITIALIZED)) return;
> >  
> >  	/* Take a lock on the serial tranmit buffer! */
> > -	LOCKIT;
> > +	mutex_lock(& port->port_write_mutex);
> >   
> 
> ^ Contains additional whitespace.


Its an old driver, it doesn't follow the coding style too well at all -
viz stuff like if (! ( the line above. Given its age and limited userbase
I don't plan to go and make it conform either, but I will take patches
for the formatting (and the spelling errors it is full of) from someone
who wants to do the work.

Alan
