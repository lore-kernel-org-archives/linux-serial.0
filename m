Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297356;
	b=MEbtauPqirEOO20FWKnPqur6YilR5WaCoF8Fi2MyCU7286+e2S/7MpS2356AnFKHUZXG
	 Rx5GRZFQY53IL9N49CdIgI0AmKLvMHGxqtXaOh2fg5FoRwgwQH2BGwcpSKzfdPnr6OyMc
	 VsItnWC7A4mwaej2JUKAjjK7M9FZuYrw0ELo0MEYrOuLkFSl1kK+p5SUEXCs2PP6wXSkA
	 iwViAtJdJgjtorHCv3GX5KzCWE2NOjs/ID32tMERcaVXrclXK54KuuK8EnWocjGYcYdP4
	 GFUl5hv4G/6DU+wpPaC9aCIpgBThMcRY5zztDdepNjuKDwUPlFM8jqZvYWSWlnwddeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
	b=rU7gwstVtfpof3i4gTYKhjm+DxiQlFbvT+AhUnD70fcGomsvBXZg43keTy+utQfvSjw4
	 BXq+w3HErWXfMhTIpetZLxssxVoTEwN+ukzJaAwdl3I2m3U7BXbb27sZGXi/OLjw/Acsu
	 X9BGvRpK2YjoF9hdv9De0HMRvvIUcpkOPwJJEY5gCkGeL0zrx8m2HO6nQbB/cPMciQbbd
	 rcMZZcgqYOUnUyt05WhNsTzacHXnRPWGBVCocYCaRlStu8qtfj3GIVQkjITlfBlIDZpF1
	 YtzvbUXfrSoYslm+p/RpY77WQFTLoT5uA/VTdoNUQher141UmdFzk36FtUEljhyRl4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF6zik9H;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F11606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 07:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F11606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF6zik9H
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1444743e87.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297355; x=1794902155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
        b=pF6zik9HqBlnUxyUVNjaDYPeJJIaueDqrerGbI1ZJDvDiePLXsIlsxwVF4Mdu+w9Fa
         2Zfk0ByvlBzDBww56nSiYryLeVawKmGXACnac/KLGAWDq9w/nRCLpWLWYuN11rxmiJwu
         7WF9n7Ek1Sggu/UJtVZslhmOzRiYZHExgW8toGjDegiXJEfMN7Tij9XCqc4RYZtcaxv5
         Ib31OQB993JrhVIvj9uxVOEyty1sh5n0Cd5UuzrpzFkRg+MYsV/FxWcRyyzR1yHf0Qfd
         u108Mk80rcnC5yNkMBXmdVvsgMXwzHFKYXXxBvqq2rQzHENKBozwVbr/bPZdprjbN3N7
         CRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297355; x=1794902155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
        b=kS5j2b41zC9e+kcam1TcI9kkIm5qzvVUERkdzGLow+7s5Dhnq6NKN4KTInNN2uzPg/
         kKGo0ohwfQ7DIuRG6TPOebqvfKbshjG1iNvgCRnlySWrQnX0HlOZGXm1coc2LDHA8Frs
         Sg0ibBYCXluNWZQiLAyZrCpHuJHuqT26jNx2r/+hisoEiw0QY8bA7E52ok5PWzvo3mN7
         4eKE06Z/emrYPl/KvWt760uRfXanpRhGh6cTAJBrxZeZkZEcfX9NmsXqMGEHgbIDO8GH
         Kw7blDYgRM4I2Mt9gaHV/2RGt59MityCHneGLWkOSPzTXSYlnlQAbPOsRDaWVMqoIh/O
         SBLA==
X-Gm-Message-State: APuU4Z9chnBsjTMHnag1KUHYQwPfItZYmh1wZoIJuJwgzgzRIvTgc3Ti
	ijwkBjr32DTkRY+gTtOB/XdP5ImL2jUzI6QKIy2o4OLT4gYv0usWiJWrpMGE9GP+InrwWg==
X-Gm-Gg: AYBFou25eeDrJr/zVFQLavUgC1l7TdDogWzcaDVlOjxO8eXFRzjap5t4sAsrrjAnUTf
	zh0FFzH13TDVP0+MD9iR7wGdpWDmgcGWfL6RuBTX+5YzPQbsZdS1DTnRyZ/pdwYcqrA95EtXSQL
	PhWWdTy3ZY48O3C6cE5QlhWHFbAskdqNzQSD1UF9tpqkdHMe7nriHXFIlkltV/632T7sLp+FuUt
	kSklHmBfHXIKb6DnPvuLXiqQkS6bJZXfv6zAbKvcwdCxx85vlHRsREM/PhS+ZhSELGltrjTEPkW
	uOMtpms2LbyKRqyxcsREqdb1i5/5zodAwMsiSYh29TAmCGmNdzucZB6HteIFGQyatqb86OGeUQ4
	P2Qz/hqk4iNbK43rrl6oIe5IXTvgC1O7CB6G9VEkRQ0ESZDyWx+Jo3FW5Bcy/LyzTw2Ru510WUh
	af6PMxBl4/aynEqXW4ktEqMQNmlpaFjg+sZMEeD45pfO38Co6zexwMcG3BdEP/UhxCjGWs7YmNV
	cGPtGwt4mlIzoxM3ZM3t3GVnw+y9bG7mWK8TnDW2e58FbTIPK1eSDXD6Q5tBsWycIwP/6dfP/eP
	lZ5wRL0l16CYe2I6Q6Q0hkrGOHUZT/toKIgnLNzOVA1DCFLvhYWUg0gXk7x9gxo57fB2niPxUVM
	u6m7N+AclWZpBrFcYgzhW3Zou/yo=
