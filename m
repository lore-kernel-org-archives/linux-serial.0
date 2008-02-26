From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: Inter-Character Delay
Date: Tue, 26 Feb 2008 13:21:18 -0500
Message-ID: <200802261321.18288.rgetz@blackfin.uclinux.org>
References: <200802181336.26328.rgetz@blackfin.uclinux.org> <200802261111.58448.rgetz@blackfin.uclinux.org> <20080226171156.GA11561@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:7823 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbYBZSTl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 13:19:41 -0500
In-Reply-To: <20080226171156.GA11561@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-serial@vger.kernel.org

On Tue 26 Feb 2008 12:11, Russell King pondered:
> On Tue, Feb 26, 2008 at 11:11:58AM -0500, Robin Getz wrote:
> > ping.
> > 
> > Comments appreciated.
> 
> ascii-xfr does inter-line and inter-character delays without requiring
> any kernel modifications - used it with some dumb boot loaders which
> required 'mem deposit <address> <word>' to be sent slowly to the target.

Thanks for the pointer.

Solving the problem in userspace (with tcdrain and udelay) when some hardware 
can do the same thing with zero overhead - doesn't seem like the most 
efficient way to do things....

It also lacks the ability to work with pre-existing user space applications.

-Robin
