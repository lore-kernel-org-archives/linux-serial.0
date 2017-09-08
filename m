From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v1 07/10] iio:adc:at91-sama5d2: Support backup mode
Date: Fri,  8 Sep 2017 17:36:01 +0200
Message-ID: <20170908153604.28383-8-romain.izard.pro@gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908153604.28383-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Jonathan Cameron <jic23@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

Support the backup mode for platform suspend, by restoring the hardware
registers on resume.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 71 ++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e10dca3ed74b..f9718c863363 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -200,6 +200,7 @@ struct at91_adc_state {
 	u32				conversion_value;
 	struct at91_adc_soc_info	soc_info;
 	wait_queue_head_t		wq_data_available;
+	unsigned int			current_rate;
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.
@@ -269,6 +270,8 @@ static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
 	mr |= AT91_SAMA5D2_MR_PRESCAL(prescal);
 	at91_adc_writel(st, AT91_SAMA5D2_MR, mr);
 
+	st->current_rate = freq;
+
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
 		freq, startup, prescal);
 }
@@ -375,7 +378,9 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 	    val > st->soc_info.max_sample_rate)
 		return -EINVAL;
 
+	mutex_lock(&st->lock);
 	at91_adc_setup_samp_freq(st, val);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -386,6 +391,21 @@ static const struct iio_info at91_adc_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static void at91_adc_init_hw(struct at91_adc_state *st, unsigned int freq)
+{
+	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
+	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
+	/*
+	 * Transfer field must be set to 2 according to the datasheet and
+	 * allows different analog settings for each channel.
+	 */
+	at91_adc_writel(st, AT91_SAMA5D2_MR,
+			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
+
+	at91_adc_setup_samp_freq(st, freq);
+
+}
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -482,16 +502,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 		goto vref_disable;
 	}
 
-	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
-	/*
-	 * Transfer field must be set to 2 according to the datasheet and
-	 * allows different analog settings for each channel.
-	 */
-	at91_adc_writel(st, AT91_SAMA5D2_MR,
-			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
-
-	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
+	at91_adc_init_hw(st, st->soc_info.min_sample_rate);
 
 	ret = clk_prepare_enable(st->per_clk);
 	if (ret)
@@ -541,12 +552,52 @@ static const struct of_device_id at91_adc_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int at91_adc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	clk_disable_unprepare(st->per_clk);
+
+	regulator_disable(st->vref);
+	regulator_disable(st->reg);
+
+	return 0;
+}
+
+static int at91_adc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int err;
+
+	err = regulator_enable(st->reg);
+	if (err)
+		return err;
+
+	err = regulator_enable(st->vref);
+	if (err)
+		return err;
+
+	at91_adc_init_hw(st, st->current_rate);
+
+	err = clk_prepare_enable(st->per_clk);
+	return err;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
 	.remove = at91_adc_remove,
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
+		.pm = &at91_adc_pm_ops,
 	},
 };
 module_platform_driver(at91_adc_driver)
-- 
2.11.0
