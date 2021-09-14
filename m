Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FEFC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E167260F21
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhINJPg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhINJPf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44E19220D0;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFdEy9fYKtaLBQe6L29ZLxJvFnQ+yKgKSkBJTFaDQsQ=;
        b=1h7uhD+xxVa9pvPt7sa3QV8JjOpqyYrhi4F5CDMFAfeCY1seBVG28HmPOWL4LIRhFgzL4E
        /bZlY4Xrm3RghaQutti3tRB6UVjUcUTAReZ123/3tHQ7TTDF3frmgaYuYKMz1/Cghn6pQI
        Tbbj7YqT6nT2tuqQKodJS+jtmBt7JTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFdEy9fYKtaLBQe6L29ZLxJvFnQ+yKgKSkBJTFaDQsQ=;
        b=m6gDN/RRv8w5Djy57McEXcRSi66jXBY8jzZxoU9Fh9qoxBJ2DLTCzpQ2eD7rxMl6+6BeL8
        aIf8bBEmIObNXsDA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE58AA3B90;
        Tue, 14 Sep 2021 09:14:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Al Cooper <alcooperx@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 08/16] tty: drivers/tty/serial/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:07 +0200
Message-Id: <20210914091415.17918-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in
drivers/tty/serial/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Timur Tabi <timur@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/21285.c                  |  2 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  2 +-
 drivers/tty/serial/8250/8250_bcm7271.c      |  2 +-
 drivers/tty/serial/8250/8250_dma.c          |  2 +-
 drivers/tty/serial/8250/8250_mtk.c          |  2 +-
 drivers/tty/serial/8250/8250_omap.c         |  2 +-
 drivers/tty/serial/8250/8250_port.c         |  2 +-
 drivers/tty/serial/altera_jtaguart.c        |  2 +-
 drivers/tty/serial/altera_uart.c            |  2 +-
 drivers/tty/serial/amba-pl010.c             |  2 +-
 drivers/tty/serial/amba-pl011.c             |  6 +++---
 drivers/tty/serial/apbuart.c                |  2 +-
 drivers/tty/serial/ar933x_uart.c            |  2 +-
 drivers/tty/serial/arc_uart.c               |  2 +-
 drivers/tty/serial/atmel_serial.c           |  6 +++---
 drivers/tty/serial/bcm63xx_uart.c           |  2 +-
 drivers/tty/serial/clps711x.c               |  2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
 drivers/tty/serial/digicolor-usart.c        |  2 +-
 drivers/tty/serial/dz.c                     |  2 +-
 drivers/tty/serial/fsl_linflexuart.c        |  2 +-
 drivers/tty/serial/fsl_lpuart.c             |  6 +++---
 drivers/tty/serial/icom.c                   |  2 +-
 drivers/tty/serial/imx.c                    |  6 +++---
 drivers/tty/serial/ip22zilog.c              |  4 ++--
 drivers/tty/serial/jsm/jsm_tty.c            |  2 +-
 drivers/tty/serial/kgdb_nmi.c               |  2 +-
 drivers/tty/serial/lantiq.c                 |  4 ++--
 drivers/tty/serial/liteuart.c               |  2 +-
 drivers/tty/serial/lpc32xx_hs.c             |  2 +-
 drivers/tty/serial/max3100.c                |  4 ++--
 drivers/tty/serial/max310x.c                |  2 +-
 drivers/tty/serial/mcf.c                    |  2 +-
 drivers/tty/serial/men_z135_uart.c          |  2 +-
 drivers/tty/serial/meson_uart.c             |  2 +-
 drivers/tty/serial/milbeaut_usio.c          |  2 +-
 drivers/tty/serial/mpc52xx_uart.c           |  2 +-
 drivers/tty/serial/mps2-uart.c              |  4 ++--
 drivers/tty/serial/msm_serial.c             |  6 +++---
 drivers/tty/serial/mux.c                    |  2 +-
 drivers/tty/serial/mvebu-uart.c             |  2 +-
 drivers/tty/serial/mxs-auart.c              |  4 ++--
 drivers/tty/serial/omap-serial.c            |  2 +-
 drivers/tty/serial/owl-uart.c               |  2 +-
 drivers/tty/serial/pch_uart.c               |  4 ++--
 drivers/tty/serial/pic32_uart.c             |  2 +-
 drivers/tty/serial/pmac_zilog.c             |  4 ++--
 drivers/tty/serial/pxa.c                    |  2 +-
 drivers/tty/serial/qcom_geni_serial.c       |  4 ++--
 drivers/tty/serial/rda-uart.c               |  2 +-
 drivers/tty/serial/rp2.c                    |  2 +-
 drivers/tty/serial/sa1100.c                 |  2 +-
 drivers/tty/serial/samsung_tty.c            |  6 +++---
 drivers/tty/serial/sb1250-duart.c           |  2 +-
 drivers/tty/serial/sc16is7xx.c              |  2 +-
 drivers/tty/serial/sccnxp.c                 |  2 +-
 drivers/tty/serial/serial-tegra.c           |  2 +-
 drivers/tty/serial/serial_core.c            |  2 +-
 drivers/tty/serial/serial_txx9.c            |  2 +-
 drivers/tty/serial/sh-sci.c                 | 12 ++++++------
 drivers/tty/serial/sifive.c                 |  2 +-
 drivers/tty/serial/sprd_serial.c            |  4 ++--
 drivers/tty/serial/st-asc.c                 |  2 +-
 drivers/tty/serial/stm32-usart.c            |  2 +-
 drivers/tty/serial/sunhv.c                  |  2 +-
 drivers/tty/serial/sunsab.c                 |  2 +-
 drivers/tty/serial/sunsu.c                  |  2 +-
 drivers/tty/serial/sunzilog.c               |  4 ++--
 drivers/tty/serial/tegra-tcu.c              |  2 +-
 drivers/tty/serial/timbuart.c               |  2 +-
 drivers/tty/serial/uartlite.c               |  2 +-
 drivers/tty/serial/ucc_uart.c               |  2 +-
 drivers/tty/serial/vr41xx_siu.c             |  2 +-
 drivers/tty/serial/vt8500_serial.c          |  2 +-
 drivers/tty/serial/xilinx_uartps.c          |  2 +-
 drivers/tty/serial/zs.c                     |  2 +-
 76 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 09baef4ccc39..6a5e86f6b363 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -146,7 +146,7 @@ static irqreturn_t serial21285_rx_chars(int irq, void *dev_id)
 
 		status = *CSR_UARTFLG;
 	}
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3bb5e4..b5abe2d4cd74 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -363,7 +363,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 					break;
 			} while (lsr & (UART_LSR_DR | UART_LSR_BI));
 
