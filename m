Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA526ED45
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042736; cv=none; b=BoiVcPYdSmZKtf37gUeELxGz3OrWeBXDBbSJ4nvvOpMZzWb5G2jkMF8jh499EBm2WVdK6VW3RiwFoGU57P0lDTCLmKA8e/s1sdLheemnRdrhhB3xPi3hL6BJvwvJTZNypsuVygyp8GTYusq4pnmefDo5VnpIJPTKayMshpp9QKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042736; c=relaxed/simple;
	bh=f21bnwPYLwQFGOrlp1u7eE89ouKQzkhp6GUbiDoJ+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fiGxaQCRsrxaTaDhTlQLFelLfVRno6OBlWeL2SCRltmWOiyTt0Ad9MBnxQDowSVZ0QHapDZiMeZSNdaGjQL1WxgJDBi36D2G4pdUFjsdvL85it2Ib4/ncf95F7FJN1s8bur13kABuV0h6QbyJGs2JLqxc4GvYV/4lL4cS7jNqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxUHxerN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYTbZ639; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxUHxerN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYTbZ639"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6460iYnc3740705
	for <linux-serial@vger.kernel.org>; Wed, 6 May 2026 04:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W37kRhirnPcGF9X8nJPDZN
	I5oBwfiWycDGcpi70IxgU=; b=BxUHxerNN9S8uv1rDNrT+6ppr2inC5R7avBbFM
	4WkIVW+yupNW2NJ/iPht7Afu7KwNqwZMUkn7N1ARVrtC37oY1Y5oUiyt1oL26H9W
	XZeNYabTbhhEwA93bsXBowi5PWY/rhl3LsQKec5N1m83S+urj9FLsFvxnInh15mb
	aSS8AHNOT63gJhe25PlbCMhBq0N7rRzFCyob+nCN+vyHWKwsClUjW/Jg9YXBrdaH
	ppqVD9G16cWVTrl1iXCEgwpaH+L3LsymWK8rHGL2Oir2w9Ncqkw7CKsGTI5V/5uO
	33H97hccFYVSYMovMZCAeaCflHvzM+NZGZfM9hdvWtIYayWA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyefqbw9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 04:45:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adc527eaf5so41681395ad.0
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778042733; x=1778647533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W37kRhirnPcGF9X8nJPDZNI5oBwfiWycDGcpi70IxgU=;
        b=RYTbZ6397tkOcukftE3it6gDRFOdXqAY/ZdEwjysVGitYCBh3A6S47VuAc65GqdKvs
         RYC2s8upe9WB853mSWhq8Z665fTgQVQpwNoxYplNvPUTsFNR8zJyguuks9QJXezPCoq5
         DHyMSxLNMJwwe/gfDiA5vNezeJusyliiBdWkqquh7QZsmUc1laf+2aqujsTsxGUqajpY
         8eVhDs8QPQs3e3mHkPAgvjfyrBa94r3qqHa2ZEuC0uA57hRZaApLSkAo9u5CT14l08NG
         7ku+NgYHs/GSTmv3uvTn4ukrTaLRN4vhb0rf5ny7p4QlFqO/dkdRY3rtpUv+bkaJR1c6
         2rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778042733; x=1778647533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W37kRhirnPcGF9X8nJPDZNI5oBwfiWycDGcpi70IxgU=;
        b=XXnL2s0/zHf1xrJ7cU5mBysGB8y+YyfJRfgS63UfwAiQJNLAEwgmS4Ak+CGwby+8fj
         bbbDsPn8pGFmT23IbcDQ0kHrokr5XeGsVt7v5JMq4xLMUxLzfHJksP4CEcXHrRXAOfdb
         13MbhMmEGBqxZGtvm8E6SHTCcUvQOZbZd331yOy/O5JNiqr9QGvtm0og/FQOA57zw2C1
         CWNSZLPGozcX+k5akiqsRXKwFXrJcQkXcBP0vqUqC5wHaRCO82JQK7pU+7RtSK3TPThJ
         7acVplonvavh7M3AbjTEcI9Zk+Q9Sh3tDRhrQ7z1JQ7BI7z8IHq3kXbPZx/4GwSoxWkh
         xGeA==
X-Forwarded-Encrypted: i=1; AFNElJ+pfTCjx5AkYj3M3hPoK+Ie2j4xvmLSJeBsFCSpcqYrwZaUaeyoRXXqqxdLlKf1vwzE0CLBLw4jFlbivq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3k98UPFjGu34e8gDhFkr+Yf09aPZIDye6JxSg+TW0SXhVWYr
	D4Ec/hlslvuACOc31hj9TzP7wgFSmPUXmmBJKSGrbZ/b34O6wxL4VdQI2TLB+R7dz3QaRBiYGi0
	CizNh4dzqbnBtO1ocVqyXFlsIu/cCQKBzq7R9p/Uz4GhIBRq+sOpdWg0GvLqniyRscXg=
X-Gm-Gg: AeBDiesfHeeA+SSARutplqaOwElq7J1zKDtUbCL9RW1SHTg+IAZ3hxUrGmzXHZ40LDg
	kFiWzsI1T7e5eia7nfKBA7aaO82kW2eJzTbsphqq62Z49IMz8ssg6gL1B02fthHs7IlnoLKYqS6
	8zD9xfv995Is3NDEyK3sT4VpcXhC/xmtwSXXVdWGT0DluLX1BRmSFAVI6eskRLkpM88eEqdNN+9
	fX4qUTlQl7QwJtMHRqxiO2b5U5F8c5TJc62c1r1VxfGk8u2hAFEIKDPLdIbVIDQbVzXXEhaX0dU
	UTsaJHQJojoa6I5wekbicT2DUBQVJbU0YJ4dW9xH2787BiwmTiiMPLmCrkS+MGPtVP0xTvMzQMD
	gFTVQHY+2wV2XO5AGbIgXoO6TAiEuViGqpfKO8Wz9jr3022qDjkmk7b5dFlBQR6FxCa6S
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr17868165ad.13.1778042733016;
        Tue, 05 May 2026 21:45:33 -0700 (PDT)
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr17867835ad.13.1778042732503;
        Tue, 05 May 2026 21:45:32 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2e8cfsm10248395ad.30.2026.05.05.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:45:31 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 06 May 2026 10:15:21 +0530
