From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Fri, 21 Nov 2008 11:35:45 +1100
Message-ID: <20081121003545.GC13049@yookeroo.seuss>
References: <200811201501.24000.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38160 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbYKUAfv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 19:35:51 -0500
Content-Disposition: inline
In-Reply-To: <200811201501.24000.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Benjamin Krill <ben@codiert.org>, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Nov 20, 2008 at 03:01:23PM +0100, Arnd Bergmann wrote:
> From: Benjamin Krill <ben@codiert.org>
> 
> This patch adds support for the nwp serial device which is connected to
> a DCR bus. It uses the of_serial device driver to determine necessary
> properties from the device tree. The supported device is added as serial
> port number 84.

Uh.. registers as port number 84??  What's this random number about?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