-			tty_flip_buffer_push(&port->state->port);
+			tty_schedule_flip(&port->state->port);
 		}
 	}
 
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 7f656fac503f..82c6c4490460 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -493,7 +493,7 @@ static void brcmuart_rx_buf_done_isr(struct uart_port *up, int index)
 	else
 		priv->dma_rx_full_buf++;
 
-	tty_flip_buffer_push(tty_port);
+	tty_schedule_flip(tty_port);
 }
 
 static void brcmuart_rx_isr(struct uart_port *up, u32 rx_isr)
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 890fa7ddaa7f..037d71eb3662 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -56,7 +56,7 @@ static void __dma_rx_complete(void *param)
 	tty_insert_flip_string(tty_port, dma->rx_buf, count);
 	p->port.icount.rx += count;
 
-	tty_flip_buffer_push(tty_port);
+	tty_schedule_flip(tty_port);
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb65dc601b23..905be8b79cfd 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -120,7 +120,7 @@ static void mtk8250_dma_rx_complete(void *param)
 
 	up->port.icount.rx += copied;
 
-	tty_flip_buffer_push(tty_port);
+	tty_schedule_flip(tty_port);
 
 	mtk8250_rx_dma(up);
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 891fd8345e25..29d22b6f18da 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -861,7 +861,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	p->port.icount.buf_overrun += count - ret;
 out:
 
