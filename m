From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [RFC v2 1/4] ACPI: SPCR: check bit width for the 16550 UART
Date: Tue,  6 Dec 2016 23:58:26 +0600
Message-ID: <20161206175830.6989-2-aleksey.makarov@linaro.org>
References: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

Check the 'Register Bit Width' field of the ACPI Generic Address
Structure that specifies the address of the UART registers to
decide if the driver should use "mmio32" access instead of "mmio".

If the driver is other than 16550 the access width is defined
by the Interface Type field of the SPCR table.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Reported-by: Heyi Guo <heyi.guo@linaro.org>
---
 drivers/acpi/spcr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index e8d7bc7..6c6710b 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -70,6 +70,10 @@ int __init parse_spcr(bool earlycon)
 		break;
 	case ACPI_DBG2_16550_COMPATIBLE:
 	case ACPI_DBG2_16550_SUBSET:
+		if (table->serial_port.space_id ==
+			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+		    table->serial_port.bit_width == 32)
+			iotype = "mmio32";
 		uart = "uart";
 		break;
 	default:
-- 
2.10.2

