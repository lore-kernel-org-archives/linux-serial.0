Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377421;
	b=nodDwq4OeeTr0jGnt4LivalDTyR8TguMWf93SeRJ7mS7UAop2jgy6CmLoLgRsKl42nTy
	 gYgtNJp3mrkn96qscnAgUSTmHQ7ou7fFzbcjCW8CEx7/qZrWtHQGdZZQaIn1Vkzo5V3st
	 sAApwfQ3BuK1y/OgBGl2/0o9o6ukBbz+eYk/FfPTWMkds3nmWi3YqPDzG1TYqxEpNbCMg
	 ZkC46UIIfNjwSGElcgcu/JdzKHsoe3zH+SQ98SyrSpvMQlCvWAhLPQ310r453ADRBb4Po
	 /XIpcOtiOHESWZr4Y2C9FE4IIj5CSan0t1bdV0GaPV6xgAzpDCkHqoFpW2zej/BHI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b0GnmpO+AJdyxic7fk9eFb7rmK6rtUcv8tGjcAKiwQE=;
	b=j/ZHzB3abKa7na3CKol5o9g5o6BJPLPTP7o1URQ7Njl6jWfoVtrL4+5mAcEOZVb9EWdo
	 8dK1mwv8xvw8Mo1sTXTRnAdes9v8mPoXvcCKHiTYCwHBscDRLaW8OnKht2b8dgURMAjZ/
	 bHkhqdlymyh9oWWJMS/woHqT1YJrnwLvJBK7cBpkAMBZeSjFdOk4Ec8lSPY5qAGoUYsO5
	 P37BoIULW0R3fZRr2bytF94NhUcLbtVqaeUcUNJ2xQVIrC8BHB51tAsyebpbSI5OixJ1e
	 ap8qa/vJPrGZEuzEDDBDib78P+0qp7Iq9BF5W0rLtVeYYZ1GZW5tTPYTkPw4mrv8eiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XgtcXKLi;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D54606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 16:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XgtcXKLi
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so1346038c88.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377420; x=1793982220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0GnmpO+AJdyxic7fk9eFb7rmK6rtUcv8tGjcAKiwQE=;
        b=XgtcXKLiYXTxAo/HVRXwkkZT78K7n9ohemQOapb2bgfWp8C/QQTdYer3Bn0wIid+Ou
         jT+jJKgjRVvpgSxdRG4taV4LQnW7782zo/q25AjIO8Wx2NM25rmq9V6UiGXO+WigDq1L
         +uG4lMoY2UiE9GOXGcw4dWEcAuAuNOAEiMf9USmABC6nL4VZ0f4HubTTSeWVr3q4fYBg
         2lkR4YyCurNn6xZc9gaS//SJudwCNPHRpH5jqInUrfp4ouOhzMhtOduJ1osAhDdqfUgs
         kJq6MgjZSqZxXaOsuV8lgByYsjCNRmn0C1WGdUaXhp8nYXe4vL2E1unB3yUmbzOH1lWs
         RXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377420; x=1793982220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0GnmpO+AJdyxic7fk9eFb7rmK6rtUcv8tGjcAKiwQE=;
        b=oJHjmxFMkjT1jm8mxMNdFk1X1l040piaG/PhdbOcNwqSCmSpPvTGHoj5SSMp2fKOJY
         ALROjasOdM0/K9/uoYF07Qv2E5upFrohwmKZz7GM3RdS+bRFFINT52dHbavt3eYiyJZC
         Sb4qZWHmur81WJy583h4jkSB/63nnv7gCOx7jtahSfE7T7Lz8e3x5dEKNQn29y1FLYOp
         s4OQKQx8Rjwcs+aH3vALP6Ltd2wSENYejAub99BsnuNAX0GAO3ojKTWqLsyyRy7uYU7n
         ZfnevhVRsSh3lt5bIKINqy8k7rzCNTztqIXNSN+duMqVHjw9HCe7yHwmTF79aGeu2DlB
         NAeA==
X-Forwarded-Encrypted: i=1; AKwUvByevrnkWriX/1GlubW/F2DQO0DhYNdB3YGDDxNND/nioKCR+FKc6yIldJuvbZOw3cTgum5TYE3NcRTRiQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmyJP3asOTezANq9wjQ4l7Ek16DPR0v4pUYnVTjcGNeZ96t4Gc
	EVotFL6Wgr/o923LpNjUMPsVTG7VveRrR6WlROnxNrjJQIa8exIVLdBb