-	tty_flip_buffer_push(tty_port);
+	tty_schedule_flip(tty_port);
 }
 
 static void __dma_rx_complete(void *param)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66374704747e..278379732082 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1787,7 +1787,7 @@ unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 		lsr = serial_in(up, UART_LSR);
 	} while (lsr & (UART_LSR_DR | UART_LSR_BI));
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 	return lsr;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_chars);
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 23c4e0e79694..980d81943ce1 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -131,7 +131,7 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 		uart_insert_char(port, 0, 0, ch, flag);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 7c5f4e966b59..c9805c980066 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -243,7 +243,7 @@ static void altera_uart_rx_chars(struct altera_uart *pp)
 				 flag);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void altera_uart_tx_chars(struct altera_uart *pp)
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index e744b953ca34..d8072f9e6699 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -159,7 +159,7 @@ static void pl010_rx_chars(struct uart_amba_port *uap)
 	ignore_char:
 		status = readb(uap->port.membase + UART01x_FR);
 	}
-	tty_flip_buffer_push(&uap->port.state->port);
+	tty_schedule_flip(&uap->port.state->port);
 }
 
 static void pl010_tx_chars(struct uart_amba_port *uap)
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d361cd84ff8c..3e9678bf8c97 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -944,7 +944,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 	dev_vdbg(uap->port.dev,
 		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
 		 dma_count, fifotaken);
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void pl011_dma_rx_irq(struct uart_amba_port *uap)
@@ -1084,7 +1084,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 			dmarx->last_residue =  state.residue;
 		dmarx->last_jiffies = jiffies;
 	}
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	/*
 	 * If no data is received in poll_timeout, the driver will fall back
@@ -1383,7 +1383,7 @@ __acquires(&uap->port.lock)
 	pl011_fifo_to_tty(uap);
 
 	spin_unlock(&uap->port.lock);
-	tty_flip_buffer_push(&uap->port.state->port);
+	tty_schedule_flip(&uap->port.state->port);
 	/*
 	 * If we were temporarily out of DMA mode for a while,
 	 * attempt to switch back to DMA mode again.
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d8c937bdf3f9..0e94314f5d7f 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -117,7 +117,7 @@ static void apbuart_rx_chars(struct uart_port *port)
 		status = UART_GET_STATUS(port);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void apbuart_tx_chars(struct uart_port *port)
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 4379ca4842ae..daccf86aaeb7 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -385,7 +385,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
 			tty_insert_flip_char(port, ch, TTY_NORMAL);
 	} while (max_count-- > 0);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 596217d10d5c..01b6851fec54 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -236,7 +236,7 @@ static void arc_serial_rx_chars(struct uart_port *port, unsigned int status)
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, RXOERR, ch, flg);
 
-		tty_flip_buffer_push(&port->state->port);
+		tty_schedule_flip(&port->state->port);
 	} while (!((status = UART_GET_STATUS(port)) & RXEMPTY));
 }
 
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 249ea35088d2..8f80d812a320 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1178,7 +1178,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 			       1,
 			       DMA_FROM_DEVICE);
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
 }
@@ -1570,7 +1570,7 @@ static void atmel_rx_from_ring(struct uart_port *port)
 		uart_insert_char(port, status, ATMEL_US_OVRE, c.ch, flg);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void atmel_release_rx_pdc(struct uart_port *port)
@@ -1655,7 +1655,7 @@ static void atmel_rx_from_pdc(struct uart_port *port)
 		}
 	} while (head >= pdc->dma_size);
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	atmel_uart_writel(port, ATMEL_US_IER,
 			  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5fb0e84f7fd1..0e884ea05ac5 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -294,7 +294,7 @@ static void bcm_uart_do_rx(struct uart_port *port)
 
 	} while (--max_count);
 
-	tty_flip_buffer_push(tty_port);
+	tty_schedule_flip(tty_port);
 }
 
 /*
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 95abc6faa3d5..09c280c28636 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -136,7 +136,7 @@ static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
 		uart_insert_char(port, status, UARTDR_OVERR, ch, flg);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index c719aa2b1832..f8efddba2160 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -305,7 +305,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 	pinfo->rx_cur = bdp;
 
 	/* activate BH processing */
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	return;
 
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 13ac36e2da4f..0f9032e8d5be 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -175,7 +175,7 @@ static void digicolor_uart_rx(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void digicolor_uart_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index e9edabc5a211..8f74ab71f3e2 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -239,7 +239,7 @@ static inline void dz_receive_chars(struct dz_mux *mux)
 	}
 	for (i = 0; i < DZ_NB_PORT; i++)
 		if (lines_rx[i])
