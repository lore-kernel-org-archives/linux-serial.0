Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3A44162A
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109937; cv=none; b=rLKB08nOUMAy51vQCIAALVx68bkouzQEGpuKo6AHvwD+6PP5wkVcNeaXRZgGgV/H3nWgRMEjKKZ0ctIku+oqWpXiC5om/m6mRh0iNfEbtsvF7f48OtMJduD2RT4eWc2UbzcIRVaGEBu25QFiRxLzYUpRUxEOF5ESBgaTDM+r+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109937; c=relaxed/simple;
	bh=a605jU1pvQWqUiL7tcAWYklt0O8GbI56dhq13ru7r/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn8efF5bFOUFNai3ZMACIgPsz+doZvSiGADaUR/MH+NG4c/GtO/U/LDyAS8EN3u+0C+P/SzV6dSmESMdqXE258U3r/XW1MmQdDPt4oZN8nRTFMYlB3wORuSWxPIyHEf6SQSGMY8V/VTGz5pU3GVeu1Us3w7SNkceZsfoE7yuDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5ZIm9HZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ZIm9HZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964e480f76so820537a91.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 23:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789109924; x=1789714724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJmAEC50POxoDcN++SEhq+0rid1s+953+Y3vycFEQyk=;
        b=H5ZIm9HZJYAwpXJDQjioWAlsQ3Y3qlgYeusOH3a3tmeAi6JA/O2d5wiOfpsEA3L/HQ
         jd/nxcbRZFDi5lIbWLNQ2OeBTlYPsUzzKL+Vfkwmnfy1IO4/1fGnNKm0ifLUyz0KbLqL
         m7AWAHko95vlyjCAvtQ7cD8JoHNKLs9U1WtwzXDfnLXYSn810SEErxT0iRLzNqJl1ekP
         4xoY5CKx9Gf/DW//yo0ZFIx332UybVtHvBN+EWr6qzd/yVmDVcFDGyTyM4hoGiFUACjw
         Y99mqYfCylBcBKkcDfvibh3C5pGZ85wa4uq4Kd6NHpCJfpVeKPPcyh+XhAFBkyfifxHo
         8PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789109924; x=1789714724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJmAEC50POxoDcN++SEhq+0rid1s+953+Y3vycFEQyk=;
        b=gucFqOz2ataQtti5GRNcQ/DI7UFveul/rUM4cpupP8Ogte4V8lR1pUUnrabarCLuqv
         8V/b0/r5EV4Rzpq3QJjG5q7UEboF629tpLp+wQkCoqQHvoWpleWEtOCB9L5mZqml/BXf
         81prWQlbpQ1lqovb7t5Oz8WBwTqTar7x2lnVyVT5JN8OhKwo2jvDwT9xhqQu8qMdPt5F
         iQ6nIsEGL5gdsWYEolcwkVldab+6Axgzsf3pOsc7krSulPvgKN/APlm0iW2+vu/1un+o
         SioEcaJdgktzB023X/SNcf6jYZQmlUz+MSyAyQ/w3knteMKQrdtjDkejeo6vGwubpVoC
         bXdg==
X-Forwarded-Encrypted: i=1; AKwUvBwYoObP3b0r8e6rfUwQKwkguNBuKKyYZz/5BDyl9M5DnSQq4s1W9LRiGyFejicb2k2MQEQSylgU6qFs6NM=@vger.kernel.org
X-Gm-Message-State: AFuF++nU08zryVH776wr6AM6qeu3g3Fyr0I/Qi3q4y0HHqRUwy3XO5yg
	0eMC9Wk0H8QjyQu+Br2mt2ou2kkt5qfOTFd8R8zvwBt8QOg4GZruxXJh
