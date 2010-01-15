From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: Fix crash if the minimum rate of the device is
 > 9600 baud
Date: Fri, 15 Jan 2010 10:58:39 -0800
Message-ID: <20100115185839.GI12146@kroah.com>
References: <20100104162557.17151.23761.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51584 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215Ab0AOUQu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jan 2010 15:16:50 -0500
Content-Disposition: inline
In-Reply-To: <20100104162557.17151.23761.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jan 04, 2010 at 04:26:21PM +0000, Alan Cox wrote:
> 
> (Resend for -next)
> 
> In that situation if the old rate is invalid and the new rate is invalid
> and the chip cannot do 9600 baud we report zero, which makes all the
> drivers explode.
> 
> Instead force the rate based on min/max

Is this something that should go into 2.6.33 and backport to older
kernels?

thanks,

greg k-h