-			tty_flip_buffer_push(&mux->dport[i].port.state->port);
+			tty_schedule_flip(&mux->dport[i].port.state->port);
 }
 
 /*
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 283757264608..759558641c23 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -281,7 +281,7 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&sport->lock, flags);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b1e7190ae483..6e0733f8a326 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -941,7 +941,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 
 	uart_unlock_and_check_sysrq(&sport->port);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void lpuart32_txint(struct lpuart_port *sport)
@@ -1023,7 +1023,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 out:
 	uart_unlock_and_check_sysrq(&sport->port);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static irqreturn_t lpuart_int(int irq, void *dev_id)
@@ -1233,7 +1233,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
 }
 
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 03a2fe9f4c9a..061b824f9612 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -829,7 +829,7 @@ static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 	}
 	icom_port->next_rcv = rcv_buff;
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void process_interrupt(u16 port_int_reg,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..cae87199ef5c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -844,7 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	}
 
 out:
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	return IRQ_HANDLED;
 }
@@ -1180,7 +1180,7 @@ static void imx_uart_dma_rx_callback(void *data)
 	}
 
 	if (w_bytes) {
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 		dev_dbg(sport->port.dev, "We get %d bytes.\n", w_bytes);
 	}
 }
@@ -1236,7 +1236,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 		uart_handle_break(&sport->port);
 		if (tty_insert_flip_char(port, 0, TTY_BREAK) == 0)
 			sport->port.icount.buf_overrun++;
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 	} else {
 		if (usr1 & USR1_FRAMERR) {
 			sport->port.icount.frame++;
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index f4dc5fe4ba92..00f1b5815a58 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -452,7 +452,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		spin_unlock(&up->port.lock);
 
 		if (push)
-			tty_flip_buffer_push(&up->port.state->port);
+			tty_schedule_flip(&up->port.state->port);
 
 		/* Channel B */
 		up = up->next;
@@ -475,7 +475,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		spin_unlock(&up->port.lock);
 
 		if (push)
-			tty_flip_buffer_push(&up->port.state->port);
+			tty_schedule_flip(&up->port.state->port);
 
 		up = up->next;
 	}
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index d74cbbbf33c6..62baad9e13c8 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -638,7 +638,7 @@ void jsm_input(struct jsm_channel *ch)
 	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 	/* Tell the tty layer its okay to "eat" the data now */
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	jsm_dbg(IOCTL, &ch->ch_bd->pci_dev, "finish\n");
 }
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 55c3c9db7462..77308f4e5b8f 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -202,7 +202,7 @@ static void kgdb_nmi_tty_receiver(struct timer_list *t)
 
 	while (kfifo_out(&priv->fifo, &ch, 1))
 		tty_insert_flip_char(&priv->port, ch, TTY_NORMAL);
