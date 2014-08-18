From: Greg KH <greg@kroah.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 08:50:46 -0500
Message-ID: <20140818135046.GA927@kroah.com>
References: <53F1CD68.9080901@ts.fujitsu.com>
 <20140818105307.GA5811@kroah.com>
 <53F1DF48.8000007@ts.fujitsu.com>
 <53F1E14D.7000408@ts.fujitsu.com>
 <53F202FF.5020809@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48203 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbaHRNvw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 09:51:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway1.nyi.internal (Postfix) with ESMTP id C538422FB5
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2014 09:51:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53F202FF.5020809@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, Aug 18, 2014 at 03:43:27PM +0200, Cestonaro Thilo wrote:
> Hey,
> 
> do I need to do something like:
> ----
> f = filp_open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY, 0600);
> fs=get_fs();
> set_fs(KERNEL_DS);
> ---
> Is there really no API for a uart attached device to communicate with it?
> 
> That would be the last thing I thought of :(.

Wait, you want to talk to a serial port from within the kernel?  No,
don't open the device node, just talk directly to the tty layer.  An
example of code that does this is some of the bluetooth layer.

good luck,

greg k-h
