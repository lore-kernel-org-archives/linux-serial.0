From: David Woodhouse <dwmw2@infradead.org>
Subject: RE: Serial custom speed deprecated?
Date: Thu, 24 Aug 2006 14:03:30 +0100
Message-ID: <1156424610.3012.29.camel@pmac.infradead.org>
References: <033001c6c77a$a7d8ab10$294b82ce@stuartm>
	 <1156425568.3007.138.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:3762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751317AbWHXNDe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Aug 2006 09:03:34 -0400
In-Reply-To: <1156425568.3007.138.camel@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stuart MacDonald <stuartm@connecttech.com>, 'LKML' <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Thu, 2006-08-24 at 14:19 +0100, Alan Cox wrote:
> Actually to do this right we have to make a decision or two
> 
> The POSIX way of handling this requires the speeds are in the termios
> structure "somewhere". We can't easily implement cfgetispeed/cfgetospeed
> unless we grow the termios structure in the kernel and issue 3 new
> ioctls (keeping the others as trivial translations) and then bumping
> glibc and the kernel to do the right thing.
> 
> The alternative is that we provide an extra pair of speed ioctls and
> glibc does the magic to hide this lot while providing a termios with the
> new fields itself.
> 
> Whichever way we go glibc already has the fields present and the
> libc<->application API appears to be unchanged by this.
> 
> I'd rather we went the way of extending our termios to include c_ispeed,
> c_ospeed values. The code isn't hard for the remapping of the old ones
> and it avoids extra ioctls and the corner case races between two speed
> sets that occur if they are two ioctls.

Agreed. Some architectures have c_[io]speed in their struct termios
already, in fact, but others would need new ioctls for it.

-- 
dwmw2

