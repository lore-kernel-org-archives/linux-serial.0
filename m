From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 10/12] [Blackfin] serial driver: use simpler comment headers and strip out information that is maintained in the scm's log
Date: Wed, 30 Jan 2008 17:30:10 +0800
Message-ID: <1201685412-29095-11-git-send-email-bryan.wu@analog.com>
References: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:7326 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbYA3JaT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2008 04:30:19 -0500
In-Reply-To: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mike Frysinger <michael.frysinger@analog.com>, Bryan Wu <bryan.wu@analog.com>

From: Mike Frysinger <michael.frysinger@analog.com>

Signed-off-by: Mike Frysinger <michael.frysinger@analog.com>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/serial/bfin_5xx.c |   27 ++++-----------------------
 1 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 50aa3b2..a07df53 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -1,30 +1,11 @@
 /*
- * File:         drivers/serial/bfin_5xx.c
- * Based on:     Based on drivers/serial/sa1100.c
- * Author:       Aubrey Li <aubrey.li@analog.com>
+ * Blackfin On-Chip Serial Driver
  *
- * Created:
- * Description:  Driver for blackfin 5xx serial ports
+ * Copyright 2006-2007 Analog Devices Inc.
  *
- * Modified:
- *               Copyright 2006 Analog Devices Inc.
+ * Enter bugs at http://blackfin.uclinux.org/
  *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Licensed under the GPL-2 or later.
  */
 
 #if defined(CONFIG_SERIAL_BFIN_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-- 
1.5.3.4
