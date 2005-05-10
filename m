From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] add ignore_ports option
Date: Tue, 10 May 2005 10:35:56 -0300
Message-ID: <20050510133556.GG3907@cathedrallabs.org>
References: <20050510121151.GA4676@cathedrallabs.org> <20050510135000.B3358@flint.arm.linux.org.uk> <20050510130104.GE3907@cathedrallabs.org> <20050510143415.E3358@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panda.sul.com.br ([200.219.150.4]:58125 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261644AbVEJNgG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 09:36:06 -0400
Content-Disposition: inline
In-Reply-To: <20050510143415.E3358@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

> > 	this is needed when you have to compile serial driver built-in
> > 	for serial console but have, for example, an IRDA device in one
> > 	of the ports. In my notebook this happens and I'm unable to load
> > 	nsc-ircc driver after that because the I/O range is already
> > 	taken:
> 
> No need for a patch.  Just use:
> 
> setserial /dev/ttyS1 none
Thanks!

-- 
Aristeu

