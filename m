From: Greg KH <greg@kroah.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 05:53:07 -0500
Message-ID: <20140818105307.GA5811@kroah.com>
References: <53F1CD68.9080901@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46495 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773AbaHRKxr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 06:53:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id D406C22E17
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2014 06:53:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53F1CD68.9080901@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, Aug 18, 2014 at 11:54:48AM +0200, Cestonaro Thilo wrote:
> Hey,
> 
> I need to write a driver which communicates with it's chip via uart.
> So I was wondering which the best way is to do this.
> 
> For a i2c device there is the i2c subsystem with it's
> "module_i2c_driver(foo_driver);" and so on.
> But I couldn't find any equivalent for a uart device.

Did you see include/linux/serial_core.h ?

