From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] IP22: fix serial console hangs
Date: Sun, 9 Jul 2006 20:59:37 +0100
Message-ID: <20060709195937.GB32457@flint.arm.linux.org.uk>
References: <87irm6naxt.fsf@frigate.technologeek.org> <20060709175841.GB24958@deprecation.cyrius.com> <873bdamxke.fsf@frigate.technologeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161101AbWGIT7o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jul 2006 15:59:44 -0400
Content-Disposition: inline
In-Reply-To: <873bdamxke.fsf@frigate.technologeek.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Julien BLACHE <jblache@debian.org>
Cc: linux-serial@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

On Sun, Jul 09, 2006 at 08:40:17PM +0200, Julien BLACHE wrote:
> The patch below fixes serial console hangs as seen on IP22
> machines. Typically, while booting, the machine hangs for ~1 minute
> displaying "INIT: ", then the same thing happens again when init
> enters in the designated runlevel and finally the getty process on
> ttyS0 hangs indefinitely (though strace'ing it helps).

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
