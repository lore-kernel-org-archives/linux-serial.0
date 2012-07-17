From: "Tobias Arp" <tobiasarp@gmx.de>
Subject: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 09:43:55 +0200
Message-ID: <20120717074355.80180@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36716 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754611Ab2GQHn7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 03:43:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

we use on our system (ARM board Processor EP9315) a quad uart (ST16C654) with kernel 3.2 (the quad uart is connected only to one irq, so the four interfaces of the quad uart have to share this irq). Multiple simultanous  connections are working fine for some hours (3 Modem connections and one null modem connection / transferring data in both directions with hardware handshake (CRTSCTS) enabled). Then one connection can't send data to the remote host anymore (often the null modem connection). The driver is the 8250 serial driver.

I found out that the hw_stopped flag is set to 1 but not set to 0 again although CTS is set (measuring with the oscilloscope and reading out the modem status register are confirming this / i modified the serial8250_get_mctrl function to print out these values).

It seems to me that an CTS change (UART_MSR_DCTS) is lost.
Could this cause this behaviour?

Any suggestions for a workaround are appreciated.

Thanks in  advance

Tobias




