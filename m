From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 02/13] arm: fiq: Allow EOI to be communicated to the intc
Date: Thu, 19 Jun 2014 11:38:12 +0100
Message-ID: <1403174303-25456-3-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Modern ARM systems require an EOI to be sent to the interrupt controller
on completion of both IRQ and FIQ. The FIQ code currently does not provide
any API to perform this. This patch provides this API, implemented by
adding a callback to the fiq_chip structure.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fiq.h | 6 ++++++
 arch/arm/kernel/fiq.c      | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index a7806ef..e5d9458 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -21,6 +21,11 @@
 struct fiq_chip {
 	void (*fiq_enable)(struct irq_data *data);
 	void (*fiq_disable)(struct irq_data *data);
+
+	/* .fiq_eoi() will be called from the FIQ handler. For this
+	 * reason it must not use spin locks (or any other locks).
+	 */
+	void (*fiq_eoi)(struct irq_data *data);
 };
 
 struct fiq_handler {
@@ -43,6 +48,7 @@ extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern void eoi_fiq(int fiq);
 extern bool has_fiq(int fiq);
 extern void fiq_register_mapping(int irq, struct fiq_chip *chip);
 
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 567f8fd..edde332 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -183,6 +183,15 @@ void disable_fiq(int fiq)
 	disable_irq(fiq + fiq_start);
 }
 
+void eoi_fiq(int fiq)
+{
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data && data->fiq_chip->fiq_eoi)
+		data->fiq_chip->fiq_eoi(data->irq_data);
+}
+EXPORT_SYMBOL(eoi_fiq);
+
 bool has_fiq(int fiq)
 {
 	struct fiq_data *data = lookup_fiq_data(fiq);
-- 
1.9.3
