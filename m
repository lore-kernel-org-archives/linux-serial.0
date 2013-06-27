From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: usb_serial, ftdi_sio chars_in_buffer blocking tcdrain
Date: Thu, 27 Jun 2013 08:20:30 -0700
Message-ID: <20130627152030.GB24911@kroah.com>
References: <51CC2D44.9090400@helmcke.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34646 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab3F0PTp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Jun 2013 11:19:45 -0400
Content-Disposition: inline
In-Reply-To: <51CC2D44.9090400@helmcke.name>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andreas Helmcke <ahe@helmcke.name>
Cc: linux-serial@vger.kernel.org

On Thu, Jun 27, 2013 at 02:17:08PM +0200, Andreas Helmcke wrote:
> Hi,
> 
> after upgrading from Kernel 3.5 to Kernel 3.8 (actually updating
> kubuntu 12.10 to 13.04) I am having the problem, that some times
> tcdrain does not return.

3.8 is no longer supported by the community, can you try the latest
3.10-rc7 release, or 3.9.7, both of which should have some fixes for
this issue?

thanks,

greg k-h
