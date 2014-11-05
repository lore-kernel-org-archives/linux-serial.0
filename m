From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: pl2303 linux driver does not work
Date: Tue, 4 Nov 2014 18:25:10 -0800
Message-ID: <20141105022510.GA7342@kroah.com>
References: <54597F77.9050602@grapecity.mn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51079 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbaKEC03 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 21:26:29 -0500
Content-Disposition: inline
In-Reply-To: <54597F77.9050602@grapecity.mn>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Batdelger.O" <david.batdelger@grapecity.mn>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 05, 2014 at 09:37:59AM +0800, Batdelger.O wrote:
> Hello
> Hope you guys are doing great.
> I've got problem with pl2303 Linux driver. In a nutshell, my mission is to
> control magnetic card reader/writer with PL-2303 XA / HXA chip from the
> Linux. I'm using Ubuntu 14.04(kernel version: 3.13.0-39-generic). Everything
> is going fine. Giving no errors. Writing data via usb-serial seems to work.
> But the device is not receiving data. If that issue familiar with you,
> please give me advice.

How exactly are you "writing data"?  And have you set up flow control
properly?

thanks,

greg k-h
