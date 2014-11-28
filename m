From: Dmitriy Fitisov <dmitriy@radier.ca>
Subject: Making our own device work under Linux
Date: Fri, 28 Nov 2014 13:39:36 -0500
Message-ID: <37235F81-C73A-4CBB-A4ED-C1B9B8D8182D@radier.ca>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from old.radier.ca ([76.10.149.124]:59690 "EHLO server.radier.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750976AbaK1Sj7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 13:39:59 -0500
Received: from localhost (unknown [127.0.0.1])
	by server.radier.ca (Postfix) with ESMTP id 4E2DE1292ED4
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2014 13:39:55 -0500 (EST)
Received: from server.radier.ca ([127.0.0.1])
	by localhost (server.radier.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EYO9IJB7q-73 for <linux-serial@vger.kernel.org>;
	Fri, 28 Nov 2014 13:39:37 -0500 (EST)
Received: from dmitriys-mbp.castgroup.local (mail.castgroupinc.com [108.63.21.110])
	by server.radier.ca (Postfix) with ESMTPSA id D01151292EA8
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2014 13:39:37 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everyone,
we have made our own device using STM32 chip and it works well under Windows using serial communication
through USB.
We used ST Micro supplied driver and firmware example.

  Now we have a task to make it work under Linux.
USB configuration is declared it as CDC modem, therefore Linux pickups cdc-acm driver and attach it to the device.
I tested it under Ununtu and it seems that once device is attached some program 
tests it using AT commands. I would guess it is ModemManager which is started in /etc/init/modemmanager.conf
I updated firmware on our device to process those commands, now I think I may simply remove ModemManager from startup and it would be fine.

But our final platform should be Raspberry.
It seems init here a little bit different, I do not see initctl program, man init differs and I'm getting different data on my device.
It sounds like terminal sequence, with lot of "0x20 0x08" bytes after start sequence.

So, I need to find out what program/daemon/service trying to communicate with cdc-acm.
Is there a simple easy way without recompiling kernel with debug info?

Thank you.
Dmitriy