From: Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Sun, 16 Mar 2008 16:45:06 +0100
Message-ID: <200803161645.06364.technoboy85@gmail.com>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out114.alice.it ([85.37.17.114]:3401 "EHLO
	smtp-out114.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbYCPPp1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 16 Mar 2008 11:45:27 -0400
In-Reply-To: <20080315104009.GA6533@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Il Saturday 15 March 2008 11:40:09 Thomas Bogendoerfer ha scritto:
> On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:
> > This is a bit better
> 
> is it possible to try without the serial changes first ?
> 
> Use 
> 
>        uart_port[0].type = PORT_16550A;
> 
> in arch/mips/ar7/platform.c.
> 
> Does it work ?
> 
> Thomas.
> 

Tried I get teh usual broken serial output:

IP6 oover IPv4 tuneliing driver
NET: eggistered protooll family 17
VFS: Monteed root (squahfss filesystem)reaadonly.
