Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F13D9526
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529138; cv=none; b=gxJbG8ZHvlcLh8MgRiABT1v7uJ/N2L0cPcMP2y0/dq0DHUCSUk+mDwqLQk+oClv051MJLoUqdkYhGnpXWZppZQkO9KWSnwkau3LzPT3T3CcX93c63OSy0FtQtA564piWOQxEYqq3uQlQ2hJLaKQnerGczEFgGkkbAkKkzUS9eeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529138; c=relaxed/simple;
	bh=etezjtKq84RmKKFwlxvqbxkYNKXZRTfCGt9+9ybA+P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7PfXqFkfcS33z0ts15LdGfa6BRd6WveQUQwPjieOerfz3MYYYQ0HZ/OnpY/HTD2dHXKbrkt2eD4KLFF2R0zDrGjjID+BqrOoXHpM0c5nqyGYhq1Elt7kAaegdGpeRGYllbOH+vUZF7FdFwqaSB/UdXijGxmm67QNQgdKI18Ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBX3o8IQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClwZRfk+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBX3o8IQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClwZRfk+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HK9I966470
	for <linux-serial@vger.kernel.org>; Fri, 9 Oct 2026 06:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7KByrBfALr8GgfkLAO2yXCXT1aba1OS74wxtQzGISJs=; b=kBX3o8IQ8pZ+xswY
	AtjXBSemSpsNG9amdZkIbhvhsi1kOGVLwy4ZK5wMmZy48o646HpbCI/vJlMDfZ3M
	8NDfrCSz+aIZjjDOumgXgcT2d1fz0zwMAOoS6Y1cFq33lxYDfNqK/VDPXx8cyx84
	X1W8kpzPYPyHXyND6vKsMAjkXWakbr2tw0FU5MaTwzsvMs1gvWWCrMUHN/kP2Qsf
	MasXO+xQYzGKZ3EasKaVxykE0vxTlOyhAsyLDbNy1Y2rsmd/2+LLndnhEfT5+Saz
	afXeOVH+OC8XUk2m+HZ0692CzNVP5D45Ckw/nMzs82X7M7aRB+uawvk/ONj+NvQI
	b01JjA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj2apn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 06:58:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88a1de72cf7so1412128b3a.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791529135; x=1792133935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KByrBfALr8GgfkLAO2yXCXT1aba1OS74wxtQzGISJs=;
        b=ClwZRfk+pAgyo7C/VFVCxBYSTz2xmdbWIVy1Mh4EbW8pP/UUFmDQp/cJnlqHsCNdgE
         PR9CPK+SSCtKPUXPjL1T2zsqMEh9udlKmA8D681kPi/8mJ2SdedXhpLExClXn5bGu6Tk
         YcFLpsjWpF6oDuS6NumipugLnwZFViwv6vM/cQnxDz4yzb85Vs+DCQadxkhWXnG+Ukpy
         BYSxLGiidwcNC6FsHnj+h1eZZtBQK7cWMQ1FG3EMulYg9Xzkpmfiq84wAEli91vvPIDf
         JDNY/wXPvYKx86hzwn684gVMNE5xuG6ITHIfoPbUnqPjv0cIodNaSPNuKuySgbFhhbuS
         w+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529135; x=1792133935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KByrBfALr8GgfkLAO2yXCXT1aba1OS74wxtQzGISJs=;
        b=kmsN9e058ivcN2Uyj+cUwMdHx1XG/CBm5Wr2ZWLBp3KsujQr8PM4UsY5GUH8W2UDf3
         vgJQd7pkCNrzHOtXo1EvZ7FKCx0h/s3bcVlWENTdCJrij75ESkY9YbUivSVWNT+Pho7W
         OnFmGFUCJf7OeiACVTyvo93V7u6zD4RKxHXx+56hiNX9zM9tmPpUOOVNTkWK3k9r/hFh
         1wrVP+EXOaZhnVVbPj4yhR4tFZ7nSnw9Sk+bjPnWmJWUgfswc8rryNacjvVdxDOUyxKY
         Pk6BkRoe4yYiVFicsu6BNHXX8nFDu5bnhKTdiRjp4PH982ZaggbwSpYdl2nMnxxW1oLW
         TZiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcS7uQcGvBWfE3e/1we6Y4puAemJWxmuBG6VSYTutWKDAOU43YXr55m9YLX/MoptMcsox8Fwim7zLKB+8=@vger.kernel.org
