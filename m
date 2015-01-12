From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 4/4] Document: Modify 8250 earlycon kernel parameters
Date: Mon, 12 Jan 2015 21:08:24 +0800
Message-ID: <1421068104-30463-5-git-send-email-eddie.huang@mediatek.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Add options "noinit" to avoid init serial hardware in 8250_early.c

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 Documentation/kernel-parameters.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4df73da..03a4e9b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -948,7 +948,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			UART at the specified I/O port or MMIO address.
 			MMIO inter-register address stride is either 8-bit
 			(mmio) or 32-bit (mmio32).
-			The options are the same as for ttyS, above.
+			The options have two choices: one is the same as for
+			ttyS, above. The other is noinit, which means don't
+			initialize serial hardware, use the same setting as
+			loader.
 
 		pl011,<addr>
 			Start an early, polled-mode console on a pl011 serial
-- 
1.8.1.1.dirty
