From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 05/12] arm64: add mvebu architecture entry
Date: Tue, 16 Feb 2016 19:14:55 +0100
Message-ID: <1455646502-23834-6-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 cores
depending of the variant.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bde..85bec422d508 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -48,6 +48,12 @@ config ARCH_MEDIATEK
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
+config ARCH_MVEBU
+	bool "Marvell EBU SoC Family"
+	help
+	  This enables support for Marvell EBU family such as the
+	  Armada 3700 SoC family.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select PINCTRL
-- 
2.5.0
