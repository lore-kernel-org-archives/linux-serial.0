From: "Jim Deas" <jdeas@jadsystems.com>
Subject: Releasing the UART
Date: Fri, 25 Oct 2002 11:35:00 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <005c01c27c55$41236be0$2d2e820a@warnerbros.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jimdeas ([10.130.46.45])
	by wbsmtphost.wb.aoltw.net (8.10.2/8.10.2) with SMTP id g9PIY7B23734
	for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2002 11:34:19 -0700
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I need to write a special driver for the system UART to
support a specific protocol.
How can I get the serial.c driver (not a module in my kernel)
to release the UARTS ioports?

Regards,
JD

