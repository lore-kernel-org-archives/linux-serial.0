From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 05/22] clk: sunxi: Fix gate indexing for sun6i-a31-apb0-gates
Date: Fri, 23 May 2014 15:51:08 +0800
Message-ID: <1400831485-28576-6-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

sun6i-a31-apb0-gates supports using clock-indices for holes between
individual gates. However, the driver passes the number of gates
registered in clk_data->clk_num, which of_clk_src_onecell_get uses
to recognize the range of valid indices a consumer can use.

This patch makes the driver pass the maximum gate index + 1, so
of_clk_src_onecell_get does not complain about indices greater
than gates registered.

This was tested on the A23 SoC, which has a similar APB0 clock,
but has holes for gates to removed IP blocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 44cd27c..b342f2a 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -25,6 +25,7 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 	void __iomem *reg;
 	int gate_id;
 	int ngates;
+	int gate_max = 0;
 	int i;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -72,9 +73,12 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 							    reg, gate_id,
 							    0, NULL);
 		WARN_ON(IS_ERR(clk_data->clks[gate_id]));
+
+		if (gate_id > gate_max)
+			gate_max = gate_id;
 	}
 
-	clk_data->clk_num = ngates;
+	clk_data->clk_num = gate_max + 1;
 
 	return of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 }
-- 
2.0.0.rc2
