From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v3 3/3] arm64: dts: Add mediatek MT8173 earlycon support
Date: Tue, 28 Apr 2015 21:40:34 +0800
Message-ID: <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Wang Long <long.wanglong@huawei.com>, Kevin Cernekee <cernekee@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Cox <alan@linux.intel.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.orgSascha Hauer <kern>
List-Id: linux-serial@vger.kernel.org

Add earlycon support to mediatek MT8173 evaluation board dts.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 43d5401..d4cf751 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -30,7 +30,9 @@
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
-	chosen { };
+	chosen {
+		linux,stdout-path = &uart0;
+	};
 };
 
 &uart0 {
-- 
1.8.1.1.dirty
