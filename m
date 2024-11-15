Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CE18CBEC
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660002; cv=none; b=N9ClWC1+2ja/yrGWo5oD8Tac2zM2gICC24oipB39v3eosciixBVyPZDkytycBpopc2R3vE/KnbzWMlT86vFAStFLZVtAhdJcYYzCC0HhjgYi2MhTd9g/UdRwSGCG5DuPyP/17aD70YCGItwgcj7YvC9HrEMFYRw3QDerJwov7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660002; c=relaxed/simple;
	bh=FFRF80H0koM3Bidlvn0OS6uCtbx82Je6SC/UPGx3164=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nk1ShNb9FfVlvEAoGo+M8y2X3VHDH3BO2gT48pMfgZujNmoTDeQZnu0MxM8WGrRkEbT5WOkYSSMTOkDJrNuMy4LMmPRV94tt2mRbXQiso4hA7gpX3Fzyf4EPwP+706FTh3Zeb43u0Tf4xTGi4eWHCI5hor0v1yfEgFKyMZxdIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tOGb483d; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOGb483d"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731659997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJcngzl/I+Enjvlx2cl2k9RgEKpAZGwiIl4gIVm0NBo=;
	b=tOGb483dQLGOP3sTJg5JviyT7Gx6ZtaYzEzqFhqiG2VhsCdABuvJzxtIjt2p6gII1wqpjN
	YUQn75OOrypGMT8hCfgSCKQNu3fA55ilBV3PEYk79Ai3dzmLLUfT36sS83iVJpHMYHHUv9
	utRmPW0kkb1MEb6EOWu1GrG1cQBGPbE=
Date: Fri, 15 Nov 2024 08:39:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: cixi.geng@linux.dev
Message-ID: <d9bd254f7d2f43c99b9d2369af59b208d787683a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] serial: sprd: Add support for sc9632
To: "Wenhua Lin" <Wenhua.Lin@unisoc.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: "Orson Zhai" <orsonzhai@gmail.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Chunyan Zhang" <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, "wenhua lin" <wenhua.lin1994@gmail.com>,
 "Wenhua Lin" <Wenhua.Lin@unisoc.com>, "Xiongpeng Wu"
 <xiongpeng.wu@unisoc.com>, "Zhaochen Su" <Zhaochen.Su@unisoc.com>,
 "Zhirong Qiu" <Zhirong.Qiu@unisoc.com>
In-Reply-To: <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B411=E6=9C=8813=E6=97=A5 19:05, "Wenhua Lin" <Wenhua.Lin@uniso=
c.com> =E5=86=99=E5=88=B0:



