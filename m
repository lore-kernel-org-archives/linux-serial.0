From: Greg KH <greg@kroah.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Tue, 19 Aug 2014 07:39:23 -0500
Message-ID: <20140819123923.GA7791@kroah.com>
References: <53F1CD68.9080901@ts.fujitsu.com>
 <20140818105307.GA5811@kroah.com>
 <53F1DF48.8000007@ts.fujitsu.com>
 <53F1E14D.7000408@ts.fujitsu.com>
 <53F202FF.5020809@ts.fujitsu.com>
 <20140818135046.GA927@kroah.com>
 <53F21418.80307@ts.fujitsu.com>
 <20140818150708.GA31497@kroah.com>
 <53F34255.8050600@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51576 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751660AbaHSMkC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2014 08:40:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id CA0FF20951
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2014 08:40:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53F34255.8050600@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Aug 19, 2014 at 02:25:57PM +0200, Cestonaro Thilo wrote:
> > You might want to step back and describe what you are wanting to do in
> > the first place before wanting to add a new line discipline.
> >
> >
> Ok.
> Imagine you have two chips, one is the cpu and the other one is a device
> which needs to be configured, accessed, talked to via uart.
> The both chips are hardwired via uart.
> Now I want to communicate from the kernel module with the device.

Why within the kernel?  Why not do the communication from userspace?

> let the device be a RTC Device which has a UART interface.

How do you talk to this UART?  Through a "normal" serial chip that the
kernel already has a driver for, or through some other hardware control
interface?

> And I don't want to rewrite all the uart device stuff of the cpu uart
> device.

What do you mean by this?

> As a i2c client doesn't implement master_xfer or whatever the transfer
> methods are called in the i2c controller module.
> It just does a i2c->write(reg, value) and I need something equivalent
> like uart->send(data, len); and uart->handle_recieved =
> my_recieved_data_handler;

Do that in userspace :)

thanks,

greg k-h
