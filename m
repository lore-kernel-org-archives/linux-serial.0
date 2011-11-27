From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 02/11] TTY: Remove redundant spi driver bus initialization
Date: Sat, 26 Nov 2011 20:17:52 -0800
Message-ID: <20111127041752.GA16415@kroah.com>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de>
 <1322148561-25138-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36623 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752148Ab1K0KTp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Nov 2011 05:19:45 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9B81421A2F
	for <linux-serial@vger.kernel.org>; Sun, 27 Nov 2011 05:19:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1322148561-25138-2-git-send-email-lars@metafoo.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

On Thu, Nov 24, 2011 at 04:29:12PM +0100, Lars-Peter Clausen wrote:
> In ancient times it was necessary to manually initialize the bus field of an
> spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
> so we can drop the manual assignment.
> 
> The patch was generated using the following coccinelle semantic patch:
> // <smpl>
> @@
> identifier _driver;
> @@
> struct spi_driver _driver = {
> 	.driver = {
> -		.bus = &spi_bus_type,
> 	},
> };
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Alan Cox <alan@linux.intel.com> (maintainer:SERIAL DRIVERS)
> Cc: linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)

The () isn't needed, or nice, as I now need to edit this file by hand
and remove that text.  When applying 400+ patches in a single day, it
gets old fast...

thanks,

greg k-h
