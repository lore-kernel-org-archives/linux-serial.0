From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCHv3 0/2] serial: Drivers for Altera UARTs
Date: Fri,  5 Mar 2010 17:52:21 +0100
Message-ID: <cover.1267807169.git.klto@zhaw.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.zhaw.ch ([160.85.104.51]:41537 "EHLO mx2.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235Ab0CEQwc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2010 11:52:32 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>

This is the third version of the patchset to add the serial drivers for the
Altera UARTs. I made the corrections suggested by Alan Cox on top of the second
version submitted on 01 Mar 2010.

Changes from v2 to v3:

 - altera_uart: Copy old termios settings back and set baud rate
 - altera_uart: Remove board specific DTR/DCD macros

Changes from v1 to v2:

 - altera_jtaguart: Implement altera_jtaguart_set_termios
 - altera_jtaguart: Protect port.tty in altera_jtaguart_rx_chars
 - altera_uart, altera_jtaguart: Don't depend on EMBEDDED
 - altera_jtaguart: Correct check for co->index
 - altera_uart: Correct check for co->index

Thanks,
Tobias
