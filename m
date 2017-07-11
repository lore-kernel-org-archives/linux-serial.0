From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] clk: gemini: Fix reset regression
Date: Tue, 11 Jul 2017 14:26:01 +0200
Message-ID: <20170711122601.17745-1-linus.walleij@linaro.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

commit e2860e1f62f2 ("serial: 8250_of: Add reset support")
introduced reset support for the 8250_of driver.

However it unconditionally uses the assert/deassert pair to
deassert reset on the device at probe and assert it at
remove. This does not work with systems that have a
self-deasserting reset controller, such as Gemini, that
recently added a reset controller.

As a result, the console will not probe on the Gemini with
this message:

Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
of_serial: probe of 42000000.serial failed with error -524

This (-ENOTSUPP) is the error code returned by the
deassert() operation on self-deasserting reset controllers.

To work around this, implement dummy .assert() and
.deassert() operations in the Gemini combined clock and
reset controller. This fixes the issue on this system.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is the solution suggested by Philipp, I think.
---
 drivers/clk/clk-gemini.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index c391a49aaaff..b4cf2f699a21 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -237,6 +237,18 @@ static int gemini_reset(struct reset_controller_dev *rcdev,
 			    BIT(GEMINI_RESET_CPU1) | BIT(id));
 }
 
+static int gemini_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return 0;
+}
+
+static int gemini_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return 0;
+}
+
 static int gemini_reset_status(struct reset_controller_dev *rcdev,
 			     unsigned long id)
 {
@@ -253,6 +265,8 @@ static int gemini_reset_status(struct reset_controller_dev *rcdev,
 
 static const struct reset_control_ops gemini_reset_ops = {
 	.reset = gemini_reset,
+	.assert = gemini_reset_assert,
+	.deassert = gemini_reset_deassert,
 	.status = gemini_reset_status,
 };
 
-- 
2.9.4

