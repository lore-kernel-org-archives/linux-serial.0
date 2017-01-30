From: Christopher Covington <cov@codeaurora.org>
Subject: [RFC] tty: pl011: Work around stuck BUSY bit on QDF2400
Date: Mon, 30 Jan 2017 18:44:17 -0500
Message-ID: <20170130234417.20855-1-cov@codeaurora.org>
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
To: Peter Hurley <peter@hurleysoftware.com>, timur@codeaurora.org, pelcan@codeaurora.org, nleeder@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

N.B. I'm not confident that this patch is ready to be included as-is.
Rather I'm hoping for guidance from reviewers and maintainers on
broad implementation choices--whether A) the bitmask of flags to invert
makes sense or B) vendor-specific is_busy() function pointers or C)
hot-patching using the alternatives framework or D) some other
approach would be best.

The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 0,
instead of checking that the BUSY bit is 1, works around the issue. To
facilitate this substitution, introduce vendor-specific inversion of
Feature Register bits.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
Based on https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
---
 Documentation/arm64/silicon-errata.txt |  2 ++
 arch/arm64/Kconfig                     | 11 +++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 16 +++++++++++++
 drivers/tty/serial/amba-pl011.c        | 44 ++++++++++++++++++++++++++++++----
 6 files changed, 73 insertions(+), 5 deletions(-)

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
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5284a79bada..f90d0670171d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -501,6 +501,17 @@ config QCOM_FALKOR_ERRATUM_1009
 
 	  If unsure, say Y.
 
+config QCOM_QDF2400_ERRATUM_44
+	bool "QDF2400 E44: UART BUSY bit sticks as 1"
+	default y
+	help
+	  The BUSY bit in the Flag Register of the UART on the QDF2432v1 and
+	  QDF2400v1 SoCs may get stuck as 1, resulting in a hung serial console.
+	  Say Y here to work around the issue by checking TXFE == 0 instead of
+	  BUSY == 1 on affected systems.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 55bcd02e4a3f..b0f2402f41a2 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	17
 #define ARM64_WORKAROUND_REPEAT_TLBI		18
+#define ARM64_WORKAROUND_QCOM_QDF2400_E44	19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
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
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6cc67e7626e..1a8c2f2b9edf 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -151,6 +151,22 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
 #endif
+#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
+	{
+		.desc = "Qualcomm Technologies QDF2432 SoC erratum 44",
+		.capability = ARM64_WORKAROUND_QCOM_QDF2400_E44,
+		MIDR_RANGE(MIDR_QCOM_KRYO_V1,
+			   MIDR_CPU_VAR_REV(0, 1),
+			   MIDR_CPU_VAR_REV(0, 1)),
+	},
+	{
+		.desc = "Qualcomm Technologies QDF2400 SoC erratum 44",
+		.capability = ARM64_WORKAROUND_QCOM_QDF2400_E44,
+		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
+			   MIDR_CPU_VAR_REV(0, 0),
+			   MIDR_CPU_VAR_REV(0, 0)),
+	},
+#endif
 	{
 	}
 };
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d4171d71a258..32ed6423a6ba 100644
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
@@ -168,6 +169,32 @@ static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_ST_ABIMSC] = ST_UART011_ABIMSC,
 };
 
+#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
+#define QDF2400_E44_BUSY	UART011_FR_TXFE
+#define QDF2400_E44_INV		UART011_FR_TXFE
+#else
+#define QDF2400_E44_BUSY	UART01x_FR_BUSY
+#define QDF2400_E44_INV		0
+#endif
+
+static struct vendor_data vendor_qdt = {
+	.reg_offset		= pl011_std_offsets,
+	.fr_busy		= QDF2400_E44_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
+	.inv_fr			= QDF2400_E44_INV,
+	.access_32b		= true,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= true,
+	.fixed_options		= true,
+};
+
+#undef QDF2400_E44_BUSY
+#undef QDF2400_E44_INV
+
 static unsigned int get_fifosize_st(struct amba_device *dev)
 {
 	return 64;
@@ -1518,7 +1545,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int status = pl011_read(uap, REG_FR);
+	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
 	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
 							0 : TIOCSER_TEMT;
 }
@@ -2218,7 +2245,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
-	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
+	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
+						& uap->vendor->fr_busy)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
@@ -2385,13 +2413,17 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
+	struct uart_amba_port *uap =
+		container_of(port, struct uart_amba_port, port);
+
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	if (port->iotype == UPIO_MEM32)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+	while ((readl(port->membase + UART01x_FR) ^ uap->vendor->inv_fr)
+							& uap->vendor->fr_busy)
 		cpu_relax();
 }
 
@@ -2645,12 +2677,16 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->port.irq	= ret;
 
 	uap->reg_offset	= vendor_sbsa.reg_offset;
-	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
+	if (cpus_have_const_cap(ARM64_WORKAROUND_QCOM_QDF2400_E44))
+		uap->vendor = &vendor_qdt;
+	else
+		uap->vendor = &vendor_sbsa;
+
 	snprintf(uap->type, sizeof(uap->type), "SBSA");
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
