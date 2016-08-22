From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
Date: Mon, 22 Aug 2016 17:24:15 +0300
Message-ID: <1471875855-110782-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1471875855-110782-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471875855-110782-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Feng Kan <fkan@apm.com>
List-Id: linux-serial@vger.kernel.org

The APM X-Gene SoC UART is the only board that still needs
the hard-coded values, so handle it separately in
dw8250_quirks(). The other ACPI platforms are able to
provide the values with device properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Feng Kan <fkan@apm.com>
---
 drivers/tty/serial/8250/8250_dw.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e199696..5c0c123 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -298,12 +298,17 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			p->serial_out = dw8250_serial_out32be;
 		}
 	} else if (has_acpi_companion(p->dev)) {
-		p->iotype = UPIO_MEM32;
-		p->regshift = 2;
-		p->serial_in = dw8250_serial_in32;
+		const struct acpi_device_id *id;
+
+		id = acpi_match_device(p->dev->driver->acpi_match_table,
+				       p->dev);
+		if (id && !strcmp(id->id, "APMC0D08")) {
+			p->iotype = UPIO_MEM32;
+			p->regshift = 2;
+			p->serial_in = dw8250_serial_in32;
+			data->uart_16550_compatible = true;
+		}
 		p->set_termios = dw8250_set_termios;
-		/* So far none of there implement the Busy Functionality */
-		data->uart_16550_compatible = true;
 	}
 
 	/* Platforms with iDMA */
-- 
2.8.1

