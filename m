From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/5] serial: 8250: 8250_dw changes and dynamic capabilities
Date: Wed, 28 Nov 2012 14:48:39 +0200
Message-ID: <1354106924-11013-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47427 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab2K1Mr2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 07:47:28 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

These are mainly small changes to 8250_dw.c. The interesting patch is
probable the addition to 8250.c that would allow the drivers to
deliver their UART's capabilities when they are registering ports.


Heikki Krogerus (5):
  serial: 8250: Allow drivers to deliver capabilities
  serial: 8250_dw: Don't use UPF_FIXED_TYPE
  serial: 8250_dw: Map IO memory
  serial: 8250_dw: Move device tree code to separate function
  serial: 8250_dw: Set FIFO size dynamically

 drivers/tty/serial/8250/8250.c    |   22 ++++--
 drivers/tty/serial/8250/8250_dw.c |  140 +++++++++++++++++++++++++++----------
 2 files changed, 120 insertions(+), 42 deletions(-)

-- 
1.7.10.4