>=20
>=20Due to the platform's new project uart ip upgrade,
>=20
>=20the new project's timeout interrupt needs to use bit17
>=20
>=20while other projects' timeout interrupt needs to use
>=20
>=20bit13, using private data to adapt and be compatible
>=20
>=20with all projects.
>=20
>=20Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>=20
>=20---
>=20
>=20 drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++--=
--
>=20
>=20 1 file changed, 36 insertions(+), 5 deletions(-)
>=20
>=20diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
>=20
>=20index 3fc54cc02a1f..882580c3cf37 100644
>=20
>=20--- a/drivers/tty/serial/sprd_serial.c
>=20
>=20+++ b/drivers/tty/serial/sprd_serial.c
>=20
>=20@@ -53,10 +53,12 @@
>=20
>=20 #define SPRD_IEN_TX_EMPTY BIT(1)
>=20
>=20 #define SPRD_IEN_BREAK_DETECT BIT(7)
>=20
>=20 #define SPRD_IEN_TIMEOUT BIT(13)
>=20
>=20+#define SPRD_IEN_DATA_TIMEOUT BIT(17)
>=20
>=20=20
>=20
>  /* interrupt clear register */
>=20
>=20 #define SPRD_ICLR 0x0014
>=20
>=20 #define SPRD_ICLR_TIMEOUT BIT(13)
>=20
>=20+#define SPRD_ICLR_DATA_TIMEOUT BIT(17)
>=20
>=20=20
>=20
>  /* line control register */
>=20
>=20 #define SPRD_LCR 0x0018
>=20
>=20@@ -102,6 +104,7 @@
>=20
>=20 #define SPRD_IMSR_TX_FIFO_EMPTY BIT(1)
>=20
>=20 #define SPRD_IMSR_BREAK_DETECT BIT(7)
>=20
>=20 #define SPRD_IMSR_TIMEOUT BIT(13)
>=20
>=20+#define SPRD_IMSR_DATA_TIMEOUT BIT(17)
>=20
>=20 #define SPRD_DEFAULT_SOURCE_CLK 26000000
>=20
>=20=20
>=20
>  #define SPRD_RX_DMA_STEP 1
>=20
>=20@@ -118,6 +121,12 @@ struct sprd_uart_dma {
>=20
>=20 bool enable;
>=20
>=20 };
>=20
>=20=20
>=20
> +struct sprd_uart_data {
>=20
>=20+ unsigned int timeout_ien;
>=20
>=20+ unsigned int timeout_iclr;
>=20
>=20+ unsigned int timeout_imsr;
>=20
>=20+};
>=20
>=20+
>=20
>=20 struct sprd_uart_port {
>=20
>=20 struct uart_port port;
>=20
>=20 char name[16];
>=20
>=20@@ -126,6 +135,7 @@ struct sprd_uart_port {
>=20
>=20 struct sprd_uart_dma rx_dma;
>=20
>=20 dma_addr_t pos;
>=20
>=20 unsigned char *rx_buf_tail;
>=20
>=20+ const struct sprd_uart_data *pdata;
>=20
>=20 };
>=20
>=20=20
>=20
>  static struct sprd_uart_port *sprd_port[UART_NR_MAX];
>=20
>=20@@ -134,6 +144,18 @@ static int sprd_ports_num;
>=20
>=20 static int sprd_start_dma_rx(struct uart_port *port);
>=20
>=20 static int sprd_tx_dma_config(struct uart_port *port);
>=20
>=20=20
>=20
> +static const struct sprd_uart_data sc9836_data =3D {
>=20
>=20+ .timeout_ien =3D SPRD_IEN_TIMEOUT,
>=20
>=20+ .timeout_iclr =3D SPRD_ICLR_TIMEOUT,
>=20
>=20+ .timeout_imsr =3D SPRD_IMSR_TIMEOUT,
>=20
>=20+};
>=20
>=20+
>=20
>=20+static const struct sprd_uart_data sc9632_data =3D {
>=20
>=20+ .timeout_ien =3D SPRD_IEN_DATA_TIMEOUT,
>=20
>=20+ .timeout_iclr =3D SPRD_ICLR_DATA_TIMEOUT,
>=20
>=20+ .timeout_imsr =3D SPRD_IMSR_DATA_TIMEOUT,
>=20
>=20+};
>=20
>=20+
>=20
>=20 static inline unsigned int serial_in(struct uart_port *port,
>=20
>=20 unsigned int offset)
>=20
>=20 {
>=20
>=20@@ -637,6 +659,8 @@ static irqreturn_t sprd_handle_irq(int irq, void =
*dev_id)
>=20
>=20 {
>=20
>=20 struct uart_port *port =3D dev_id;
>=20
>=20 unsigned int ims;
>=20
>=20+ struct sprd_uart_port *sp =3D
>=20
>=20+ container_of(port, struct sprd_uart_port, port);
>=20
>=20=20
>=20
>  uart_port_lock(port);
>=20
>=20=20
>=20
> @@ -647,14 +671,14 @@ static irqreturn_t sprd_handle_irq(int irq, void =
*dev_id)
>=20
>=20 return IRQ_NONE;
>=20
>=20 }
>=20
>=20=20
>=20
> - if (ims & SPRD_IMSR_TIMEOUT)
>=20
>=20- serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
>=20
>=20+ if (ims & sp->pdata->timeout_imsr)
>=20
>=20+ serial_out(port, SPRD_ICLR, sp->pdata->timeout_iclr);
>=20
>=20=20
>=20
>  if (ims & SPRD_IMSR_BREAK_DETECT)
>=20
>=20 serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
>=20
>=20=20
>=20
>  if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
>=20
>=20- SPRD_IMSR_TIMEOUT))
>=20
>=20+ sp->pdata->timeout_imsr))
>=20
>=20 sprd_rx(port);
>=20
>=20=20
>=20
>  if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
>=20
>=20@@ -729,7 +753,7 @@ static int sprd_startup(struct uart_port *port)
>=20
>=20 /* enable interrupt */
>=20
>=20 uart_port_lock_irqsave(port, &flags);
>=20
>=20 ien =3D serial_in(port, SPRD_IEN);
>=20
>=20- ien |=3D SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
>=20
>=20+ ien |=3D SPRD_IEN_BREAK_DETECT | sp->pdata->timeout_ien;
>=20
>=20 if (!sp->rx_dma.enable)
>=20
>=20 ien |=3D SPRD_IEN_RX_FULL;
>=20
>=20 serial_out(port, SPRD_IEN, ien);
>=20
>=20@@ -1184,6 +1208,12 @@ static int sprd_probe(struct platform_device *=
pdev)
>=20
>=20=20
>=20
>  up->mapbase =3D res->start;
>=20
>=20=20
>=20
> + sport->pdata =3D of_device_get_match_data(&pdev->dev);
>=20
>=20+ if (!sport->pdata) {
>=20
>=20+ dev_err(&pdev->dev, "get match data failed!\n");
>=20
>=20+ return -EINVAL;
>=20
>=20+ }
>=20
>=20+
>=20
>=20 irq =3D platform_get_irq(pdev, 0);
>=20
>  if (irq < 0)
>=20
>=20 return irq;
>=20
>=20@@ -1248,7 +1278,8 @@ static int sprd_resume(struct device *dev)
>=20
>=20 static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
>=20
>=20=20
>=20
>  static const struct of_device_id serial_ids[] =3D {
>=20
>=20- {.compatible =3D "sprd,sc9836-uart",},
>=20
>=20+ {.compatible =3D "sprd,sc9836-uart", .data =3D &sc9836_data},
>=20
>=20+ {.compatible =3D "sprd,sc9632-uart", .data =3D &sc9632_data},
>=20
>=20 {}
>=20
>=20 };
>=20
>=20 MODULE_DEVICE_TABLE(of, serial_ids);
>=20
>=20--=20
>=20
> 2.34.1
>
Acked-by: Cixi Geng <cixi.geng@linux.dev>
