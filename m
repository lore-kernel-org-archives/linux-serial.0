From: Noam Camus <noamc@ezchip.com>
Subject: 8250_early for big-endian
Date: Fri, 12 Oct 2012 15:05:42 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:26645 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab2JLNLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 09:11:50 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hello

I am using 8250 console and wish to use the 8250_early as well.

I encounter endianess problem while using this driver for mmio32.

The problem is since my serial peripheral like my cpu is in BIG endian.

Driver through serial_in/serial_out uses readl/writel from asm-generic/io.h.

These macros assume peripheral is always in LITTLE endian.

Therefore all data needs a swab. 

In 8250 driver I can register replacement for default serial_in/serial_out and workaround the problem.
In 8250_early I had no choice but to change code with additional swab to workaround the problem.

I am looking for proper solution so it can be added to upstream.
I got several ideas if interest arise.

Waiting for your comments
Noam Camus 

