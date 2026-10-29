Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283248;
	b=ZdzBCpdgsoyhnU5b6KsfxYV5+hmeAL5W64oWtnOQrPLUw/0m661iKFwEKfWLqI3ypu+p
	 JzS5Br9/2ZkdQePQ0d8De939x2VB88ZMmP0tzFjZtfw43fGrjvxKYBEj3GUwk6rVgh+I6
	 agEZ1wQ2SFBjwiFITIEKQ0203MgfxWk2crFsRe9gOa1xelPHiIo0YWOTElTyUfLdx3fR5
	 9YE3fiDKOJsJgtmOzJQLOQlP8bMiycpTscfE3/pyf6Gg6xoEHDMfECUfdfgqId+YMeO01
	 dTPGqg3zz/djXYsvcA8f0sZohGRWggzt5xNwuyjm9Fhvz88nr4Lr/tdv3VadsJ6icGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wneFayV8k/HtNzsfaZR2kxbDT08YnIr1bVGtS9YLVJY=;
	b=SH7GGdeXLde8H9+Z5M0M90j/FuMDaM3pPl5MrQi1ZouNnFDU6JBgjFPv8Q5pSFy7vOb0
	 HqIo6zVJH926+a6+2dmDtmBhKbwY6eC1i+oFdCU05pwVnRzgCXTIApppRdUbT6FQmkxbs
	 DptOWPnjPijWShnbIIAnEAoxUQPNOwDVFLec4l2MNlbXzTrXIFE6equ5jn3Jxq6rQRV4+
	 jNaykrFe+0x8wcC97WRvosSz1VN+yRnd0HgQ5s+NrFq82/zF/Sy/9i0K2k4UJKvegisYG
	 xrNyFNxHWmlo3YAF+PPsSOaWGeZHn4RkGzDA3jElXqJA2ST7PJNtsw/3VuKwy3KkS5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tt4jl6du;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9B606A32E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 14:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C9B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tt4jl6du
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2953854c88.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283247; x=1793888047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wneFayV8k/HtNzsfaZR2kxbDT08YnIr1bVGtS9YLVJY=;
        b=tt4jl6dutspAaYqtKRMFA/8QObZsHgQVcl6Pf3GKtvE/+dIEuOjFjCoqphIEANyVY0
         e+R+3dovah4+8y4IFaoWQfLyPuCI+RbZwSFyAtdQJSWuCM7eVOUYyPGMDMeIV2/cHkrF
         wSpyC8s4VwcTOtANA9hwXwdj46DmpVHR11nfLyheB+qvWiGFdofxR0Lq4iG8yvBiqvQI
         BDc2ZAeksSLjZJwZWjwWWevMmPcjHtpmhVmDlbYJBK+RPsfgP661UXCr7eiH7bCM1cn1
         6hFrzG5X8XaZUCskcj7tP+QeQr/c/nlA7vwpF1e7V8TuFo08C5kIrnYd+xtBzRBHXCx/
         J0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283247; x=1793888047;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wneFayV8k/HtNzsfaZR2kxbDT08YnIr1bVGtS9YLVJY=;
        b=v8tRJBHALwOigqOf6zmTx/LIepVnIwWtM+82l5JzPOr5h4E9/6S37EP1OjZnk+LN4b
         1Yylfd/BS0fnicXINO5kQygXHN8i4ybmXgLsj9H8xQp1mah1wlZulxU3TS/j/IxxqrBX
         Ws6MOpIbbX6EFUB+tq5NTk5Vhurv5gkNw2t8avCRLW4xbTQ4OLTT+YDSSGTAIshCzpCu
         qMZzLYwfNImfZl2lH7FWzuOn26mYQhqCtNt5yQvr+QF02bn85LnwEEHxYynNHj0lXPj6
         cVD+Moo0TosrK7iFbEvDUhXnHe1M+WYRzMEqi2TNlc2rfBb3soVmUrlAchti7C8QXP9O
         PXcQ==
X-Gm-Message-State: AFq9FYLezTcrJ1wzEduAf/xY3x8h0Y5rDtwCm7o6g7mbY/1hdIY5mfDy
	+NT1QUED858zjCtUzpMrc79Mfxt6zXwMxuQR59fq4yiBYsLSBtj9rkT+
