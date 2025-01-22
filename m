Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC3F9FE;
	Wed, 22 Jan 2025 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509168; cv=none; b=fWZDdhZtEy4io2OVaUWdv106ZhCkO6xgGcOpyycYRMfeuLfu2qrBwu1cozRj5FG09yjjTTdZ25diRJiRr6cPrF9IgpDfihZJo76Wl6qfd0I1rVriMBh1PoGcpvMUgca1RWL9UjjIjUGC8Tc8cVhqu2lLCDkIhQZt6Hn2pC+stTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509168; c=relaxed/simple;
	bh=dE54q8plUzkJNcRihgrva7gUPb6cDS6+pUOTEuUhA00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpYkLpsVU+7l01tLRGvnJWjPB2XUP7gpd35n2wLGeSqa6qv0ja0rRbmEBxTRG3p0zzlCM1HFHXsrJYAuFOaplY52JaitGAt6A9vAdzvK80iBKvaweYxmKWAxuzZ/ZqDitYqp1NkoLyxsiENEnAOfS928aTMdaFHfEFEOv3MvN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GXKR11A2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GXKR11A2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=pJrTNcoRbn9q1Z9/5850fdF2FlHyhjmq8x+79l1Teno=; b=GXKR11A2ekVJENGY
	l56xfuAIHykC7/qj44/vIUA0DiEiYa6YikvpCMPC/VHRdYhvpgeQQoviR/8DLUHiPbDSjsX/8xo+4
	TuToQQv6/xWn4RCmYypbEgkIr8h0Z0tLmFTqGsxi1jpvtn0M5HYI6+ReVQTEC2IZLVO+/BEHL2JL1
	TugaqeBxgyFQhimYb7OUFM0Gt4XLgE047GLQ9t+oY5FW9BnGRUI6U+gIX2gWPT+VRvaaRRaVtcBKw
	s7efTlLq/+4hdbpwwY67YvbHzzXi0Gz9cJWlhM3osOpREeaYxj+2z4QhrvJrILyKBZKwv/HXRwpTS
	5OEjGM+wSPiB94Ei6Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1taPVH-00BP3y-2t;
	Wed, 22 Jan 2025 01:25:59 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] tty/ldsem: Remove unused ldsem_down_write_trylock
Date: Wed, 22 Jan 2025 01:25:59 +0000
Message-ID: <20250122012559.441006-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ldsem_down_write_trylock() was added in 2013 by
commit 4898e640caf0 ("tty: Add timed, writer-prioritized rw semaphore")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/tty/tty_ldsem.c   | 17 -----------------
 include/linux/tty_ldisc.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 3be428c16260..4e18031a5ca3 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -366,23 +366,6 @@ int __sched ldsem_down_write(struct ld_semaphore *sem, long timeout)
 	return __ldsem_down_write_nested(sem, 0, timeout);
 }
 
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-int ldsem_down_write_trylock(struct ld_semaphore *sem)
-{
-	long count = atomic_long_read(&sem->count);
-
-	while ((count & LDSEM_ACTIVE_MASK) == 0) {
-		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_WRITE_BIAS)) {
-			rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
-			lock_acquired(&sem->dep_map, _RET_IP_);
-			return 1;
-		}
-	}
-	return 0;
-}
-
 /*
  * release a read lock
  */
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index af01e89074b2..c5cccc3fc1e8 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -39,7 +39,6 @@ do {								\
 int ldsem_down_read(struct ld_semaphore *sem, long timeout);
 int ldsem_down_read_trylock(struct ld_semaphore *sem);
 int ldsem_down_write(struct ld_semaphore *sem, long timeout);
-int ldsem_down_write_trylock(struct ld_semaphore *sem);
 void ldsem_up_read(struct ld_semaphore *sem);
 void ldsem_up_write(struct ld_semaphore *sem);
 
-- 
2.48.1

