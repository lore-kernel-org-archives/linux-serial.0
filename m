From: kees <kees@schoen.mine.nu>
Subject: port operation
Date: Thu, 10 May 2007 12:17:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705101146150.3020@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp13.wxs.nl ([195.121.247.4]:34073 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761292AbXEJKQw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 May 2007 06:16:52 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JHT00CIDLW281@smtp13.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 10 May 2007 12:16:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id 998663546A	for
 <linux-serial@vger.kernel.org>; Thu, 10 May 2007 12:17:01 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have a Debian system,
Linux version 2.6.20.4 (root@pc_develop02.fluidwell.local) (gcc version 
4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP PREEMPT Fri Apr 6 
13:41:02 CEST 2007

The motherboard has one serial port and the pci card (PCI 9835 Multi-I/O 
Controller) has another two. When autoconfig is set for setserial we get:

/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x1030 (irq = 20) is a 16550A
/dev/ttyS2 at 0x1028 (irq = 20) is a 16550A

I have an application that works well if I use ttyS0 but not from ttyS1 or 
ttyS2. I loose characters in the latter case. It looks if only the last 
character is outputted on the port...

I have the assumption that it must be possible to "set" the ports with 
setserial as a 16450.

/dev/ttyS0 at 0x03f8 (irq = 4) is a 16450
/dev/ttyS1 at 0x1030 (irq = 20) is a 16450
/dev/ttyS2 at 0x1028 (irq = 20) is a 16450

Doing that makes ttyS0 not longer work, here only the last character is 
output. This is similar to ttyS1/ttyS2 in 16550A mode.   ???



If I modify the application like:

#ifdef _NORMAL_SERIAL_OUT
     write(hartfd.fd, &odbuf, pcnt);
#else

int fd;
#define PORT_ADDR 0x3f8
unsigned char cc= 0x00;
    fd=open("/dev/port", O_RDWR);

    for( i =0 ; i<= pcnt; i++){
       do {
          lseek(fd, PORT_ADDR+5, 0);  // LSR
          read(fd, &cc, 1);
  fprintf(stderr,  "read LSR=%02x\n", cc);
       } while (!(cc & 0x20));
         lseek(fd, PORT_ADDR, 0);       // THR
         write(fd, &odbuf[i], 1);
  fprintf(stderr,  "write THR=%02x\n",odbuf[i]);
     }
     close(fd);
#endif

Everything is output on ttyS0, ttyS1 and ttyS2 (If I set the PORT_ADDR 
correct)
So the _device_ works well.

I noticed though that for port ttyS0 the stderr(log) shows
read LSR=60  <--
write THR=ff
read LSR=00  <--
...
read LSR=20  <--
write THR=ff
read LSR=00
...

which looks OK but for the NMOS chip I get

For ttyS1/ttyS2 I get
read LSR=60  <--
write THR=ff
read LSR=40 <-- (repeat 24 times)
...
read LSR=00 <--
...
read LSR=20 <--
write THR=ff
read LSR=00
...

So this chip does not clear XMIT Empty right away but it took time before 
it was cleared.

I feel that somewhere the driver is confused by this. But I find it 
difficult to follow the flow of the data in the serial 
driver in the kernel.

I'm able and willing to do more detailed tests (even in the driver source) 
if one asks for it.

Any clue?

regards

Kees
