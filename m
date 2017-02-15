From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH v4] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 16:39:43 -0500
Message-ID: <20170215213944.17901-1-cov@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Shanker Donthineni <shankerd@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, Steve Ulrich <sulrich@codeaurora.org>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
and 2400v1 SoCs.Checking that the Transmit FIFO Empty (TXFE) bit is 0,
instead of checking that the BUSY bit is 1, works around the issue.

To facilitate this substitution of flags and values, introduce
vendor-specific inversion of Feature Register bits when UART AMBA Port
(UAP) data is available. For the earlycon case, prior to UAP availability,
implement alternative putc and early_write functions.

Similar to what how ARMv8 ACPI PCI quirks are detected during MCFG parsing,
check the OEM fields of the Serial Port Console Redirection (SPCR) ACPI
table to determine if the current platform is known to be affected by the
erratum.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Timur Tabi <timur@codeaurora.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
Changes in v4:
* Added Acks from Mark and Timur
* Dropped arm64/silicon-errata.txt change (will be sent separately)
* Rebased onto gregkh/tty.git tty-next
    http://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/log/?h=tty-next
---
 drivers/acpi/spcr.c             | 23 ++++++++++++++
 drivers/tty/serial/amba-pl011.c | 66 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index b8019c4c1d38..2b5d0fac81f0 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -16,6 +16,26 @@
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
 
+/*
+ * Some Qualcomm Datacenter Technologies SoCs have a defective UART BUSY bit.
+ * Detect them by examining the OEM fields in the SPCR header, similiar to PCI
+ * quirk detection in pci_mcfg.c.
+ */
+static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
+{
+	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
+		return false;
+
+	if (!memcmp(h->oem_table_id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
+		return true;
+
+	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
+			h->oem_revision == 0)
+		return true;
+
+	return false;
+}
+
 /**
  * parse_spcr() - parse ACPI SPCR table and add preferred console
  *
@@ -93,6 +113,9 @@ int __init parse_spcr(bool earlycon)
 		goto done;
 	}
 
+	if (qdf2400_erratum_44_present(&table->header))
+		uart = "qdf2400_e44";
+
 	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 		 table->serial_port.address, baud_rate);
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 533b18d4a587..8789ea423ccf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -97,6 +97,7 @@ struct vendor_data {
 	unsigned int		fr_dsr;
 	unsigned int		fr_cts;
 	unsigned int		fr_ri;
+	unsigned int		inv_fr;
 	bool			access_32b;
 	bool			oversampling;
 	bool			dma_threshold;
@@ -141,6 +142,30 @@ static struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
+/*
+ * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit as
+ * occasionally getting stuck as 1. To avoid the potential for a hang, check
+ * TXFE == 0 instead of BUSY == 1. This may not be suitable for all UART
+ * implementations, so only do so if an affected platform is detected in
+ * parse_spcr().
+ */
+static bool qdf2400_e44_present = false;
+
+static struct vendor_data vendor_qdt_qdf2400_e44 = {
+	.reg_offset		= pl011_std_offsets,
+	.fr_busy		= UART011_FR_TXFE,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
+	.inv_fr			= UART011_FR_TXFE,
+	.access_32b		= true,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= true,
+	.fixed_options		= true,
+};
+
 static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
@@ -1518,7 +1543,10 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int status = pl011_read(uap, REG_FR);
+
+	/* Allow feature register bits to be inverted to work around errata */
+	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
+
 	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
 							0 : TIOCSER_TEMT;
 }
@@ -2215,10 +2243,12 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&uap->port, s, count, pl011_console_putchar);
 
 	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the TCR
+	 *	Finally, wait for transmitter to become empty and restore the
+	 *	TCR. Allow feature register bits to be inverted to work around
+	 *	errata.
 	 */
-	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
+	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
+						& uap->vendor->fr_busy)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
@@ -2340,8 +2370,12 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;
 
-	if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0)
+	if (strcmp(name, "qdf2400_e44") == 0) {
+		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
+		qdf2400_e44_present = true;
+	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
 		return -ENODEV;
+	}
 
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
@@ -2383,6 +2417,22 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
+static void qdf2400_e44_putc(struct uart_port *port, int c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	writel(c, port->membase + UART01x_DR);
+	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
+		cpu_relax();
+}
+
+static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
+}
+
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2408,7 +2458,8 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = pl011_early_write;
+	device->con->write = qdf2400_e44_present ?
+				qdf2400_e44_early_write : pl011_early_write;
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
@@ -2645,7 +2696,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->port.irq	= ret;
 
 	uap->reg_offset	= vendor_sbsa.reg_offset;
-	uap->vendor	= &vendor_sbsa;
+	uap->vendor	= qdf2400_e44_present ?
+					&vendor_qdt_qdf2400_e44 : &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.ops	= &sbsa_uart_pops;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.

