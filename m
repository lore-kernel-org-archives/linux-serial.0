From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Linux USB Serial
Date: Mon, 17 Sep 2012 14:41:36 -0700
Message-ID: <20120917214136.GA20773@kroah.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com>
 <87zk4o1kh4.fsf@nemi.mork.no>
 <00b801cd9518$715dd160$54197420$@acscontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49836 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab2IQVlo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 17:41:44 -0400
Received: by ggdk6 with SMTP id k6so1578063ggd.19
        for <linux-serial@vger.kernel.org>; Mon, 17 Sep 2012 14:41:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <00b801cd9518$715dd160$54197420$@acscontrol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Steven J. Ackerman" <steve@acscontrol.com>
Cc: =?iso-8859-1?Q?'Bj=F8rn?= Mork' <bjorn@mork.no>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Sep 17, 2012 at 05:07:26PM -0400, Steven J. Ackerman wrote:
> Bjrn-
> 
> Thank you for your response.
> 
> This change gets me closer. I can now successfully execute the modprobe
> without error, but the device still doesn't show up in /dev/ttyUSB? .
> 
> sja@UBUNTU-10:~$ sudo modprobe usbserial vendor=0x0c6a product=0x0005

Eeek, no, never do that with a device you actually want to use.  This
should be controlled by the cdc-acm driver, not the usbserial driver.
That driver should be auto-loaded for this device, but it looks like the
descriptor is wrong, so it's not binding to it.

Are you able to test a patch and rebuild the kernel to see if we can get
this to work properly?

thanks,

greg k-h
