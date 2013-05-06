From: Fernando Di Nucci <f.dinucci@alice.it>
Subject: Setting PL2303 baud rate
Date: Mon, 06 May 2013 22:27:51 +0200
Message-ID: <51881247.9050809@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:49316 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755971Ab3EFU1y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 16:27:54 -0400
Received: from [192.168.30.175] (79.22.98.121) by smtp206.alice.it (8.6.060.15) (authenticated as f.dinucci@alice.it)
        id 511D120D0CD7B39D for linux-serial@vger.kernel.org; Mon, 6 May 2013 22:27:52 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a PL2303HX adapter and I need to set up its baud rate to 1228800 
or 2457600

(openwrt, linux kernel 3.3.8, coreutils 8.16 and ubuntu quantal 
3.5.0-28, same coreutils).

I tried stty -F /dev/ttyUSB0 baudrate

Well, when baudrate is 921600 or 3000000 everything is fine, but when I 
try 1228800 or 2457600 stty complaints:
stty: invalid argument '2457600'.

I searched stty source and added:

#ifdef B1228800
   {"1228800", B1228800, 1228800},
#endif
#ifdef B2457600
   {"2457600", B2457600, 2457600},
#endif

and compiled but no luck. I don't know where else those values need also 
to be modified.

Can you please point me to the right direction?

Or there is another way to set pl2303 baud rate passing some information 
on the command line of kernel module?

I searched the web but didn't find any clue.

Any help appreciated, thank you very much anyway.
