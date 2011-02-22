From: Greg KH <greg@kroah.com>
Subject: Re: SC16is752 I2c driver
Date: Tue, 22 Feb 2011 14:05:07 -0800
Message-ID: <20110222220507.GA4530@kroah.com>
References: <4D63C80A.3070005@dawning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35374 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab1BVWGE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 17:06:04 -0500
Content-Disposition: inline
In-Reply-To: <4D63C80A.3070005@dawning.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pete Murray <pmurray@dawning.com>
Cc: linux-serial@vger.kernel.org

On Tue, Feb 22, 2011 at 09:28:26AM -0500, Pete Murray wrote:
> Hello,
> 
> I wrote an I2C  driver for the SC16is752 dual Uart chip, I see there
> is an SPI version now.  There was no SPI version when I was
> developing, if there was I would have tried to add I2C support to
> that driver instead.  Is this something I should post for review, or
> should I work on adding support to the existing SPI version?

Try adding support to the SPI version, it might be simpler.

thanks,

greg k-h
