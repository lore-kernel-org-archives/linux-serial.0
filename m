From: Alan Cox <alan@linux.intel.com>
Subject: Re: MAX3107 driver faulty
Date: Fri, 18 Feb 2011 13:54:20 +0000
Message-ID: <20110218135420.68277c1e@bob.linux.org.uk>
References: <4D5E74C7.3040700@gmx.de>
	<20110218135908.GA7305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36040 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1BROQq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 09:16:46 -0500
In-Reply-To: <20110218135908.GA7305@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Nico Becker <nico.becker@gmx.de>, linux-serial@vger.kernel.org, jianwei.yang@intel.com

> > Have somebody test the driver,
> > or have although trouble with the chip?
> 
> I haven't, but I'll add the people who brought the driver to the
> kernel to CC. Maybe they can comment.

It had some testing but in a limited configuration and mostly for a
device that then got canned. Thus I can well believe the autocts/rts
isn't set right, and IntOscen may well only get set if the firmware
happens to do it etc

> > Because i am really new with the kernel hacking,
> > what are the next steps, build an patch?
> 
> Doing patches (one per issue) might be an idea. It is usually easier
> to talk about code. Reading Documentation/SubmittingPatches will
> probably make the process easier.

I would probably send it as four patches

1. A patch for the IntOscen configuration
2. A patch to fix autocts/rts
3. A patch to fix the register updates
4. A patch to add any platform specific stuff you need for your device.

Thanks

Alan
