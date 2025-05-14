Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C81FBC90
	for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244145; cv=none; b=YC7e32Drc+0MUR+yl8POEKqsvC6MXJmtkwC2vVcxkf6iXC5KUh5TarTrhKbxQWHuyOpm+ppG5fBa4Hbgd1BE68Q0YpoTj72dDX+DiPapp9kMBrMDLBRufLrzNlRDI82mMjw0rCzOruC2/0UV8VsJOhTwDwNDl++C5c16rUkINPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244145; c=relaxed/simple;
	bh=kzABunREDJmtd/nP/sCAoucrTGKicQVBYeEg5n15jgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPL5gOqxXrpUZ6AqTezH6mufSW95EHPGsBxZsIiVWD0LgNMPc3aDBAtU/q0PJgRnKOcNB+ySP2R8TrrXOj+AoXYGMmn1IoKEaJsLOTprNL5toqpgU1AGUy+9lkSOj63q4u2S+Szd/XbhL6eNcuWqu7x3hUurXNk1yffTN6BgKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=MCXyFAy2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="MCXyFAy2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so16865f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1747244141; x=1747848941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcE6NZPhXmy7A6UI0uxhhVHQX35b+iTI+bG4I889t7w=;
        b=MCXyFAy25xRblYEL6PmWyNb/BrJwxhbSQM2ZnHGve9kkyJeilC8tWfvrcJc08rLaaj
         csIU2rRlT4QFal6kjsBLUy2MskOAEiFMXT5Tan7XMWmb9p04yxyKx5EUFXetL18/4b3j
         VwmBJa+MsGnr0qKz8PZLMXpTzdaKBye4+1mBFBIN1kbYnpgmnD7j7WCOj5hB8/HHx4lU
         ylFxHLAftPBAzwgGz9C8J7L8yYXbIxuQ47dti9QLExeD6xIq5KlUz9Zn2Q9h0u2hB7h/
         5d33tUZZ1xmW3zlE2KI8aDvJq3EgKtsXvK17REGoJF+NKn2SfZbZU9pqZu6V6XGUHALE
         VotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244141; x=1747848941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcE6NZPhXmy7A6UI0uxhhVHQX35b+iTI+bG4I889t7w=;
        b=MLZQQIuCesuRc+J0XchZ/CPLlrf+1nxjiMfYcKV3D9J0/hcWVth6zOTbnVyRx1nGvT
         MQWaNrOT3n26gQ+4FGcbjA5rt5XYDJWi634Ra0mZLYjrACZWhCfGjDMmqZwFF2KMuwfD
         YFS9SAUX4vl45JqRAKixs2pCG4sIowboZ6dt5ICbJzczc5XoxmlNEpvhpkUdicQH4H0K
         DVYi0ktWm7cdCSsbDDKzYjIC36y1lqcpl5P/NMTrul/Xc0FHsviY0WjbfjSnxJcEQnCb
         UUJ8xFeCbCuHgXqRcoVos3Wl9fo0zp1GZpyqy2A/yXdJZXVnhot5DUHlCXaAQU3LZVOp
         RZIg==
X-Gm-Message-State: AOJu0YwRZ/hW2A9jsaBD9c/nQ1rVtsFlWGO0ygQfn106oRviyxoxg4cc
	J1us1PWsZBcn1GsrWGPb0b5AAcYeYoLz15PCkOuDnlgKDhsx9gW48mbdIgOMlKI=
X-Gm-Gg: ASbGnctMV4TPlxGZQ2dLCIhCHmdCsO8ojM9w8njNFGImRUlogavzR1I2+xUJMHQ+Usp
	iAHwJQubbo2GfYlKQipbjnm86nqEXrmYidA4PbQ1TfRt0DFcNU06xpCPpZ9nl3eI0fdAKoqWxbN
	8+ZPlcRKlZXh8pmoHN8Q7n9kowCII961KnjIFXJH5/dShX+m0X4c4lJKy/Sxt+ODzpdyzH28cz/
	9l7VtIunsnSSK/dbXD+cvMrEelKi3/N1lQv33t28uI1/7DhCwZxWDpwho4Z26t/GTnEg2zXkskZ
	DkoDMNpwR1PDhDJChNnA13yIRoPxXkaaTsEfHkdRQ/5HNx/qLi971VkwfB+KEV9DkWvhrnA/CCo
	+0iY6MAFztpG0Lu9HAssK9+szfO86jt+ntpeVfy+X4PnZQgTDeQ4vWBp1ZWNL/rKblmiy
X-Google-Smtp-Source: AGHT+IECska80s3N2h/DvBdblRLCMTQyl4wndv/Pi4IC0be3S9Z97xavleNh/Vqxz0ygaS4KYPbqPg==
X-Received: by 2002:a05:6000:184b:b0:3a0:880a:144f with SMTP id ffacd0b85a97d-3a349695517mr4306806f8f.6.1747244141353;
        Wed, 14 May 2025 10:35:41 -0700 (PDT)
Received: from ubuntu-dell-xps.thegp.cloud (shef-16-b2-v4wan-169484-cust3641.vm3.cable.virginm.net. [92.236.206.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a79sm20058436f8f.48.2025.05.14.10.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:35:40 -0700 (PDT)
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org
Cc: linux-serial@vger.kernel.org,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: [PATCH RFC 1/3] printk: Don't flush messages using write_atomic during console registration if kthreads have not been started yet.
Date: Wed, 14 May 2025 18:35:12 +0100
Message-ID: <20250514173514.2117832-2-mcobb@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-Off-By: Michael Cobb <mcobb@thegoodpenguin.co.uk>
---
 kernel/printk/internal.h | 4 +++-
 kernel/printk/nbcon.c    | 2 ++
 kernel/printk/printk.c   | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309d..e31ecb2fc81c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -64,6 +64,7 @@ struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
 extern bool printk_kthreads_running;
+extern bool printk_kthreads_pending_start;
 extern bool debug_non_panic_cpus;
 
 __printf(4, 0)
@@ -180,6 +181,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 #define PRINTKRB_RECORD_MAX	0
 
 #define printk_kthreads_running (false)
+#define printk_kthreads_pending_start (false)
 
 /*
  * In !PRINTK builds we still export console_sem
@@ -240,7 +242,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
 		if (have_nbcon_console && !have_boot_console) {
-			if (printk_kthreads_running)
+			if (printk_kthreads_running || printk_kthreads_pending_start)
 				ft->nbcon_offload = true;
 			else
 				ft->nbcon_atomic = true;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aed..adb53de5c2f2 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1707,6 +1707,8 @@ bool nbcon_alloc(struct console *con)
 				con->pbufs = NULL;
 				return false;
 			}
+		} else {
+			printk_kthreads_pending_start = true;
 		}
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648e..c71bf5c228f2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -501,6 +501,8 @@ static bool syslog_time;
 /* True when _all_ printer threads are available for printing. */
 bool printk_kthreads_running;
 
+bool printk_kthreads_pending_start = false;
+
 struct latched_seq {
 	seqcount_latch_t	latch;
 	u64			val[2];
@@ -3758,6 +3760,7 @@ static void printk_kthreads_check_locked(void)
 			unregister_console_locked(con);
 	}
 
+	printk_kthreads_pending_start = false;
 	printk_kthreads_running = true;
 }
 
-- 
2.45.2

