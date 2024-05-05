Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422965CAC
	for <linux-serial@vger.kernel.org>; Sun,  5 May 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714896260; cv=none; b=FJuOcfmOON+a76dTDCMdtO+TpT/JLiMJXaa14E9+lsWWD4URUBBiM2+z1U1GYq4arRyQPyhHNH9/7dnaILdox9gYIflf7DY10aHW+aZ9pDzrTL8YuGZg6prWImYujZM6aPU2lANJi3+ujtk6zaXX63lV1HAgZ0iTHhVt7UPmvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714896260; c=relaxed/simple;
	bh=DE3O+6aSAqPE1MrCm+1zLDbZ4sdGsvibhhmEf+RvYoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpDOEbAKVYkJpANWsxzDV83f3TIzoRbyVqDUKciAk3jes1k3VG2C5J7d5tH5hiSqNr1nTF7ggY7IQzf7FR8lnbF+lf31ntapxc9TxPcpukhv5vQw/LjSr1e/wio8IPzwuvriwiFc1QZwRI/dE6OcRTuTFl3j2IK/mDzAeyCR0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=bo4uCXlj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="bo4uCXlj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so6891225e9.2
        for <linux-serial@vger.kernel.org>; Sun, 05 May 2024 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1714896256; x=1715501056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7o3BmmVfC/sdIYcG0T60cpIrJuIdHYu3AhI1jZq65E=;
        b=bo4uCXljRt+euBsOtZ61Z7SBDz3rJa/+X5SUZ4cG6qK7XCgorNeIDMOkxHfb8opadL
         7N/MZauQN2DF84usX0f9PFHgy0yoMyRJBOaeS1RNn4jbbTwqdBwd3iW7GstIH8fotUIk
         yzp9+PaiUd/NUKAyh1fBSOUfPQAHJ7Uf2sdXr0d+OqpEDuxnQtHTRbtuW2oXYNdTBxij
         WzSbC8kIbs+PlbH18jE8Gf/ErGQEb4Sb/4vHJ8Ll/BSen1mW5iG4xjQZlw+7u9rfN30k
         yA0b2XlRC8OWjBAFq8C3+Rg/tIqKpHmy09vH7p/rQWPYyxaK4LPE7BI4aFzVxuVqnv1g
         7Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714896256; x=1715501056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7o3BmmVfC/sdIYcG0T60cpIrJuIdHYu3AhI1jZq65E=;
        b=G3AjP3z2vow3sza40jT/ebriKJRa7RVDsFhaAb06HIO9bKtD+V8d16x+lNOepttb83
         yI+O/2YrYOvQfBnNc89x/MsfnzigCfTFvu3XGVbx4edWO5B94in7ZquNvGEWA6ST1pkH
         rkY8CBRWWox3B1vh1c4BdrywlkR7mOJ0I0d62Ewx4NtRZ9p0eTDp9kAFXXFePjqsaI0Q
         sB37RaHwUslqorZzWMVueOtEdg+Doj/dae6uf2P+meNHorn0PLddUVjrmPpLqG6HfMLj
         AiDr7DeTHmSBjo1H79ZwoDMLolVHe+aFVEmHYo4svjn/q6nOJaVd7zOwI9ccAURZ40ds
         huTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjITYE76+B0rgoHjAeeulV6HjLwZs9xrqm57KazfkMzR3eAnL1/3n5lBLbvHqG2sujRW2UtQ/AdSmwq8iRjN30z8HUnXUjyArPtHna
X-Gm-Message-State: AOJu0YympFgJgzYY2VeMHhsiYkVzhbK+kg+iIpYNCrh/j+l1DrpTyBIh
	/L1S7yGo5koe66uHGJv+v/zqgKeYQ3CMlHfHMTRhrRYWKaDgpMyuo01TZqc0VHg=
X-Google-Smtp-Source: AGHT+IGaMUzSwGNxOEDo4BmFXoH3bc0KpI2QztF++hIPoIHqz/JaOrisVmhmMg4N095xkstKkWR5vA==
X-Received: by 2002:a05:600c:358a:b0:41e:454b:2f7 with SMTP id p10-20020a05600c358a00b0041e454b02f7mr3495761wmq.23.1714896256246;
        Sun, 05 May 2024 01:04:16 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm4705295wrh.10.2024.05.05.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 01:04:15 -0700 (PDT)
