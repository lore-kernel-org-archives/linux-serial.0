From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: RS485 communication
Date: 16 Mar 2003 00:56:01 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
	 <1047732394.20703.10.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1047732394.20703.10.camel@imladris.demon.co.uk>
List-Id: linux-serial@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Fowler <cfowler@outpostsentinel.com>, Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>, 'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org, 'linux-kernel' <linux-kernel@vger.kernel.org>

On Sat, 2003-03-15 at 12:46, David Woodhouse wrote:
> On Thu, 2003-03-13 at 23:30, Chris Fowler wrote:
> > Are you saying that for him to to use PPPD that he will have to write a
> > program that will run on a master and tell all the slave nodes when they
> > can transmit their data.  In this case it would be ppp data.  Hopfully
> > in block sizes that are at least the size of the MTU ppp is running.
> 
> You don't _need_ a master, although it's often an easy answer.
> 
> You can have a token-bus arrangement like ARCnet does. In fact, the
> ARCnet data sheets describing how it works may make interesting reading.

RS485 supports CDMA, thats more than enough to implement ppp nicely, all
you have to do is a little abuse in the app or driver layer to block
sending when carrier is asserted

