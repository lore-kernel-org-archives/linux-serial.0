Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TBi5Jsw3"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262681722;
	Thu,  7 Dec 2023 09:56:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76BADE000E;
	Thu,  7 Dec 2023 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701971796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/wsTmEWxe0ogRl/8Vy0GB64u7O6jbPEVRaQ+GQnwaY=;
	b=TBi5Jsw3+5mnNcW9IhE2m6nUyGUyN0WNMfAZgXLfasNSPCB4rkolx0TkeWOEZ7qBHW7FzW
	9nuXRnJQKUxnz08NeZFoFosZrgeNEbcymD/jeV/sW5mZQrDiePn7REoFzET/S7ARTJYC4Y
	v5rJexcNH/NdUJCMwinEOfk8kc+n9gc/ZioZdAM3ckW2Yo/Pd9vXD7gAvNTSKgD9Xv7FlB
	uCWJfooNeQidDBNhP7LRJ/uHqrA+uY23ZJaVWYb4hZKMgaI6w8DuAfzpbNRsmNZpb8ta7b
	bQ2/A0rfPKu+SdKZGbF4Xh1WOcht9fd6GPjfbj7MrgNK8rBfWLNEH/WVvLfSww==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Dec 2023 18:56:13 +0100
Subject: [PATCH v6 8/8] tty: serial: amba-pl011: factor QDF2400 SoC erratum
 44 out of probe
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231207-mbly-uart-v6-8-e384afa5e78c@bootlin.com>
References: <20231207-mbly-uart-v6-0-e384afa5e78c@bootlin.com>
In-Reply-To: <20231207-mbly-uart-v6-0-e384afa5e78c@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

On this platform, different vendor data is used. That requires a
compile-time check as we access (1) a global boolean & (2) our local
vendor data. Both symbols are accessible only when
CONFIG_ACPI_SPCR_TABLE is enabled.

Factor the vendor data overriding to a separate function that is empty
when CONFIG_ACPI_SPCR_TABLE is not defined.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fe910c5f3489..d50e3c14b0e4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2869,6 +2869,22 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{
+	if (!qdf2400_e44_present)
+		return;
+
+	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
+	uap->vendor = &vendor_qdt_qdf2400_e44;
+}
+#else
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{ /* empty */ }
+#endif
+
 static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
@@ -2904,13 +2920,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return ret;
 	uap->port.irq	= ret;
 
-#ifdef CONFIG_ACPI_SPCR_TABLE
-	if (qdf2400_e44_present) {
-		dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
-		uap->vendor = &vendor_qdt_qdf2400_e44;
-	} else
-#endif
-		uap->vendor = &vendor_sbsa;
+	uap->vendor = &vendor_sbsa;
+	qpdf2400_erratum44_workaround(&pdev->dev, uap);
 
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;

-- 
2.43.0

