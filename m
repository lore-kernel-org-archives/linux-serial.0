From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Sat, 15 Mar 2008 11:40:09 +0100
Message-ID: <20080315104009.GA6533@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803130138.55582.technoboy85@gmail.com> <20080313084526.GA6012@alpha.franken.de> <200803141646.09645.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:41997 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbYCOKmE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Mar 2008 06:42:04 -0400
Content-Disposition: inline
In-Reply-To: <200803141646.09645.technoboy85@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:
> This is a bit better

is it possible to try without the serial changes first ?

Use 

       uart_port[0].type = PORT_16550A;

in arch/mips/ar7/platform.c.

Does it work ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
