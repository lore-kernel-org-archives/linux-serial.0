From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Sun, 4 Mar 2007 19:46:32 +0000
Message-ID: <20070304194632.GC30345@flint.arm.linux.org.uk>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2334 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXCDTqp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2007 14:46:45 -0500
Content-Disposition: inline
In-Reply-To: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

On Thu, Mar 01, 2007 at 07:03:02PM -0500, Mike Frysinger wrote:
> the console= bootcmd allows for controlling of the initial state of
> flow control by adding/omitting the 'r' suffix ...

The console command *only* sets the state for the kernel's use of one
serial port.  It does not affect any other serial port, so tying
random RTS behaviours into that command line option is absolutely
silly.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
