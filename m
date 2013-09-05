From: Roger Davis <rogerdavis@verizon.net>
Subject: Re: Linux Serial Code Problems
Date: Thu, 05 Sep 2013 02:57:51 -0500 (CDT)
Message-ID: <13948377.218867.1378367871551.JavaMail.root@vznit170080>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53755 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763222Ab3IEH6K (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 03:58:10 -0400
Received: from vznit170080pub.verizon.net ([unknown] [192.168.1.50])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTP id <0MSN00HP87GFGY20@vms173001.mailsrvcs.net> for
 linux-serial@vger.kernel.org; Thu, 05 Sep 2013 02:57:51 -0500 (CDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

RE: Linux Serial Code Problems 

I recently found the following info.  Perhaps I'm confused, but it seems apparent to me that there is a known basic deficiency in the code causing this problem from the following quote found at :       http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CC4QFjAA&url=http%3A%2F%2Fserial.sourceforge.net%2F&ei=8DUoUo_pL6mGiQL50oCQDg&usg=AFQjCNEM7PQaUtOlie3UHz1fotvbTgPLNg&sig2=sM8-xwyv7dYtcJQ-k8aelg    
===============================
 "Periodically, I will release testing serial drivers with my guessesas to how to let the serial driver talk to a particular PCI serialboard. As you may have gathered by now, there is no standard PCIserial interface. (The PCI consoritium which is in charge ofstandardizing the PCI bus must have been   ASLEEP AT THE SWITCH  ." (my caps),   found at :       http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CC4QFjAA&url=http%3A%2F%2Fserial.sourceforge.net%2F&ei=8DUoUo_pL6mGiQL50oCQDg&usg=AFQjCNEM7PQaUtOlie3UHz1fotvbTgPLNg&sig2=sM8-xwyv7dYtcJQ-k8aelg

also...

PCI Modem support

I am getting a lot of e-mail messages about supporting PCI modems,so here's the scoop concerning supporting PCI serial/modem devices.Right now *NO* PCI modems are supported, although support for some arein testing. If you have some PCI modem, please read on below; if youhave a PCI serial board which is not a modem, please skip to the next section....

First of all, the serial driver does not, and will never support,controller-less modems, which are somtimes called winmodems.(n.b. Winmodem(tm) is a trademark of 3COM corporation, and refers to aspecific brand of controller-less modems. However, people havestarted using "winmodems", without the capital letter, to refer tothe generic class of modems which require a windows specific driverbecause they do not implement a full modem in hardware.) If you havea PCI-based modem, the odds are about even as to whether or not it isa winmodem or not. The following site, "Winmodems are notmodems". Before you send me e-mail, please check yourmodem against the listing found in the above web site; if it is awinmodem, or controller-less modem, I can't help you.

If your modem isn't listed on the "Winmodems are not modems" website, there are some other ways you can tell if your PCI modem is acontroller-less modem. If the packaging on the box states thatWindows 95 or 98 is a requirement, that's a pretty good hint. Modemswhich are labeled as "HCF" modems (Host Controller Family) fromRockwell are controller-less modems. If you've installed the softwareon a Windows box, you can check and see how big are the drivers thatthey've installed. If the driver (typically a .VXD file) is large,that's another tipoff. If the modem is extremely cheap (20 or 30 USdollars), that's another hint. Fundamentally, you get what you payfor.

If you are unfortunate enough to own a winmodem and desire to useit under Linux, there is a project which is trying to develop a driverfor some controller-less modem chipsets. But because of thecomplexities associated with the modem protocol standards (V.90 V.34,and their ilk), they have a long road ahead of them. If you areinterested in more information, please refer to the Linmodem Web Site. (Update:There is now an Alpha driver for the Lucent winmodems, and PC-TEL hasreleased a binary-only driver.)
===========================

Is the above "ASLEEP AT THE SWITCH" still current info, and if so, is there any plan to rectify the lack of PCI bus serial interface situation?

Thanks!

