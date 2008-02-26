From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Inter-Character Delay
Date: Tue, 26 Feb 2008 19:18:25 +0000
Message-ID: <20080226191825.GA31527@flint.arm.linux.org.uk>
References: <200802181336.26328.rgetz@blackfin.uclinux.org> <200802261111.58448.rgetz@blackfin.uclinux.org> <20080226171156.GA11561@flint.arm.linux.org.uk> <200802261321.18288.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42773 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376AbYBZTS4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 14:18:56 -0500
Content-Disposition: inline
In-Reply-To: <200802261321.18288.rgetz@blackfin.uclinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-serial@vger.kernel.org

On Tue, Feb 26, 2008 at 01:21:18PM -0500, Robin Getz wrote:
> On Tue 26 Feb 2008 12:11, Russell King pondered:
> > On Tue, Feb 26, 2008 at 11:11:58AM -0500, Robin Getz wrote:
> > > ping.
> > > 
> > > Comments appreciated.
> > 
> > ascii-xfr does inter-line and inter-character delays without requiring
> > any kernel modifications - used it with some dumb boot loaders which
> > required 'mem deposit <address> <word>' to be sent slowly to the target.
> 
> Thanks for the pointer.
> 
> Solving the problem in userspace (with tcdrain and udelay) when some
> hardware can do the same thing with zero overhead - doesn't seem like
> the most efficient way to do things....

I know of no serial hardware which can insert arbitary delays inbetween
characters.

> It also lacks the ability to work with pre-existing user space
> applications.

So one could say those applications are buggy.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
