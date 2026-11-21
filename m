Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296963;
	b=m9IatOoQ+kP1LAddvUNZiuYPczqY9Prpj13Uek2Bo6Z/3vHavps+HCX1waq2k1JN6fLi
	 FYfOS6MHik/pX89AsnP2zZhDAQfcg7UEigYe2AXE7w9gYxy0g8TBNomOP1EEYJydsPsn+
	 f163LACnT/SlJdVMtaDXbAk93/wbEsjBmtxbV8LWryDqPuilxxhhlfBpG+2PgH2xWfSWZ
	 xSzM1sc5Yg71Jy+GmBW/d6RPH/SXgoq1r8mXnosufcfHOSA4Fplcu7ANL2Zwc4vQrDfaO
	 HLgLP6jgAqD+OD/QrfjoTIqbYh3mokoPimSq53RHT3+11JcdPLR6pPyS8B+DN3hVhcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	b=wEOrukeHg5Jc3k0MIkJz34SIcsGKQQ2hHpZ81OW3ZpCJEeUYw/84Z4WHUJO3moymDIYu
	 FzlB9Bd6YVTqsxJl+HrF4l8lvgClpSjhwz07KqhZJ2tn3lBoHQKnecm0PUBFcDvmT0GSY
	 MyotbhvV19Yi9dSUjkkSMF2nlAdUywzTFH8DX4zcfhZlJto5e/rRn71IuXvB42QeAN/Sj
	 0Dg9x2Prc7obYaIZMQO3V6wIMJftebxr6sl+3CH8Sf8xiLBCvB+QTEbesWDglci9b5cQW
	 YcdIutGCJly2rveXT7iCHLjBaj039jYV3tvD7AK2VqQq/CdNLrZkxg9fynQmQXXEf6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjkoeKkX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40763606A690;
	Sat, 21 Nov 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjkoeKkX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296962;
	b=BDPRTal9UisAYc1gDjNb3CWXkzjl8Hs1MFa2/dFoBSM48lOENIkOOX3JzWYXAJQXf/Wx
	 PhGj1uCrmw/+GUeSCzG/pBtU+y2k6MGgzgf3cX6kGhTJeKSBO8KtzIvBpUSr7sY+ZxOsJ
	 lwMOBS1dSZ/b5zURtyKbtV50aFwqKapcMhZJwKAiU2Ke6iyQe2tbqsTfE5cDhyDLLBSlV
	 AorlCx/5GaGhMEuGQvab+dmHqOmbzgL7srNUF4lmxxN5Y68gS6M3F8oCusWNGlNbEQNAZ
	 R3FMFnQfk1ocwPkQVB0g7MEpLGw7KBFSW41VPIfjacajAVN11+P4Twsl143PB7e2QWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296962;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	b=EIGL4Mn+/xLph+PHJo1ac7UlVMwnyOW1EYEjzkmeyu2EDvVj8wJ/wK8k1oQD8xsBK4mD
	 GPK8tM+Icq7XcwPtMOO4xfnmF45aPL94Bl3q6wNVvtP2v5zTL5VGA+bVgRX5Y/awg22OV
	 dt2xYcMelqN0kBbMegL/m4KjUbqbGXBHDBwzu5zWn7RAcWQdC45hKrHqrAOQd2KPK5MnR
	 flmQy7zudO///1Yf4pwE+9CCEAXkr4zqVHUlsrZj4yiVyWayozbgLqldKza/qo8tHnT0d
	 VpWRpas3yUyCf+kbatrGp/bnL085hHoHDjNq/BE1zLy6/nnrzRx0XyF1+XdUl7hjSUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4A14C1F000D0;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296962;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PjkoeKkXmhWSfr72o06rYyUsAQyNowr0kkCrlrvPFB4JdFnEr2uA+29bEFujLZk7F
	 w3LLhXVXVDf5DF7UF0UGeo+RqsCU5M4NYFL7M8cEDJDDiygsb3tPl2l/jduMal2owC
	 u19vi2yL4wO2ZPe5uXPYTE6XVHmsbXd0EgiLX35is8x3KogekwiB329u5WQsov9oyF
	 HZ+JWJd0Yq/XThXofyGSlwFy6t0HNTEa1iRUhy2zCAzQhWvoHA1lJC/cdM9ItX8DMW
	 vWvNYBVhJOz2AriL3qdm2YRBXwNSBvVsoTnSNxk1DZP3otC1VG9pODra9UwmeBOnKX
	 yP37UQIHCVaRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CAEFC4BDF9;
	Sat, 21 Nov 2026 21:35:59 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:49 +0300
