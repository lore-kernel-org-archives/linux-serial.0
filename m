From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Garbage on serial console after serial driver loads
Date: Fri, 25 Mar 2005 20:38:53 +0000
Message-ID: <20050325203853.C12715@flint.arm.linux.org.uk>
References: <20050325202414.GA9929@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6928 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261784AbVCYUi5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2005 15:38:57 -0500
Content-Disposition: inline
In-Reply-To: <20050325202414.GA9929@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Fri, Mar 25, 2005 at 09:24:15PM +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Luca <kronos@kronoz.cjb.net>, David Woodhouse <dwmw2@infradead.org>
Cc: Linux Serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:24:15PM +0100, Luca wrote:
> I attached a null modem cable to my notebook and I'm seeing garbage as
> soon as the serial driver is loaded. I tried booting with init=/bin/bash
> to be sure that it's not some rc script doing strange things to the
> serial port, but this didn't solve the problem.

I'm uncertain how this problem can occur, unless you have one of:

* serial debugging enabled (which isn't compatible with serial console)
* a NS16550A, in which case dwmw2 needs to rework his autodetect code to
  adjust the baud rate appropriately.

I suspect your case is the latter.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
