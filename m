Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67A46AF2C
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529158; cv=none; b=uBVAQTT1KaryUs9oXrDVb9YIuTepk/qzlQ/djWPE5FvmkVb+51kZHlnwpc6JSjeXSzD8MRaI+uJrhhwfLsa5Slx956ppGJuS9IyevXnG18mbvprvXhdnm4dPIYXbCAymfA1XnZJR/GA89h1HGv+WAhQTBC1aa7KUztnhJT15T5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529158; c=relaxed/simple;
	bh=WDBjC5JQF5VdSIq9O9eCf7LHS6j6XM87O1Og4dEIOhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIN/3DrWjBwvB74HZjEYDn/6NAu3gk6ezgT2J4hTbv1xnE+BbDvSBq/pAFT8y9pbPkB06kPINJrHx4PzGkQNOi/JVmNGsOnwIrt8/7N6JvkwDuxfSrOtnOiLXfmg3x+XvlpePg5g84n+OVuy+0UyZdtkOc1eEYu6t5NldHE/hKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d//kM1kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCzKLIIc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d//kM1kI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCzKLIIc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HKjG564700
	for <linux-serial@vger.kernel.org>; Fri, 9 Oct 2026 06:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sz/X42fuQftb91zwXJTjvjf8awAls/1D2fUWK5cjhVw=; b=d//kM1kISpt2p2cB
	pCJLS+9ZJ4x/o8nPDh+iYP6LX84TbbjpOtJ7+e4NUvEJs6Ukh5t+LFukBd/C4XeZ
	uDblinQ1wI0YhrFVhnGTykf3721fp/IjwM3l/p2fU+W4MhMDzdJDAbGJogQG5/iu
	x6Nn7dngTlcd5Z/KlB6MRAzR1yKaNnxZVYdJqFO+eAyBJdXJFggpweziN+pBcYGX
	hE/2eDK5yIKEqOpqyfMmbDBq+1z+RELjayuoAldWjB2sbR0Gc8m8OZH4kQ14c0C9
	RNPzjgMLQYEQAUfVdiVuNmK8MF1y+jln/Tika71+zdKUOnFS9q4pWKHtLQbddrWz
	L6KLsw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxka8wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 06:59:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd3b9e70fa4so485793a12.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791529154; x=1792133954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sz/X42fuQftb91zwXJTjvjf8awAls/1D2fUWK5cjhVw=;
        b=GCzKLIIcN19FscFfFf6FDCfHTtr79/mp8a+jmYbJunwB+bNtOLxylttW7eZygchyui
         pdd67mf7JD1LVzZ9kVVy+MhVlY5wXU58jDlmDGkf3xl9VOJgb3KePAuskxDmQ/iYH9iX
         JoTrAt1e77JolTqaFl6ht7G5c3qBBjNxoXIIuCf2hkDDxMkiHO4Oh/cTkFoePNukGcdf
         Ma5mzLDnYAVH2iUxbZs1jzJZMUo2+E1XrB8Ip35WB91SqqHHO6hZOemAMQYubFhcpxjV
         eMGNzYigt7SvUsGmD5LliooOafYM8NwxfCRUW/sEE3y3N5b0hT+I2spk5oC+Mxk0aGOh
         VZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529154; x=1792133954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sz/X42fuQftb91zwXJTjvjf8awAls/1D2fUWK5cjhVw=;
        b=RpsAYq2sx2IRXVD3BxzSzgCoVEGhVkyXnJFobrtp17/+Ytt1BUPBVOI1Iiq5x0UctM
         vA5vcl853Wn2Vx+D25EafkLX4Ru9uT25++ZSaY6CrUeaT8mYaGvPBS78h9XAWOBeX+gt
         cyUqZ9Ltn/ZS5nsjiJUskc704h/qtbRfjmYJcrrL4GSiNAhwpye3Y+MVfR1VdGEW2EEP
         TAsExcWvOAAf22Kv7BoK9999/bgQ61po/mL1ldqV+MxgTLe8ZPyT7KXwjnZEdWlQb3dg
         gFr4kFxWgGdqFsnp84v58Hk1iKUf/HoMCKPHMVtfyeTR1CL6wTwcSPNlmXl8fGRFL1mj
         7TqA==
X-Forwarded-Encrypted: i=1; AKwUvBysVecATZdczSImFinCrCdhZT5ud+xH1pVnaXTrIC3NJjqloIf9sbd/pXoTxKPz9V/SiOdehiTv76JW2WY=@vger.kernel.org
X-Gm-Message-State: AFuF++llRD6CHdInHQJZMAiqr/kgoLnHImQrMZR+zEceQ1C1ynVIFSx9
	7RPbYfYFqQ+TVPX8Js9sg920AmUCvzutH7Tv3WN4QXrQZ4aGYPMT438xwzHo3by9/bgH8txHv2/
	dfjqOp7vSAyChjTy8omT8+mLEIl8zAKuvsY91zQezwEORbADaJNwbye5Yahv+X8ZJ01U8uoU8RH
	8=
