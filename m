From: "Carlos Velasco" <carlosev@newipnet.com>
Subject: Serial Console
Date: Mon, 19 Aug 2002 11:10:53 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200208191110530792.0D43161A@192.168.128.16>
References: <200208191108120240.0D409F0A@192.168.128.16>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from madre (madre.newipnet.com [192.168.128.4])
	by smtp.newipnet.com (ESMTP Server) with ESMTP id 86D293855C
	for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2002 11:12:53 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have configured kernel to do output to tty0 and ttyS0 (serial console).

LILO:
image = /boot/vmlinuz_2419
  root = /dev/hda3
  label = linux_2419
  append="console=ttyS0,115200n8r console=tty0 vga=0x0301"


However I have seen that if I don't open the serial port from another machine, I can't reboot or boot kernel, as the output seems to freeze until port is open. When I open the serial port, normal operation is resumed.
Is there something to solve this issue?
I would like to use the serial console only when needed not always that I want boot or reboot machine.

Regards,
Carlos Velasco


