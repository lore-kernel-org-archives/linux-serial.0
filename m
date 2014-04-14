From: "Poulain, Loic" <loic.poulain@intel.com>
Subject: 8250_dw DMA issue with BYT ?
Date: Mon, 14 Apr 2014 15:54:31 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5995 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbaDNPzf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 11:55:35 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hello Heikki,

I contact you regarding the 8250_dw driver.
My setup is an Asus T100TA (baytrail) + kernel 3.14.
The UART controller is ACPI enumerated (ID is 80860F0A).
(UART_CAP_AFE capable)

This uart is used to communicate with a BCM4324 bluetooth chip
(HCI H4 over uart). However we have many bluetooth instabilities.
These instabilities are due to the 'hardware error' HCI code sent
by the BCM chip. This error means that the BCM received an invalid
H4 packet header or an invalid sized packet => serial sync issue.
Moreover, Increasing the baudrate increases the hardware error
frequency.

This problem seems due to the DMA usage. Indeed, when I disable
the DMA manually in 8250_dw.c (up->dma = NULL), problem does not
occur anymore, all baudrates are stable.

Do you think a specific 8250 DMA configuration could apply for the byt
case ?
How/Where can I debug to know if the 8250 DMA works as expected ?

Thanks & Regards,
Loic Poulain
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

