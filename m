From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: tty loop-back device
Date: Sat, 28 Sep 2013 16:59:47 +0400
Message-ID: <l26jrq$48d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36182 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab3I1NFG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 09:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VPuCl-0004wF-BR
	for linux-serial@vger.kernel.org; Sat, 28 Sep 2013 15:05:03 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 15:05:03 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 15:05:03 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi,

Not sure whether here is the right place to ask. Do the kernel already 
has (or, would it be great to have) the tty loop-back support? At least 
I've not found something appropriate. I mean, imagine kind of /dev/tty 
device, supporting read/write and termios interface and transferring 
your read/write/ioctl calls to another user-space application listening, 
for instance, /dev/tty_loopback_master. Like a named pipe device.

The idea behind that is there are a lot of devices like RS232/485 
network ports, for instance:

http://www.moxa.com/product/nport_5110.htm
http://www.lantronix.com/device-networking/embedded-device-servers/xport.html
http://gridconnect.com/rs485-ethernet.html

They are just network devices which transfer kind of telnet protocol 
into their-own UARTs.

At the other hand, you have user-space application that wants to operate 
with tty serial device. And since there is standard termios interface in 
kernel, the user-space application don't care whether the serial port is 
real UART, usb-serial, AMBA, etc. We can transparently swap our 
hardware. That is not always the case when you use networked serial and 
have to communicate over IP.

Moxa NPort kernel driver is implemented in the way I am talking about 
(if I understand the code correctly). There is daemon application 
communicating with the IP network and putting data received back to the 
kernel.

