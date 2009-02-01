From: Christian Gagneraud <cgagneraud@techworks.ie>
Subject: Performance issue with 8250/16550 on ARM/PC104 boards (?)
Date: Sun, 01 Feb 2009 13:55:30 +0000
Message-ID: <4985A9D2.1030708@techworks.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [86.43.120.173] ([86.43.120.173]:51862 "EHLO [192.168.5.1]"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751716AbZBAOT7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Feb 2009 09:19:59 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk

Hi all,

I'm working on a data acquisition system which need to record data at 
5 Hz, these data come from analog and discrete boards and from serial 
instruments as well.
This is implemented on ARM/PC104 based embedded systems.
I have noticed that i have lot of input overrun when i use any PC104 
16550 based serial boards.

First of all, i m completely sure that the CPU is not overloaded, 
definitely the system spend almost all its time waiting for data 
(processes/threads spend more time sleeping in the select syscall, and 
the load average of the system is ridiculously low, smth like 0.0/0.2).
Secondly, i'm not asking to sample 10 serial ports running at insane 
baudrates. Currently one instrument send data at 115200, one at 19200 
and a third one at 4800.
Thirdly, The gathered data are written to a text file as they arrived 
and parsed.
Finally it is clear for me that in the userspace nothing much 
happened, but in kernel space there's "quite lot" of work to be done 
(handling a continuous flow of data/irq).

I've tried so far 2 different boards from 2 different companies, and i 
came to the same result, the 8250/16550 drivers through a PC104 bus 
are slow, too slow... At least it looks to me it is the case...

The last board i have tested had 8 built-in serial port, implemented 
in a FPGA, these are proprietary IP core that comes with their own 
(open source) drivers, each serial port has a dedicated interrupt 
line. When i run my application with these serial ports everything is 
fine, but as this acquisition system is deployed on the field (on the 
sea to be more precise), we need a GSM link.  The GSM board i have is 
a PC104 board that has a 16550 single UART chip. And guess what 
happened when i do an "ifup ppp0"? My other serial ports start loosing 
data....

So i am wandering if you have ever heard about performance issue in 
such kind of application, what people here think about that, and if 
anyone would have some advice on how i could debug and understand 
what's going on my system.

Thanks,
Chris

PS: I've cross-posted to linux-arm and linux-serial bacause i think 
that linux-serial is more appropriate for my problem but on the other 
hand i think that there's more people on linux-arm that could have 
encourted this kind of problems, hope i didn't hurt anyone! ;)



