From: Dmitriy Fitisov <dmitriy@radier.ca>
Subject: Re: Making our own device work under Linux
Date: Fri, 28 Nov 2014 14:05:55 -0500
Message-ID: <47A1438A-BFBE-4B3E-836E-D4A418DB3CC5@radier.ca>
References: <37235F81-C73A-4CBB-A4ED-C1B9B8D8182D@radier.ca> <20141128184845.GA30162@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from old.radier.ca ([76.10.149.124]:60405 "EHLO server.radier.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751041AbaK1TGJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 14:06:09 -0500
In-Reply-To: <20141128184845.GA30162@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Thank you.
I registered on a forum, awaited activation.
Raspberry mailing list is virtually dead, producing a few kilobytes montly.
But anyway, it is pretty much Debian I would think.

On Nov 28, 2014, at 1:48 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Nov 28, 2014 at 01:39:36PM -0500, Dmitriy Fitisov wrote:
>> Hello everyone,
>> we have made our own device using STM32 chip and it works well under Windows using serial communication
>> through USB.
>> We used ST Micro supplied driver and firmware example.
>> 
>>  Now we have a task to make it work under Linux.
>> USB configuration is declared it as CDC modem, therefore Linux pickups cdc-acm driver and attach it to the device.
>> I tested it under Ununtu and it seems that once device is attached some program 
>> tests it using AT commands. I would guess it is ModemManager which is started in /etc/init/modemmanager.conf
>> I updated firmware on our device to process those commands, now I think I may simply remove ModemManager from startup and it would be fine.
>> 
>> But our final platform should be Raspberry.
>> It seems init here a little bit different, I do not see initctl program, man init differs and I'm getting different data on my device.
>> It sounds like terminal sequence, with lot of "0x20 0x08" bytes after start sequence.
>> 
>> So, I need to find out what program/daemon/service trying to communicate with cdc-acm.
>> Is there a simple easy way without recompiling kernel with debug info?
> 
> There are lots of different distros for the Raspberry Pi, I would
> suggest asking on the mailing list of the distro you are using to try to
> determine this, as the people there will be able to help you out the
> best.
> 
> Good luck,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