From: yoann.congal@smile.fr
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH RESEND v6 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Date: Sun,  5 May 2024 10:03:42 +0200
Message-Id: <20240505080343.1471198-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240505080343.1471198-1-yoann.congal@smile.fr>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yoann Congal <yoann.congal@smile.fr>

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.

So, change its type to bool and adapt all usages:
CONFIG_BASE_SMALL == 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
CONFIG_BASE_SMALL != 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 arch/x86/include/asm/mpspec.h | 6 +++---
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 4 ++--
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 6 ++----
 kernel/futex/core.c           | 2 +-
 kernel/user.c                 | 2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338d..c01d3105840cf 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -15,10 +15,10 @@ extern int pic_mode;
  * Summit or generic (i.e. installer) kernels need lots of bus entries.
  * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
  */
-#if CONFIG_BASE_SMALL == 0
-# define MAX_MP_BUSSES		260
-#else
+#ifdef CONFIG_BASE_SMALL
 # define MAX_MP_BUSSES		32
+#else
+# define MAX_MP_BUSSES		260
 #endif
 
 #define MAX_IRQ_SOURCES		256
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 67e2cb7c96eec..da33c6c4691c0 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -51,7 +51,7 @@
 #include <asm/unaligned.h>
 
 #define HEADER_SIZE	4u
-#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
+#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
 
 /*
  * Our minor space:
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f18..1674a471b0b4c 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -25,13 +25,13 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_SMALL) ? 0x1000 : 0x8000)
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
  * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
-#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
+#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_SMALL) ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
 
 /*
diff --git a/include/linux/udp.h b/include/linux/udp.h
index d04188714dca1..b456417fb4515 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -24,7 +24,7 @@ static inline struct udphdr *udp_hdr(const struct sk_buff *skb)
 }
 
 #define UDP_HTABLE_SIZE_MIN_PERNET	128
-#define UDP_HTABLE_SIZE_MIN		(CONFIG_BASE_SMALL ? 128 : 256)
+#define UDP_HTABLE_SIZE_MIN		(IS_ENABLED(CONFIG_BASE_SMALL) ? 128 : 256)
 #define UDP_HTABLE_SIZE_MAX		65536
 
 static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b16..3f81ee5f9fb9c 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1141,7 +1141,7 @@ static inline void xa_release(struct xarray *xa, unsigned long index)
  * doubled the number of slots per node, we'd get only 3 nodes per 4kB page.
  */
 #ifndef XA_CHUNK_SHIFT
-#define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
+#define XA_CHUNK_SHIFT		(IS_ENABLED(CONFIG_BASE_SMALL) ? 4 : 6)
 #endif
 #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
 #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index ad4b6f778d2bd..182f2671a49dd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -743,7 +743,7 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 0 if BASE_SMALL != 0
+	default 0 if BASE_SMALL
 	default 12
 	depends on PRINTK
 	help
@@ -1950,9 +1950,7 @@ config RT_MUTEXES
 	default y if PREEMPT_RT
 
 config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
+	def_bool !BASE_FULL
 
 config MODULE_SIG_FORMAT
 	def_bool n
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1e78ef24321e8..06a1f091be81d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1150,7 +1150,7 @@ static int __init futex_init(void)
 	unsigned int futex_shift;
 	unsigned long i;
 
-#if CONFIG_BASE_SMALL
+#ifdef CONFIG_BASE_SMALL
 	futex_hashsize = 16;
 #else
 	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
diff --git a/kernel/user.c b/kernel/user.c
index 03cedc366dc9e..aa1162deafe49 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
  * when changing user ID's (ie setuid() and friends).
  */
 
-#define UIDHASH_BITS	(CONFIG_BASE_SMALL ? 3 : 7)
+#define UIDHASH_BITS	(IS_ENABLED(CONFIG_BASE_SMALL) ? 3 : 7)
 #define UIDHASH_SZ	(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-- 
2.39.2

