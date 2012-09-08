From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 8 Sep 2012 11:19:17 -0700
Message-ID: <20120908181917.GA7038@kroah.com>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
 <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
 <20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
 <20120908183015.2ca02043@pyramind.ukuu.org.uk>
 <20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43448 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2IHSTW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 14:19:22 -0400
Received: by pbbrr13 with SMTP id rr13so1093439pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 08 Sep 2012 11:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter.sheeren@axiris.be
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Sat, Sep 08, 2012 at 07:35:16PM +0200, peter.sheeren@axiris.be wrote:
> 
> I'm sorry, I've no experience with compiling a driver for Linux.
> 
> Q: When I plug in the USB device without even using it, should
> ftdi_sio and usbserial remain loaded after I unplug the USB device?

Yes, no one unloads modules after devices are removed, as you really
don't know if the driver is still needed or not.

But, this shouldn't be an issue for you, when you replug the device in,
it should be reset, with no internal, or kernel, state as to what it is
in.  You have to always explicitly set the line settings up again,
otherwise you have no idea what it is running at.

greg k-h