-	tty_flip_buffer_push(&priv->port);
+	tty_schedule_flip(&priv->port);
 }
 
 static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_struct *tty)
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 497b334bc845..020e3ca72c8e 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -172,7 +172,7 @@ lqasc_rx_chars(struct uart_port *port)
 		ch = readb(port->membase + LTQ_ASC_RBUF);
 		rsr = (__raw_readl(port->membase + LTQ_ASC_STATE)
 			& ASCSTATE_ANY) | UART_DUMMY_UER_RX;
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 		port->icount.rx++;
 
 		/*
@@ -216,7 +216,7 @@ lqasc_rx_chars(struct uart_port *port)
 	}
 
 	if (ch != 0)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index dbc0559a9157..86a64b48c1e7 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -87,7 +87,7 @@ static void liteuart_timer(struct timer_list *t)
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, 0, ch, flg);
 
-		tty_flip_buffer_push(&port->state->port);
+		tty_schedule_flip(&port->state->port);
 	}
 
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b199d7859961..1c90a5a1566e 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -273,7 +273,7 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static void __serial_lpc32xx_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 3c92d4e01488..f9ade20bff71 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -305,7 +305,7 @@ static void max3100_work(struct work_struct *w)
 		}
 
 		if (rxchars > 16) {
-			tty_flip_buffer_push(&s->port.state->port);
+			tty_schedule_flip(&s->port.state->port);
 			rxchars = 0;
 		}
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -318,7 +318,7 @@ static void max3100_work(struct work_struct *w)
 		   !uart_tx_stopped(&s->port))));
 
 	if (rxchars > 0)
-		tty_flip_buffer_push(&s->port.state->port);
+		tty_schedule_flip(&s->port.state->port);
 }
 
 static irqreturn_t max3100_irq(int irqno, void *dev_id)
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3df0788ddeb0..0c689c23894b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -742,7 +742,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		}
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void max310x_handle_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index c7cec7d03620..7f651b9fb005 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -319,7 +319,7 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 		uart_insert_char(port, status, MCFUART_USR_RXOVERRUN, ch, flag);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 /****************************************************************************/
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 9acae5f8fc32..17ce27a60dcb 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -281,7 +281,7 @@ static void men_z135_handle_rx(struct men_z135_port *uart)
 
 	port->icount.rx += copied;
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 }
 
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index efee3935917f..6a4200f493e0 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -226,7 +226,7 @@ static void meson_receive_chars(struct uart_port *port)
 
 	} while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY));
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 8f2cab7f66ad..27f7ae7cf44f 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -202,7 +202,7 @@ static void mlb_usio_rx_chars(struct uart_port *port)
 		port->membase + MLB_USIO_REG_FCR);
 	}
 
-	tty_flip_buffer_push(ttyport);
+	tty_schedule_flip(ttyport);
 }
 
 static irqreturn_t mlb_usio_rx_irq(int irq, void *dev_id)
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 2704dc988e4a..ae63f3595c15 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1421,7 +1421,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		}
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	return psc_ops->raw_rx_rdy(port);
 }
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..fd3e534b8d96 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -196,7 +196,7 @@ static void mps2_uart_rx_chars(struct uart_port *port)
 		tty_insert_flip_char(&port->state->port, rxdata, TTY_NORMAL);
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static irqreturn_t mps2_uart_rxirq(int irq, void *data)
@@ -249,7 +249,7 @@ static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 		mps2_uart_write8(port, UARTn_INT_RX_OVERRUN, UARTn_INT);
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 		handled = IRQ_HANDLED;
 	}
 
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index fcef7a961430..de6c0254bb3e 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -588,7 +588,7 @@ static void msm_complete_rx_dma(void *args)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (count)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 }
 
 static void msm_start_rx_dma(struct msm_port *msm_port)
@@ -757,7 +757,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 		count -= r_count;
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	if (misr & (UART_IMR_RXSTALE))
 		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
@@ -817,7 +817,7 @@ static void msm_handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 643dfbcc43f9..5aedfe8d0481 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -252,7 +252,7 @@ static void mux_read(struct uart_port *port)
 	}
 	
 	if (start_count != port->icount.rx)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 }
 
 /**
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 231de29a6452..5fd54e27243b 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -291,7 +291,7 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 		status = readl(port->membase + UART_STAT);
 	} while (status & (STAT_RX_RDY(port) | STAT_BRK_DET));
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ac45f3386e97..fd0bb7db8084 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -687,7 +687,7 @@ static void mxs_auart_rx_chars(struct mxs_auart_port *s)
 	}
 
 	mxs_write(stat, s, REG_STAT);
-	tty_flip_buffer_push(&s->port.state->port);
+	tty_schedule_flip(&s->port.state->port);
 }
 
 static int mxs_auart_request_port(struct uart_port *u)
@@ -848,7 +848,7 @@ static void dma_rx_callback(void *arg)
 	tty_insert_flip_string(port, s->rx_dma_buf, count);
 
 	mxs_write(stat, s, REG_STAT);
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	/* start the next DMA for RX. */
 	mxs_auart_dma_prep_rx(s);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0862941862c8..51b666604229 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -592,7 +592,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 
 	spin_unlock(&up->port.lock);
 
