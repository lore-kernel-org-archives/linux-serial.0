From: Nickie Deuxyeux <the_lt@mail.ru>
Subject: High speed RS232 card woes
Date: Wed, 15 Mar 2006 13:16:19 +0300
Message-ID: <4417E973.6070602@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx3.mail.ru ([194.67.23.149]:7006 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751596AbWCOKQt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Mar 2006 05:16:49 -0500
Received: from [81.195.17.170] (port=19413 helo=[192.168.1.67])
	by mx3.mail.ru with asmtp
	id 1FJT3f-0009xE-00
	for linux-serial@vger.kernel.org; Wed, 15 Mar 2006 13:16:48 +0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everyone,

I am trying to setup a 2-port high-speed RS232 card (MP954R2) under 
Gentoo Linux 2006.0. The card has an Oxford Semi OX16PCI954 chip and a 
clock oscillator at 1.8432 Mhz.

I am running the latest 2.6.15-gentoo-r1 kernel with the following 
related .config options.

*Code:*

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y



Here goes the lspci output...

*Code:*

00:0d.0 Serial controller: Oxford Semiconductor Ltd OX16PCI952 (Dual 
16950 UART) (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd Unknown device 0001
        Flags: medium devsel, IRQ 16
        I/O ports at 2058 [size=8]
        I/O ports at 2050 [size=8]
        I/O ports at 2060 [size=32]
        Memory at f4104000 (32-bit, non-prefetchable) [size=4K]
        Memory at f4103000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1



This is my setserial output...

*Code:*

 setserial -g -a /dev/ttyS*
/dev/ttyS0, Line 0, UART: 16550A, Port: 0x03f8, IRQ: 4
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

/dev/ttyS1, Line 1, UART: 16550A, Port: 0x02f8, IRQ: 3
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

/dev/ttyS2, Line 2, UART: 16950/954, Port: 0x2058, IRQ: 16
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_shi skip_test

/dev/ttyS3, Line 3, UART: 16950/954, Port: 0x2050, IRQ: 16
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_shi skip_test



This is my /etc/serial.conf

*Code:*

/dev/ttyS2 baud_base 115200 spd_shi
/dev/ttyS3 baud_base 115200 spd_shi


The serial script is activated at boot-time.

The main problem is, the device I am trying to connect (CDMA terminal) 
can only work with a baud rate of 230400. I can't seem to get the device 
to respond to AT commands in minicom, though I have absolutely no 
problems under Windows, the device works flawlessly using the same card.

I've tried setting minicom to 230k and to 38.4k, tried playing with 
"baud_base" and other settings like flow control to no avail.

There must be something I am doing wrong here, but I ran out of ideas! 
I've also been informed that I may need an alternative driver, but I 
have no idea where to find one.

Please help! Thanks in advance for any replies!
