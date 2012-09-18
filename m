From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Linux USB Serial
Date: Tue, 18 Sep 2012 08:46:10 +0200
Message-ID: <5789366.GGq3fAeCyr@linux-lqwf.site>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> <87zk4o1kh4.fsf@nemi.mork.no> <00b801cd9518$715dd160$54197420$@acscontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56979 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321Ab2IRGri (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Sep 2012 02:47:38 -0400
In-Reply-To: <00b801cd9518$715dd160$54197420$@acscontrol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Steven J. Ackerman" <steve@acscontrol.com>
Cc: =?ISO-8859-1?Q?=27Bj=F8rn?= Mork' <bjorn@mork.no>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Monday 17 September 2012 17:07:26 Steven J. Ackerman wrote:
> Bjrn-
> 
> Thank you for your response.
> 
> This change gets me closer. I can now successfully execute the modprobe
> without error, but the device still doesn't show up in /dev/ttyUSB? .

It shouldn't. Your device follows the CDC ACM specification, aside from
the incorrect subclass. Such devices don't generate /dev/ttyUSB devices
nodes. They generate /dev/ttyACM nodes.

> sja@UBUNTU-10:~$ sudo modprobe usbserial vendor=0x0c6a product=0x0005

That is the wrong driver. usbserial is for vendor specific serial devices.
Your device follows a class specification. You need cdc_acm. As soon
as the subclass is fixed, it should autoload.

If cdc_acm doesn't bind, please post "dmesg".

	Regards
		Oliver

