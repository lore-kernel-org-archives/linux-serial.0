From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 23:57:32 +0200
Message-ID: <200708052357.32650.arnd@arndb.de>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<E1IHnhY-0008PO-IZ@jdl.com>
	<Pine.LNX.4.60.0708052336360.4120@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: Jon Loeliger <jdl@jdl.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> 
> > I supect it will have the same issue in the end, right?
> 
> ...if you choose to use of_serial.c, yes, if you don't use it and just use 
> legacy_serial.c, then you're fine.

But of_serial can be a loadable module, which means you still get into
trouble if you load it, even if the port was originally initialized
by legacy_serial.

Maybe the best solution would be for 824[15] to not claim compatibility
with 8250 at all then. If the device tree contains an entry that matches
what the generic driver looks for, it better be something that can
be handled by that driver.

	Arnd <><