-	tty_flip_buffer_push(&up->port.state->port);
+	tty_schedule_flip(&up->port.state->port);
 
 	up->port_activity = jiffies;
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..10b6cfc37b2e 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -247,7 +247,7 @@ static void owl_uart_receive_chars(struct uart_port *port)
 		stat = owl_uart_read(port, OWL_UART_STAT);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0351e6f0ef6..b281130dc800 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -619,7 +619,7 @@ static int push_rx(struct eg20t_port *priv, const unsigned char *buf,
 	struct tty_port *tport = &port->state->port;
 
 	tty_insert_flip_string(tport, buf, size);
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	return 0;
 }
@@ -757,7 +757,7 @@ static void pch_dma_rx_complete(void *arg)
 	dma_sync_sg_for_cpu(port->dev, &priv->sg_rx, 1, DMA_FROM_DEVICE);
 	count = dma_push_rx(priv, priv->trigger_level);
 	if (count)
-		tty_flip_buffer_push(&port->state->port);
+		tty_schedule_flip(&port->state->port);
 	async_tx_ack(priv->desc_rx);
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_RX_INT |
 					    PCH_UART_HAL_RX_ERR_INT);
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0a12fb11e698..8525b418f960 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -268,7 +268,7 @@ static void pic32_uart_do_rx(struct uart_port *port)
 
 	spin_unlock(&port->lock);
 
-	tty_flip_buffer_push(tty);
+	tty_schedule_flip(tty);
 }
 
 /* fill tx fifo with chars to send, stop when fifo is about to be full
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 12ce150b0ad4..9677a192f829 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -469,7 +469,7 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
  skip_a:
 	spin_unlock(&uap_a->port.lock);
 	if (push)
-		tty_flip_buffer_push(&uap->port.state->port);
+		tty_schedule_flip(&uap->port.state->port);
 
 	if (!uap_b)
 		goto out;
@@ -494,7 +494,7 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
  skip_b:
 	spin_unlock(&uap_b->port.lock);
 	if (push)
-		tty_flip_buffer_push(&uap->port.state->port);
+		tty_schedule_flip(&uap->port.state->port);
 
  out:
 	return rc;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 41319ef96fa6..2338be87d760 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -158,7 +158,7 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 	ignore_char:
 		*status = serial_in(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
-	tty_flip_buffer_push(&up->port.state->port);
+	tty_schedule_flip(&up->port.state->port);
 
 	/* work around Errata #20 according to
 	 * Intel(R) PXA27x Processor Family
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index aedc38893e6c..53e8f921565d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -557,7 +557,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 		}
 	}
 	if (!drop)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 	return 0;
 }
 #else
@@ -588,7 +588,7 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 		WARN_ON_ONCE(1);
 	}
 	uport->icount.rx += ret;
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index d550d8fa2fab..5ee397db4c90 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -398,7 +398,7 @@ static void rda_uart_receive_chars(struct uart_port *port)
 		status = rda_uart_read(port, RDA_UART_STATUS);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static irqreturn_t rda_interrupt(int irq, void *dev_id)
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 6689d8add8f7..37fe97e92f88 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -423,7 +423,7 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 		up->port.icount.rx++;
 	}
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void rp2_tx_chars(struct rp2_uart_port *up)
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 697b6a002a16..b6adccbec0b7 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -223,7 +223,7 @@ sa1100_rx_chars(struct sa1100_port *sport)
 			 UTSR0_TO_SM(UART_GET_UTSR0(sport));
 	}
 
-	tty_flip_buffer_push(&sport->port.state->port);
+	tty_schedule_flip(&sport->port.state->port);
 }
 
 static void sa1100_tx_chars(struct sa1100_port *sport)
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e2f49863e9c2..601f1f6719c9 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -627,7 +627,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
 
 	if (tty) {
-		tty_flip_buffer_push(t);
+		tty_schedule_flip(t);
 		tty_kref_put(tty);
 	}
 
@@ -746,7 +746,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	s3c24xx_serial_rx_drain_fifo(ourport);
 
 	if (tty) {
-		tty_flip_buffer_push(t);
+		tty_schedule_flip(t);
 		tty_kref_put(tty);
 	}
 
@@ -842,7 +842,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 				 ch, flag);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 738df6d9c0d9..0361db9e6708 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -375,7 +375,7 @@ static void sbd_receive_chars(struct sbd_port *sport)
 		uart_insert_char(uport, status, M_DUART_OVRUN_ERR, ch, flag);
 	}
 
-	tty_flip_buffer_push(&uport->state->port);
+	tty_schedule_flip(&uport->state->port);
 }
 
 static void sbd_transmit_chars(struct sbd_port *sport)
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index acbb615dd28f..bab7a4cc0a79 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -627,7 +627,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 		rxlen -= bytes_read;
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void sc16is7xx_handle_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 10cc16a71f26..25de6a489217 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -434,7 +434,7 @@ static void sccnxp_handle_rx(struct uart_port *port)
 		uart_insert_char(port, sr, SR_OVR, ch, flag);
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 static void sccnxp_handle_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 45e2e4109acd..700c135c70a9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -702,7 +702,7 @@ static void do_handle_rx_pio(struct tegra_uart_port *tup)
 
 	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 		tty_kref_put(tty);
 	}
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0e2e35ab64c7..fb38f1cc2a2d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3109,7 +3109,7 @@ EXPORT_SYMBOL_GPL(uart_handle_cts_change);
 /**
  * uart_insert_char - push a char to the uart layer
  *
- * User is responsible to call tty_flip_buffer_push when they are done with
+ * User is responsible to call tty_schedule_flip when they are done with
  * insertion.
  *
  * @port: corresponding port
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index aaca4fe38486..dacbfe4aa65a 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -331,7 +331,7 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 
-	tty_flip_buffer_push(&up->port.state->port);
+	tty_schedule_flip(&up->port.state->port);
 
 	*status = disr;
 }
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 785537ceb606..226bebade7ae 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -916,7 +916,7 @@ static void sci_receive_chars(struct uart_port *port)
 
 	if (copied) {
 		/* Tell the rest of the system the news. New characters! */
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 	} else {
 		/* TTY buffers full; read from RX reg to prevent lockup */
 		serial_port_in(port, SCxRDR);
@@ -964,7 +964,7 @@ static int sci_handle_errors(struct uart_port *port)
 	}
 
 	if (copied)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 
 	return copied;
 }
