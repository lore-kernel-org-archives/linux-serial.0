From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: RS485 communication
Date: 16 Mar 2003 10:51:47 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1047811906.22070.44.camel@imladris.demon.co.uk>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
	 <1047732394.20703.10.camel@imladris.demon.co.uk>
	 <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
	 <1047809131.22070.33.camel@imladris.demon.co.uk>
	 <20030316103517.B14404@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030316103517.B14404@flint.arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Fowler <cfowler@outpostsentinel.com>, Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>, 'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org, 'linux-kernel' <linux-kernel@vger.kernel.org>

On Sun, 2003-03-16 at 10:35, Russell King wrote
> No - that's not how RS485 works.  With a balanced line, the result
> that any one receiver will see will depend on it's position on the
> line and the relative distance to each transmitter, the resistance
> of the line, and the manufacturer/type of the RS485 transceiver.
> In other words, the state you see is indeterminent.

Ah, OK. Then I must have been mistaken in thinking that CAN was based on
RS485 -- or mistaken in remembering that that's how CAN does collision
avoidance I suppose, but I suspect the former is more likely.

Thanks for the correction.

-- 
dwmw2


