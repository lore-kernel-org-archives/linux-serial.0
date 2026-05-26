Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1B3CF699
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791371; cv=none; b=THF5uvDz+GfkaHmA2Sm34bTdYk3J8Cierfyn4W+/SI2wIT7PPtAf10vJQJIPqXy8UxyqlzP7eOqIgjEwb4Qs4lCods9g5shAy+R/DbEAoLLNEpS7fzjlkpKNcsns6k5v9705JYvJL2lLKrizvlreKOcG1v1Ojt+8HZf/GB8JGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791371; c=relaxed/simple;
	bh=mHtmgigyJN//tHGQx9aqwwlcUisCAtjn+8tR49/ZPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lppF6b1DJ41pFqhNlqpePNiJFA8DPqFUrtYty5pkuU0Vw7dk0jHNfyNWfoXe3Ogw4tmtD9RFApk4pvni1L1RVL3O26vDExQXf8GaJCBId5vw7HHK1arsIcwJj8x1w1y11UQrGU/lhgtJ+ez7xPax7iwNhKaPlz8/S929pd6D38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcUphU5; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcUphU5"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso7475155a91.1
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791369; x=1780396169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5A30EzvmaHkqzi3qHH6wov2FtrUPyQbO2x3ZrkFeGs=;
        b=JJcUphU52Ucs35z/D2MS1SL0E9SN1Q1piCS7TctBeQ/4RvBhjwbZSR8oLBxbN6m/eq
         R8SbAqpk5yT4vexUP5DlYloJFEbOOwHD6ZH9FeXruvvEQz5X3Tr7zWV9MM3ZP2al/h2R
         A3wEDgMZpZJ4UjctEr2yCt2z9vaq35yiZ4gdxqhe0ssskyf9XgYvJlktoZPA/YOzXj8g
         4kbIyfQgUfUdGjyXqe9sDoxr2MNcgP8nP/jsECPirz1Euh74cVVX3COAERgkAz+GaUG7
         8am3yHKICO76SwHnetMPy3bCuVJWcujlDbmH3U0R4Ql6VMHyk7+cfVvFhKGCxQUbJCf1
         i2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791369; x=1780396169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5A30EzvmaHkqzi3qHH6wov2FtrUPyQbO2x3ZrkFeGs=;
        b=q/Wke+IXI+uclHerYN0hHM/+/q/XWeNmwwrIYwZOJJPfrN4RLMRUsX3IJMFoBUlxeq
         jrFD1ZZ8S5EBvSeWpc0OtEfyj/uBXDbj/1qsAngz4ApivcANSTxOPFzIaOQSRt04QDmk
         3/3jy3UWjdPy1k7e8LqhOYmtQa6Miv08c5KAznVuXPEzGG2fEFf/y9fKWITTLjtNevIV
         Ji4YjCK8zVwLeGrXY809OdN0cgJKI5wwMwL1liUTug54ZgSI/8De916JH6VBl5z+KTos
         wo0AcwAfCjvkrBmV0anJmlU/utiPA9YuVvibLwI9nFoU6CkUbgUWLkMnqhaaub7X2GGY
         VWjQ==
X-Gm-Message-State: AOJu0Ywx/TfTMoOd5k7pNo6zu76ImI6lGpxV1PhMSXzPMRweDDEdfFyi
	/3FL2vyp3maENuuhz9McCjcI6PB8HV/TH1biP7Gv1RWLiORxlPUt2HvNUH80aUgqBT/UtPsC
X-Gm-Gg: Acq92OF7lVP7tOU8GMIbwFRQXG//6KwAMn582nIstveEu6qUU0eRIsbnDJJJ04Gjole
	ZmNdh5egSL2C2wehqygmqhomvh9qzZvB4HXiWqf6yL2wjlHL+MOAzO3hZ+QLHBQIsbSHIhrhdsT
	IwPO2yovCGSkUYNOJEt50GhlVRq9igQYJNsVeoKG57Qd3xoOl1gadDeOerrXE8eB2hS3N3ENhIP
	Y0l+7+DIjAk5hZz1ayycniJlLtUG0o72qeDO6YHa1MCf2xMxtDsbh61GPhaBo7IPIRMesl2A3sr
	R+j/Ecvqunl2ndkhnwu03jpAX6l4iATIvyHHUuJIBGbAPne+K6wHNOqdt9dMb4P1awBy5d8HPF8
	N+uDOxEPW85XDlQO1i0fbXN7R1ZMABtILVJ7XoZdLAwsapbuLf0E/JRR/4IWYmWVzUbVByXHg5Y
	e7t3plAfx6fOumAv83Ro9jZJbcqxJaP3l+8ex2GNgp1PujTk5kptleQkib5KIVkGuW1vN5t28=
X-Received: by 2002:a17:90b:164e:b0:369:e9a2:6b with SMTP id 98e67ed59e1d1-36a6c7bdd25mr13270383a91.13.1779791369414;
        Tue, 26 May 2026 03:29:29 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7cf9sm12262469a91.10.2026.05.26.03.29.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:29:29 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH tty] tty: n_gsm: fix use-after-free in gsm_queue vs gsm_cleanup_mux race
Date: Tue, 26 May 2026 18:29:24 +0800
Message-ID: <20260526102924.3174-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gsm_queue() reads gsm->dlci[address] into a local pointer in the
flush_to_ldisc workqueue without any lock. Concurrently,
gsm_cleanup_mux() (triggered by GSMIOC_SETCONF ioctl) frees DLCIs under
gsm->mutex — which the receive path never holds. The cached pointer in
gsm_queue() becomes dangling, and the subsequent dlci->data() call
dereferences freed memory.

Fix this by:
1. Checking gsm->dead at the start of gsmld_receive_buf() to reject
   frame processing after cleanup has begun.
2. Moving tty_ldisc_flush() before the DLCI release loop in
   gsm_cleanup_mux(). tty_ldisc_flush() acquires the tty buffer lock
   (buf->lock), which serializes against any in-flight flush_to_ldisc
   work. After it returns, in-flight receive processing has completed,
   and subsequent calls see gsm->dead and return early.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 drivers/tty/n_gsm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..8322fffbaeba 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3156,12 +3156,18 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 		gsm_unregister_devices(gsm_tty_driver, gsm->num);
 		gsm->has_devices = false;
 	}
+	/*
+	 * Flush the ldisc before releasing DLCIs. tty_ldisc_flush() waits
+	 * for any in-flight flush_to_ldisc work to complete via buf->lock,
+	 * and the gsm->dead check added to gsmld_receive_buf() rejects any
+	 * future receive processing. This ensures gsm_queue() cannot access
+	 * a DLCI being freed.
+	 */
+	tty_ldisc_flush(gsm->tty);
 	for (i = NUM_DLCI - 1; i >= 0; i--)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
 	mutex_unlock(&gsm->mutex);
-	/* Now wipe the queues */
-	tty_ldisc_flush(gsm->tty);
 
 	guard(spinlock_irqsave)(&gsm->tx_lock);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
@@ -3604,6 +3610,9 @@ static void gsmld_receive_buf(struct tty_struct *tty, const u8 *cp,
 	struct gsm_mux *gsm = tty->disc_data;
 	u8 flags = TTY_NORMAL;
 
+	if (gsm->dead)
+		return;
+
 	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, cp, count);
 
-- 
2.50.1 (Apple Git-155)

