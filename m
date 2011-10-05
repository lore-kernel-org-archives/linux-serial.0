From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 13/16] serial: pl011: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:05:04 +0100
Message-ID: <1317830707-17517-14-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54987 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499Ab1JEQF7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Oct 2011 12:05:59 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so1862228wyg.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Oct 2011 09:05:58 -0700 (PDT)
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 00233af..6958594 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1994,6 +1994,8 @@ static struct amba_id pl011_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl011_ids);
+
 static struct amba_driver pl011_driver = {
 	.drv = {
 		.name	= "uart-pl011",
-- 
1.7.4.1

