From: Dimitris Lampridis <dlampridis@logikonlabs.com>
Subject: [PATCH 0/2] tty/serial: omap: remove unwanted local echo during half-duplex TX
Date: Thu, 13 Mar 2014 15:11:45 +0200
Message-ID: <1394716307-11248-1-git-send-email-dlampridis@logikonlabs.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from promitheas2.multiserver.gr ([144.76.157.92]:55136 "EHLO
	promitheas2.multiserver.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbaCMNfu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2014 09:35:50 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Dimitris Lampridis <dlampridis@logikonlabs.com>

This patchset addresses the issue of unwanted local echo during half-duplex RS485 
transmissions within the OMAP serial driver.

The first patch disables all RX-related interrupts in the serial_omap_stop_rx(), 
which is called from serial_omap_start_tx() before the start of a half-duplex
transmission. It also makes sure that whatever is disabled by serial_omap_stop_rx(), 
is subsequently re-enabled in serial_omap_stop_tx() when the half-duplex transmission 
is complete.

The second patch empties the RX FIFO of the OMAP UART at the end of a half-duplex TX.
This is required when using a transceiver such as the Intersil ISL3332, which does
not provide a way to disable the receiver during a half-duplex transmission.

Both patches have been successfully tested on a Beaglebone Black with ttyO2 and ttyO4
wired to an Intersil ISL3332 dual port transceiver, while communicating with 3-wire
RS485 half-duplex (MODBUS) devices.

Dimitris Lampridis (2):
  tty/serial: omap: fix RX interrupt enable/disable in half-duplex TX
  tty/serial: omap: empty the RX FIFO at the end of half-duplex TX

 drivers/tty/serial/omap-serial.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
1.7.10.4

