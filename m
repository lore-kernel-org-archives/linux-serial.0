From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 13:29:14 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031211132914.I12637@microdata-pos.de>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com> <20031210.203940.8.0.whitnl73@juno.com> <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com> <20031211103352.G12637@microdata-pos.de> <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:19979
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S264923AbTLKM3Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 07:29:16 -0500
Content-Disposition: inline
In-Reply-To: <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com>; from informatic@sedifa.com on Thu, Dec 11, 2003 at 01:12:54PM +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,
On Thu, Dec 11, 2003 at 01:12:54PM +0100, Albert Cervera Areny wrote:
> Thanks for your suggestion, in fact now we can receive data from the note
> dispenser and see the 'Ok' response. We keep on beeing unable to use the
> other devices though. It seems that for some strange (to us) reason,
> devices are not receiving data correctly (as they would do the appropiate
> thing even if we didn't receive any response). Do you have any ideas on
> why the sent data shouldn't be received correctly by the device? I've
> looked at the speed, parity, CS and Bstop parameters but they are right.
> Could there be any other reason for that strange behaviour in some of the
> devices?
I think the Card-Reader need 9600/8bit/None Parity and CRTSCTS

t.c_cflag 		= baud|parity|bits|stop ;
t.c_cflag 		|= CRTSCTS;

Use tcdrain with caution, tcdrain blocks forever without a device ! 
better use in a timed loop;

ioctl(fd, TIOCOUTQ, &bytes)  bytes = bytes in outqueue

Michael
