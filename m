From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 8 Mar 2007 14:20:18 +0000
Message-ID: <20070308142017.GB30023@flint.arm.linux.org.uk>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <200703071019.55896.rgetz@blackfin.uclinux.org> <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com> <200703080844.32157.rgetz@blackfin.uclinux.org> <20070308134800.GA30023@flint.arm.linux.org.uk> <45F01AA8.7010608@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3360 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbXCHOUb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2007 09:20:31 -0500
Content-Disposition: inline
In-Reply-To: <45F01AA8.7010608@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Thu, Mar 08, 2007 at 03:16:08PM +0100, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> On 08.03.2007 14:48, Russell King wrote:
> > As I've said already, having a console on the same port as your application
> > program is just asking for trouble.  All bets are off - the kernel _will_
> > corrupt your data stream in random places.
> > 
> > Don't do it - it will _NEVER_ be reliable.
> > 
> > Never, ever, mix kernel consoles with application serial ports.
> 
> Unless you want two machines to monitor each other via serial console and
> each of them has only one serial port. It's not perfect, but it works well
> enough despite all claims to the contrary.

That's fine - you're not sending application specific data which could
be corrupted by an inopportune kernel message.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
