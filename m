From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 6/6] Blackfin Serial Driver: Remove BI status for known_good_char
Date: Mon, 13 Oct 2008 17:46:25 +0800
Message-ID: <1223891185-13924-7-git-send-email-cooloney@kernel.org>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:3133 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763285AbYJMJpx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2008 05:45:53 -0400
In-Reply-To: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
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