X-Gm-Message-State: AFuF++kLcwOFFOFpfPKkz45T2F7/N6ap2OCQDzHqlGIvvV85ibEutA9Q
	bGfptNwhuYztqySOH0dvGZi+qDESuE6EJExEAHFWss+ZCxyvrRaZFE9E6CvnfDszjVYgSggMKJ/
	PlxpA4vASWxGb68VEVDxAX2FDvdAFmLZMqbn0Ax9rh5vCeyk6YzJ7zhiEN+pz1doqShY=
X-Gm-Gg: AYBFou2Zps20HXJ+u5x/dpDNnrIvmUu07Y4MHgV/UYJyc0VEBFC2crpeSDJ4d2Gaau1
	HpBBQRH5RdJS0d0sDpXHTxIccNPX+0itefNQd6jtrQzIrN/CKnqWZGDBIv3z7O/Uh99P3XIh6Rm
	47vXVE2iarVpFmldqe5zAsrYbf19aqw3IXWGVQj3lp4XtAjfue5wkPzaRku/5h36Sds5IA5e57E
	3w6P7rXtA1SOs3EuBE3OeQage2ff16H3TAX+O1YLuo+3h3KFO/AkAMxdTZvKITiKN2ng5POcJCd
	y3viE3PyNRqvXAwmoYl2l+uZ0VSNygAClWXUntZvPbw2m942watck9yHnPmVZibxi0HnNXhBRjS
	whgvFN2pDSw4mtal/CsP8
X-Received: by 2002:a05:6300:49c:b0:3e1:1d22:aafd with SMTP id adf61e73a8af0-3e164fcfdadmr966484637.32.1791529135221;
        Thu, 08 Oct 2026 23:58:55 -0700 (PDT)
X-Received: by 2002:a05:6300:49c:b0:3e1:1d22:aafd with SMTP id adf61e73a8af0-3e164fcfdadmr966472637.32.1791529134727;
        Thu, 08 Oct 2026 23:58:54 -0700 (PDT)
Received: from [10.213.103.163] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e088efsm499980a12.11.2026.10.08.23.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:58:54 -0700 (PDT)
From: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 12:27:53 +0530
Subject: [PATCH 1/4] dmaengine: qcom: gpi: Add UART transfer support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-add-gpi-dma-support-for-uart-v1-1-c69e728df686@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791529122; l=6625;
 i=naresh.maramaina@oss.qualcomm.com; s=20260316; h=from:subject:message-id;
 bh=etezjtKq84RmKKFwlxvqbxkYNKXZRTfCGt9+9ybA+P0=;
 b=3csQ9vavv4D5uWJ1KcGZ22SjdsAEgSR63ad+u+Ca8yohioxZTT42A3yHIpN2oPhKAH0v7243+
 3Oay5hKaKHwDU+Y7V+TpigqylUzEcFVQQeTTQUQDsjozLJ4S9NDWf96
X-Developer-Key: i=naresh.maramaina@oss.qualcomm.com; a=ed25519;
 pk=j7iST9yrLbsgWcWrqdlUNIOWl2WBl4wV1q35/n9SCkg=
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac890b0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=q9FSIy8fX9HaZm_J2qEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: OomHZGTsaQ_4MGJiGxTyAvtWmAH1LK1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX0HIKQokK85ef
 THTg5Nie7kGs9kKb+uNakktVDaSxOaEPCJ+Nfn374wOYkTzsJEtA+AenZrXZ/C/dqlomS0HjPWX
 xLmuKqE1teWlEGj0OP2bHqrfvv7bd+BXSeQys/xDgro0V0/9irZIRE++Y/CWjaIHj6X2v9OG8oV
 XBtLoMjcVFqOoErm72SoUYHTOEuBi8HNAIGTXxkJNm+okAEMczYnFTQlOGi4/TM9wpTaLGEJlC2
 Y+dR18o6ZjF7VvWDNoUVFQzc5/znPpuhrSiAHkRE0u/5dMoWDCfSHJqlMtIL1zDLBY3AYRSTFc3
 I0r3qAwrSSyboJzgr5pSaZ1ZkS+QroPrQxX16AWP1dhVXDyMrCHFHPhdcNFcrFU8/gCU6R5uuuL
 Aslcon0a4IvsBJTWcTeL66mXwxmbJ8d3fBV3Ke4YBDwBZI0k00nbnXG4mjC/O00MrOYZThdXpuO
 ck/ujjT3XzWCxPzEMVw==
