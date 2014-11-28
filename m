From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Making our own device work under Linux
Date: Fri, 28 Nov 2014 10:48:45 -0800
Message-ID: <20141128184845.GA30162@kroah.com>
References: <37235F81-C73A-4CBB-A4ED-C1B9B8D8182D@radier.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53189 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaK1SuH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 13:50:07 -0500
Content-Disposition: inline
In-Reply-To: <37235F81-C73A-4CBB-A4ED-C1B9B8D8182D@radier.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Fitisov <dmitriy@radier.ca>
Cc: linux-serial@vger.kernel.org

On Fri, Nov 28, 2014 at 01:39:36PM -0500, Dmitriy Fitisov wrote:
> Hello everyone,
> we have made our own device using STM32 chip and it works well under Windows using serial communication
> through USB.
> We used ST Micro supplied driver and firmware example.
> 
>   Now we have a task to make it work under Linux.
> USB configuration is declared it as CDC modem, therefore Linux pickups cdc-acm driver and attach it to the device.
> I tested it under Ununtu and it seems that once device is attached some program 
> tests it using AT commands. I would guess it is ModemManager which is started in /etc/init/modemmanager.conf
> I updated firmware on our device to process those commands, now I think I may simply remove ModemManager from startup and it would be fine.
> 
> But our final platform should be Raspberry.
> It seems init here a little bit different, I do not see initctl program, man init differs and I'm getting different data on my device.
> It sounds like terminal sequence, with lot of "0x20 0x08" bytes after start sequence.
> 
> So, I need to find out what program/daemon/service trying to communicate with cdc-acm.
> Is there a simple easy way without recompiling kernel with debug info?

There are lots of different distros for the Raspberry Pi, I would
suggest asking on the mailing list of the distro you are using to try to
determine this, as the people there will be able to help you out the
best.

Good luck,

greg k-h
