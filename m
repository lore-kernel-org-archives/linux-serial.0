From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Major problem with serial driver and serial_pci_guess_board()
Date: Tue, 26 Aug 2003 20:16:01 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030826201601.J28810@flint.arm.linux.org.uk>
References: <20030826182745.GA29051@endlich.mbsi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6406 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262708AbTHZTQF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Aug 2003 15:16:05 -0400
Content-Disposition: inline
In-Reply-To: <20030826182745.GA29051@endlich.mbsi.ca>; from marc@linuxant.com on Tue, Aug 26, 2003 at 02:27:46PM -0400
List-Id: linux-serial@vger.kernel.org
To: Marc Boucher <marc@linuxant.com>
Cc: linux-serial@vger.kernel.org, arjanv@redhat.com, jsimon@linuxant.com

On Tue, Aug 26, 2003 at 02:27:46PM -0400, Marc Boucher wrote:
> This problem appears to be present in all recent serial driver variants,
> including those in 2.6 and the latest RedHat Severn beta. It is
> a serious issue preventing our drivers from working correctly.

My only interest is in 2.6, and the messages appear to be from a
2.4 kernel.  It does seem that we are detecting a device incorrectly,
since we aren't finding an 8250-compatible serial port.

Unfortunately, we don't have tables of exclusion, nor do we have
a clean method to do that at present in any kernel.

What I'd like to see is the output from lspci -vvx from a range of
PCI cards with this problem to see if there is characteristic (eg,
the PCI class/programming interface IDs) we can pick up on.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

