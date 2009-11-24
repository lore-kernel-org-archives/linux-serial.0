From: monstr@monstr.eu
Subject: [PATCH] serial: 8250: Add ns16550a to OF compatible list
Date: Tue, 24 Nov 2009 10:21:42 +0100
Message-ID: <1259054502-28284-2-git-send-email-monstr@monstr.eu>
References: <1259054502-28284-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932468AbZKXJWU@vger.kernel.org>
In-Reply-To: <1259054502-28284-1-git-send-email-monstr@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, john.williams@petalogix.com, stable@kernel.org, chrisw@sous-sol.org, greg@kroah.com, Michal Simek <monstr@monstr.eu>
List-Id: linux-serial@vger.kernel.org

From: Michal Simek <monstr@monstr.eu>

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 drivers/serial/of_serial.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 02406ba..b047c38 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -161,6 +161,7 @@ static int of_platform_serial_remove(struct of_device *ofdev)
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
 	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
+	{ .type = "serial", .compatible = "ns16550a",  .data = (void *)PORT_16550A, },
 	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
 	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
 	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
-- 
1.5.5.1