Subject: [PATCH v9 04/10] ARM: goldengate: Add support for the CS75xx SoC
 family
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-cs75xx-v9-4-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=6148;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=nTS5Z74lLExG23tYr5NCIxQN5f9mdU4gDsH+rip8OJo=;
 b=3CEF3buFG5JwZz8bVn9NEFtNsof3SvVYnH15Dytxqzjfe8dz7aqohSx5jbgCwLAUqLtl4pGAc
 8TOmLLMSvG0AYlL4P/0qJP9V7xf6Ir2CkNegErHtiYqMnQbxasmz6lG
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

The Cortina Systems CS75xx ("Goldengate G2") are network processors
with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
timers and a PL310 L2 cache controller. The family includes at least
the CS7522 and the CS7542; the CS7542 is used, among others, in the
Securifi Almond+ router.

Apart from the vendor this has little in common with the Cortina
Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
controller are different blocks. It therefore gets its own directory,
named after the Goldengate codename like in the vendor kernel. The
Kconfig symbol, ARCH_CORTINA_ACCESS, covers the whole family and is
named after Cortina Access, which last sold these chips and also makes
the newer 64-bit parts.

The generic DT machine is sufficient for the platform, so only the SMP
bring-up needs code: the bootloader parks the secondary core in a WFI
loop that polls a global software register, so boot it by writing the
physical address of secondary_startup to the register named by the
cpu-release-addr property and sending it a wakeup IPI.

The CPU is a Cortex-A9 r2p1, so select the errata workarounds that apply
to that revision and can be enabled on a multiplatform kernel. The PL310
is r3p1-50rel0 (CACHE_ID 0x410000c7), select the workaround for its
erratum 769419 as well.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/Kconfig                   |  2 ++
 arch/arm/Makefile                  |  1 +
 arch/arm/mach-goldengate/Kconfig   | 19 ++++++++++
 arch/arm/mach-goldengate/Makefile  |  2 ++
 arch/arm/mach-goldengate/platsmp.c | 72 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0cc289a71..87ff65256 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -391,6 +391,8 @@ source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
 
+source "arch/arm/mach-goldengate/Kconfig"
+
 source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 573813ef5..21d7a443c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -187,6 +187,7 @@ machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
+machine-$(CONFIG_ARCH_CORTINA_ACCESS)	+= goldengate
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
diff --git a/arch/arm/mach-goldengate/Kconfig b/arch/arm/mach-goldengate/Kconfig
new file mode 100644
index 000000000..302e24841
--- /dev/null
+++ b/arch/arm/mach-goldengate/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARCH_CORTINA_ACCESS
+	bool "Cortina Systems CS75xx (Goldengate G2)"
+	depends on ARCH_MULTI_V7
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select PL310_ERRATA_769419
+	help
+	  Support for the Cortina Systems CS75xx (Goldengate G2) family of
+	  network processors, such as the CS7542 used in the Securifi
+	  Almond+ router. These SoCs have two Cortex-A9 cores with a PL310
+	  L2 cache controller, a packet processing engine, PCIe, NAND and
+	  the usual low speed peripherals.
diff --git a/arch/arm/mach-goldengate/Makefile b/arch/arm/mach-goldengate/Makefile
new file mode 100644
index 000000000..b839201c9
--- /dev/null
+++ b/arch/arm/mach-goldengate/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SMP)	+= platsmp.o
diff --git a/arch/arm/mach-goldengate/platsmp.c b/arch/arm/mach-goldengate/platsmp.c
new file mode 100644
index 000000000..d9285297b
--- /dev/null
+++ b/arch/arm/mach-goldengate/platsmp.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SMP support for the Cortina Systems CS75xx SoCs
+ *
+ * The bootloader parks the secondary core in a WFI loop that polls a
+ * global software register and jumps to the address found there once it
+ * becomes non-zero. The register is described by the cpu-release-addr
+ * property of the secondary CPU node.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+static int cs75xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	struct device_node *np;
+	void __iomem *release;
+	u64 addr;
+	int ret;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		return -ENODEV;
+
+	ret = of_property_read_u64(np, "cpu-release-addr", &addr);
+	of_node_put(np);
+	if (ret) {
+		pr_err("CPU%u: missing cpu-release-addr\n", cpu);
+		return ret;
+	}
+
+	release = ioremap(addr, sizeof(u32));
+	if (!release)
+		return -ENOMEM;
+
+	writel(__pa_symbol(secondary_startup), release);
+	iounmap(release);
+
+	/* The secondary core waits in WFI, wake it up */
+	dsb_sev();
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return 0;
+}
+
+static void __init cs75xx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("failed to map SCU\n");
+		return;
+	}
+
+	scu_enable(scu_base);
+	iounmap(scu_base);
+}
+
+static const struct smp_operations cs75xx_smp_ops __initconst = {
+	.smp_prepare_cpus	= cs75xx_smp_prepare_cpus,
+	.smp_boot_secondary	= cs75xx_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(cs7542_smp, "cortina,cs7542-smp", &cs75xx_smp_ops);

-- 
2.53.0