X-Received: by 2002:a05:6512:39c3:b0:5bb:7b64:340d with SMTP id 2adb3069b0e04-5c156ead9dfmr509262e87.28.1794297354505;
        Mon, 09 Nov 2026 23:55:54 -0800 (PST)
Received: from localhost.localdomain ([92.36.11.150])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157ced5basm249834e87.41.2026.11.09.23.55.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 23:55:54 -0800 (PST)
From: Artem Novikov <novart962@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tty: n_gsm: serialize mux configuration
Date: Tue, 10 Nov 2026 10:55:38 +0300
Message-ID: <20261110075538.51452-1-novart962@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Artem Novikov <naa@amicon.ru>

Concurrent GSMIOC_SETCONF calls can both decide to restart the same mux.
gsm_cleanup_mux() releases gsm->mutex before gsm_config() calls
gsm_activate_mux(), so cleanup and activation from different calls can
overlap. The activation paths can register the same gsmtty minors, and
registration rollback can race with another registration or cleanup.
GSMIOC_SETCONF_EXT can restart the mux through the same paths.

A 5.10.246-syzkaller report shows a NULL dereference in the unregister
path:

 KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
 RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:596
 Call Trace:
  tty_unregister_device drivers/tty/tty_io.c:3290 [inline]
  tty_unregister_device+0x117/0x1c0 drivers/tty/tty_io.c:3285
  gsm_register_devices drivers/tty/n_gsm.c:496 [inline]
  gsm_activate_mux drivers/tty/n_gsm.c:2286 [inline]
  gsm_config drivers/tty/n_gsm.c:2517 [inline]
  gsmld_ioctl+0x9b2/0xff0 drivers/tty/n_gsm.c:2829
  tty_ioctl+0x86a/0x16d0 drivers/tty/tty_io.c:2757
  vfs_ioctl fs/ioctl.c:48 [inline]
  __do_sys_ioctl fs/ioctl.c:753 [inline]
  __se_sys_ioctl fs/ioctl.c:739 [inline]
  __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:739
  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x67/0xd1

Current tty_unregister_device() checks for a NULL cdev. The overlapping
registration and cleanup operations in n_gsm remain unsynchronized.

Serialize the complete configuration transaction with a per-mux mutex.
Use the same mutex for GSMIOC_SETCONF_EXT, which can also restart the mux,
and for the corresponding configuration snapshots. Keep userspace copies
outside the critical sections. Use a separate mutex because
gsm_cleanup_mux() already acquires gsm->mutex.

Leave receive, transmit, timer and workqueue callbacks outside the new
lock so that control-channel shutdown can still make progress. Concurrent
configuration requests for one mux now wait for its reconfiguration to
finish; independent muxes retain separate locks.

Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
Cc: stable@vger.kernel.org
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/tty/n_gsm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e55779ff0af2bb6328cf5f0ec70497107f1462e8..26e34e79b034a19e1b5dc1f4a87d56a74e884d56 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -273,6 +273,7 @@ struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
+	struct mutex config_mutex;	/* Serializes mux configuration ioctls */
 	unsigned int num;
 	struct kref ref;
 
@@ -3219,6 +3220,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 			break;
 		}
 	}
+	mutex_destroy(&gsm->config_mutex);
 	mutex_destroy(&gsm->mutex);
 	kfree(gsm->txframe);
 	kfree(gsm->buf);
@@ -3290,6 +3292,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
+	mutex_init(&gsm->config_mutex);
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
@@ -3328,6 +3331,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_unlock(&gsm_mux_lock);
 	if (i == MAX_MUX) {
+		mutex_destroy(&gsm->config_mutex);
 		mutex_destroy(&gsm->mutex);
 		kfree(gsm->txframe);
 		kfree(gsm->buf);
@@ -3341,6 +3345,8 @@ static struct gsm_mux *gsm_alloc_mux(void)
 static void gsm_copy_config_values(struct gsm_mux *gsm,
 				   struct gsm_config *c)
 {
+	guard(mutex)(&gsm->config_mutex);
+
 	memset(c, 0, sizeof(*c));
 	c->adaption = gsm->adaption;
 	c->encapsulation = gsm->encoding;
@@ -3384,6 +3390,10 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		return -EINVAL;
 	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
 		return -EINVAL;
+
+	/* gsm_cleanup_mux() takes gsm->mutex, so use a separate lock. */
+	guard(mutex)(&gsm->config_mutex);
+
 	/*
 	 * See what is needed for reconfiguration
 	 */
@@ -3451,6 +3461,8 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
 				       struct gsm_config_ext *ce)
 {
+	guard(mutex)(&gsm->config_mutex);
+
 	memset(ce, 0, sizeof(*ce));
 	ce->wait_config = gsm->wait_config ? 1 : 0;
 	ce->keep_alive = gsm->keep_alive;
@@ -3471,6 +3483,8 @@ static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 	if (ce->flags & ~GSM_FL_RESTART)
 		return -EINVAL;
 
+	guard(mutex)(&gsm->config_mutex);
+
 	/* Requires care */
 	if (ce->flags & GSM_FL_RESTART)
 		need_restart = true;

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
