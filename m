From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v10 3/6] MIPS: PCI: Fix fake subdevice ID for IOC3
Date: Tue, 15 Oct 2019 14:09:48 +0200
Message-ID: <20191015120953.2597-4-tbogendoerfer@suse.de>
References: <20191015120953.2597-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015120953.2597-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Generation of fake subdevice ID had vendor and device ID swapped.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/pci/pci-xtalk-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index dcf6117a17c3..d1d5f54c2632 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -437,7 +437,7 @@ static int bridge_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-#define IOC3_SID(sid)	(PCI_VENDOR_ID_SGI << 16 | (sid))
+#define IOC3_SID(sid)	(PCI_VENDOR_ID_SGI | ((sid) << 16))
 
 static void bridge_setup_ip27_baseio6g(struct bridge_controller *bc)
 {
-- 
2.16.4
