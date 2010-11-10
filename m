From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 08:08:51 -0800
Message-ID: <20101110160851.GA10708@kroah.com>
References: <4CDAA41F.1060402@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43673 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756893Ab0KJQTp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 11:19:45 -0500
Content-Disposition: inline
In-Reply-To: <4CDAA41F.1060402@visionsystems.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 10, 2010 at 02:54:39PM +0100, Yegor Yefremov wrote:
> This will make sure that multiple serial port cards can be
> used out of the box. Otherwise the user must pass
> nr_uarts parameter, that will be often forgotten and increases
> support requests for serial card vendors.

Has this really happened in the past?  What is the downside of changing
this option that has been around for many years now?  Also note that
multi-port serial cards are more rare these days than they used to be so
changing this seems a bit pointless now.

thanks,

greg k-h
