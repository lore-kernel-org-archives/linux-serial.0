From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 05/75] Blackfin Serial Driver: Remove BI status for
	known_good_char
Date: Fri, 02 Jan 2009 13:40:45 +0000
Message-ID: <20090102134043.13472.48111.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60277 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754562AbZABNka (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:30 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/bfin_5xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 1c85039..318d69d 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -219,6 +219,7 @@ static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 			return;
 
  known_good_char:
+			status &= ~BI;
 			anomaly_start.tv_sec = 0;
 		}
 	}

