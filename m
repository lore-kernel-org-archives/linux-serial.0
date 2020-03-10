Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387AC18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD15020727
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJRnm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:43:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:64923 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCJRnm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 13:43:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 10:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="321875772"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2020 10:43:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D75B7211; Tue, 10 Mar 2020 19:43:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] serial: core: Use uart_console() helper in SysRq code
Date:   Tue, 10 Mar 2020 19:43:36 +0200
Message-Id: <20200310174337.74109-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310174337.74109-1-andriy.shevchenko@linux.intel.com>
References: <20200310174337.74109-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use uart_console() helper in SysRq code instead of open coded variant.
This eliminates the conditional entirely for SERIAL_CORE_CONSOLE=n case.
While here, refactor the conditional to be more compact.

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: add tag
 drivers/tty/serial/serial_core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e3f2afc15ad4..e3f8e641e3a7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3315,14 +3315,12 @@ int uart_handle_break(struct uart_port *port)
 	if (port->handle_break)
 		port->handle_break(port);
 
-	if (port->has_sysrq) {
-		if (port->cons && port->cons->index == port->line) {
-			if (!port->sysrq) {
-				port->sysrq = jiffies + SYSRQ_TIMEOUT;
-				return 1;
-			}
-			port->sysrq = 0;
+	if (port->has_sysrq && uart_console(port)) {
+		if (!port->sysrq) {
+			port->sysrq = jiffies + SYSRQ_TIMEOUT;
+			return 1;
 		}
+		port->sysrq = 0;
 	}
 
 	if (port->flags & UPF_SAK)
-- 
2.25.1

