From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 14:27:05 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031211142704.J12637@microdata-pos.de>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com> <20031210.203940.8.0.whitnl73@juno.com> <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com> <20031211103352.G12637@microdata-pos.de> <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com> <20031211132914.I12637@microdata-pos.de> <32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:21771
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S264935AbTLKN1G (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 08:27:06 -0500
Content-Disposition: inline
In-Reply-To: <32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com>; from informatic@sedifa.com on Thu, Dec 11, 2003 at 02:08:44PM +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Thu, Dec 11, 2003 at 02:08:44PM +0100, Albert Cervera Areny wrote:
> 
> > Hello,
> > On Thu, Dec 11, 2003 at 01:12:54PM +0100, Albert Cervera Areny wrote:
> >> Thanks for your suggestion, in fact now we can receive data from the
> >> note
> >> dispenser and see the 'Ok' response. We keep on beeing unable to use the
> >> other devices though. It seems that for some strange (to us) reason,
> >> devices are not receiving data correctly (as they would do the
> >> appropiate
> >> thing even if we didn't receive any response). Do you have any ideas on
> >> why the sent data shouldn't be received correctly by the device? I've
> >> looked at the speed, parity, CS and Bstop parameters but they are right.
> >> Could there be any other reason for that strange behaviour in some of
> >> the
> >> devices?
> > I think the Card-Reader need 9600/8bit/None Parity and CRTSCTS
> 
> According to the Card-Reader documentation, the parameters are: 8 bit, 1
> bit stop, even parity ant the speed is automaticalli recognized, and I've
> tried 9600 (and others too). Trying with the CRTSCTS doesn't work either.

Test with strace ?
or i

stty -F /dev/ttyS0 raw clocal ispeed 9600 parenb -parodd -echo [crtscts]

check with

stty -a -F /dev/ttyS0

cat /dev/ttyS0 > /tmp/xxxx&
printf "aa\x0d"  > /dev/ttyS0	(example) 

test with 

ls -l /tmp/xxxx
hexdump /tmp/xxxx

check the interrpts with 
cat /proc/interrupts (/proc/stat)


> 
> PS: ioctl(TIOCOUTQ) returns 0 in bytes; So it seems everything is sent,
> isn't it?
the queue is empty, it's all transmitted. 

Michael