X-Gm-Gg: AYBFou0oQb3I0ezj/L8gZBQZv8HaSkugLMC9syfwHsxbUD/ymLuy3W1hzFOr18aeRW1
	pJRk8SqfsDxhKnHeFTNxJQlY14Xn1vX37+8U+4EjUSchlCygdgw1Kl5chbzGxAikYP6TxTd5aF6
	Z3UsbCAwbuLe9PANeMEqRA/3MBSAlFPiRFjr1hlDvOda5fUqD25hacMLnKkjrBAZNTwSogin+em
	jSX8r50kKKRSP8wmzUp36rbBwGY2zPU0OveOKc90z0BiPP40sUsBLwi6WgmqWrZLt3KDZLU06j1
	+4laGHSib56e6qPTM9ayMbFsEWwksKtfC8aIPTh/RM2aIw+W85N5xVOS/+hzDqFIRv7LR+MKEcZ
	g8+MNMw7Vm6OkB/X8VpyMhfJNhjyni+Hco7Rg2pJQUPifxQZRWOvJFjb7Bgk2XuEuLUdugcO9jJ
	4ucOrVHsD0TKSK0ZF2NaGDx9S0Qg9tJ6vWUYRvvP8PqDyVE2AgiGuZL6J8OTW/0G4nSA32c2NAr
	C8Sds7mMLvK7wP5tcAE3hBpO9VioEPCsvc7bAGXbEtx2zXP7gpz3PeKCF8C43UZ+rYeOBufhltv
	YPwInPe2D8y1Gzr1b+jF971LDAU5jz/WtG4LNj0MO0GwgFuiW9RzW2FMdSVnotuT9J5jAA7Pa7J
	7/WPn2pOtUIgijX+u++tZhJzPSBCqdgxgZWVxxp6YX4MmHi3MobqBhdlvackFAtko0UXrEQKpRl
	uvcKdZ7Mn+DTAjGg==
X-Received: by 2002:a05:701b:4281:20b0:158:1ed2:cb58 with SMTP id a92af1059eb24-1ac5e6f5362mr3896872c88.39.1793377420369;
        Fri, 30 Oct 2026 09:23:40 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm7689041c88.3.2026.10.30.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:23:39 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] tty: serial: samsung: use dmaengine_terminate_sync() in release_dma
Date: Fri, 30 Oct 2026 16:23:34 +0000
Message-Id: <20261030162334.3000737-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s3c24xx_serial_release_dma() stops the RX and TX DMA channels using the
deprecated dmaengine_terminate_all() before unmapping their buffers and
freeing the RX buffer. Since this does not guarantee that DMA transfers
or their completion callbacks have finished, the controller may continue
accessing memory after it has been unmapped or returned to the
allocator, particularly when the port is shut down while RX DMA is
active.

Replace dmaengine_terminate_all() with dmaengine_terminate_sync() to
ensure that outstanding DMA activity is terminated before the buffers
are released. Both callers of s3c24xx_serial_release_dma() run in
process context, where synchronous termination is permitted.

Fixes: 62c37eedb74c ("serial: samsung: add dma reqest/release functions")
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
This issue was identified by a research static analyzer for DMA
lifecycle ordering and has not been validated on hardware. The patch has
only been compile-tested on arm64 with W=1.

On Exynos systems, the UART uses PL330, which does not implement a
device_synchronize callback, so this change follows the DMAengine API
contract without independently establishing that all hardware activity
has stopped. The PL330 termination behavior is being raised separately
with the DMAengine maintainers.

Two related questions outside the scope of this patch:

- s3c24xx_serial_rx_dma_complete() unconditionally re-arms RX DMA,
  potentially racing with release_dma() and submitting another
  descriptor after termination. Should shutdown prevent further
  submissions before terminating the channel?
- s3c24xx_serial_stop_rx() calls dmaengine_pause(dma->tx_chan) before
  checking the RX channel's residue. Should this instead use
  dma->rx_chan?

 drivers/tty/serial/samsung_tty.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d..4eeef149b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1145,7 +1145,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 	struct s3c24xx_uart_dma	*dma = p->dma;
 
 	if (dma->rx_chan) {
-		dmaengine_terminate_all(dma->rx_chan);
+		dmaengine_terminate_sync(dma->rx_chan);
 		dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				 dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
@@ -1154,7 +1154,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 	}
 
 	if (dma->tx_chan) {
-		dmaengine_terminate_all(dma->tx_chan);
+		dmaengine_terminate_sync(dma->tx_chan);
 		dma_unmap_single(dmaengine_get_dma_device(dma->tx_chan), dma->tx_addr,
 				 UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