Subject: [PATCH v1] serial: qcom_geni: fix kfifo underflow when flush
 precedes DMA completion IRQ
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-serial-dma-stale-tx-buf-v1-1-e3ccb360d719@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGHH+mkC/yWMQQqDMBBFryKz7kBiMItepXQxMROdYm3JRBHEu
 xvb5fv893ZQzsIK92aHzKuofOYK9tZAP9I8MEqsDK1pvemMx+tPE8Y3oRaaGMuGYUmYOheDc56
 sI6j2N3OS7Vd+wGrh+d90CS/uy5WE4zgBUe33SX8AAAA=
X-Change-ID: 20260506-serial-dma-stale-tx-buf-f53db336a13a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778042729; l=2812;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=f21bnwPYLwQFGOrlp1u7eE89ouKQzkhp6GUbiDoJ+Vc=;
 b=6wLqgffK/F9OSZbfDbSFnjWU0glIUlKW4LkdwNo9Ygs151R8/jkqkLPaxKZN1a+wH0N3oXkQ3
 k+Tdo/WF8uiBZ7qdLrDH6GHS5VWhmdo+xFpNPLls9/QwB1rRKmuOTjD
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA0MiBTYWx0ZWRfX8CzqNwfk656b
 jZChafunSEZPubK2j5gKsXx4cN5iuo9lt41cOIi2d3BrLqwyVFh+ANJLQV5KgWS0Ru7rXQyk/iY
 ZFSR6FEi8Qbbw/B+yGVe4hImmh++wPOjgUgOb9UQQjOt5AwQLA7rZs5IFjMJU6l/ue4vkwHMWaM
 JVWMCEr/jnFBIx/M9uWjDN9Zr0j13vQaUpGsVSCzsyYLvkK3OcfwVw5SRQ5xBTFn9i6fIfgXxkM
 xEfpb+yyPgF3Rbq8aLUykoanasDpzMoA2VcvutJqzcahHfysYGEkVU/3W6i8L0hcKWlgsVRovNQ
 LIDkUysdUOKpjF759KfPTLGCcayl0OAGO3nQz2JtQ3Fg0O68l4rKrxxV+gFKO/W8vgvHmqXwgzv
 qKBfQgNHh1TX6fkMywymM5M8WB+eOG2dffxLtk5DBYuUi1k/h18N+3y+qZWaGG9Zc1qa7Ua6hFN
 0VUVAscCHp0FUx7xpWQ==
X-Proofpoint-ORIG-GUID: 0h7aKKiIFIL7ZKVFnPHGbq-4X5mXR8Y4
X-Proofpoint-GUID: 0h7aKKiIFIL7ZKVFnPHGbq-4X5mXR8Y4
X-Authority-Analysis: v=2.4 cv=edoNubEH c=1 sm=1 tr=0 ts=69fac76e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OPMqKeeqv5z9Eww7yPYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060042

When uart_flush_buffer() runs before the DMA completion IRQ is delivered,
the following race can occur (all steps serialized by uart_port_lock):

  1. DMA starts: tx_remaining = N, kfifo contains N bytes
  2. DMA completes in hardware; IRQ is pending but not yet delivered
  3. uart_flush_buffer() acquires the port lock and calls kfifo_reset(),
     making kfifo_len() = 0 while tx_remaining remains N
  4. uart_flush_buffer() releases the port lock
  5. DMA IRQ fires; handle_tx_dma() acquires the port lock and calls
     uart_xmit_advance(uport, tx_remaining) on an empty kfifo

uart_xmit_advance() increments kfifo->out by tx_remaining. Since
kfifo_reset() already set both in and out to 0, out wraps past in,
causing kfifo_len() to return UART_XMIT_SIZE - tx_remaining. The next
start_tx_dma() call then submits a DMA transfer of stale buffer data.

Fix this by snapshotting kfifo_len() at the start of handle_tx_dma()
and skipping uart_xmit_advance() when fifo_len < tx_remaining, which
indicates the kfifo was reset by a preceding flush.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b365dd5da3cb..3c1be7b21290 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1031,8 +1031,20 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct tty_port *tport = &uport->state->port;
+	unsigned int fifo_len = kfifo_len(&tport->xmit_fifo);
+
+	/*
+	 * Only advance the kfifo if it still contains the bytes that were
+	 * transferred. uart_flush_buffer() may have run before this IRQ
+	 * fired: it calls kfifo_reset() under the port lock, making
+	 * fifo_len = 0 while tx_remaining remains non-zero. Calling
+	 * uart_xmit_advance() in that case would underflow kfifo->out past
+	 * kfifo->in, making kfifo_len() wrap to UART_XMIT_SIZE - tx_remaining
+	 * and triggering a spurious large DMA transfer of stale data.
+	 */
+	if (fifo_len >= port->tx_remaining)
+		uart_xmit_advance(uport, port->tx_remaining);
 
-	uart_xmit_advance(uport, port->tx_remaining);
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;

---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260506-serial-dma-stale-tx-buf-f53db336a13a

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

