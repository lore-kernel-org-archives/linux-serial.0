From: "Karl Kamysek" <karl.kamysek@gmail.com>
Subject: Serial Port Woes - Blocked From Sending?
Date: Fri, 6 Oct 2006 08:40:55 -0400
Message-ID: <9248506a0610060540k3972d2b4k33e6d02ab1a81b2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:16619 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751258AbWJFMk4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 08:40:56 -0400
Received: by wx-out-0506.google.com with SMTP id s14so825242wxc
        for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2006 05:40:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, hope someone can help me out here, I'm a linux noob with a serial
port issue :)

I'm running a distro called KnoppMyth R5D1.  It's a Knoppix based
distro designed specifically for running MythTV, a pvr program in case
you need to know.

I need to send a signal out the serial port (via a script) to change
the channel on my digital cable box.  It worked fine on previous
versions but not at all on this build.

I have already determined all of the hardware involved does work (
e.g. cable box accepts input through serial port, cable is good, etc.)

Here's the info on my serial ports;

root@mythtv:/# dmesg | grep tty
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

root@mythtv:/# setserial -g /dev/ttyS[01]
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3

Now following along with this howto

http://www.linux.org/docs/ldp/howto/Serial-HOWTO-11.html

I checked the serial port and find it appears to be blocked from
sending according to this:

"The transmit pin should go from several volts negative to a voltage
fluctuating around zero after you start sending the bytes. If it
doesn't (but the DTR went positive) then you've got the right port but
it's blocked from sending. This may be due to a wrong IRQ, -clocal
being set, etc. The command "stty -F /dev/ttyS1 -a" should show clocal
(and not -clocal). If not, change it to clocal."

Well, my signal went to about 10-12 volts positive so I'm assuming the
port is blocked from sending.  Checking for -clocal vice clocal shows;

root@mythtv:/# stty -F /dev/ttyS0 -a
speed 9600 baud; rows 0; columns 0; line = 0;
intr = <undef>; quit = <undef>; erase = <undef>; kill = <undef>; eof =
<undef>; eol = <undef>; eol2 = <undef>;
start = <undef>; stop = <undef>; susp = <undef>; rprnt = <undef>;
werase = <undef>; lnext = <undef>; flush = <undef>;
min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal -crtscts
ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl
-ixon -ixoff -iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0
bs0 vt0 ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase
-tostop -echoprt -echoctl -echoke

It does show clocal not -clocal.  What else could then be blocking the
port from sending a signal out?

 The source for the channel change script can be seen here,
http://www.cuymedia.net/doxygen-dev-docs/html/channel_8c-source.html

Here is the specific error I get when running my channel change script;

root@mythtv:/home/mythtv/tmp/mythtv
/contrib/channel_changers/dct-channel# ./channel -v 10
 Attempting to initialize DCT
 No response to packet
 No response to init_1; trying to continue
 No response to packet
 No response to initialize_2
 Initialization failed
 Attempting to initialize DCT
 No response to packet
 No response to init_1; trying to continue
 No response to packet
 No response to initialize_2
 Initialization failed
 Attempting to initialize DCT
 No response to packet
 No response to init_1; trying to continue
 No response to packet
 No response to initialize_2
 Initialization failed
 Attempting to initialize DCT
 No response to packet
 No response to init_1; trying to continue
 No response to packet
 No response to initialize_2
 Initialization failed
 Attempting to initialize DCT
 No response to packet
 No response to init_1; trying to continue
 No response to packet
 No response to initialize_2
 Initialization failed
 Communication failed after 5 tries
 0
 root@mythtv:/home/mythtv/tmp/mythtv/contrib/channel_changers/dct-channel#

Thanks much, If anyone can help I'd really appreciate it, and if you
need any more info just ask!

Kamy
