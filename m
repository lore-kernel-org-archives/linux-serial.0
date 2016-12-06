From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [RFC v2 2/4] ACPI: SPCR: don't initialize baud rate
Date: Tue,  6 Dec 2016 23:58:27 +0600
Message-ID: <20161206175830.6989-3-aleksey.makarov@linaro.org>
References: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

AppliedMicro X-Gene based boards don't use the "standard"
16550 clock rate so supplying a baud rate makes it change
to a random baud rate.

I suggest to introduce a new value '0' for the "Baud
Rate" field of SPCR (now this value is reserved).

This patch introduces a check for this value.  In this case
the code does not emit baud rate specification for initialization
of the console.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/spcr.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 6c6710b..2bf338c 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -37,7 +37,7 @@ int __init parse_spcr(bool earlycon)
 	acpi_status status;
 	char *uart;
 	char *iotype;
-	int baud_rate;
+	char *baud_rate_string;
 	int err;
 
 	if (acpi_disabled)
@@ -82,25 +82,33 @@ int __init parse_spcr(bool earlycon)
 	}
 
 	switch (table->baud_rate) {
+	case 0:
+		/*
+		 * This value is not standaritzed by ACPI SPCR for now.
+		 * It means that hardware should not be re-initialized with
+		 * new speed.
+		 */
+		baud_rate_string = "";
+		break;
 	case 3:
-		baud_rate = 9600;
+		baud_rate_string = ",9600";
 		break;
 	case 4:
-		baud_rate = 19200;
+		baud_rate_string = ",19200";
 		break;
 	case 6:
-		baud_rate = 57600;
+		baud_rate_string = ",57600";
 		break;
 	case 7:
-		baud_rate = 115200;
+		baud_rate_string = ",115200";
 		break;
 	default:
 		err = -ENOENT;
 		goto done;
 	}
 
-	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
-		 table->serial_port.address, baud_rate);
+	snprintf(opts, sizeof(opts), "%s,%s,0x%llx%s", uart, iotype,
+		 table->serial_port.address, baud_rate_string);
 
 	pr_info("console: %s\n", opts);
 
-- 
2.10.2
