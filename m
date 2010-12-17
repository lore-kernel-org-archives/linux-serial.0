From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Serial: Avoid unbalanced IRQ wake disable during resume
Date: Thu, 16 Dec 2010 23:04:02 -0800
Message-ID: <20101217070402.GA25180@kroah.com>
References: <14261.10.24.255.17.1292503367.squirrel@dbdmail.itg.ti.com>
 <31ed13d20cd8ceb25e914a60cf5bb588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34064 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab0LQHDn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Dec 2010 02:03:43 -0500
Content-Disposition: inline
In-Reply-To: <31ed13d20cd8ceb25e914a60cf5bb588@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Govindraj Raja <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Dec 17, 2010 at 11:52:44AM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Govindraj.R [mailto:govindraj.raja@ti.com]
> > Sent: Thursday, December 16, 2010 6:13 PM
> > To: linux-serial@vger.kernel.org; Greg KH
> > Cc: Paul Walmsley; Santosh Shilimkar; Kevin Hilman; Greg KH
> > Subject: [PATCH] Serial: Avoid unbalanced IRQ wake disable during resume
> >
> > To avoid unbalanced IRQ wake disable, ensure that wakeups are disabled
> > only when wakeups have been successfully enabled.
> > Tested on OMAP3630SDP/ZOOM3.
> >
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> > Reported-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Greg KH <greg@kroah.com>
> As suggested by Kevin, please update the change log. You could
> also use the change log of intermediate version I created.
> 
> Also add a note the fix is suggested by Paul.

Sorry, I already checked this into my git tree, so it will have to stay
as-is.

thanks,

greg k-h
