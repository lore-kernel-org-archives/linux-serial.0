From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Linux Serial Code Problems
Date: Thu, 5 Sep 2013 09:30:03 -0400
Message-ID: <20130905133003.GA7526@thunk.org>
References: <13948377.218867.1378367871551.JavaMail.root@vznit170080>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:55053 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab3IENa0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 09:30:26 -0400
Content-Disposition: inline
In-Reply-To: <13948377.218867.1378367871551.JavaMail.root@vznit170080>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roger Davis <rogerdavis@verizon.net>
Cc: linux-serial@vger.kernel.org

On Thu, Sep 05, 2013 at 02:57:51AM -0500, Roger Davis wrote:
> 
> I recently found the following info.  Perhaps I'm confused, but it
> seems apparent to me that there is a known basic deficiency in the
> code causing this problem from the following quote found at....

You are quoting from: http://serial.sourceforge.net/ which was written
by yours truly back when I was the serial driver maintainer.  I don't
want to tread on the current maintainer's toes, but with that caveat,
it's not that there's a "basic deficiency in the code", but rather
it's a fundamental deficiency in the reality as you might wish it to be.

Take a look at drivers/tty/serial/8250/8250_pci.c from the kernel
sources.  You will see there is a huge list of quirks and exceptions
for various PCI cards, to work around the fact that the standards by
the PCI Consortium are well, "loose".  There are some some generic
entries that can be found in the PCI standards --- see the generic
entries for PCI_CLASS_COMMUNICATION_SERIAL,
PCI_CLASS_COMMUNICATION_MODEM, PCI_CLASS_COMMUNICATOIN_MULTISERIAL.
But then also take a look at all of the quirks and exceptions to deal
with random cards and modems.

Thus my comments, which you quoted:

> As you may have gathered by now, there is no standard PCIserial
> interface.  (The PCI consoritium which is in charge of standardizing
> the PCI bus must have been asleep at the switch.)

If it worked on an older kernel, but doesn't on a new kernel.  It
could be because someone added a quirk that that worked for their PCI
card, but not for yours.  This could happen if they added one with an
overly broad match based on the PCI id, or it could be because the
vendor made changes in their PCI card without changing the PCI id's.
(I've seen that before.)  This is why Greg K-H's suggestion of doing a
kernel bisection search might be useful to identify what change might
have caused the regression.

Looking at this whole mess, you know one of the reasons why I'm glad
I'm no longer the serial driver maintainer.  (Also, these days I'm a
big fan of ethernet and MyFi devices, and try to avoid serial/modem
interfaces in general.  :-)

Cheers,

						- Ted