X-Gm-Gg: AYBFou36f1E9jBiD0Q1J84lzo01/Auznb/Yn0NJ6zwemBBkD9CyMOA005HtyEJd+3rh
	cPvVomvHUGIui+KBsJfWjud3A7l2c4wpw+BD/k9+xs4c7/SgOp+4BzB7rxgt1IYitSW/u6E+vqC
	9eGJRwYwW2jE+DiXiFQqwxfvT9edqF39nuRBPlZrmeBDSz1kGocKYA12qdeLRuUvsNDNyHJfzOe
	T7b9cM/ZWEaJ6DAw3CNzbwVnNhEkbOy46eaCEBgXiKro/Tto2HnI6xbRVVWuZEXq6L2rxD9eguU
	0ehGbPS7ukFVzt9GeZLo+7c0fgucs9eFtkv6Awn/qQq/j+aUT6N+S8eHhCJ1UslCYtJTs26V5v5
	tzckYil02ZdbzlhRQWFCP
X-Received: by 2002:a05:6a20:3d06:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3e16b7aa7dcmr755363637.0.1791529153425;
        Thu, 08 Oct 2026 23:59:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d06:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3e16b7aa7dcmr755343637.0.1791529152850;
        Thu, 08 Oct 2026 23:59:12 -0700 (PDT)
Received: from [10.213.103.163] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e088efsm499980a12.11.2026.10.08.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:59:12 -0700 (PDT)
From: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 12:27:56 +0530
Subject: [PATCH 4/4] tty: serial: qcom_geni_serial: Add GPI DMA support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        praveen.talari@oss.qualcomm.com,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791529122; l=27059;
 i=naresh.maramaina@oss.qualcomm.com; s=20260316; h=from:subject:message-id;
 bh=WDBjC5JQF5VdSIq9O9eCf7LHS6j6XM87O1Og4dEIOhw=;
 b=+9IxgMnvt3Y0cRqb3mWltWEPWqfDZYJZ6yBRFXfx5D9AUJK+TgOQ0GbTd1OcYQa6wsTvqSa3x
 FLvXp8gOFvwBsEH/AyzqwwTLkuxtIVQPlKT2cazcNrki8qfC2gqBHcX
X-Developer-Key: i=naresh.maramaina@oss.qualcomm.com; a=ed25519;
 pk=j7iST9yrLbsgWcWrqdlUNIOWl2WBl4wV1q35/n9SCkg=
X-Proofpoint-GUID: 7nShMtCF0MyzN3sg8emKVi7_q-gyq1NR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX78q2Uab3Z5Sl
 dVbQx3peJ1JUo2MNFnT6zNwVGnLnhvtBh6J2RH3kuOpTz0AsJDq8qxa3hPCmWwRI5X5VHUna935
 P1Dk9pwX7dNpZmzTWQKN67IVpbz90PE=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac890c2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hBjL1wLKESsYej-2EWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfXyQeX9oLC5pyc
 Q74vg8h1rLInHZnxdhfKlWl17iOAN0ik4m8gapGsd+fdUAkyhUZWkfOVsgGYoHE8HYQpoYZcv+7
 eRm29bZvzfYaTGoZ5ZrjwScGpweTtE2YpZlOuG7A6WAc+bK/JoylwVfLM6AYcAyOlbwtnvbzj1R
 kqHPN6h4OLNtsU8uifUcQzUcnAiETLKIFIBpdwJFAg9F9ltVksc48euRn+rC55m0C8ia/9+JvIG
 d9CMBbwcXdcj3FAlqyPPDLnAOZr1VE9X36uhfuKovFk1OG3DB9se+V7UD30uOuSOfD7HfUs9Zgv
 KzHY3NE6l0a3K3ktmk1Ehij1P1N/nFWbPGNv47bZENxZ5j9Cs0sifcS38ICaoqcsgzpBYQQzcuf
 PL0VfIj/FpLxAPlPnQFWN+Z3UxsZ8uHWPiXO3CcZdau0htcr3VAXgk75wWKfEhhyKAdynI+OoMU
 xYYUZ04bzTnQIKRL8OA==
X-Proofpoint-ORIG-GUID: 7nShMtCF0MyzN3sg8emKVi7_q-gyq1NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090027

Some QUP serial engines are configured to operate in GPI DMA mode,
while the UART driver currently supports only FIFO and SE DMA
transfers. Add support for UARTs operating through the DMAengine GPI
interface.
 
Allow UART serial engines to remain in GPI DMA mode during firmware
loading instead of forcing FIFO mode. Detect GPI DMA operation during
port setup and initialize the DMA channels, workqueues and RX buffers
required for GPI transfers.
 
Submit TX and RX transfers through DMAengine when operating in GPI
mode, and route transfer cancellation and shutdown through the GPI DMA
channels. Defer these operations to workqueues since the DMAengine path
may sleep while waiting on mutexes or timeouts, whereas UART transfer
operations can be invoked with the port spinlock held.

