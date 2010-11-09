From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: 8250_pci and OXPCIe952
Date: Tue, 09 Nov 2010 12:57:45 -0200
Message-ID: <4CD96169.2060705@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:54036 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab0KIO5u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 09:57:50 -0500
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp03.br.ibm.com (8.14.4/8.13.1) with ESMTP id oA9Eo7Bv020749
	for <linux-serial@vger.kernel.org>; Tue, 9 Nov 2010 12:50:07 -0200
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oA9F4VgF806962
	for <linux-serial@vger.kernel.org>; Tue, 9 Nov 2010 13:04:32 -0200
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oA9EvVAJ002220
	for <linux-serial@vger.kernel.org>; Tue, 9 Nov 2010 12:57:31 -0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org

Hi Greg,

I put an OXPCIe952 card on my machine (PPC), and the driver is not
running fine.
First of all, it identifies 8 ports, which is wrong. Also, it says

0000:01:00.1: ttyS1 at MMIO 0x3c05ff7fd200 (irq = 66) is a 16C950/954

and the driver loads without any other error, although it's not working.

So, my question is: Does this driver support this chipset? Was it ever
tested on PPC ?


Thanks
Breno

---
lspci output

01:00.0 System peripheral: Oxford Semiconductor Ltd Device c20c
	Subsystem: Oxford Semiconductor Ltd Device c20c
	Flags: fast devsel, IRQ 65
	Memory at 3c05ff7fb000 (32-bit, non-prefetchable) [disabled] [size=1K]
	Memory at 3c05ff800000 (32-bit, non-prefetchable) [disabled] [size=2M]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Count=1/1 
Enable-
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [100] Device Serial Number 00-02-00-11-11-e0-30-00
	Capabilities: [110] Power Budgeting <?>

01:00.1 Serial controller: Oxford Semiconductor Ltd Device c20d (prog-if 
02 [16550])
	Subsystem: Oxford Semiconductor Ltd Device c20d
	Flags: fast devsel, IRQ 66
	Memory at 3c05ff7fc000 (32-bit, non-prefetchable) [size=16K]
	Memory at 3c05ffa00000 (32-bit, non-prefetchable) [size=2M]
	Memory at 3c05ffc00000 (32-bit, non-prefetchable) [size=2M]
	Capabilities: [40] Power Management version 3
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [b0] MSI-X: Enable- Mask- TabSize=16
	Capabilities: [100] Power Budgeting <?>
	Kernel driver in use: serial
	Kernel modules: 8250_pci