X-Gm-Gg: AYBFou1h0pHHWfujMsENC7on8zOZwDfKv46/YySYcU8zlnDRn26k/L0JnfasGZ9LdZ5
	1KiUDvTgVgFeUQDssc57Uozzy1dTTyTZrLG7Hy8jyQpHmL956DhG69VJuQrlwn4vIxfXNqBIJkw
	cRyX/6tlYCqz85MryqMtsSlBZKh/UQEXwUs+J9nu6NDYGhEvK5mSnbaozRgr/5x89/u9XwRZTkn
	ICJHZwbJuqb2It3hdOJ/6aHmNxB8N/WUPB0cZThHx+Z7CNS+5WlC23pf1FZbprQiiEG0V0LTtpF
	mchqBd5nHN+RFW10jNJoqs8r84NFyrMxsa3TZcAPL/osY+a2dMJ6XbaSULw72Lk3dV6qbaV/Oej
	WdM+cEKyGTJrXRQ9W24FBi+85PMYAbesp3RjH7ohuREBa2w9BcED9dvU0Yph/G/aLvQ2YU20fah
	htMdGe9sEo4RoUUY4tQhZvlqXyZD/eTI/IB/pO9d4+wFbGSY/x9bndn5lmHGbcZTkINVPlBgZF1
	TS5VD4FUIotVqx1xQmbxVu+4DfiZLZEPgiWEU6GeNo=
X-Received: by 2002:a17:90a:e710:b0:398:d843:cad9 with SMTP id 98e67ed59e1d1-39d9c202f33mr5190127a91.19.1789109924394;
        Thu, 10 Sep 2026 23:58:44 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm3061850a91.13.2026.09.10.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:58:43 -0700 (PDT)
From: henrymei <ljp1205831794@gmail.com>
X-Google-Original-From: henrymei <henrymei@tencent.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: n_gsm: keep DLCI 0 object across mux restarts
Date: Fri, 11 Sep 2026 14:58:26 +0800
Message-ID: <20260911065826.3515170-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

gsmtty_install() takes a reference on the object occupying the
gsm->dlci[0] slot, and gsmtty_cleanup() drops a reference on whatever
object occupies the slot at cleanup time. The two are expected to
balance on the same object, but gsm_activate_mux() breaks that: on a
mux restart (GSMIOC_SETCONF with a need_restart change) it
unconditionally allocates a fresh DLCI 0 into the slot, orphaning the
old object which still has install-time references outstanding.

When the last of those old gsmttys is closed, gsmtty_cleanup() then
drops its slot reference on the *new* DLCI 0, driving its base kref
from 1 to 0: gsm_dlci_free() frees it and NULLs the slot while the
mux stays alive (dead == false), and the old object is leaked. The
next gsmtty open passes the dead check and dereferences the NULL slot
in gsmtty_install() (dlci_get(gsm->dlci[0])), crashing the kernel.

Keep the DLCI 0 object in the slot on reactivation when one is still
present: it can only still be there because open gsmttys hold
references on it, and gsm_dlci_free() is the only code that clears the
slot and only runs at kref 0, so the slot identity can no longer
change while install-time references are outstanding. Re-take the base
reference that gsm_cleanup_mux() dropped via gsm_dlci_release(), clear
the dead flag it set, and refresh the per-object config fields exactly
like a fresh gsm_dlci_alloc() would, since the restart may carry a
config change.

This also restores the invariant that dead == false implies
gsm->dlci[0] != NULL, making the NULL dereference structurally
impossible.

Fixes: 6ab8fba7fcb0 ("tty: n_gsm: Added refcount usage to gsm_mux and gsm_dlci structs")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 drivers/tty/n_gsm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..2ca7e18addc5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3186,7 +3186,29 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
-	dlci = gsm_dlci_alloc(gsm, 0);
+	dlci = gsm->dlci[0];
+	if (dlci) {
+		/*
+		 * gsmtty_install() takes a reference on the object that
+		 * occupies the dlci[0] slot and gsmtty_cleanup() drops a
+		 * reference on the object occupying the slot at cleanup
+		 * time. Replacing the object here while such references
+		 * are still outstanding makes the cleanup reference drop
+		 * on the wrong (new) object, freeing it prematurely, and
+		 * leaks the old one. Keep the still-referenced object in
+		 * the slot and re-take the base reference that
+		 * gsm_cleanup_mux() dropped so the install and cleanup
+		 * references always balance on the same object.
+		 */
+		dlci_get(dlci);
+		dlci->dead = false;
+		dlci->adaption = gsm->adaption;
+		dlci->mtu = gsm->mtu;
+		dlci->ftype = gsm->ftype;
+		dlci->k = gsm->k;
+	} else {
+		dlci = gsm_dlci_alloc(gsm, 0);
+	}
 	if (dlci == NULL)
 		return -ENOMEM;
 
-- 
2.43.7