X-Proofpoint-GUID: OomHZGTsaQ_4MGJiGxTyAvtWmAH1LK1S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX/v7LzIkN42tc
 npxs9kZ2hC9501ITgjZbPm5yfKHEDmTp3/ujnMc8V1ZnU+KPezGziLC2ugKpBGzj6fH4JzRroGT
 uuz9D54HHoXXu2MjMiv8dHQftn25shI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090027

The GPI DMA driver currently supports TRE construction for SPI and I2C
clients, but not for UART clients. Add the UART CONFIG0 and GO TRE
definitions and expose a UART peripheral configuration structure so
UART clients can describe their transfer parameters.

Build the TRE sequence needed for UART transfers. Emit a CONFIG0 TRE
when a configuration update is requested, followed by a GO TRE and
a DMA TRE for the transfer buffer.

Add the UART case to the TRE construction path in gpi_prep_slave_sg().

Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c           | 101 +++++++++++++++++++++++++++++++++++++--
 include/linux/dma/qcom-gpi-dma.h |  33 +++++++++++++
 2 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..fb26a286e5df 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -30,6 +30,21 @@
 #define TRE_FLAGS_LINK		BIT(11)
 #define TRE_FLAGS_TYPE		GENMASK(23, 16)
 
+/* UART CONFIG0 WD0 */
+#define TRE_UART_C0_CHAR_SZ		GENMASK(2, 0)
+#define TRE_UART_C0_STOP_BIT_LEN	GENMASK(4, 3)
+#define TRE_UART_C0_PARITY		GENMASK(7, 5)
+#define TRE_UART_C0_LOOPBACK		BIT(8)
+#define TRE_UART_C0_HW_FLOW_CTRL_EN	BIT(10)
+#define TRE_UART_C0_PACKING		BIT(24)
+
+/* UART CONFIG0 WD1 */
+#define TRE_UART_C0_RX_STALE_TIMEOUT	GENMASK(23, 0)
+#define TRE_UART_C0_RX_RFR_LEVEL	GENMASK(29, 24)
+
+/* UART GO WD0 */
+#define TRE_UART_GO_CMD		GENMASK(4, 0)
+
 /* SPI CONFIG0 WD0 */
 #define TRE_SPI_C0_WORD_SZ	GENMASK(4, 0)
 #define TRE_SPI_C0_LOOPBACK	BIT(8)
@@ -1793,6 +1808,80 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 	return tre_idx;
 }
 
