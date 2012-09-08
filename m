From: peter.sheeren@axiris.be
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 08 Sep 2012 19:35:16 +0200
Message-ID: <20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
 <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
 <20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
 <20120908183015.2ca02043@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay02-01.mx.hostbasket.com ([85.255.198.148]:54591 "EHLO
	mailrelay02-01.mx.hostbasket.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300Ab2IHRq3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 13:46:29 -0400
In-Reply-To: <20120908183015.2ca02043@pyramind.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org


I'm sorry, I've no experience with compiling a driver for Linux.

Q: When I plug in the USB device without even using it, should  
ftdi_sio and usbserial remain loaded after I unplug the USB device?


Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

>> The existence of /dev/ttyUSB0 depends on the system:
>> * RPi with Raspbian: /dev/ttyUSB0 never goes away after step 4.
>> * RPi with Debian6, BBXM: /dev/ttyUSB0 goes away after step 4 and
>> comes back after step 6.
>
> Thats dependant upon your user space and really nothing to do with this
>
>> Are there any commands I can run to provide you with more information?
>
> As I said...
>
>> > If you think that if check is the problem can you replace it with an
>> > unconditional call to change_speed(tty, port) and the re-test. That will
>> > confirm if it is the cause.
>
> Alan
>


