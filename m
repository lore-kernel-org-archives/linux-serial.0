Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599E310620
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516854; cv=none; b=sGa0WyaB3Mc9zlCb7DueNhiWIXDj3Z5uPd0AYJ8GFWVWk6BDJL9TDOLTT4fHGnulTPTT8wnU+YQId4Y7lrow2Oh8gORCvEbzHBXMLbx/ghCEl3l6uGdzf8t4Gkfmsyr7CSjIQfaF7OltEePYWTlLjmmf1OcpfRYDBM+z7yilKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516854; c=relaxed/simple;
	bh=OdXr9buh7p6jJ6fdErV3EJUeKFck1B1EUKSJKzNY6qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaiBHARsAAGJd1f0nVZ43iJUleO91ghIfeNp0CgZWTDrl/ReHWuKo4M7Q7LlDiDAZq9skRsF7URueK6kq2Y/vcaC0FL7pw5ZViESVdifs5Heet+uKHelX2j/5iWCUaiLBCTwQqo0Rmvlg5cCAi8rV618Lr3lGgjw6dsG497sTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyA7bZpC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyA7bZpC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so9328595ad.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783516852; x=1784121652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHfzCeJu6ryJc9c2Al2Kh80lix65mmf/MitGQxQ/Q3g=;
        b=LyA7bZpCwgW2IE2PV3r9Dd8/4xSPeu1bYN6661zfDHqj7DtNdRD4CfjGXkIWYZDkiP
         UCzjzk5udkHvqeOpQ8FqDVrFgt7+8pxyTwofhhODi8gqnT6k4nde/HeukF36AD5yBU/v
         5J9lNxcA6t3MgPiy3lUzZMAsUwftMGWAb0R9kr3vXVTG6QqUCH8AeIm+PkgcSEIV1e7W
         UsNxsTyUKcH73rphE0l21EdYG6CCpPznDSpo8v/aiahJQgUermURuNjwnoIvd3hyiU8v
         EwSaugvV3pSCxc3Zj6wNUTGKNyruU/GuiLy9r+57VMq58nBRWQmQA1s0M2fSNtxenRLN
         KE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516852; x=1784121652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHfzCeJu6ryJc9c2Al2Kh80lix65mmf/MitGQxQ/Q3g=;
        b=oCsWWgphY/K9o/qBiOeGJL4q69Wsg1GWTAMPcrtW/DUhAuxPpDJW1pjdkQ9RqKw9nH
         teR7wvJTdx6iZf3HqwJHnQ0LEdNijM4TWt6GBUcl9heNhwYHd1vzuWFHPG1bh6P2iLGO
         wgX5tdJi0UNGeKq84FFhr/UIfqK84NQAv+j40LBjPVW1MAv1/WMcxVXGYY6lg/Ix+CN7
         3njvgc/7/jMlfPlkGr13S66znVbGkxA18Mm2FN4n5AmxElwc2K0jGOJPVjXM9r1NvAqL
         HIkfgViQOFTVvRy+/mzbAmsvCLsgYE+W8+WC002TcMLrat4fP4j6mMWNksRk7i7F78SY
         L/lQ==
X-Forwarded-Encrypted: i=1; AHgh+RpT2Fzm0LtOaThpVaoQZETtmhEW1/ew4p3qOfUrmzMM359/JZVDB51Mp5LaqLa3y5uJ5NJgSdLbxhvDuA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIHnCntBX8dKPZCZO5auWqeKVIkZk+hST08+AHZayqE4CX/tk
	/Jg14BKWRg/YudTvqyX1Rmviu5ZuEDVhyXsadYp5kHhNzNjSE5R3K3IH
X-Gm-Gg: AfdE7cmcoXkNY6e/pcKz//oAT37Lns4kwVN37PUrCgwbWMz73uioGca3Pr8dlk1iGoy
	Zvo2Ml/0JUjUFSs7/rR2JCwtBnu9HjOwecYEwJt+bJvdqZRa/oADz7hIPyTCbPOMvxLNp+nzGh+
	9JXORqBCLmVbKtFVG23ag3iRJZ3flFu1Xprpd1+OXfGIGL9iQJkgsiDLncZxMbExX+8CdBT71as
	YnBIDWLParMQtp+8gQN1bZyTndaABMtgcpdcftbCFKKpboCC7zzb0zjL2dFlz9JKUQIfXicdY0z
	sjKuRA7rj0oST0ZrNFRvYfFPICVCj12m/Kg5k39CtkU+bp67LzH+ZL7wo3BaVOP2A6d4iCBOwly
	IIiVIJoncfNHtv51L6j9hvT0IvK/EhSjl9V6+kw+usLLdVvCVR00CKd1If6kt2PNOG3ChDTY=
X-Received: by 2002:a17:902:c402:b0:2cc:df15:91de with SMTP id d9443c01a7336-2ccea47c1eamr29734045ad.42.1783516852204;
        Wed, 08 Jul 2026 06:20:52 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb775sm28222045ad.2.2026.07.08.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:20:51 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Zong Jiang <quic_zongjian@quicinc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] serial: qcom-geni: do not advance stale DMA completions
Date: Wed,  8 Jul 2026 21:17:26 +0800
Message-ID: <20260708131726.768692-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qcom GENI serial DMA TX completion path advances the transmit fifo by
the number of bytes recorded in port->tx_remaining.

If uart_flush_buffer() runs after the hardware has completed a DMA
transfer but before the DMA completion interrupt has been handled, the
serial core resets the transmit fifo while port->tx_remaining still
describes the old DMA transfer.

A previous fix avoided advancing an empty fifo by checking that the fifo
length is at least tx_remaining. That still does not distinguish the old
DMA payload from new bytes written after the flush. If userspace writes
new data before the stale DMA completion interrupt is handled, the fifo
can again contain at least tx_remaining bytes and the stale completion
can advance and discard those new bytes.

Mark an in-flight DMA transfer stale when the transmit fifo is flushed.
The later completion still unprepares the original DMA mapping using the
saved length, but it no longer advances the transmit fifo.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..ab3dbee3e526 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -143,6 +143,7 @@ struct qcom_geni_serial_port {
 
 	unsigned int tx_remaining;
 	unsigned int tx_queued;
+	bool tx_dma_stale;
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
@@ -697,6 +698,7 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	}
 
 	port->tx_remaining = xmit_size;
+	port->tx_dma_stale = false;
 }
 
 static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
@@ -1029,6 +1031,7 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct tty_port *tport = &uport->state->port;
 	unsigned int fifo_len = kfifo_len(&tport->xmit_fifo);
+	bool tx_dma_stale = port->tx_dma_stale;
 
 	/*
 	 * Only advance the kfifo if it still contains the bytes that were
@@ -1039,12 +1042,13 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 	 * kfifo->in, making kfifo_len() wrap to UART_XMIT_SIZE - tx_remaining
 	 * and triggering a spurious large DMA transfer of stale data.
 	 */
-	if (fifo_len >= port->tx_remaining)
+	if (!tx_dma_stale && fifo_len >= port->tx_remaining)
 		uart_xmit_advance(uport, port->tx_remaining);
 
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;
+	port->tx_dma_stale = false;
 
 	if (!kfifo_is_empty(&tport->xmit_fifo))
 		qcom_geni_serial_start_tx_dma(uport);
@@ -1182,6 +1186,10 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
 {
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	if (port->tx_dma_addr)
+		port->tx_dma_stale = true;
 	qcom_geni_serial_cancel_tx_cmd(uport);
 }
 
-- 
2.43.0

