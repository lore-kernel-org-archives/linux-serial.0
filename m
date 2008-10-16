From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 7/9] Blackfin Serial Driver: Remove BI status for known_good_char
Date: Fri, 17 Oct 2008 01:44:05 +0800
Message-ID: <1224179047-13073-8-git-send-email-cooloney@kernel.org>
References: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:20082 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758498AbYJPRpI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2008 13:45:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so49514tic.23
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2008 10:45:07 -0700 (PDT)
In-Reply-To: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/serial/bfin_5xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 82854d7..350bfc4 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -220,6 +220,7 @@ static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 			return;
 
  known_good_char:
+			status &= ~BI;
 			anomaly_start.tv_sec = 0;
 		}
 	}
-- 
1.5.6

