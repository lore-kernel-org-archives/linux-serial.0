From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 04/10] Documentation: dt-bindings: Add a new compatible for
 the Armada 3700
Date: Tue,  2 Feb 2016 19:07:42 +0100
Message-ID: <1454436468-4241-5-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The AHCI interfaces used in the Armada 3700 has a few differences with
the one used in the Armada 38x, so it deserves its own compatible string.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340eeeb97f..796e2c23e5df 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -13,6 +13,7 @@ Required properties:
   - "hisilicon,hisi-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
+  - "marvell,armada-3700-ahci"
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
-- 
2.5.0
