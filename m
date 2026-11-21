Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795294933;
	b=nyh/mF/6va4dFsQog+THrSFk7Sq3TGxKGdz1pRQ+NP46mZPMfa34jtIcdDzCEQA3vUN6
	 zF3xD/j2f2K489LGQsqT4LnS2UmYtxnCjDE+tKn0RdGwuBjNGhdHAoReTm1J4RqjtOmgN
	 9TT4yirIFYGRI1GP4QDsbRmpHV4Qo5LZ1p3HEV+SHsCYPkYsxAmgnYf1GcKm18haqK+G+
	 /6zioPurLue1Ynvcf7Qmfl3WquthllqpzlUh6Tu5tln7dWXVuDuxZD8L5OMpjBt1lUBSt
	 LN4RAyKKWubJCo0GoYpJ3NKjaWb5HScqDZu5n1NUVmNrO8AWRRHg3vVi/X3KOShjH8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294933;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	b=VlRFgo5u7pa9ilYOVNgeuX3BbeFRMHCH3B1A4lj98niPeZmH9uOgOW63yGESxeBCsJbr
	 Nq+h/wOkhosIdFiuclB7xilnj7E30u43B0wMtnDB7yBnwAI5uaXdcPkE2tX3ikZmEb+y9
	 t5N18NzG4LzHdlsBwnnULG1OY5p2/LT29xa9TQsIAhAVKI/oi/I/ux6q9aBft1lURCoUf
	 T5QEs4xvfFlwDMWx1mvMNoBJIdFAtytqyQI5LCRSxJ3K1NkqySdESqPJFqm4xljcEanIU
	 UnZfUzP1Dt5FtRgL34q4tNGjWPRXTfQul3yBhd54f4g4wMwlk+v5pZhIvjdA1zOltqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qlr4lcdS;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6060606A33C;
	Sat, 21 Nov 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qlr4lcdS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294933;
	b=iDyDVzZF4eMka7UnNxEXcvfsdkAIBRaqiD8mTf2aX5aYW9/dmIcofQg8mktQz0mjyWBb
	 YZsHEgtEuNcht/VBSJSSxtmVkgRY+r4yWG9vi6zodJ3aRK9UgC8M2d4VMFnjz5gv11F2i
	 N7DI4Uyjat1XxahRF9SIsrB6VKG0pi6iGfHnxD3gltQidbeHTeDHrTJmfii/AMvw9lPgt
	 i4NutoP0FSiy7HeQFeTWJ9qB6j14cpodJRhrmdbU2+rDAh0qqUPza9W5AaXYlTSV4WVNH
	 TUMon+d1yDeW5mUIkoq/iQZz5G2tMIExG0unrtmRLyV1TLMppLDGhBJZZ1Hw+MaXQeA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294933;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	b=2e3K+8JfnwOmo93cMrUAmvCGZwxtgPVdkOrhriNq8V0QHjlAc7KXAPZtYAGGb+BmKkaH
	 6kqszeU+YUttg/eYrQyC0oLn3cBCBXVT9nyod0bYs5IS0NPdY3pS+/8xnVka3n20i+4P0
	 ZKXxJrCtHIUpNLkcsyM+qvpIJ3Q+xsbucqJ1ZAo8U6zximyeZt/BjA1cYdIz9+RR8sbMZ
	 1FGEO3V7V/AaCttc8qjvngVFmUhbiVHWl28dG9g9TEi4jfMQhmvjIMMqUd4BFRjKMSlOG
	 qBzJ5HWnCIp8SQu1ygUp9z+xpWlTIEdFcYUP5ghcoMY8xaUS8THS4hhho8Ufhyom/UQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17F9E1F000D2;
	Sat, 21 Nov 2026 21:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294933;
	bh=5yPoSbTCYvIdSzDOXsxGntkkui/i1Du//m4UfG6w1zA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Qlr4lcdSnSDm1KFVg6Q3r1JIYHfmT03PxZ/egLHBvkHnPekHobL/thRRvtbUh/wAX
	 86rMUcK31y0cMLR1bHK/4h2K2rbUeUJ8PLXpuc0dDWKqqUvLaJGj5oH7EzzhkxAhPi
	 PbcBoFsFWeSzp6xoMILgg3CUoWnU5gmwBxj5hA5fzskWRlf51JNvgqV+BRyEWhmtKG
	 mIemmE/IpWKrh+QxaQNZYGbrb+OwL4zf9VWObFMWOcylfnNarEQJdi43R1gAL2v6S6
	 wrttr8uSB5t7PcoV8XDj5QIcWuQQ0I8uCQIOST3OXH5H3sWBypw2PfbvCqaqZgwQ5q
	 5ht6JqzeymrAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 967F74BDB2;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:49 +0300
Subject: [PATCH v8 04/10] ARM: goldengate: Add support for the CS75xx SoC
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
Message-Id: <20261122-b4-cs75xx-v8-4-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=6148;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=nTS5Z74lLExG23tYr5NCIxQN5f9mdU4gDsH+rip8OJo=;
 b=Rf3SJSwRTWDOTPjzOJAjnOXYxQxn2I1p4BaKDxim+tOQfs48m1sYtWlcUzRIZPkywJ515B+gv
 YGOZYRsqFL5DnCU4r95oZQ4Ei6gcFHgOrR1e4WAqvinPw1/9/IHw06S
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


