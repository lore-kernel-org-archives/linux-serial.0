From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 8250/16550 serial driver not being installed if set modular
Date: Thu, 17 Nov 2005 22:55:30 +0000
Message-ID: <20051117225530.GA20221@flint.arm.linux.org.uk>
References: <20051115115613.GA10399@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36107 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964883AbVKQWzg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Nov 2005 17:55:36 -0500
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EcsfF-0003I0-I8
	for linux-serial@vger.kernel.org; Thu, 17 Nov 2005 22:55:34 +0000
Content-Disposition: inline
In-Reply-To: <20051115115613.GA10399@roll>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hikaru1@verizon.net
Cc: linux-serial@vger.kernel.org

On Tue, Nov 15, 2005 at 06:56:13AM -0500, Hikaru1@verizon.net wrote:
> Hi, I'm emailing you to report a bug with the serial driver in linux kernel
> 2.6.14.2, you are listed as the maintainer in the MAINTAINERS file, so if
> I've sent you this bug report in error please tell me where I should be
> sending it.
> 
> I'm using slackware 10.2 on a AMD K7 (XP 2600) this is a 32bit i386
> compatible machine.
> 
> in 2.6.14.2's menuconfig, under Device Drivers->Character devices->Serial
> drivers if I select the option 8250/16550 and compatible serial support to
> be compiled into the kernel, it works fine. If I select it to compile as a
> module, the module 'serial' is not installed when I do make modules_install.
> I'm also pretty sure it's not being compiled at all when selected to be
> compiled as a module.
> 
> Just to be clear, the help for that option specifically says the module will
> be named 'serial' if the name's wrong, could you tell me what it is named?
> 
> I don't know what's wrong with it, nor where to check. Could you give me
> some pointers on what to check so I can give you more information? I
> really prefer to have as much as I can as modules as my computer has to boot
> using a floppy disk.

It's actually called '8250' and it depends on 'serial_core' as well.
I'll fix the docs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
