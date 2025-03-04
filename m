Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3ED205AA1
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080388; cv=none; b=jyO7YfmN6qh0XA7clowFH38iqg01G00SvRQVnJRoUbVXvANmkcEUO349MnZJyUgy4uUAVVBVq6hjhFIA4LhtuDX8FZiJuGkEtqa2//nwI3b8ra3xdq/d6Lp4zdqWiI5hG0Kfbzc4LrbhhLcnzsyXReayhUOiC/jfOWL0SjS2k6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080388; c=relaxed/simple;
	bh=AA8LaiOOwcSbUCgOuJPxceK60VVmqz78yjgxOe6a/xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJXV9dEc9Qmmo+hyHaQVGEhPYu/VUSIs5vfZGpoYebmtRyEsJpOpVGiFNGr9xhD845hKyAyQDK+GQbdMc+CogBwNobIhcfFEW8rrg8y9wAA57m1X1fwkVD08mTkQXJ00Cmbvz71/YqzwIviZwqgqDljgMej6XTX3LnwAVDHjXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRxEYeg5; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRxEYeg5"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abf46dba035so324430466b.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080385; x=1741685185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCbQJguuxExNh/1WWVSwShtOCrr3VVCLOHRvUq00gbI=;
        b=pRxEYeg5vrHpLCDBpOE0i+wuYu/dn7VBcKXnRbZukPD2yuJLjnJYnWDJ1CLrXXyaf1
         hRl11uPydj7ZzkQGtA2h90bC7hhtR50ycdN33xvVZinMqspVPyA5oOmYKBI0frTU1A9x
         ghqanVRy4DmUnsSOQ/cSEY/7Bpg+l/Ks1vQJbLpOcgiwjYAwGBvkefG0wGP4WpFJn1Cu
         xwqyQAA3stIpf7VJXPsNHGJlVpK20kZRrqpPUMgLtgR4+b8wTpv7ayyIaPw9bLzGhcAx
         SxDjEyl+J7oL3ZeOj3I2JmLeb2XtsIOU9V+a1JX8bwhpiZm1qOtIRKvHD5KuTucYggY5
         lMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080385; x=1741685185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCbQJguuxExNh/1WWVSwShtOCrr3VVCLOHRvUq00gbI=;
        b=F5Juqscm1VadSPKQ6Az3Y9w54+jO16WC8FbguvxV+so1DKwwNaxcJwjEaWc/od55zV
         Zrmrf60WKyMvFOZLfyF9x9u74qlBW357qvRg3rbKVWqxJYQNKBrH4XsHy+bFJojVdbCP
         hlmFv/365QiM+9JmWAWLOb54QYSf3ZPd5w1fO8kiJ/Yflmp5E/tfBq7NQ63chmc4E52Y
         ol9H6LNpqjrveIUI1B25YYDHXckErkN/+Mt+LUT6GMRJ2bE6YVLPdhhyAaE61Ksax9hP
         9owS6wCad7LiHlX728HQ0Ev6cSorE63xN1hEJbWDA+abxfVJ5Ls0PKINMeKyNkbrHD6G
         bRpg==
X-Forwarded-Encrypted: i=1; AJvYcCURH16OffqU5/N135/OtYLI6mGBC+T6PdyNGjk4P427M+1TC4g9yHPHqPN9Fs57SS3jnT+hjucKVUtV6z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7IONKri8HCUI8shatRF2taQbVILXbGJw44m5ZmAB83W+6zxvv
	5YHrv7OC5r4Erlo9aY+w16ZKkBcbqNtzuI84GUmM3LUhT8I6eKCg3Djrql+91CqvY6E/UacdVQ=
	=
X-Google-Smtp-Source: AGHT+IElsv0b6BPDqEe7C+Jsk5RB6FSq2PE2ahKujenY2V0Uy7jmG9RZfhrNhYmr9XWSjfqUNV8ETxzUug==
X-Received: from ejcwb15.prod.google.com ([2002:a17:907:d50f:b0:abf:740d:69f5])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1b26:b0:abb:c647:a4bf
 with SMTP id a640c23a62f3a-abf25faa163mr1968124666b.23.1741080385011; Tue, 04
 Mar 2025 01:26:25 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:27 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-29-elver@google.com>
Subject: [PATCH v2 28/34] stackdepot: Enable capability analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable capability analysis for stackdepot.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove disable/enable_capability_analysis() around headers.
---
 lib/Makefile     |  1 +
 lib/stackdepot.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 1dbb59175eb0..f40ba93c9a94 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -270,6 +270,7 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
 CFLAGS_stackdepot.o += -fno-builtin
+CAPABILITY_ANALYSIS_stackdepot.o := y
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
 # In particular, instrumenting stackdepot.c with KMSAN will result in infinite
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 245d5b416699..a8b6a49c9058 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -61,18 +61,18 @@ static unsigned int stack_bucket_number_order;
 /* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
 
+/* The lock must be held when performing pool or freelist modifications. */
+static DEFINE_RAW_SPINLOCK(pool_lock);
 /* Array of memory regions that store stack records. */
-static void *stack_pools[DEPOT_MAX_POOLS];
+static void *stack_pools[DEPOT_MAX_POOLS] __guarded_by(&pool_lock);
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
 /* Offset to the unused space in the currently used pool. */
-static size_t pool_offset = DEPOT_POOL_SIZE;
+static size_t pool_offset __guarded_by(&pool_lock) = DEPOT_POOL_SIZE;
 /* Freelist of stack records within stack_pools. */
-static LIST_HEAD(free_stacks);
-/* The lock must be held when performing pool or freelist modifications. */
-static DEFINE_RAW_SPINLOCK(pool_lock);
+static __guarded_by(&pool_lock) LIST_HEAD(free_stacks);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
@@ -242,6 +242,7 @@ EXPORT_SYMBOL_GPL(stack_depot_init);
  * Initializes new stack pool, and updates the list of pools.
  */
 static bool depot_init_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
 
@@ -289,6 +290,7 @@ static bool depot_init_pool(void **prealloc)
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
 
@@ -308,6 +310,7 @@ static void depot_keep_new_pool(void **prealloc)
  * the current pre-allocation.
  */
 static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
 	void *current_pool;
@@ -342,6 +345,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 
 /* Try to find next free usable entry from the freelist. */
 static struct stack_record *depot_pop_free(void)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
 
@@ -379,6 +383,7 @@ static inline size_t depot_stack_record_size(struct stack_record *s, unsigned in
 /* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
 depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash, depot_flags_t flags, void **prealloc)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack = NULL;
 	size_t record_size;
@@ -437,6 +442,7 @@ depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash, dep
 }
 
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
+	__must_not_hold(&pool_lock)
 {
 	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
@@ -453,7 +459,8 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 		return NULL;
 	}
 
-	pool = stack_pools[pool_index];
+	/* @pool_index either valid, or user passed in corrupted value. */
+	pool = capability_unsafe(stack_pools[pool_index]);
 	if (WARN_ON(!pool))
 		return NULL;
 
@@ -466,6 +473,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 
 /* Links stack into the freelist. */
 static void depot_free_stack(struct stack_record *stack)
+	__must_not_hold(&pool_lock)
 {
 	unsigned long flags;
 
-- 
2.48.1.711.g2feabab25a-goog

