From: Rick Bolen <rickbolgm@gmail.com>
Subject: serial port being reset at top of every hour?
Date: Thu, 18 Sep 2008 08:14:16 -0400
Message-ID: <48D24618.1040605@gmail.com>
Reply-To: rickbolgm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:41341 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbYIRMOw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Sep 2008 08:14:52 -0400
Received: by wx-out-0506.google.com with SMTP id h27so1445890wxd.4
        for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2008 05:14:51 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello all,

I've been trying to chase down an issue for about one month now.

Config:
Debian Etch (4.04a) w/xfce, kernel 2.6.18-6-686, VIA PC2500E mobo, Moxa 
Smartio C168H/PCI (rev 01)

Symptoms:
I run a Perl based home automation software package, Misterhouse (been 
running it on various versions of Debian since ~'98). It interfaces to 
numerous serial devices through the mobo's ttyS0 and the Moxa ttyMx 
ports. It uses the SerialPort.pm PERL module (POSIX) for initializing 
and utilizing ports.

At the top of the hour, some [other] process resets either ttyM0 or 
ttyS0 (randomly determined at boot?) which causes the home automation 
software to lose communication to the device.

Question:
How can I determine what process is resetting the port? Is there any 
logging available to list PIDs that access a port? ...or a way to attach 
a debugger to "the system" so I can identify the process?

I used strace on the home automation process to verify that it wasn't 
clobbering itself, but I have no idea what other processes may be 
"candidates", so I need to watch this from the system level.

Thank you,

Rick Bolen


