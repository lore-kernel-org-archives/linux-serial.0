From: Ed Vance <EdV@macrolink.com>
Subject: RE: 4 port serial card configuration
Date: Fri, 7 Feb 2003 12:20:09 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33D8D@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: "'Ward... James Ward'" <jew@Mail.Research.Bio2.EDU>
Cc: 'linux-serial' <linux-serial@vger.kernel.org>

Hi James,

Yes, it looks like that card is already supported in the serial driver. Run
dmesg | more and find the initialization messages from the serial driver. It
should look something like the following:

Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS04 at port 0x24a0 (irq = 10) is a 16C950/954
ttyS05 at port 0x24a8 (irq = 10) is a 16C950/954
ttyS06 at port 0x24b0 (irq = 10) is a 16C950/954
ttyS07 at port 0x24b8 (irq = 10) is a 16C950/954
ttyS08 at port 0x2400 (irq = 10) is a 16C950/954
ttyS09 at port 0x2408 (irq = 10) is a 16C950/954
ttyS10 at port 0x2410 (irq = 10) is a 16C950/954

Any entries named ttyS04 and higher are probably the VScom card. If the
VScom is the only PCI serial card in the system, its ports should show up as
ttyS04 - ttyS07. By the way, this text was taken from a RedHat 7.3 system.

If the driver has detected the VScom's ports, there is nothing more that
needs to be done to make the ports available as /dev/ttyS4 through
/dev/ttyS7.

What is the automatic setup program that you mention? 
What are the directions that were given for additions to
/sbin/init.d/serial? Is it a setserial script?

Ed

-----Original Message-----
From: Ward... James Ward [mailto:jew@Mail.Research.Bio2.EDU]
Sent: Friday, February 07, 2003 8:18 AM
To: edv@macrolink.com
Cc: Ward... James Ward
Subject: 4 port serial card configuration


Ed,

I saw a post on the linux kernel mailing list and you seem to know 
EVERYTHING about serial connections under Linux.  I have what I am sure is 
a very basic problem for you, but it seems daunting to me.

I have installed a VSCOM 410H four port PCI controller in a Dell running 
Redhat 8.0.  All I need to do is set it up to connect several scientific 
instruments.  When I run the automatic setup program, it doesn't seem to 
respond to many keystrokes, so I can't figure out how it's supposed to 
work.  And then it becomes a runaway process more often than not.  I do 
see the card in /proc/pci:

  Bus  1, device   8, function  0:
    Serial controller: Titan Electronics Inc VScom 400H 4 port serial 
adaptor (rev 0).
      IRQ 11.
      I/O at 0xe8e0 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xff8fe000 [0xff8fefff].
      I/O at 0xe8a0 [0xe8bf].
      Non-prefetchable 32 bit memory at 0xff8fd000 [0xff8fdfff].
  Bus  1, device   8, function  1:
    Parallel controller: Titan Electronics Inc VScom 010H 1 port parallel 
adaptor (rev 0).
      IRQ 11.
      I/O at 0xe8d8 [0xe8df].
      I/O at 0xe8c8 [0xe8cf].
      I/O at 0xe880 [0xe89f].
      Non-prefetchable 32 bit memory at 0xff8fc000 [0xff8fcfff].

So I think the card is functional?  The documentation says to set stuff up 
in /sbin/init.d/serial, but that directory structure doesn'tr even exist 
on my system.  Do I do it in /etc/init.d?

Please help...

James
