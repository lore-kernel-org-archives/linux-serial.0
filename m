From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/6] arm64: defconfig: Enable TI's J721E SoC platform
Date: Wed, 22 May 2019 11:19:21 -0500
Message-ID: <20190522161921.20750-7-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-serial@vger.kernel.org

Enable J721E SoC support from TI.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE:
 - I will resubmit this patch (defconfig update) separately once again once
   patches 1-7 hit the next tree or for 5.3-rc2 which ever is convenient.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..83a509dc247d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -696,6 +696,7 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_K3_AM6_SOC=y
+CONFIG_ARCH_K3_J721E_SOC=y
 CONFIG_SOC_TI=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
-- 
2.21.0.777.g83232e38648b
