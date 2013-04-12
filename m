From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/1] serial: 8250_dw: fix for tty-next
Date: Fri, 12 Apr 2013 12:44:26 +0300
Message-ID: <1365759867-29657-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35471 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965Ab3DLJo3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Apr 2013 05:44:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org



Heikki Krogerus (1):
  serial: 8250_dw: Fix the stub for dw8250_probe_acpi()

 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.4

