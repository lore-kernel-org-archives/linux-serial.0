From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 2/2] serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 SoC
Date: Wed, 31 Aug 2016 11:29:12 +0800
Message-ID: <1472614152-43136-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1472614152-43136-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472614152-43136-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, z.liuxinliang@hisilicon.com, linux-acpi@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Add ACPI identifier for UART on Hisilicon Hip05 SoC, be careful that
it is not 16550 compatible, and "reg-io-width" and "reg-shift" need
be set properly by _DSD method in DSDT.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index adecece..3478c2c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -623,6 +623,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "APMC0D08", 0},
 	{ "AMD0020", 0 },
 	{ "AMDI0020", 0 },
+	{ "HISI0031", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
1.7.12.4

