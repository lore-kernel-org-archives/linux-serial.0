From: "Alan Grimes" <alangrimes@starpower.net>
Subject: =\
Date: Sun, 07 Nov 2004 14:04:43 GMT
Message-ID: <10486807836-BeMail@BeBox>
Mime-Version: 1.0
Content-Type: text/plain; charset="dos-437"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:15871 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261675AbUKGTJJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Nov 2004 14:09:09 -0500
Received: from 66-44-55-133.s387.tnt1.lnhva.md.dialup.rcn.com ([66.44.55.133]:49244 helo=smtp.starpower.net)
	by smtp04.mrf.mail.rcn.net with smtp (Exim 4.42 #5)
	id 1CQsPU-0007c7-7P
	for linux-serial@vger.kernel.org; Sun, 07 Nov 2004 14:09:08 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

While I'm sitting here waiting for my linux machine to serve a login to 
my terminal emulator on my BeOS machine over a serial cable, (it takes 
a minute or two to respond under this 2.6.9 kernel as opposed to 
instantly for the 2.4.27 kernel), I'm going to report a very serious 
bug.. (admittedly, this absurdly long latancy is also present on the 
regular console but linux offers far too few clues as to why...) 

Hitting enter exactly once to cause the logon prompt to appear causes 
several logon prompts to appear over the next several seconds. However, 
when login is accomplished the machine behaves very well. -- go figure. 

I am beginning to suspect that the reason I can't get a reliable dialup 
connection using the other serial port (an actual hardware port on the 
back of the machine), is that tthe serial driver or something in the 
kernel which, in some way, supports the serial port causes all outbound 
network trafic to (apparently) fail. and completely precludes all 
inbound trafic. 

Recompiling the kernel last night I found that there were different ppp 
drivers for synchronous and asynchronoous ports... I made sure those 
were correct.. I hoped that would fix it, it seemed to at first but now 
it is as unreliable as ever...

A typical dialup session on 2.6.9 will -- about 2/3rds of the time, 
successfully chat with the modem and make a connection. -- Other times 
the chat fails randomly during any part of the process from 
initializing the modem to negotiating a PPP session. 

Earlier 2.6 kernels would disconnect randomly, this one just freezes. =
\ 

It's somewhat frustrating when it takes you 2+ hours to get your e-
mail. =( 
