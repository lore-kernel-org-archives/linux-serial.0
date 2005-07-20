From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] 8250 PCI Serial driver not always disabling PCI device
Date: Wed, 20 Jul 2005 09:03:23 +0100
Message-ID: <20050720090323.A1864@flint.arm.linux.org.uk>
References: <200507200927.06500@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261273AbVGTID3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jul 2005 04:03:29 -0400
Content-Disposition: inline
In-Reply-To: <200507200927.06500@bilbo.math.uni-mannheim.de>; from eike-kernel@sf-tec.de on Wed, Jul 20, 2005 at 09:27:05AM +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-serial@vger.kernel.org

On Wed, Jul 20, 2005 at 09:27:05AM +0200, Rolf Eike Beer wrote:
> I found that pciserial_remove_one() only disables the device if it finds 
> private data. This looks suspicious to me. Patch attached.

Makes no difference.  If we don't have the private data set, then
we have errored out during the initialisation, and we disabled the
device on the way out.  Moreover, the exit function won't even be
called.

So we actually have the guarantee that there will always be private
data here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
