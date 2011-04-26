From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Tue, 26 Apr 2011 12:47:40 -0700
Message-ID: <20110426194740.GB17748@kroah.com>
References: <342576875.1870580.1303826202211.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
 <1494342619.1871798.1303827533853.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:55145 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839Ab1DZTsf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Apr 2011 15:48:35 -0400
Content-Disposition: inline
In-Reply-To: <1494342619.1871798.1303827533853.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-serial@vger.kernel.org, grant likely <grant.likely@secretlab.ca>

On Tue, Apr 26, 2011 at 02:18:53PM +0000, johnlinn@comcast.net wrote:
> It's not clear to me how owns the serial driver subsystem as I see that
> you own the tty and a serial driver. I'm trying to figure out who I would
> ask if they will merge this patch in to their tree?

Resend it, cc the linux-serial list and me and Alan Cox.  I'll pick it
up in my "tty" tree if he acks it.

thanks,

greg k-h
