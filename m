From: Roman Kurakin <rik@cronyx.ru>
Subject: Re: Fix supprot for AFAVLAB 8port boards in 2.6.x
Date: Fri, 05 Mar 2004 17:15:01 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <40488B65.904@cronyx.ru>
References: <20040305112404.GJ1105@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hanoi.cronyx.ru ([144.206.181.53]:10771 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id S262598AbUCEOOc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2004 09:14:32 -0500
Received: (from root@localhost) by hanoi.cronyx.ru
  id i25EEBIc041435 for linux-serial@vger.kernel.org.checked; (8.12.8/vak/2.1)
  Fri, 5 Mar 2004 17:14:11 +0300 (MSK) (envelope-from rik@cronyx.ru)
In-Reply-To: <20040305112404.GJ1105@sunbeam.de.gnumonks.org>
List-Id: linux-serial@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

May be you didn't add support of more than four ports?

Best regards,
                         Roman Kurakin

Harald Welte wrote:

>Hi!
>
>I didn't yet use one of my AFAVLAB boards with 2.6.x until now.  The
>upper 4 ports are not detected at all.  I suppose the bug was introduced
>while porting the driver from 2.4.x.
>
>Please consider applying the following patch.  It also adds support for
>a new 8port board called P030.
>
>Thanks,
>
>
>diff -Nru --exclude-from /sunbeam/home/laforge/scripts/dontdiff linuxppc25bh-040218-test/drivers/pci/pci.ids linuxppc25bh-040218-serial/drivers/pci/pci.ids
>--- linuxppc25bh-040218-test/drivers/pci/pci.ids	2004-02-16 09:43:49.000000000 +0100
>+++ linuxppc25bh-040218-serial/drivers/pci/pci.ids	2004-03-05 12:10:09.685724629 +0100
>@@ -5601,6 +5601,8 @@
> 14da  National Aerospace Laboratories
> 14db  AFAVLAB Technology Inc
> 	2120  TK9902
>+	2180  P028
>+	2182  P030
> 14dc  Amplicon Liveline Ltd
> 	0000  PCI230
> 	0001  PCI242
>diff -Nru --exclude-from /sunbeam/home/laforge/scripts/dontdiff linuxppc25bh-040218-test/drivers/serial/8250_pci.c linuxppc25bh-040218-serial/drivers/serial/8250_pci.c
>--- linuxppc25bh-040218-test/drivers/serial/8250_pci.c	2004-02-16 09:44:28.000000000 +0100
>+++ linuxppc25bh-040218-serial/drivers/serial/8250_pci.c	2004-03-05 12:23:02.331325424 +0100
>@@ -141,13 +141,15 @@
> 	      struct serial_struct *req, int idx)
> {
> 	unsigned int bar, offset = board->first_offset;
> 	
> 	bar = FL_GET_BASE(board->flags);
> 	if (idx < 4)
> 		bar += idx;
>-	else
>+	else {
>+		bar = 4;
> 		offset += (idx - 4) * board->uart_offset;
>+	}
> 
> 	return setup_port(dev, req, bar, offset, board->reg_shift);
> }
> 
>@@ -1891,6 +1895,9 @@
> 	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
> 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> 		pbn_b0_bt_8_115200 },
>+	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P030,
>+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>+		pbn_b0_bt_8_115200 },
> 
> 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
> 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  
>



