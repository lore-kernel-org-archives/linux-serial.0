From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 12/16] serial: pl010: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:05:03 +0100
Message-ID: <1317830707-17517-13-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54187 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499Ab1JEQF5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Oct 2011 12:05:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so2790863wwf.1
        for <linux-serial@vger.kernel.org>; Wed, 05 Oct 2011 09:05:56 -0700 (PDT)
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/tty/serial/amba-pl010.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index efdf92c..0d91a54 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -795,6 +795,8 @@ static struct amba_id pl010_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl010_ids);
+
 static struct amba_driver pl010_driver = {
 	.drv = {
 		.name	= "uart-pl010",
-- 
1.7.4.1

