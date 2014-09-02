From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 13/26] locking: Add non-fatal spin lock assert
Date: Tue,  2 Sep 2014 17:39:22 -0400
Message-ID: <1409693975-1028-14-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:39499 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755275AbaIBWMp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 18:12:45 -0400
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

Provide method for non-essential or non-critical code to warn of
invariant errors.

CC: Ingo Molnar <mingo@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/spinlock.h         | 1 +
 include/linux/spinlock_api_smp.h | 1 +
 include/linux/spinlock_api_up.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3f2867f..8a9aaf1 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -394,6 +394,7 @@ static inline int spin_can_lock(spinlock_t *lock)
 }
 
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
+#define warn_not_spin_locked(lock)	warn_not_raw_spin_locked(&(lock)->rlock)
 
 /*
  * Pull the atomic_t declaration:
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 42dfab8..0ddd499 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -18,6 +18,7 @@
 int in_lock_functions(unsigned long addr);
 
 #define assert_raw_spin_locked(x)	BUG_ON(!raw_spin_is_locked(x))
+#define warn_not_raw_spin_locked(x)	WARN_ON_ONCE(!raw_spin_is_locked(x))
 
 void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index d0d1888..f890f12 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -17,6 +17,7 @@
 #define in_lock_functions(ADDR)		0
 
 #define assert_raw_spin_locked(lock)	do { (void)(lock); } while (0)
+#define warn_not_raw_spin_locked(lock)	do { (void)(lock); } while (0)
 
 /*
  * In the UP-nondebug case there's no real locking going on, so the
-- 
2.1.0