@@ -989,7 +989,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 		port->icount.overrun++;
 
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 
 		dev_dbg(port->dev, "overrun error\n");
 		copied++;
@@ -1018,7 +1018,7 @@ static int sci_handle_breaks(struct uart_port *port)
 	}
 
 	if (copied)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 
 	copied += sci_handle_fifo_overrun(port);
 
@@ -1307,7 +1307,7 @@ static void sci_dma_rx_complete(void *arg)
 	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
 
 	if (count)
-		tty_flip_buffer_push(&port->state->port);
+		tty_schedule_flip(&port->state->port);
 
 	desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[active], 1,
 				       DMA_DEV_TO_MEM,
@@ -1517,7 +1517,7 @@ static enum hrtimer_restart sci_dma_rx_timer_fn(struct hrtimer *t)
 	if (read) {
 		count = sci_dma_rx_push(s, s->rx_buf[active], read);
 		if (count)
-			tty_flip_buffer_push(&port->state->port);
+			tty_schedule_flip(&port->state->port);
 	}
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 0ac0371f943b..b65234aaccef 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -448,7 +448,7 @@ static void __ssp_receive_chars(struct sifive_serial_port *ssp)
 		uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
 	}
 
-	tty_flip_buffer_push(&ssp->port.state->port);
+	tty_schedule_flip(&ssp->port.state->port);
 }
 
 /**
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9a7ae6384edf..706351a48557 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -392,7 +392,7 @@ static void sprd_uart_dma_rx(struct uart_port *port)
 
 	port->icount.rx += sp->rx_dma.trans_len;
 	tty_insert_flip_string(tty, sp->rx_buf_tail, sp->rx_dma.trans_len);
-	tty_flip_buffer_push(tty);
+	tty_schedule_flip(tty);
 }
 
 static void sprd_uart_dma_irq(struct uart_port *port)
@@ -621,7 +621,7 @@ static inline void sprd_rx(struct uart_port *port)
 		uart_insert_char(port, lsr, SPRD_LSR_OE, ch, flag);
 	}
 
-	tty_flip_buffer_push(tty);
+	tty_schedule_flip(tty);
 }
 
 static inline void sprd_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 87e480cc8206..45d5086464d9 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -350,7 +350,7 @@ static void asc_receive_chars(struct uart_port *port)
 	}
 
 	/* Tell the rest of the system the news. New characters! */
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static irqreturn_t asc_interrupt(int irq, void *ptr)
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 8f032e77b954..5cb33293f12d 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -277,7 +277,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 
 	uart_unlock_and_check_sysrq(port);
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static void stm32_usart_tx_dma_complete(void *arg)
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index eafada8fb6fa..616aa86b923a 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -225,7 +225,7 @@ static irqreturn_t sunhv_interrupt(int irq, void *dev_id)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (tport)
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 92e572634009..9a6cb4523ab9 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -334,7 +334,7 @@ static irqreturn_t sunsab_interrupt(int irq, void *dev_id)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	if (port)
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 425a016f9db7..9426ea939eb3 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -466,7 +466,7 @@ static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id)
 		if (status & UART_LSR_THRE)
 			transmit_chars(up);
 
