From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] 8250 driver interrupt sharing
Date: Thu, 28 Oct 2004 12:00:26 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20041028120026.B3327@flint.arm.linux.org.uk>
References: <200410281301.59584.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29969 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262969AbUJ1LAc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2004 07:00:32 -0400
Content-Disposition: inline
In-Reply-To: <200410281301.59584.thomas.koeller@baslerweb.com>; from thomas.koeller@baslerweb.com on Thu, Oct 28, 2004 at 01:01:58PM +0200
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-serial@vger.kernel.org

On Thu, Oct 28, 2004 at 01:01:58PM +0200, Thomas Koeller wrote:
> here is a little patch that causes the driver to no longer pretend having
> handled an interrupt if none of the ports actually interrupted. I am currently
> doing a port to a platform where I want (actually, have) to share a single
> interrupt between serial ports and other devices. The patch is against kernel
> version 2.6.9.

You can only share serial port interrupts with other devices if the
interrupt controller input is level sensitive rather than edge
sensitive.  If it is edge sensitive, then you'll run into problems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