+static int
+gpi_create_serial_tre(struct gchan *chan, struct gpi_desc *desc,
+		      struct scatterlist *sgl, enum dma_transfer_direction direction)
+{
+	struct gpi_serial_config *serial = chan->config;
+	struct device *dev = chan->gpii->gpi_dev->dev;
+	struct gpi_tre *tre;
+	dma_addr_t address;
+	unsigned int tre_idx = 0;
+	unsigned int i;
+	bool set_config = (direction == DMA_DEV_TO_MEM) ?
+			   serial->set_rx_config :
+			   serial->set_tx_config;
+
+	/* create config tre if applicable */
+	if (set_config) {
+		tre = &desc->tre[tre_idx];
+		tre_idx++;
+		tre->dword[0] = u32_encode_bits(serial->char_size, TRE_UART_C0_CHAR_SZ);
+		tre->dword[0] |= u32_encode_bits(serial->stop_bit_len, TRE_UART_C0_STOP_BIT_LEN);
+		tre->dword[0] |= u32_encode_bits(serial->parity, TRE_UART_C0_PARITY);
+		tre->dword[0] |= u32_encode_bits(serial->loopback_en, TRE_UART_C0_LOOPBACK);
+		tre->dword[0] |= u32_encode_bits(serial->hw_flow_ctrl_en,
+						 TRE_UART_C0_HW_FLOW_CTRL_EN);
+		tre->dword[0] |= u32_encode_bits(serial->packing, TRE_UART_C0_PACKING);
+		if (direction == DMA_MEM_TO_DEV) {
+			/* No configuration for dword1 of TX channel */
+			tre->dword[1] = 0;
+		} else if (direction == DMA_DEV_TO_MEM) {
+			tre->dword[1] = u32_encode_bits(serial->rx_stale_timeout,
+							TRE_UART_C0_RX_STALE_TIMEOUT);
+			tre->dword[1] |= u32_encode_bits(serial->rfr_level,
+							 TRE_UART_C0_RX_RFR_LEVEL);
+			serial->set_rx_config = false;
+		}
+
+		tre->dword[2] = u32_encode_bits(serial->clk_div, TRE_C0_CLK_DIV);
+		tre->dword[2] |= u32_encode_bits(serial->clk_src, TRE_C0_CLK_SRC);
+
+		tre->dword[3] = u32_encode_bits(TRE_TYPE_CONFIG0, TRE_FLAGS_TYPE);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+	}
+
+	/* create the GO tre */
+	tre = &desc->tre[tre_idx];
+	tre_idx++;
+
+	tre->dword[0] = u32_encode_bits(serial->opcode, TRE_UART_GO_CMD);
+	tre->dword[1] = 0;
+	tre->dword[2] = 0;
+	tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
+	tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+
+	/* create the dma tre */
+	tre = &desc->tre[tre_idx];
+	tre_idx++;
+
+	address = sg_dma_address(sgl);
+	tre->dword[0] = lower_32_bits(address);
+	tre->dword[1] = upper_32_bits(address);
+	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
+	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
+	if (direction == DMA_MEM_TO_DEV)
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+	else if (direction == DMA_DEV_TO_MEM)
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+
+	for (i = 0; i < tre_idx; i++)
+		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
+			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
+
+	return tre_idx;
+}
+
 /* copy tre into transfer ring */
 static struct dma_async_tx_descriptor *
 gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
@@ -1841,11 +1930,17 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 
 	/* create TREs for xfer */
-	if (gchan->protocol == QCOM_GPI_SPI) {
+	switch (gchan->protocol) {
+	case QCOM_GPI_SPI:
 		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
-	} else if (gchan->protocol == QCOM_GPI_I2C) {
+		break;
+	case QCOM_GPI_I2C:
 		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
-	} else {
+		break;
+	case QCOM_GPI_UART:
+		i = gpi_create_serial_tre(gchan, gpi_desc, sgl, direction);
+		break;
+	default:
 		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
 		kfree(gpi_desc);
 		return NULL;
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 332be28427e4..ba42e8383391 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -83,4 +83,37 @@ struct gpi_i2c_config {
 	bool multi_msg;
 };
 
+/**
+ * struct gpi_serial_config - serial config for peripheral
+ *
+ * @rx_stale_timeout: serial rx stale timeout
+ * @clk_div: source clock divider
+ * @clk_src: serial clock
+ * @stop_bit_len: stop bit length
+ * @char_size: UART character size
+ * @rfr_level: auto rfr level for FIFO threshold
+ * @parity: set parity type
+ * @opcode: go TRE opcode for tx and rx
+ * @hw_flow_ctrl_en: hardware flow control enable when set
+ * @set_tx_config: set tx channel peripheral config
+ * @set_rx_config: set rx channel peripheral config
+ * @packing: set packing config
+ * @loopback_en: serial loopback enable when set
+ */
+struct gpi_serial_config {
+	u32 rx_stale_timeout;
+	u32 clk_div;
+	u32 clk_src;
+	u8 stop_bit_len;
+	u8 char_size;
+	u8 rfr_level;
+	u8 parity;
+	u8 opcode;
+	bool hw_flow_ctrl_en;
+	bool set_tx_config;
+	bool set_rx_config;
+	bool packing;
+	bool loopback_en;
+};
+
 #endif /* QCOM_GPI_DMA_H */

-- 
2.34.1

