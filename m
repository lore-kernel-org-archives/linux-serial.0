From: Greg KH <greg@kroah.com>
Subject: Re: Driver for PL-2303 HX not working
Date: Sun, 31 Mar 2013 08:01:11 -0700
Message-ID: <20130331150111.GB9494@kroah.com>
References: <515839A1.2050904@dct.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46832 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755197Ab3CaPCg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 31 Mar 2013 11:02:36 -0400
Content-Disposition: inline
In-Reply-To: <515839A1.2050904@dct.mine.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karsten Malcher <debian@dct.mine.nu>
Cc: linux-serial@vger.kernel.org

On Sun, Mar 31, 2013 at 03:26:57PM +0200, Karsten Malcher wrote:
> Hello,
> 
> I have a problem with the PL2303HX chip.
> 
> Please refer to this bug:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=704242
> 
> Where can i address such a bug?
> How can i debug and help to solve the problem?

Please post to the linux-usb@vger.kernel.org mailing list the output of
the kernel log when you try to use the device.

Also, as you are using a distro kernel, there's usually not much we can
do to help out.  If you use a kernel.org release, like the latest one
(3.8), we can help you, otherwise you need to work with your distro.

good luck,

greg k-h
