From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 09/17] serial/8250: Limit the omap workarounds to omap1
Date: Tue, 11 Sep 2012 20:19:19 +0100
Message-ID: <20120911201919.58d44dcb@bob.linux.org.uk>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
	<20120911053104.29637.95283.stgit@muffinssi.local>
	<20120911174234.45919fd3@bob.linux.org.uk>
	<20120911164023.GE23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64117 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759171Ab2IKTBZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 15:01:25 -0400
In-Reply-To: <20120911164023.GE23092@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

> > Even better would be if for other cases is_omap_port and friends
> > returned 0...
> 
> Yes it seems that those macros could be moved from plat-omap/serial.h
> to live in drivers/tty/serial/8250/8250.h? Or do you have some better
> place in mind?

I've not looked at it enough to decide if it's doable or not. I'm happy
either way - both patches are progress the right way!
