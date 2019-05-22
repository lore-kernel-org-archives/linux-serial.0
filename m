From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/6] soc: ti: Add Support for J721E SoC config option
Date: Wed, 22 May 2019 11:19:19 -0500
Message-ID: <20190522161921.20750-5-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Add option to build J721E SoC specific components

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index dbd6c60b81db..a51beac6751f 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -8,6 +8,11 @@ config ARCH_K3_AM6_SOC
 	help
 	  Enable support for TI's AM6 SoC Family support
 
+config ARCH_K3_J721E_SOC
+	bool "K3 J721E SoC"
+	help
+	  Enable support for TI's J721E SoC Family support
+
 endif
 
 endif
-- 
2.21.0.777.g83232e38648b
