From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Tue, 18 Mar 2008 16:43:44 +0300
Message-ID: <47DFC710.5060907@ru.mvista.com>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com> <20080318133015.GA7239@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29284 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752514AbYCRNmZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Mar 2008 09:42:25 -0400
In-Reply-To: <20080318133015.GA7239@alpha.franken.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hello.

Thomas Bogendoerfer wrote:

>>Il Saturday 15 March 2008 11:40:09 Thomas Bogendoerfer ha scritto:

>>>On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:

>>>>This is a bit better

>>>is it possible to try without the serial changes first ?

>>>Use 

>>>       uart_port[0].type = PORT_16550A;

>>>in arch/mips/ar7/platform.c.

>>>Does it work ?

>>Tried I get teh usual broken serial output:

> I just checked the latest AR7/UR8 source, I have, and they don't need
> special hacks. This is a 2.6.10 based tree. At that time there was
> no serial8250_console_putchar(), console output was done via
> serial8250_console_write() without any helper. Before writing to 
> the UART_TX, wait_for_xmitr() is called. And this wait_for_xmitr() does
> check for BOTH_EMPTY.

> Is there a good reason, why we don't check for BOTH_EMPTY in
> serial8250_console_putchar() ?

    I guess transmission will be slower if you check both THRE and TSRE 
conditions.

> To match the 2.6.10 behaviour we
> would need that and this would fix the AR7 case without any
> special handling.

    AR7 case seems to be the case of bad hardware, and so require special 
handling...

> Thomas.

WBR, Sergei
