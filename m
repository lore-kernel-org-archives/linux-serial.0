From: Lee Howard <lee.howard@mainpine.com>
Subject: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Wed, 08 Dec 2010 15:55:29 -0800
Message-ID: <4D001AF1.80902@mainpine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fangorn.howardsilvan.com ([216.235.106.115]:46128 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0LIACb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Dec 2010 19:02:31 -0500
Received: from fangorn.howardsilvan.com (localhost [127.0.0.1])
	by mail.howardsilvan.com (Postfix) with ESMTP id 5929CC421AF
	for <linux-serial@vger.kernel.org>; Wed,  8 Dec 2010 15:55:26 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everyone,

A week ago I had a customer report to me that they were having problems 
using the Mainpine IQ Express Rev3 (multiport modem which uses the 
Oxsemi OXPCIe95x chipset) after updating their system from kernel 
2.6.22.10 (which they patched because native support for the IQ Express 
didn't enter the kernel until 2.6.28) to kernel 2.6.36.

As I had never used any 2.6.36 kernel, myself, I explained that I had 
experienced no problem with the 2.6.35.6 kernel (as found in Fedora 14) 
at which point they installed kernel 2.6.35.8 and reported back that 
this had resolved the problem for them.

Following their report I then tested by installing the 2.6.37-rc4 kernel 
(using 'make oldconfig', taking .config from the Fedora 14 kernel that 
was working), and I was quickly able to determine that there were 
problems because simple communications with the modems were not working 
properly using 'minicom'.  (I also have now tested with 2.6.37-rc5 with 
the same result.)  Characters appear to be getting lost/dropped in the 
communication... for example, I *expect* the following on the minicom 
terminal screen when I start it up as it initializes the modem:

-------------------
AT S7=45 S0=0 L1 V1 X4 &c1 E1 
Q0                                                           
OK                                                                                          

-------------------

The blinking cursor will be on the line following the OK.  This is what 
happens when using kernel 2.6.35.  However, when I use 2.6.37-rc5 this 
is what I see:

-------------------
AT S7=45 S0=0 L1
-------------------

Sometimes there is a character or two more on the screen but there will 
be no OK and the cursor will be blinking at the end of the line of 
commands... which leads me to believe that the modem did not see the 
CR+LF from the application.  If I simply press enter on the terminal, 
then I'll see the OK as expected.  So it seems to me that only the first 
bunch of characters are making it through and that the rest are getting 
dropped for some reason.

setserial tells me the following about the port:

# setserial -G /dev/ttyS4
/dev/ttyS4 uart 16950/954 port 0x0000 irq 18 baud_base 4000000 
spd_normal skip_test

I think I can say with confidence that the problem started with 2.6.36.

What can I do to help solve the problem?

Thanks,

Lee.

-- 
*Lee Howard*
*Mainpine, Inc. Software Development Lead*
Tel: +1 866 363 6680 | Fax: +1 360 462 8160
lee.howard@mainpine.com | www.mainpine.com
