From: Marc Boucher <marc@linuxant.com>
Subject: Re: Major problem with serial driver and serial_pci_guess_board()
Date: Tue, 26 Aug 2003 14:54:29 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030826185429.GA29937@endlich.mbsi.ca>
References: <20030826182745.GA29051@endlich.mbsi.ca> <20030826202951.B28144@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:33033
	"EHLO valve.mbsi.ca") by vger.kernel.org with ESMTP id S262622AbTHZSyj
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Aug 2003 14:54:39 -0400
Content-Disposition: inline
In-Reply-To: <20030826202951.B28144@devserv.devel.redhat.com>
List-Id: linux-serial@vger.kernel.org
To: Arjan van de Ven <arjanv@redhat.com>
Cc: rmk@arm.linux.org.uk, serial-pci-info@lists.sourceforge.net, linux-serial@vger.kernel.org, jsimon@linuxant.com

On Tue, Aug 26, 2003 at 08:29:51PM +0200, Arjan van de Ven wrote:
> On Tue, Aug 26, 2003 at 02:27:46PM -0400, Marc Boucher wrote:
> > 
> > Arjan, any chance we could get this patched in time for the next
> > Red Hat release?
> 
> I don't take patches that have the sole purpose of facilitating binary
> only kernel modules.
> 

We have tried very hard to change Conexant's position on this
but the best that we have been able to achieve is the current
compromise (everything non proprietary, i.e. os-specific part is
distributed in source form, modem modulations are included as
an object file), which is acceptable for most users. Just try to
get a modem vendor to release their IP in source and you will see
how hard/impossible it is, given patent and other issues.
There is also in practice little difference between our current split
and a totally open-source driver for a bus-mastering dma card with firmware.
You won't get the firmware in source, yet both can screw up the system if
they are badly written.

In the practical world, the lack of (or deficient) softmodem support
is a serious weakness and obstacle to linux adoption, which we are
trying to fix.

We have received hundreds of "thank-you" mails from users who are very
happy to have working drivers for their modems.

Now let's not get politics get in the way of fixing a real technical bug,
which is the serial driver incorrectly binding itself to an AC97 device
it can't handle.

Marc
