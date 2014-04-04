From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: FW: FTDI spontanteous disconnect/reconnect
Date: Fri, 4 Apr 2014 08:34:52 -0700
Message-ID: <20140404153452.GA11409@kroah.com>
References: <3F4B290D8BFAD2458191EB243C0592C4850B0D4EC9@seuppms301>
 <20140403180102.GA21565@kroah.com>
 <3F4B290D8BFAD2458191EB243C0592C4850B0D4FA7@seuppms301>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39800 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaDDPcc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Apr 2014 11:32:32 -0400
Content-Disposition: inline
In-Reply-To: <3F4B290D8BFAD2458191EB243C0592C4850B0D4FA7@seuppms301>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sven Lahr <Sven.Lahr@biotage.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, Apr 04, 2014 at 08:13:01AM +0200, Sven Lahr wrote:
> Hi!
> 
> Thank you for your quick response. We will definitely look into the electronics.
> 
> But I am not quite sure what you mean when you say the in-kernel
> driver is up-to-date. Where can I find that information?
> The only place I have found any information about ftdi_sio is the
> SourceForge page, which clearly states nothing has happened since
> 2009.
> And I have really searched the web, specifically I was trying to find
> a "Known Issues" kinda page, bugtracker or something.

As Mats said, the driver is developed in the Linux kernel directly, like
almost all kernel drivers are.  There's no way we have individual pages
for each Linux driver, or have bug trackers like that, there are just
too many drivers that we support to do that.  The
linux-usb@vger.kernel.org mailing list is the place the driver is
discussed if you have any questions about it or the USB subsystem.

hope this helps,

greg k-h
