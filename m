From: David Woodhouse <dwmw2@infradead.org>
Subject: RE: RS485 communication
Date: 16 Mar 2003 10:05:31 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1047809131.22070.33.camel@imladris.demon.co.uk>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
	 <1047732394.20703.10.camel@imladris.demon.co.uk>
	 <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Fowler <cfowler@outpostsentinel.com>, Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>, 'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org, 'linux-kernel' <linux-kernel@vger.kernel.org>

On Sun, 2003-03-16 at 00:56, Alan Cox wrote:
> RS485 supports CDMA, thats more than enough to implement ppp nicely, all
> you have to do is a little abuse in the app or driver layer to block
> sending when carrier is asserted

Note you don't need any separate lines for this. If someone else is
transmitting a zero while you are also transmitting a zero, that's fine
and you didn't stomp on each other. If someone else is transmitting a
zero while you are transmitting a one, you won and a one was
transmitted, and they back off. If they transmit a one while you
transmit a zero, then they won :)

That's how CAN does it, IIRC. I don't believe it actually requires
synchronous clocks.

-- 
dwmw2