X-Gm-Gg: AYBFou1o7iTsiaraLoznvRe8N2+gDeLzRQ94PRIUWYShp7tpaaYhUg+EpAwxEmi11Em
	JmiEI8aIOj94HScVNzuIuo2x8fVvDYl+EughFE0evYitHWjvxfP01znkijJ9Q1a3v1FZkCWFCJd
	4k7ruUUjnrArgRjTlnJ5+uc5edet7E+OJ5o1vtkeIdyP5lQ5I5g1Zad7fkMquwWDT6hbVtNR1aW
	nLikYej4oF7ZmPGK9C26YCMaHKrzJKfvpLUHtaX5xuWjMBe5cRvarkE55fqPAaFkIBpOf5mUhZ8
	nLrK8s5vqyZgNV156WJpo15eZKrPZjvtnQV9NRZ7iIDymmAn6p2rtNDudOJtAtqSkiDg+y7NadF
	mVhAN6uwIVoNigkOe5+97xh9wc/51NjDnqv/rnlkQh2izwavkqDmXUUVUBsyly/1EClwdTfj2ca
	ruBjczBTlPlNAfRMHNc+rH9H64mUc+b1zZYXx2FxHocn7yL7jDFZlw7fXInISGzsu92ssXGTLZG
	IxvqOf2ZuTaskCfFuxjiMaUaou087qGkVOSjjhERotBlIRi0gbB7NjJCNDzIMaysDw8wGU3VEMn
	ExQSMILuow8t3HiwYflXX4WBCU3YPPoaxR6H/cyHxyqG8wl64A8+Mw==
X-Received: by 2002:a05:701b:2511:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1a6c7d2c428mr7145915c88.4.1793283246851;
        Thu, 29 Oct 2026 07:14:06 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:14:06 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_hdlc: fix duplicated prefix on partial writes
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314077.648427.13745367584859897488@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

n_hdlc_send_frames() passes the whole queued frame to tty->ops->write().
When the driver accepts only a prefix and returns a positive short count,
the current code puts the whole buffer back at the head of tx_buf_list
without adjusting its length.  The wakeup callback later sends the frame
again from byte 0, so the prefix already committed to the peer's flip
buffer is transmitted twice:

  DUPLICATED PREFIX: magic occurrence 5 at offset 19968, frame index 4
  drained 36864 bytes, target 28672

n_hdlc_tty_write() still returns the full count because the ldisc owns
the queued frame; the short write is an internal transport event.  Drop
the written prefix from the buffer and requeue only the remaining bytes,
so the next wakeup continues where the driver stopped.  Full writes, the
-ERESTARTSYS rollback, other errors, and a zero-byte write keep their
existing behavior.  Clamp a driver report larger than the frame to the
frame length.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 drivers/tty/n_hdlc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 895b850..db2103f 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -288,6 +288,9 @@ check_again:
 		/* pretending it was accepted by driver */
 		if (actual < 0)
 			actual = tbuf->count;
+		/* a driver cannot have accepted more than the frame */
+		if (actual > tbuf->count)
+			actual = tbuf->count;
 
 		if (actual == tbuf->count) {
 			pr_debug("frame %p completed\n", tbuf);
@@ -304,9 +307,17 @@ check_again:
 			pr_debug("frame %p pending\n", tbuf);
 
 			/*
-			 * the buffer was not accepted by driver,
-			 * return it back into tx queue
+			 * The frame was not accepted in full: return it back
+			 * into tx queue. A positive count means the driver
+			 * took that many bytes of the frame, so drop that
+			 * prefix and retry only the unsent remainder instead
+			 * of transmitting the prefix a second time.
 			 */
+			if (actual > 0) {
+				memmove(tbuf->buf, tbuf->buf + actual,
+					tbuf->count - actual);
+				tbuf->count -= actual;
+			}
 			n_hdlc_buf_return(&n_hdlc->tx_buf_list, tbuf);
 			break;
 		}
-- 
2.34.1

