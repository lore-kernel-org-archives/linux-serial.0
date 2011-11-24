From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] TTY: Remove redundant spi driver bus initialization
Date: Thu, 24 Nov 2011 16:29:12 +0100
Message-ID: <1322148561-25138-2-git-send-email-lars@metafoo.de>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322148561-25138-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

In ancient times it was necessary to manually initialize the bus field of an
spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
so we can drop the manual assignment.

The patch was generated using the following coccinelle semantic patch:
// <smpl>
@@
identifier _driver;
@@
struct spi_driver _driver = {
	.driver = {
-		.bus = &spi_bus_type,
	},
};
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alan Cox <alan@linux.intel.com> (maintainer:SERIAL DRIVERS)
Cc: linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
---
 drivers/tty/serial/ifx6x60.c      |    1 -
 drivers/tty/serial/max3100.c      |    1 -
 drivers/tty/serial/max3107-aava.c |    1 -
 drivers/tty/serial/max3107.c      |    1 -
 drivers/tty/serial/mrst_max3110.c |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 426434e..7e925e2 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1334,7 +1334,6 @@ MODULE_DEVICE_TABLE(spi, ifx_id_table);
 static const struct spi_driver ifx_spi_driver = {
 	.driver = {
 		.name = DRVNAME,
-		.bus = &spi_bus_type,
 		.pm = &ifx_spi_pm,
 		.owner = THIS_MODULE},
 	.probe = ifx_spi_spi_probe,
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 8a6cc8c..b4902b9 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -901,7 +901,6 @@ static int max3100_resume(struct spi_device *spi)
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
-		.bus		= &spi_bus_type,
 		.owner		= THIS_MODULE,
 	},
 
diff --git a/drivers/tty/serial/max3107-aava.c b/drivers/tty/serial/max3107-aava.c
index 90c40f2..aae772a 100644
--- a/drivers/tty/serial/max3107-aava.c
+++ b/drivers/tty/serial/max3107-aava.c
@@ -315,7 +315,6 @@ static int __devinit max3107_probe_aava(struct spi_device *spi)
 static struct spi_driver max3107_driver = {
 	.driver = {
 		.name		= "aava-max3107",
-		.bus		= &spi_bus_type,
 		.owner		= THIS_MODULE,
 	},
 	.probe		= max3107_probe_aava,
diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.c
index 7827000..17c7ba8 100644
--- a/drivers/tty/serial/max3107.c
+++ b/drivers/tty/serial/max3107.c
@@ -1181,7 +1181,6 @@ static int max3107_probe_generic(struct spi_device *spi)
 static struct spi_driver max3107_driver = {
 	.driver = {
 		.name		= "max3107",
-		.bus		= &spi_bus_type,
 		.owner		= THIS_MODULE,
 	},
 	.probe		= max3107_probe_generic,
diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 4c309e8..df2a224 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -876,7 +876,6 @@ static int __devexit serial_m3110_remove(struct spi_device *dev)
 static struct spi_driver uart_max3110_driver = {
 	.driver = {
 			.name	= "spi_max3111",
-			.bus	= &spi_bus_type,
 			.owner	= THIS_MODULE,
 	},
 	.probe		= serial_m3110_probe,
-- 
1.7.7.1