-		tty_flip_buffer_push(&up->port.state->port);
+		tty_schedule_flip(&up->port.state->port);
 
 	} while (!(serial_in(up, UART_IIR) & UART_IIR_NO_INT));
 
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 1a54e3e52ed6..de4c26f3523d 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -552,7 +552,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 		spin_unlock(&up->port.lock);
 
 		if (port)
-			tty_flip_buffer_push(port);
+			tty_schedule_flip(port);
 
 		/* Channel B */
 		up = up->next;
@@ -575,7 +575,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 		spin_unlock(&up->port.lock);
 
 		if (port)
-			tty_flip_buffer_push(port);
+			tty_schedule_flip(port);
 
 		up = up->next;
 	}
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 4877c54c613d..3232f702d3d1 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -171,7 +171,7 @@ static void tegra_tcu_receive(struct mbox_client *cl, void *msg)
 		tty_insert_flip_char(port, TCU_MBOX_BYTE_V(value, i),
 				     TTY_NORMAL);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static int tegra_tcu_probe(struct platform_device *pdev)
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 08941eabe7b1..c82365cf85b7 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -87,7 +87,7 @@ static void timbuart_rx_chars(struct uart_port *port)
 		tty_insert_flip_char(tport, ch, TTY_NORMAL);
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	dev_dbg(port->dev, "%s - total read %d bytes\n",
 		__func__, port->icount.rx);
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index dfc1ba4e1572..28d3670faa01 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -218,7 +218,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 
 	/* work done? */
 	if (n > 1) {
-		tty_flip_buffer_push(&port->state->port);
+		tty_schedule_flip(&port->state->port);
 		return IRQ_HANDLED;
 	} else {
 		return IRQ_NONE;
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6000853973c1..d5fc1e29d4d1 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -523,7 +523,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 	qe_port->rx_cur = bdp;
 
 	/* Activate BH processing */
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 
 	return;
 
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 647198b1e2b9..6c36c7d44812 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -346,7 +346,7 @@ static inline void receive_chars(struct uart_port *port, uint8_t *status)
 		lsr = siu_read(port, UART_LSR);
 	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 
 	*status = lsr;
 }
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index e15b2bf69904..172b0c2ebc9d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -184,7 +184,7 @@ static void handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
-	tty_flip_buffer_push(tport);
+	tty_schedule_flip(tport);
 }
 
 static void handle_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 962e522ccc45..156c1e449f9b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -302,7 +302,7 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 		isrstatus = 0;
 	}
 
-	tty_flip_buffer_push(&port->state->port);
+	tty_schedule_flip(&port->state->port);
 }
 
 /**
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 4b4f604646a7..001958ab6041 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -600,7 +600,7 @@ static void zs_receive_chars(struct zs_port *zport)
 		uart_insert_char(uport, status, Rx_OVR, ch, flag);
 	}
 
-	tty_flip_buffer_push(&uport->state->port);
+	tty_schedule_flip(&uport->state->port);
 }
 
 static void zs_raw_transmit_chars(struct zs_port *zport)
-- 
2.33.0

