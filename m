From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [RFC v2 4/4] ACPI: SPCR: support 16550 UART with 32-bit access
Date: Tue,  6 Dec 2016 23:58:29 +0600
Message-ID: <20161206175830.6989-5-aleksey.makarov@linaro.org>
References: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

It was suggested to add a new Microsoft Debug Port Table 2
(DBG2) (the table used to enumerate the various subtypes of serial
port covered by the SPCR) 16550 UART subtype that may be needed for
some additional platforms, such as those based upon AppliedMicro
X-Gene ARMv8 SoCs.  This new subtype would be 16550-compatible
with 32-bit access.  There already exists 32-bit variant
ACPI_DBG2_ARM_SBSA_32BIT of SBSA console ACPI_DBG2_ARM_SBSA_GENERIC.

This patch supports this type of console.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/spcr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 2bf338c..bc17e77 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -68,6 +68,9 @@ int __init parse_spcr(bool earlycon)
 	case ACPI_DBG2_BCM2835:
 		uart = "pl011";
 		break;
+	case ACPI_DBG2_16550_32BIT:
+		iotype = "mmio32";
+		/* fall through */
 	case ACPI_DBG2_16550_COMPATIBLE:
 	case ACPI_DBG2_16550_SUBSET:
 		if (table->serial_port.space_id ==
-- 
2.10.2
