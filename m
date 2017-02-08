From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Tue,  7 Feb 2017 19:57:35 -0500
Message-ID: <20170208005736.18724-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, timur@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
Cc: Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Christopher Covington <cov@codeaurora.org>, Mark Salter <msalter@redhat.com>
List-Id: linux-serial@vger.kernel.org

The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 0,
instead of checking that the BUSY bit is 1, works around the issue. To
facilitate this substitution when UART AMBA Port (UAP) data is available,
introduce vendor-specific inversion of Feature Register bits. To keep the
change small, this patch only works around the full console case, where UAP
data is available, and does not handle the erratum for earlycon, as the UAP
data is not available then.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Changes between the previous RFC [1] and this PATCH:
* don't use arch/arm64/kernel/cpu_errata.c at Will's request
* separate out earlycon case to separate patch
* rework earlycon case to not depend on UAP as suggested by Timur

Because they need a newly-defined MIDR values, the patches are currently
based on:
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

I'm not confident that I know the best route for these two patches. Should
I request Catalin and Will to take them via arm64 as the essential MIDR
additions are their purview?

Thanks Russell for the ack. Compared to the RFC, I've made minor changes to
what is now patch 1/2 and am making an educated guess that the ack sticks
(but if not please let me know). Patch 2/2 is significantly revised from
the RFC so I've not included the ack on it.

1. https://patchwork.codeaurora.org/patch/163281/
---
 Documentation/arm64/silicon-errata.txt |  2 ++
 arch/arm64/include/asm/cputype.h       |  2 ++
 drivers/tty/serial/Kconfig             | 12 ++++++++++
 drivers/tty/serial/amba-pl011.c        | 40 +++++++++++++++++++++++++++++++---
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 50da8391e9dd..0993ebb3e86b 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -65,3 +65,5 @@ stable kernels.
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003|
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009|
+| Qualcomm Tech. | QDF2432v1 UART  | SoC E44         | QCOM_QDF2400_ERRATUM_44 |
+| Qualcomm Tech. | QDF2400v1 UART  | SoC E44         | QCOM_QDF2400_ERRATUM_44 |
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index fc502713ab37..cb399c7fe6ec 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -88,12 +88,14 @@
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
+#define QCOM_CPU_PART_KRYO_V1		0x281
 #define QCOM_CPU_PART_FALKOR_V1		0x800
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_QCOM_KRYO_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_V1)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 
 #ifndef __ASSEMBLY__
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e9cf5b67f1b7..4cde8f48a540 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -73,6 +73,18 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config QCOM_QDF2400_ERRATUM_44
+	bool "Work around QDF2400 SoC E44 stuck BUSY bit"
+	depends on SERIAL_AMBA_PL011_CONSOLE=y
+	default y
+	help
+	  The BUSY bit in the Flag Register of the UART on the QDF2432v1 and
+	  QDF2400v1 SoCs may get stuck as 1, resulting in a hung serial console.
+	  Say Y here to work around the issue by checking TXFE == 0 instead of
+	  BUSY == 1 on affected systems.
+
+	  If unsure, say Y.
+
 config SERIAL_EARLYCON_ARM_SEMIHOST
 	bool "Early console using ARM semihosting"
 	depends on ARM64 || ARM
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d4171d71a258..41e51901d6ef 100644
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
@@ -141,6 +142,25 @@ static struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
+#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
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
+#else
+#define vendor_qdt_qdf2400_e44 vendor_sbsa
+#endif
+
 static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
@@ -1518,7 +1538,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int status = pl011_read(uap, REG_FR);
+	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
 	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
 							0 : TIOCSER_TEMT;
 }
@@ -2218,7 +2238,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
-	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
+	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
+						& uap->vendor->fr_busy)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
@@ -2383,6 +2404,13 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
+static bool qdf2400_e44(void) {
+	u32 cpu_var_model = read_cpuid_id() & ~MIDR_REVISION_MASK;
+
+	return (cpu_var_model == MIDR_QCOM_KRYO_V1 ||
+	    cpu_var_model == MIDR_QCOM_FALKOR_V1);
+}
+
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2645,12 +2673,18 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->port.irq	= ret;
 
 	uap->reg_offset	= vendor_sbsa.reg_offset;
-	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
+	if (qdf2400_e44()) {
+		uap->vendor = &vendor_qdt_qdf2400_e44;
+		dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
+	} else {
+		uap->vendor = &vendor_sbsa;
+	}
+
 	snprintf(uap->type, sizeof(uap->type), "SBSA");
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
