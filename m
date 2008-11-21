From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Fri, 21 Nov 2008 18:29:28 +1100
Message-ID: <20081121072928.GA14179@yookeroo.seuss>
References: <200811201501.24000.arnd@arndb.de> <20081121003545.GC13049@yookeroo.seuss> <20081121072101.GP24487@codiert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:40084 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbYKUH3j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2008 02:29:39 -0500
Content-Disposition: inline
In-Reply-To: <20081121072101.GP24487@codiert.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Krill <ben@codiert.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Nov 21, 2008 at 08:21:02AM +0100, Benjamin Krill wrote:
> * David Gibson | 2008-11-21 11:35:45 [+1100]:
> 
> >
> >Uh.. registers as port number 84??  What's this random number about?
> >
> It's just the next free number in serial_core.h.

Ah, right, sorry, those are type codes.  Thought you meant it was
registering as /dev/ttyS84 or something similarly strange.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
