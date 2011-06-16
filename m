From: Greg KH <greg@kroah.com>
Subject: Re: kernel lockup due to bad baud rate data
Date: Wed, 15 Jun 2011 17:21:30 -0700
Message-ID: <20110616002130.GA25488@kroah.com>
References: <1719676005.1623192.1308182800563.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
 <1786375823.1623268.1308182952117.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59808 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329Ab1FPAWm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 20:22:42 -0400
Content-Disposition: inline
In-Reply-To: <1786375823.1623268.1308182952117.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-serial@vger.kernel.org

On Thu, Jun 16, 2011 at 12:09:12AM +0000, johnlinn@comcast.net wrote:
> I'm testing with 2.6.39 and our serial driver that's unique to our ARM
> platform.  I suspect we have a problem with our serial driver but
> wanted to see if anyone has seen any similar behavior.
> 
> When running with 2 serial ports, any input from a serial terminal
> running at the wrong baud rate (9600 instead of 115.2K) on a 2nd shell
> (not the console shell) causes the kernel to lock up. It doesn't
> crash, I'm still trying to understand what it's doing.  I can no
> longer ping the board as the network was working prior.
> 
> I just wanted to make sure there's not any known tty issues related to
> this.

There are some odd issues with stuff in this area, care to try 3.0-rc3
and see if the problem is there as well or not?

thanks,

greg k-h
