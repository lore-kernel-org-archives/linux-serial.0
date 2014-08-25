From: Greg KH <greg@kroah.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 25 Aug 2014 07:57:10 -0700
Message-ID: <20140825145710.GA14725@kroah.com>
References: <20140818105307.GA5811@kroah.com>
 <53F1DF48.8000007@ts.fujitsu.com>
 <53F1E14D.7000408@ts.fujitsu.com>
 <53F202FF.5020809@ts.fujitsu.com>
 <20140818135046.GA927@kroah.com>
 <53F21418.80307@ts.fujitsu.com>
 <20140818150708.GA31497@kroah.com>
 <53F34255.8050600@ts.fujitsu.com>
 <20140819123923.GA7791@kroah.com>
 <53F346FB.5020101@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58531 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932328AbaHYO5y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Aug 2014 10:57:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id D33AD207B0
	for <linux-serial@vger.kernel.org>; Mon, 25 Aug 2014 10:57:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53F346FB.5020101@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Aug 19, 2014 at 02:45:47PM +0200, Cestonaro Thilo wrote:
> On 19.08.2014 14:39, Greg KH wrote:
> > On Tue, Aug 19, 2014 at 02:25:57PM +0200, Cestonaro Thilo wrote:
> >>> You might want to step back and describe what you are wanting to do in
> >>> the first place before wanting to add a new line discipline.
> >>>
> >>>
> >> Ok.
> >> Imagine you have two chips, one is the cpu and the other one is a device
> >> which needs to be configured, accessed, talked to via uart.
> >> The both chips are hardwired via uart.
> >> Now I want to communicate from the kernel module with the device.
> > Why within the kernel?  Why not do the communication from userspace?
> Cause it's a rtc, and I don't know of a way to have a /dev/rtc from
> userspace
> 
> >
> >> let the device be a RTC Device which has a UART interface.
> > How do you talk to this UART?  Through a "normal" serial chip that the
> > kernel already has a driver for, or through some other hardware control
> > interface?
> Jup, via normal serial chip.
> 
> >
> >> And I don't want to rewrite all the uart device stuff of the cpu uart
> >> device.
> > What do you mean by this?
> As it is via a normal serial chip, one option would be to write a
> sperate driver which includes all the register stuff from the original
> serial chip module.
> But this, I don't want to do.

Try using the serio interface, it should do this all for you.

greg k-h
