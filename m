From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date: Fri, 5 Jun 2009 00:20:20 +0200
Message-ID: <20090604222020.GA14843@alpha.franken.de>
References: <200906041622.47591.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <200906041622.47591.florian@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> We discussed that in private, there are a couple of things
> to fix in order to get 8250 working properly with TI AR7 HW.
> If you can still merge that bit, this would ease future work, thanks !

I still have a tree here, which works without any changes to the 8250
serial driver on a TNETD7300 device.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
