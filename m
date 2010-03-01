From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCHv2 0/2] serial: Drivers for Altera UARTs
Date: Mon,  1 Mar 2010 14:31:01 +0100
Message-ID: <cover.1267448534.git.klto@zhaw.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.zhaw.ch ([160.85.104.51]:60835 "EHLO mx2.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab0CANbK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Mar 2010 08:31:10 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>

This is the second version of the patchset to add the serial drivers for the
Altera UARTs. The following changes were made on top of the first version
submitted on 25 Feb 2010:

 - altera_jtaguart: Implement altera_jtaguart_set_termios
 - altera_jtaguart: Protect port.tty in altera_jtaguart_rx_chars
 - altera_uart, altera_jtaguart: Don't depend on EMBEDDED
 - altera_jtaguart: Correct check for co->index
 - altera_uart: Correct check for co->index

Thanks,
Tobias
