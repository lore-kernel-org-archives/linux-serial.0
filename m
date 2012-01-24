From: Philip Prindeville <philipp@redfish-solutions.com>
Subject: Support for Perle Systems Speed/LE-8
Date: Mon, 23 Jan 2012 23:19:21 -0700
Message-ID: <4F1E4D69.3040907@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.redfish-solutions.com ([66.232.79.143]:52456 "EHLO
	mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753491Ab2AXGTW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Jan 2012 01:19:22 -0500
Received: from macbook.redfish-solutions.com (macbook.redfish-solutions.com [192.168.1.17])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.14.5/8.14.5) with ESMTP id q0O6JLS6012587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2012 23:19:21 -0700
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi.

I have a Perle Speed/LE-8 card that's poorly supported (cough) by the vendor.

The design seems to be plain-vanilla enough: it uses Oxford 9501 and 9511 chips.

$ lspci -v -n -s 04:07
04:07.0 0700: 155f:b008 (prog-if 06 [16950])
	Subsystem: 1415:9501
	Flags: medium devsel, IRQ 21
	I/O ports at ec00 [size=32]
	Memory at fbfff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at e880 [size=32]
	Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
	Kernel driver in use: perle-serial
	Kernel modules: perle-serial

04:07.1 0680: 155f:b008
	Subsystem: 1415:9511
	Flags: medium devsel, IRQ 21
	I/O ports at e800 [size=32]
	Memory at fbffd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at e480 [size=32]
	Memory at fbffc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
	Kernel driver in use: perle-serial
	Kernel modules: perle-serial


$

There's nothing funky about this card except that one of the lines is either DTR or RTS if I've understood the scarce documentation.

Anyway, I was wondering what's involved in getting the drivers/tty/serial/8250_pci.c to support this?

Thanks,

-Philip
