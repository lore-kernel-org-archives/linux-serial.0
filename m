From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Subject: Re: How to get a list of all available serial ports?
Date: Thu, 26 Aug 2004 12:52:27 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <412DC0EB.1090605@wincor-nixdorf.com>
References: <200408260924.02123.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mixi.wincor-nixdorf.com ([217.115.67.70]:44011 "HELO
	mail.wincor-nixdorf.com") by vger.kernel.org with SMTP
	id S268724AbUHZLLI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Aug 2004 07:11:08 -0400
Received: from label.wincor-nixdorf.com (label.wincor-nixdorf.com [172.18.160.24])
	by zapp.wincor-nixdorf.com (8.12.8/8.12.8) with ESMTP id i7QBB3CU018327
	for <linux-serial@vger.kernel.org>; Thu, 26 Aug 2004 13:11:03 +0200
In-Reply-To: <200408260924.02123.fmmarzoa@softronica.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org



> Under Windows my program is able to perform an autodetection of the device 
> with which it work. For that it takes a list of all available serial ports 
> from Windows registry. 
> 
> Is there any manner to do the same under LiNUX that works on all 
> distributions?



hi,

cat /proc/ioports and serach serial

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
0340-0340 : HiSax hscx A fifo
03c0-03df : vga+
03f8-03ff : serial(auto)
0740-075f : HiSax hscx A
0b40-0b40 : HiSax hscx B fifo
0cf8-0cff : PCI conf1
0f40-0f5f : HiSax hscx B
1340-1340 : HiSax isac fifo
1740-175f : HiSax isac
1b40-1b47 : avm cfg
e800-e8ff : Adaptec AHA-2940U2/W
f0a0-f0bf : Intel Corp. 82371AB PIIX4 ACPI
f0c0-f0ff : Intel Corp. 82371AB PIIX4 ACPI
f400-f43f : Intel Corp. 82557 [Ethernet Pro 100]
   f400-f43f : eepro100
f800-f81f : Intel Corp. 82371AB PIIX4 USB
   f800-f81f : usb-uhci
fcf0-fcff : Intel Corp. 82371AB PIIX4 IDE
   fcf0-fcf7 : ide0
   fcf8-fcff : ide1

or cat /proc/tty/driver/serial

serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16550A port:3F8 irq:4 baud:9600 tx:11 rx:0
1: uart:16550A port:2F8 irq:3 baud:9600 tx:11 rx:0

Frank
