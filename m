From: Roger Davis <rogerdavis@verizon.net>
Subject: Fwd: RESEND: Delivery Notification: Delivery has failed - Linux Serial
 Code Problems
Date: Tue, 03 Sep 2013 20:08:16 -0500 (CDT)
Message-ID: <13899040.614860.1378256896870.JavaMail.root@vms170033>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56435 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934187Ab3IDCI2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Sep 2013 22:08:28 -0400
Received: from vms170033pub.verizon.net ([unknown] [192.168.1.50])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTP id <0MSK00GU8TTS8710@vms173001.mailsrvcs.net> for
 linux-serial@vger.kernel.org; Tue, 03 Sep 2013 20:08:16 -0500 (CDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

 Resend in plain text...

----------Original Message----------
From: postmaster@verizon.net
Date: Sep 3, 2013 12:57:28 AM
Subject: Delivery Notification: Delivery has failed
To: rogerdavis@verizon.net
 
This report relates to a message you sent with the following header fields:

 Message-id: <23861466.541760.1378191434963.JavaMail.root@vms170033>
 Date: Tue, 03 Sep 2013 01:57:14 -0500 (CDT)
 From: Roger Davis <rogerdavis@verizon.net>
 To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
 Subject: Linux Serial Code Problems

Your message cannot be delivered to the following recipients:

 Recipient address: linux-serial@vger.kernel.org
 Reason: SMTP transmission failure has occurred
 Diagnostic code: smtp;550 5.7.1 Content-Policy reject msg: The message contains HTML, therefore we consider it SPAM. Send pure TEXT/PLAIN if you are not a spammer. BF:<U 0.50262>; S1752039Ab3ICH51
 Remote system: dns;vger.kernel.org (TCP|206.46.173.7|47547|209.132.180.67|25) (vger.kernel.org ZMailer Server 2.99.57.pre4 #3 ESMTP ready at Tue, 3 Sep 2013 03:57:27 -0400)



Reporting-MTA: dns;vms173007.mailsrvcs.net (tcp-daemon)
Arrival-date: Tue, 03 Sep 2013 01:57:15 -0500 (CDT)

Original-recipient: rfc822;linux-serial@vger.kernel.org
Final-recipient: rfc822;linux-serial@vger.kernel.org
Action: failed
Status: 5.7.1 (SMTP transmission failure has occurred)
Remote-MTA: dns;vger.kernel.org (TCP|206.46.173.7|47547|209.132.180.67|25)
 (vger.kernel.org ZMailer Server 2.99.57.pre4 #3 ESMTP ready at Tue, 3 Sep 2013
 03:57:27 -0400)
Diagnostic-code: smtp;550 5.7.1 Content-Policy reject msg: The message contains
 HTML, therefore we consider it SPAM. Send pure TEXT/PLAIN if you are not a
 spammer. BF:<U 0.50262>; S1752039Ab3ICH51



Greg - I hope this (linux-serial@vger.kernel.org) was the correct address. If not, please let me know what it is and I will immediately take care of sending it properly. I want to properly do whatever is needed to fix this bug.
Thanks! 

----------Original Message---------- 

Also, I forgot to mention I'm running 12.04 version. 

 
The reasonable man adapts himself to the world.

The unreasonable man persists in trying to adapt the world to himself.
Therefore, all progress depends on the unreasonable man.

 -----------------------------------------------------------------------------------------------------
 
On Mon, Sep 02, 2013 at 06:14:30PM -0500, Roger Davis wrote:
> I have been pursuing a serial port problem for over a year. I reported it on 
> 2012-12-07, and the bug was confirmed soon after that. I'm not sure if the
> root cause is in the basic Linux kernel, or if it is only in Ubuntu. Others
> are having problems with similar modems.
> 
> The exact same computer and modem (USR 5610C, PCI, 16550 chip, Linux
> compatible, http://www.usr.com/products/modem/modem-comparison.asp , with
> integral controller and serial port, NOT a Wimmodem ) works just fine in
> Windoze. I switch OS's by hardwire switches in removable drive trays, so it is
> really the very same computer, not just another one of the same spec.
> 
> The serial port ttyS4 seems to be detected, but not detected, and not usable by
> the modem. IRQ 17 also seems to behave oddly. I suspect that internal modems
> with both controller and integral serial ports have been kinda "overlooked", so
> the code gets confused?
> 
> There has been no action, and the bug is still unassigned.
> 
> Please see confirmed bug " https://bugs.launchpad.net/ubuntu/+bug/1087519 " for
> much more details.