Pass clock source, clock divider, character format, parity,
flow-control settings, RX stale timeout, FIFO threshold and other
UART configuration parameters to the GPI DMA driver through the
UART peripheral configuration structure. Start RX only after this
configuration is available so the DMA engine can program the
corresponding CONFIG0 TRE.

Support 2-wire UART TX and RX transfers in GPI DMA mode. GPI DMA
support for CTS/RTS flow control is outside the scope of this change.

Keep the existing FIFO and SE DMA paths unchanged.

Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c       |   4 -
 drivers/tty/serial/qcom_geni_serial.c | 576 ++++++++++++++++++++++++++++++++--
 2 files changed, 557 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 074087c592cc..2e5ba93e1d7e 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1582,10 +1582,6 @@ int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protoco
 	if (of_property_read_bool(se->dev->of_node, "qcom,enable-gsi-dma"))
 		mode = GENI_GPI_DMA;
 
-	/* GSI mode is not supported by the UART driver; therefore, setting FIFO mode */
-	if (protocol == GENI_SE_UART)
-		mode = GENI_SE_FIFO;
-
 	ret = request_firmware(&fw, fw_name, se->dev);
 	if (ret) {
 		if (ret == -ENOENT)
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4a6f526340b8..eb66194a7f64 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -12,7 +12,9 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/qcom-gpi-dma.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -69,6 +71,16 @@
 #define PAR_ODD				0x01
 #define PAR_SPACE			0x10
 
+/* UART GPI mode parity flags */
+#define GPI_PAR_EVEN		0x0
+#define GPI_PAR_ODD		0x1
+#define GPI_PAR_SPACE		0x2
+#define GPI_PAR_MARK		0x3
+#define GPI_PAR_NONE		0x4
+
+#define GPI_START_TRANSFER	1
+#define GPI_CHAR_SIZE_OFFSET	5
+
 /* SE_UART_MANUAL_RFR register fields */
 #define UART_MANUAL_RFR_EN		BIT(31)
 #define UART_RFR_NOT_READY		BIT(1)
@@ -106,6 +118,8 @@
 #define BYTES_PER_FIFO_WORD		4U
 
 #define DMA_RX_BUF_SIZE		2048
+#define NUM_GPI_RX_BUFFERS	4
+#define INC_WRAP_RX_INDEX(index) (((index) + 1) % NUM_GPI_RX_BUFFERS)
 
 static DEFINE_IDA(port_ida);
 
@@ -129,6 +143,26 @@ struct qcom_geni_private_data {
 	unsigned int write_cached_bytes_cnt;
 };
 
+struct qcom_geni_serial_gpi {
+	struct gpi_serial_config peripheral;
+	struct qcom_geni_serial_port *port;
+	struct work_struct tx_cancel_work;
+	struct work_struct tx_xfer_work;
+	struct work_struct rx_cancel_work;
+	struct work_struct rx_xfer_work;
+	struct workqueue_struct *tx_wq;
+	struct workqueue_struct *rx_wq;
+	struct completion tx_xfer_completion;
+	struct dma_chan *tx_chan;
+	struct dma_chan *rx_chan;
+	dma_addr_t rx_dma_addr[NUM_GPI_RX_BUFFERS];
+	void *rx_buf[NUM_GPI_RX_BUFFERS];
+	u32 xmit_size;
+	u8 rx_done_index;
+	unsigned int baud;
+	bool tx_cancel_pending;
+};
+
 struct qcom_geni_serial_port {
 	struct uart_port uport;
 	struct geni_se se;
@@ -157,6 +191,9 @@ struct qcom_geni_serial_port {
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
 	struct notifier_block panic_nb;
+
+	struct qcom_geni_serial_gpi *gpi;
+	bool gpi_mode;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -170,6 +207,8 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static int qcom_geni_serial_port_setup(struct uart_port *uport);
 static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport);
 static void qcom_geni_serial_resume_tx(struct uart_port *uport);
+static void
+qcom_geni_serial_gpi_rx_callback_result(void *cb, const struct dmaengine_result *result);
 
 static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 {
@@ -789,6 +828,11 @@ static void handle_rx_uart(struct uart_port *uport, u32 bytes)
 
 static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
 {
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	if (port->gpi_mode)
+		return !port->tx_dma_addr ? TIOCSER_TEMT : 0;
+
 	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 }
 
@@ -805,6 +849,17 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
+	if (port->gpi_mode && port->tx_dma_addr) {
+		/*
+		 * Allow tx_xfer_work to finish. Buffer cleanup is deferred until
+		 * the DMA channel has been terminated.
+		 */
+		port->gpi->tx_cancel_pending = true;
+		complete(&port->gpi->tx_xfer_completion);
+		queue_work(port->gpi->tx_wq, &port->gpi->tx_cancel_work);
+		return;
+	}
+
 	if (qcom_geni_serial_main_active(uport))
 		__qcom_geni_serial_cancel_tx_cmd(uport);
 
@@ -836,6 +891,11 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	if (kfifo_is_empty(&tport->xmit_fifo))
 		return;
 
+	if (port->gpi_mode) {
+		queue_work(port->gpi->tx_wq, &port->gpi->tx_xfer_work);
+		return;
+	}
+
 	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
 			UART_XMIT_SIZE);
 
@@ -996,6 +1056,11 @@ static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
 	if (!qcom_geni_serial_secondary_active(uport))
 		return;
 
+	if (port->gpi_mode) {
+		queue_work(port->gpi->rx_wq, &port->gpi->rx_cancel_work);
+		return;
+	}
+
 	geni_se_cancel_s_cmd(&port->se);
 	done = qcom_geni_serial_poll_bit(uport, SE_DMA_RX_IRQ_STAT,
 			RX_EOT, true);
@@ -1021,6 +1086,11 @@ static void qcom_geni_serial_start_rx_dma(struct uart_port *uport)
 	if (qcom_geni_serial_secondary_active(uport))
 		qcom_geni_serial_stop_rx_dma(uport);
 
+	if (port->gpi_mode) {
+		queue_work(port->gpi->rx_wq, &port->gpi->rx_xfer_work);
+		return;
+	}
+
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, UART_PARAM_RFR_OPEN);
 
 	if (!port->rx_dma_addr) {
@@ -1311,6 +1381,16 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 	/* Atomic console output queues tx_kick without taking the port lock. */
 	WRITE_ONCE(port->tx_kick_enabled, false);
 	irq_work_sync(&port->tx_kick);
+
+	if (port->gpi_mode) {
+		qcom_geni_serial_stop_tx_dma(uport);
+		flush_workqueue(port->gpi->tx_wq);
+		flush_workqueue(port->gpi->rx_wq);
+
+		pm_runtime_put_sync(uport->dev);
+		return;
+	}
+
 	disable_irq(uport->irq);
 
 	uart_port_lock_irq(uport);
@@ -1332,6 +1412,379 @@ static void qcom_geni_serial_flush_buffer_fifo(struct uart_port *uport)
 	qcom_geni_serial_cancel_tx_cmd(uport);
 }
 
+static void qcom_geni_serial_gpi_tx_unmap(struct qcom_geni_serial_port *port)
+{
+	struct qcom_geni_serial_gpi *gpi = port->gpi;
+
+	if (!port->tx_dma_addr)
+		return;
+
+	dma_unmap_single(port->se.dev->parent, port->tx_dma_addr,
+			 gpi->xmit_size, DMA_TO_DEVICE);
+	port->tx_dma_addr = (dma_addr_t)NULL;
+}
+
+static void qcom_geni_serial_gpi_cancel_tx_work(struct work_struct *work)
+{
+	struct qcom_geni_serial_gpi *gpi = container_of(work, struct qcom_geni_serial_gpi,
+							tx_cancel_work);
+	struct qcom_geni_serial_port *port = gpi->port;
+
+	dmaengine_terminate_sync(gpi->tx_chan);
+	qcom_geni_serial_gpi_tx_unmap(port);
+}
+
+static void qcom_geni_serial_gpi_cancel_rx_work(struct work_struct *work)
+{
+	struct qcom_geni_serial_gpi *gpi = container_of(work, struct qcom_geni_serial_gpi,
+							rx_cancel_work);
+	dmaengine_terminate_sync(gpi->rx_chan);
+}
+
+static void qcom_geni_serial_gpi_rx_queue_dma_tre(struct qcom_geni_serial_port *port, u8 idx)
+{
+	struct qcom_geni_serial_gpi *gpi = port->gpi;
+	struct uart_port *uport = &port->uport;
+	struct dma_async_tx_descriptor *desc;
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	dma_cookie_t rx_cookie;
+
+	desc = dmaengine_prep_slave_single(gpi->rx_chan, gpi->rx_dma_addr[idx],
+					   UART_XMIT_SIZE, DMA_DEV_TO_MEM, flags);
+	if (!desc) {
+		dev_err(uport->dev, "Error setting up rx desc\n");
+		return;
+	}
+
+	desc->callback_result = qcom_geni_serial_gpi_rx_callback_result;
+	desc->callback_param = port;
+	rx_cookie = dmaengine_submit(desc);
+	if (dma_submit_error(rx_cookie)) {
+		dev_err(uport->dev, "%s: dmaengine_submit failed: %d\n", __func__, rx_cookie);
+		dmaengine_terminate_sync(gpi->rx_chan);
+		return;
+	}
+	dma_async_issue_pending(gpi->rx_chan);
+}
+
+static void
+qcom_geni_serial_gpi_rx_callback_result(void *cb, const struct dmaengine_result *result)
+{
+	struct qcom_geni_serial_port *port = cb;
+	struct uart_port *uport = &port->uport;
+	struct tty_port *tport = &uport->state->port;
+	size_t bytes = UART_XMIT_SIZE - result->residue;
+	u8 idx = port->gpi->rx_done_index;
+	int ret;
+
+	if (result->result != DMA_TRANS_NOERROR) {
+		dev_err(uport->dev, "rx dma xfer failed: %d\n", result->result);
+		qcom_geni_serial_stop_rx_dma(uport);
+		qcom_geni_serial_start_rx_dma(uport);
+		return;
+	}
+
+	if (bytes <= 0) {
+		port->gpi->rx_done_index = INC_WRAP_RX_INDEX(idx);
+		qcom_geni_serial_gpi_rx_queue_dma_tre(port, idx);
+		return;
+	}
+
+	dma_sync_single_for_cpu(port->se.dev->parent,
+				port->gpi->rx_dma_addr[idx],
+				UART_XMIT_SIZE, DMA_FROM_DEVICE);
+
+	ret = tty_insert_flip_string(tport, port->gpi->rx_buf[idx], bytes);
+	if (ret != bytes) {
+		dev_err(uport->dev, "%s: Unable to push data %d_bytes %zu\n",
+			__func__, ret, bytes);
+		WARN_ON_ONCE(1);
+	}
+
+	uport->icount.rx += ret;
+	tty_flip_buffer_push(tport);
+	dma_sync_single_for_device(port->se.dev->parent, port->gpi->rx_dma_addr[idx],
+				   UART_XMIT_SIZE, DMA_FROM_DEVICE);
+
+	port->gpi->rx_done_index = INC_WRAP_RX_INDEX(idx);
+	qcom_geni_serial_gpi_rx_queue_dma_tre(port, idx);
+}
+
+static void qcom_geni_serial_gpi_rx_xfer_work(struct work_struct *work)
+{
+	struct qcom_geni_serial_gpi *gpi = container_of(work, struct qcom_geni_serial_gpi,
+							rx_xfer_work);
+	struct qcom_geni_serial_port *port = gpi->port;
+	struct uart_port *uport = &port->uport;
+	struct dma_slave_config config = {};
+	int ret, i;
+
+	config.peripheral_config = &gpi->peripheral;
+	config.peripheral_size = sizeof(gpi->peripheral);
+
+	ret = dmaengine_slave_config(gpi->rx_chan, &config);
+	if (ret) {
+		dev_err(uport->dev, "rx dma config error: %d\n", ret);
+		return;
+	}
+
+	gpi->rx_done_index = 0;
+	for (i = 0; i < NUM_GPI_RX_BUFFERS; i++)
+		qcom_geni_serial_gpi_rx_queue_dma_tre(port, i);
+}
+
+static void
+qcom_geni_serial_gpi_tx_callback_result(void *cb, const struct dmaengine_result *result)
+{
+	struct qcom_geni_serial_port *port = cb;
+	struct uart_port *uport = &port->uport;
+	struct tty_port *tport = &uport->state->port;
+	unsigned long flags;
+
+	if (result->result != DMA_TRANS_NOERROR) {
+		dev_err(uport->dev, "tx dma xfer failed: %d\n", result->result);
+		qcom_geni_serial_stop_tx_dma(uport);
+		return;
+	}
+
+	uart_port_lock_irqsave(uport, &flags);
+	uart_xmit_advance(uport, port->gpi->xmit_size - result->residue);
+	complete(&port->gpi->tx_xfer_completion);
+
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(uport);
+	uart_port_unlock_irqrestore(uport, flags);
+}
+
+#define UART_BITS_PER_BYTE		10	/* 8N1 */
+#define UART_TX_SAFETY_COEFF		10
+#define UART_TX_MIN_TIMEOUT_USEC	20000
+
+static unsigned long qcom_geni_serial_gpi_tx_timeout(struct qcom_geni_serial_gpi *gpi)
+{
+	u64 wire_time_usec;
+	u64 timeout_usec;
+
+	if (!gpi->xmit_size || WARN_ON_ONCE(!gpi->baud))
+		return 0;
+
+	wire_time_usec = mul_u64_u32_div((u64)gpi->xmit_size * UART_BITS_PER_BYTE,
+					 USEC_PER_SEC, gpi->baud);
+	timeout_usec = wire_time_usec * UART_TX_SAFETY_COEFF + UART_TX_MIN_TIMEOUT_USEC;
+
+	return usecs_to_jiffies(min_t(u64, timeout_usec, UINT_MAX));
+}
+
+static void qcom_geni_serial_gpi_tx_xfer_work(struct work_struct *work)
+{
+	struct qcom_geni_serial_gpi *gpi = container_of(work, struct qcom_geni_serial_gpi,
+							tx_xfer_work);
+	struct qcom_geni_serial_port *port = gpi->port;
+	struct uart_port *uport = &port->uport;
+	struct tty_port *tport = &uport->state->port;
+	struct dma_slave_config config = {};
+	struct dma_async_tx_descriptor *desc;
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	unsigned long time_left;
+	unsigned long timeout;
+	dma_cookie_t tx_cookie;
+	u8 *tail = NULL;
+	int ret;
+
+	gpi->xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
+					      UART_XMIT_SIZE);
+	if (!gpi->xmit_size)
+		return;
+
+	config.peripheral_config = &gpi->peripheral;
+	config.peripheral_size = sizeof(gpi->peripheral);
+
+	ret = dmaengine_slave_config(gpi->tx_chan, &config);
+	if (ret) {
+		dev_err(uport->dev, "tx dma config error: %d\n", ret);
+		return;
+	}
+
+	port->tx_dma_addr = dma_map_single(port->se.dev->parent, tail,
+					   gpi->xmit_size, DMA_TO_DEVICE);
+	ret = dma_mapping_error(port->se.dev->parent, port->tx_dma_addr);
+	if (ret) {
+		dev_err(uport->dev, "DMA mapping failure: %d\n", ret);
+		port->tx_dma_addr = (dma_addr_t)NULL;
+		return;
+	}
+
+	dma_sync_single_for_cpu(port->se.dev->parent, port->tx_dma_addr,
+				gpi->xmit_size, DMA_TO_DEVICE);
+	desc = dmaengine_prep_slave_single(gpi->tx_chan, port->tx_dma_addr,
+					   gpi->xmit_size, DMA_MEM_TO_DEV, flags);
+	if (!desc) {
+		dev_err(uport->dev, "Error setting up tx desc\n");
+		goto err;
+	}
+
+	desc->callback_result = qcom_geni_serial_gpi_tx_callback_result;
+	desc->callback_param = port;
+	tx_cookie = dmaengine_submit(desc);
+	if (dma_submit_error(tx_cookie)) {
+		dev_err(uport->dev, "%s: dmaengine_submit failed: %d\n", __func__, tx_cookie);
+		dmaengine_terminate_sync(gpi->tx_chan);
+		goto err;
+	}
+	reinit_completion(&port->gpi->tx_xfer_completion);
+	dma_async_issue_pending(gpi->tx_chan);
+
+	gpi->peripheral.set_tx_config = false;
+
+	timeout = qcom_geni_serial_gpi_tx_timeout(gpi);
+
+	time_left = wait_for_completion_timeout(&port->gpi->tx_xfer_completion, timeout);
+	if (!time_left) {
+		dev_err(uport->dev, "Error: gpi tx timedout:%ld\n", timeout);
+		dmaengine_terminate_sync(gpi->tx_chan);
+		goto err;
+	}
+
+	/*
+	 * tx_cancel_work will terminate the channel and release the DMA
+	 * mapping. Return early to avoid racing with that cleanup.
+	 */
+	if (gpi->tx_cancel_pending) {
+		gpi->tx_cancel_pending = false;
+		return;
+	}
+
+err:
+	qcom_geni_serial_gpi_tx_unmap(port);
+}
+
+static void qcom_geni_serial_unprepare_gpi_rx_dma(struct qcom_geni_serial_port *port)
+{
+	struct qcom_geni_serial_gpi *gpi = port->gpi;
+	int i;
+
+	for (i = 0; i < NUM_GPI_RX_BUFFERS; i++) {
+		if (gpi->rx_dma_addr[i]) {
+			dma_unmap_single(port->se.dev->parent, gpi->rx_dma_addr[i],
+					 UART_XMIT_SIZE, DMA_FROM_DEVICE);
+			gpi->rx_dma_addr[i] = (dma_addr_t)NULL;
+		}
+	}
+}
+
+static int qcom_geni_serial_prepare_gpi_rx_dma(struct qcom_geni_serial_port *port)
+{
+	struct qcom_geni_serial_gpi *gpi = port->gpi;
+	struct uart_port *uport = &port->uport;
+	int i, ret;
+
+	for (i = 0; i < NUM_GPI_RX_BUFFERS; i++) {
+		gpi->rx_buf[i] = devm_kzalloc(uport->dev, UART_XMIT_SIZE, GFP_KERNEL);
+		if (!gpi->rx_buf[i])
+			return dev_err_probe(uport->dev, -ENOMEM, "RX buffer %d\n", i);
+
+		gpi->rx_dma_addr[i] = dma_map_single(port->se.dev->parent, gpi->rx_buf[i],
+						     UART_XMIT_SIZE, DMA_FROM_DEVICE);
+		ret = dma_mapping_error(port->se.dev->parent, gpi->rx_dma_addr[i]);
+		if (ret) {
+			dev_err(uport->dev, "Failed to map gpi rx buffer[%d]\n", i);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static void qcom_geni_serial_release_gpi_dma(struct qcom_geni_serial_port *port)
+{
+	if (port->gpi->rx_chan) {
+		dma_release_channel(port->gpi->rx_chan);
+		port->gpi->rx_chan = NULL;
+	}
+
+	if (port->gpi->tx_chan) {
+		dma_release_channel(port->gpi->tx_chan);
+		port->gpi->tx_chan = NULL;
+	}
+}
+
+static int qcom_geni_serial_setup_gpi_dma(struct qcom_geni_serial_port *port)
+{
+	struct qcom_geni_serial_gpi *gpi = port->gpi;
+	int ret = -EINVAL;
+
+	gpi->tx_chan = dma_request_chan(port->se.dev, "tx");
+	if (IS_ERR(gpi->tx_chan)) {
+		dev_err(port->se.dev, "Failed to get tx DMA ch\n");
+		return ret;
+	}
+
+	gpi->rx_chan = dma_request_chan(port->se.dev, "rx");
+	if (IS_ERR(gpi->rx_chan)) {
+		dev_err(port->se.dev, "Failed to get rx DMA ch\n");
+		dma_release_channel(gpi->tx_chan);
+		gpi->tx_chan = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_geni_serial_gpi_init(struct qcom_geni_serial_port *port)
+{
+	struct uart_port *uport = &port->uport;
+	int ret;
+
+	port->gpi = devm_kzalloc(uport->dev, sizeof(*port->gpi), GFP_KERNEL);
+	if (!port->gpi)
+		return -ENOMEM;
+
+	ret = qcom_geni_serial_prepare_gpi_rx_dma(port);
+	if (ret)
+		return ret;
+
+	port->gpi->port = port;
+	ret = qcom_geni_serial_setup_gpi_dma(port);
+	if (ret)
+		goto err_unprepare_gpi_rx_dma;
+	/*
+	 * Defer GPI DMA operations to workqueues as the DMAengine path may
+	 * sleep while waiting on mutexes or timeouts, whereas UART transfer
+	 * operations can be invoked with the port spinlock held.
+	 */
+	port->gpi->tx_wq = alloc_ordered_workqueue("%s_tx_wq", WQ_HIGHPRI,
+						   dev_name(uport->dev));
+	if (!port->gpi->tx_wq) {
+		ret = -ENOMEM;
+		goto err_release_gpi_dma;
+	}
+
+	port->gpi->rx_wq = alloc_ordered_workqueue("%s_rx_wq", WQ_HIGHPRI,
+						   dev_name(uport->dev));
+	if (!port->gpi->rx_wq) {
+		ret = -ENOMEM;
+		goto err_destroy_tx_wq;
+	}
+
+	INIT_WORK(&port->gpi->tx_xfer_work, qcom_geni_serial_gpi_tx_xfer_work);
+	INIT_WORK(&port->gpi->tx_cancel_work, qcom_geni_serial_gpi_cancel_tx_work);
+	INIT_WORK(&port->gpi->rx_xfer_work, qcom_geni_serial_gpi_rx_xfer_work);
+	INIT_WORK(&port->gpi->rx_cancel_work, qcom_geni_serial_gpi_cancel_rx_work);
+	init_completion(&port->gpi->tx_xfer_completion);
+
+	/* Prevent spurious interrupts during data transfers for gpi mode */
+	writel(0, uport->membase + SE_GENI_M_IRQ_EN);
+	writel(0, uport->membase + SE_GENI_S_IRQ_EN);
+	return 0;
+
+err_destroy_tx_wq:
+	destroy_workqueue(port->gpi->tx_wq);
+err_release_gpi_dma:
+	qcom_geni_serial_release_gpi_dma(port);
+err_unprepare_gpi_rx_dma:
+	qcom_geni_serial_unprepare_gpi_rx_dma(port);
+	return ret;
+}
+
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
@@ -1352,13 +1805,26 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 		return -ENXIO;
 	}
 
+	port->gpi_mode = readl(uport->membase + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+	if (port->gpi_mode) {
+		geni_se_select_mode(&port->se, GENI_GPI_DMA);
+		ret = qcom_geni_serial_gpi_init(port);
+		if (ret)
+			return ret;
+	}
+
 	qcom_geni_serial_stop_rx(uport);
 
 	ret = setup_fifos(port);
 	if (ret)
 		return ret;
 
-	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
+	if (port->gpi_mode) {
+		port->gpi->peripheral.rx_stale_timeout = rxstale;
+		port->gpi->peripheral.rfr_level = port->rx_fifo_depth - 2;
+	} else {
+		writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
+	}
 
 	pin_swap = readl(uport->membase + SE_UART_IO_MACRO_CTRL);
 	if (port->rx_tx_swap) {
@@ -1379,10 +1845,12 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	 */
 	if (uart_console(uport))
 		qcom_geni_serial_poll_tx_done(uport);
-	geni_se_config_packing(&port->se, BITS_PER_BYTE, BYTES_PER_FIFO_WORD,
-			       false, true, true);
-	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
-	geni_se_select_mode(&port->se, port->dev_data->mode);
+	if (!port->gpi_mode) {
+		geni_se_config_packing(&port->se, BITS_PER_BYTE, BYTES_PER_FIFO_WORD,
+				       false, true, true);
+		geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
+		geni_se_select_mode(&port->se, port->dev_data->mode);
+	}
 	port->setup = true;
 
 	return 0;
@@ -1415,11 +1883,23 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	if (uart_console(uport))
 		tport->closing_wait = ASYNC_CLOSING_WAIT_NONE;
 
-	uart_port_lock_irq(uport);
-	qcom_geni_serial_start_rx(uport);
-	uart_port_unlock_irq(uport);
+	/*
+	 * FIFO and SE-DMA modes apply UART configuration directly to
+	 * hardware registers, so configuration updates take effect
+	 * without restarting RX.
+	 *
+	 * GPI mode programs UART configuration through a CFG TRE
+	 * submitted with an RX transfer. Defer RX startup until the
+	 * initial configuration can be queued.
+	 */
+	if (!port->gpi_mode) {
+		uart_port_lock_irq(uport);
+		qcom_geni_serial_start_rx(uport);
+		uart_port_unlock_irq(uport);
+
+		enable_irq(uport->irq);
+	}
 
-	enable_irq(uport->irq);
 	WRITE_ONCE(port->tx_kick_enabled, true);
 
 	return 0;
@@ -1461,6 +1941,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
+	if (port->gpi_mode) {
+		port->gpi->peripheral.clk_div = clk_div;
+		port->gpi->peripheral.clk_src = clk_idx;
+	}
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1474,6 +1958,9 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 
+	if (port->gpi_mode)
+		return 0;
+
 	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
 	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
 	/* Configure clock selection register with the selected clock index */
@@ -1494,8 +1981,22 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 rx_trans_cfg;
 	u32 rx_parity_cfg;
 	u32 stop_bit_len;
+	u8 gpi_parity;
 	int ret = 0;
 
+	/*
+	 * Drain pending GPI transfers before updating the UART
+	 * configuration. Unlike FIFO and SE-DMA modes, configuration
+	 * changes are not applied directly to hardware registers in
+	 * GPI mode. Stop the active RX transfer so the next RX request
+	 * can submit an updated CFG TRE.
+	 */
+	if (port->gpi_mode) {
+		flush_workqueue(port->gpi->tx_wq);
+		qcom_geni_serial_stop_rx(uport);
+		flush_workqueue(port->gpi->rx_wq);
+	}
+
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
@@ -1516,18 +2017,22 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		if (termios->c_cflag & PARODD) {
 			tx_parity_cfg |= PAR_ODD;
 			rx_parity_cfg |= PAR_ODD;
+			gpi_parity = GPI_PAR_ODD;
 		} else if (termios->c_cflag & CMSPAR) {
 			tx_parity_cfg |= PAR_SPACE;
 			rx_parity_cfg |= PAR_SPACE;
+			gpi_parity = GPI_PAR_SPACE;
 		} else {
 			tx_parity_cfg |= PAR_EVEN;
 			rx_parity_cfg |= PAR_EVEN;
+			gpi_parity = GPI_PAR_EVEN;
 		}
 	} else {
 		tx_trans_cfg &= ~UART_TX_PAR_EN;
 		rx_trans_cfg &= ~UART_RX_PAR_EN;
 		tx_parity_cfg &= ~PAR_CALC_EN;
 		rx_parity_cfg &= ~PAR_CALC_EN;
+		gpi_parity = GPI_PAR_NONE;
 	}
 
 	/* bits per char */
@@ -1570,16 +2075,41 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		WRITE_ONCE(port->poll_timeout_us, timeout);
 	}
 
-	if (!uart_console(uport))
-		writel(port->loopback,
-				uport->membase + SE_UART_LOOPBACK_CFG);
-	writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
-	writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
-	writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
-	writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
-	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
-	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
-	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	if (port->gpi_mode) {
+		struct gpi_serial_config *peripheral = &port->gpi->peripheral;
+
+		port->gpi->baud = baud;
+		peripheral->char_size = bits_per_char - GPI_CHAR_SIZE_OFFSET;
+		peripheral->loopback_en = !!port->loopback;
+		peripheral->packing = true;
+		peripheral->stop_bit_len = stop_bit_len;
+		peripheral->opcode = GPI_START_TRANSFER;
+		peripheral->parity = gpi_parity;
+		peripheral->hw_flow_ctrl_en = !(tx_trans_cfg & UART_CTS_MASK);
+		peripheral->set_rx_config = true;
+		peripheral->set_tx_config = true;
+	} else {
+		if (!uart_console(uport))
+			writel(port->loopback, uport->membase + SE_UART_LOOPBACK_CFG);
+		writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
+		writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
+		writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
+		writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
+		writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
+		writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
+		writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	}
+
+	/*
+	 * Re-arm RX to submit the updated CFG TRE. FIFO and SE-DMA
+	 * modes apply configuration changes immediately through
+	 * register updates, whereas GPI mode requires a new RX
+	 * transfer for the updated settings to reach hardware.
+	 */
+	if (port->gpi_mode) {
+		qcom_geni_serial_start_rx(uport);
+		flush_workqueue(port->gpi->rx_wq);
+	}
 
 	trace_geni_serial_set_termios(uport->dev, baud, bits_per_char,
 				      tx_trans_cfg, tx_parity_cfg, rx_trans_cfg,
@@ -2035,6 +2565,14 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 
 	WRITE_ONCE(port->tx_kick_enabled, false);
 	irq_work_sync(&port->tx_kick);
+
+	if (port->gpi_mode && port->setup) {
+		destroy_workqueue(port->gpi->tx_wq);
+		destroy_workqueue(port->gpi->rx_wq);
+		qcom_geni_serial_release_gpi_dma(port);
+		qcom_geni_serial_unprepare_gpi_rx_dma(port);
+	}
+
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	if (!port->dev_data->console)

-- 
2.34.1

