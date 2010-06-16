From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/2] Moorestown serial consoles
Date: Wed, 16 Jun 2010 14:45:47 +0100
Message-ID: <20100616134304.12686.39604.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38566 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758783Ab0FPOIj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jun 2010 10:08:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

This patch series adds support for the Max3110 used as the serial console on
the Moorestown platform.

Although the max3100 driver can and does support the 3110 it's not capable of
handling the needs of the Moorestown platform. At the same time this driver
does things that we don't want in a generic 3110 driver.

So we end up with two. We've tried really hard but there isn't an obvious
way to avoid this without producing one driver that is far harder to maintain
than having two.

Earlyprintk support also exists for this device but is dependant on some
bits that are not yet submitted so has been omitted for the initial submission.

Alan

---

Feng Tang (1):
      mrst_max3110: add UART driver for Max3110 on Moorestown

jianwei.yang (1):
      max3110 sanity check a register


 drivers/serial/Kconfig        |   17 +
 drivers/serial/Makefile       |    1 
 drivers/serial/mrst_max3110.c |  853 +++++++++++++++++++++++++++++++++++++++++
 drivers/serial/mrst_max3110.h |   59 +++
 4 files changed, 930 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/mrst_max3110.c
 create mode 100644 drivers/serial/mrst_max3110.h

