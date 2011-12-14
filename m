From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 0/4] OMAP serial device tree support
Date: Wed, 14 Dec 2011 10:27:10 -0800
Message-ID: <20111214182710.GC8039@kroah.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <87d3brnpsi.fsf@ti.com>
 <20111214171843.5f638874@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41193 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960Ab1LNS7K (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Dec 2011 13:59:10 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E1A2C21666
	for <linux-serial@vger.kernel.org>; Wed, 14 Dec 2011 13:59:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111214171843.5f638874@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

On Wed, Dec 14, 2011 at 05:18:43PM +0000, Alan Cox wrote:
> On Wed, 14 Dec 2011 07:20:13 -0800
> Kevin Hilman <khilman@ti.com> wrote:
> 
> > Greg, Alan,
> > 
> > Rajendra Nayak <rnayak@ti.com> writes:
> > 
> > > v3 is rebased on top of the latest serial runtime
> > > patches[1] and boot tested with/without DT on OMAP4
> > > SDP and OMAP4 Panda boards.
> > 
> > With your ack on the drivers/tty/* stuff, I can queue this via the
> > OMAP tree on top of the runtime PM conversion that it depends on.
> 
> Go for it

Fine with me as well.

greg k-h
