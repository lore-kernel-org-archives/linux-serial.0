From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Tue, 15 Jan 2013 23:58:13 -0800
Message-ID: <20130116075813.GA30819@kroah.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
 <20130116070521.GB2527@kroah.com>
 <50F65C5E.9090804@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38015 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab3APH5Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:57:16 -0500
Content-Disposition: inline
In-Reply-To: <50F65C5E.9090804@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rickard Andersson <rickard.andersson@stericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On Wed, Jan 16, 2013 at 08:53:02AM +0100, Rickard Andersson wrote:
> On 01/16/2013 08:05 AM, Greg KH wrote:
> >On Wed, Dec 12, 2012 at 01:40:51PM +0100, Rickard Andersson wrote:
> >>Add power management function to tty driver interface
> >>and add implementation for serial core.
> >>
> >>Signed-off-by: Rickard Andersson<rickard.andersson@stericsson.com>
> >>---
> >>ChangeLog v1->v2
> >>- add mutex handling
> >As no one is using this, why add it?
> >
> >greg k-h
> We want to use this pm function from our bluetooth driver to save
> current when possible. So in our case when the bluetooth driver sees
> that the serial communication to the bluetooth chip will not be used
> it can tell the pl011 serial driver to turn off clocks.

Is that driver in the tree already?

