Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9217C72
	for <linux-serial@vger.kernel.org>; Tue,  5 Mar 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603401; cv=none; b=EDdAbyYJtKVEB458RRPP0fbpwMzffhUi13QrDeqIYZJxkB33ZPachzGxETasaw+N7swk3qwW4vklzx+gQLCc1w+pcTOfNJbGV5Kkv+umi+fnOmDAgSClWniNjbPmf5clHP2TtWFUoGlCuLomiBMtPWjMso73tE8sZk5DxtGvEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603401; c=relaxed/simple;
	bh=yyW5I+Reax9tvwEf8AlEoNpwkjdPnt8mWZ23KJMTI6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B94ZzdvMxPYE8lobBoIKF+uBct6Nm+MQ5fsdnMsSXGrogKXaWt1K7cBJGydH0M2YsIxXWsmiAYmolJQtFtteAxwZsSMrF8cDmTmLaF30nNR2+AC0f3+r6zE9QcBuLmiLYohMu6CgiOzTspqrlwHdY6iTPqYuETjGzCkuDJtW8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aZ4lXG5D; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZ4lXG5D"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcc7f4717fso51714665ad.0
        for <linux-serial@vger.kernel.org>; Mon, 04 Mar 2024 17:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709603399; x=1710208199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h13kFiOG83l2eut0x8wl6gIo0vAvu5MS7zN4PwJZB2w=;
        b=aZ4lXG5D8BAuThlzP1OO1ZjA6u7qP24QFm8uS4PSB9x1RF7btALo9IFR6EIIxZ7sWz
         AML1BDOqZr0u4EopH69TmUc7Ss4Tiib4rxDJZtdBB7ya0pMVC1llzhSkCwMeoVxl/dUH
         jChGGLsm2lRo5XDiy4igI3i0yOetj3He/jYWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709603399; x=1710208199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h13kFiOG83l2eut0x8wl6gIo0vAvu5MS7zN4PwJZB2w=;
        b=RKEOdzlXoB5swj9HFx9G+VYJ4SNNuVMnRwWu7qGGxJeXwDs3gUox2awzFP6mkf0Dix
         FZluVJNQEYvE7D+a3pWHA2AsGnzu5TU7A+zCeg+dvD1r2vglSVgS7Twf3YmN1zTF3Q9w
         rAm5funoX+6e428qnJlMS0zRJbilnjyTFxMqbee3hauxx0QHXCPNd7KJwnSBICgQBqHA
         ZInuLzuA/ZNxPUYVdeXuXu14RssM/vA6ONDcCC1iHBz5H6I0KOGpgVLBRyFG5dJADLxt
         OwVS4tRClMO7EGObxANo8knWX6d44TDiaM9pQSWoOhs4nhQXi5CLRUUywSnn/JPRSb9O
         vz5A==
X-Forwarded-Encrypted: i=1; AJvYcCV5wjZkxW8n3A/kacBfB1H91xzbh+5v+rh8OHpdxlXZZxocRZYUhjHE6wgpY58jcffIARYLDgRuysFE7KtBTi//jRuORHH7REi49GZp
X-Gm-Message-State: AOJu0YxoYrwz8JPsKyaHUvMn++uBzADfoQce7NOl3xgYXLZBLPXoCRXU
	GLO4nCkvj5Ih7JEq7Co0MC4YQHUABft5AOHIsCjxOEHOSdDeJoLbQwyp9aycXA==
X-Google-Smtp-Source: AGHT+IEY2MyLk4Pt5JuQWaChUMdnDCImSXnsfKZzDSoADAlNhDR4tmnQTOUcjCgHTCc00JnzSTSknw==
X-Received: by 2002:a17:903:2342:b0:1d9:b099:6f9 with SMTP id c2-20020a170903234200b001d9b09906f9mr697581plh.45.1709603399526;
        Mon, 04 Mar 2024 17:49:59 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:aaf8:36b6:cbbc:88ff])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001dcc7795524sm9370813pln.24.2024.03.04.17.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 17:49:58 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()"
Date: Mon,  4 Mar 2024 17:49:53 -0800
Message-ID: <20240304174952.1.I920a314049b345efd1f69d708e7f74d2213d0b49@changeid>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5c7e105cd156fc9adf5294a83623d7a40c15f9b9.

As identified by KASAN, the simplification done by the cleanup patch
was not legal.

From tracing through the code, it can be seen that we're transmitting
from a 4096-byte circular buffer. We copy anywhere from 1-4 bytes from
it each time. The simplification runs into trouble when we get near
the end of the circular buffer. For instance, we might start out with
xmit->tail = 4094 and we want to transfer 4 bytes. With the code
before simplification this was no problem. We'd read buf[4094],
buf[4095], buf[0], and buf[1]. With the new code we'll do a
memcpy(&buf[4094], 4) which reads 2 bytes past the end of the buffer
and then skips transmitting what's at buf[0] and buf[1].

KASAN isn't 100% consistent at reporting this for me, but to be extra
confident in the analysis, I added traces of the tail and tx_bytes and
then wrote a test program:

  while true; do
    echo -n "abcdefghijklmnopqrstuvwxyz0" > /dev/ttyMSM0
    sleep .1
  done

I watched the traces over SSH and saw:
  qcom_geni_serial_send_chunk_fifo: 4093 4
  qcom_geni_serial_send_chunk_fifo: 1 3

Which indicated that one byte should be missing. Sure enough the
output that should have been:

  abcdefghijklmnopqrstuvwxyz0

In one case was actually missing a byte:

  abcdefghijklmnopqrstuvwyz0

Running "ls -al" on large directories also made the missing bytes
obvious since columns didn't line up.

While the original code may not be the most elegant, we only talking
about copying up to 4 bytes here. Let's just go back to the code that
worked.

Fixes: 5c7e105cd156 ("tty: serial: simplify qcom_geni_serial_send_chunk_fifo()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
If folks really want me to, I can adjust the patch to try to detect if
the circular buffer is going to wrap and still use the memcpy(). Let
me know.

 drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e63a8fbe63bd..99e08737f293 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -851,19 +851,21 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 }
 
 static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
-					     unsigned int remaining)
+					     unsigned int chunk)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
-	unsigned int tx_bytes;
+	unsigned int tx_bytes, c, remaining = chunk;
 	u8 buf[BYTES_PER_FIFO_WORD];
 
 	while (remaining) {
 		memset(buf, 0, sizeof(buf));
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
-		memcpy(buf, &xmit->buf[xmit->tail], tx_bytes);
-		uart_xmit_advance(uport, tx_bytes);
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[xmit->tail];
+			uart_xmit_advance(uport, 1);
+		}
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
-- 
2.44.0.rc1.240.g4c46232300-goog

