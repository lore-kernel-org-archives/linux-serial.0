From: Greg KH <gregkh@us.ibm.com>
Subject: Re: [PATCH] linux-2.6.2-rc3 Add icom serial device driver
Date: Fri, 6 Feb 2004 12:17:13 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040206201713.GB3758@us.ibm.com>
References: <OFF4CA2E9C.4E3C6DF3-ON86256E32.006E5604-86256E32.006F107D@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7830 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265611AbUBFURH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Feb 2004 15:17:07 -0500
Content-Disposition: inline
In-Reply-To: <OFF4CA2E9C.4E3C6DF3-ON86256E32.006E5604-86256E32.006F107D@us.ibm.com>
List-Id: linux-serial@vger.kernel.org
To: Michael Anderson <mjanders@us.ibm.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

On Fri, Feb 06, 2004 at 02:12:28PM -0600, Michael Anderson wrote:
> I am posting the icom serial device driver code and supporting kernel
> changes for submission to the linux kernel.  The icom serial
> device driver enables linux to use a family of IBM iSeries serial
> adapters.  The serial adapters supported by icom are intelligent adapters
> that provide multiport serial access via iSeries RS232 cables on some
> adapters or via internal modems on other adapters.  Today the icom device
> driver only uses the family of adapters for asynchronous communications.
> 
> Please review this code for submission.

Why not include the patch in this message?  Putting patches on web sites
is a tough way to get your code reviewed by the community.

And why not forward port it to 2.6.2?  2.6.2-rc3 is a old kernel version
:)

thanks,

greg k-h
