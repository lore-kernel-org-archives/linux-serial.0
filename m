From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Perle octal serial boards
Date: Sun, 11 Dec 2011 13:10:02 -0700
Message-ID: <4EE50E1A.6050408@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.redfish-solutions.com ([66.232.79.143]:56353 "EHLO
	mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752267Ab1LKUUg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Dec 2011 15:20:36 -0500
Received: from macbook.redfish-solutions.com (macbook.redfish-solutions.com [192.168.1.17])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.14.5/8.14.5) with ESMTP id pBBKA2EU012549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sun, 11 Dec 2011 13:10:02 -0700
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've got a Perle Systems "Speed8 LE" board, which seems to have the Oxford Semi 954 (16PCI954 + 16PCI954N) chips on it:

$ sudo lspci -n -v -s 04:07
04:07.0 0700: 155f:b008 (prog-if 06 [16950])
	Subsystem: 1415:9501
	Flags: medium devsel, IRQ 21
	I/O ports at ec00 [size=32]
	Memory at fbfff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at e880 [size=32]
	Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1

04:07.1 0680: 155f:b008
	Subsystem: 1415:9511
	Flags: medium devsel, IRQ 10
	I/O ports at e800 [size=32]
	Memory at fbffd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at e480 [size=32]
	Memory at fbffc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1

$

I was wondering if the 8250_pci.c driver can be made to work with it.

And if not, what's an 8-port serial PCI card that gives good performance for not a lot of money?

-Philip
