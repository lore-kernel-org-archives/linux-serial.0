Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69004448382;
	Fri,  4 Sep 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514817; cv=none; b=DGchiEWGobiIy5k2g3GzCtDGy9EhMH6L7iBGh7wl5QyMo8kb0No8Z4CR4xRP0IdOf1BWQKBNqUsLEP6w75taMXuctUXDBURGfO6u5FWGWhA4TJX6TWKizMQ7G/W831ESiLy3DN4NJNk6rt3sY1uQuywNr+vTeWgi3IwUYM/PGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514817; c=relaxed/simple;
	bh=KmuLnXF/U44uMa55GVUVP5W7FcFy4MysXP6KDZ38D2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWGXdGmQTzVsqWMeNhIcVNwvII6g7bG3cOaf9FoK4qTfJXhrwY4bprs9RIlTNGLzRCzrID6Fvr3ZxNHIPpGl437QSif6joqCHm6TbNFK9MLvWnadZeiUZHDxIeU9AWK51UwUUQg4F85KxtB+ikG15Go52aDWeiinZHXHQ1y5wSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gTLB1Qep; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=julQ9gfr; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gTLB1Qep";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="julQ9gfr"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514807; bh=3tkVlnpw7+NBfWJJgluik5B
	VtbGX5D0ZhS2q1Ia+1+o=; b=gTLB1QepB9c7bOkEJkkgFHDKZRT/2/Bcvt2hMdrRQMQ4tf3JGZ
	bjsrGFNg1hp2aGhYzcc4Au5RnvvI8aqn86TykhdKWs+T3UFLjp4F/LCkMkD87iwQhQNRGDZqhh/
	E80yyBTwOEKXbSz5nZsNIWixKGXufVva2JTwf8SZbrkipQ1ZMzD5IzuV4NYxFPZ1PQhW7EmGIOT
	IpLbgcHbCNGDhBE14XlNVa1/bYqHpm20Xjp0Tn1LL8vd9Go1ElXvS0iOtH/IgE6EqKoQK8W8hb3
	eByPuUK/SUvgmdOg+fzsiwMjYylNihn6KWsLoRA8z5FHMe2jKEwiY+YQIVE0NfL9BIw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514807; bh=3tkVlnpw7+NBfWJJgluik5B
	VtbGX5D0ZhS2q1Ia+1+o=; b=julQ9gfr+eDtvvHGTorvWHSkvLaFHwz+o0Hbx2sx9DiGx6+PFc
	fHnVpA+pR5ZeZsMDdpA0TS8S5ShV4s5+yrCw==;
From: Bradley Morgan <brads@mainlining.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Walls <awalls@md.metrocast.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bradley Morgan <brads@mainlining.org>,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/5] cpufreq: schedutil: convert to kthread_create_worker
Date: Fri,  4 Sep 2026 09:40:07 +0000
Message-ID: <b6768a4db5451e90e68befc3a9b498f1dfa52b1c.1788513591.git.brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert cpufreq_schedutil to use kthread_create_worker() instead of
the deprecated kthread_run(kthread_worker_fn) pattern. The new API
sets worker->task before the worker starts.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/sched/cpufreq_schedutil.c | 33 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..5023c24d8a21 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -31,8 +31,7 @@ struct sugov_policy {
 	struct			irq_work irq_work;
 	struct			kthread_work work;
 	struct			mutex work_lock;
-	struct			kthread_worker worker;
-	struct task_struct	*thread;
+	struct			kthread_worker *worker;
 	bool			work_in_progress;
 
 	bool			limits_changed;
@@ -586,7 +585,7 @@ static void sugov_irq_work(struct irq_work *irq_work)
 
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
-	kthread_queue_work(&sg_policy->worker, &sg_policy->work);
+	kthread_queue_work(sg_policy->worker, &sg_policy->work);
 }
 
 /************************** sysfs interface ************************/
@@ -669,7 +668,6 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
-	struct task_struct *thread;
 	struct sched_attr attr = {
 		.size		= sizeof(struct sched_attr),
 		.sched_policy	= SCHED_DEADLINE,
@@ -692,32 +690,29 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		return 0;
 
 	kthread_init_work(&sg_policy->work, sugov_work);
-	kthread_init_worker(&sg_policy->worker);
-	thread = kthread_create(kthread_worker_fn, &sg_policy->worker,
-				"sugov:%d",
-				cpumask_first(policy->related_cpus));
-	if (IS_ERR(thread)) {
-		pr_err("failed to create sugov thread: %pe\n", thread);
-		return PTR_ERR(thread);
+	sg_policy->worker = kthread_create_worker(0, "sugov:%d",
+						cpumask_first(policy->related_cpus));
+	if (IS_ERR(sg_policy->worker)) {
+		pr_err("failed to create sugov thread: %pe\n", sg_policy->worker);
+		return PTR_ERR(sg_policy->worker);
 	}
 
-	ret = sched_setattr_nocheck(thread, &attr);
+	ret = sched_setattr_nocheck(sg_policy->worker->task, &attr);
 	if (ret) {
-		kthread_stop(thread);
+		kthread_destroy_worker(sg_policy->worker);
 		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
 		return ret;
 	}
 
-	sg_policy->thread = thread;
 	if (policy->dvfs_possible_from_any_cpu)
-		set_cpus_allowed_ptr(thread, policy->related_cpus);
+		set_cpus_allowed_ptr(sg_policy->worker->task, policy->related_cpus);
 	else
-		kthread_bind_mask(thread, policy->related_cpus);
+		kthread_bind_mask(sg_policy->worker->task, policy->related_cpus);
 
 	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
-	wake_up_process(thread);
+	wake_up_process(sg_policy->worker->task);
 
 	return 0;
 }
@@ -728,8 +723,8 @@ static void sugov_kthread_stop(struct sugov_policy *sg_policy)
 	if (sg_policy->policy->fast_switch_enabled)
 		return;
 
-	kthread_flush_worker(&sg_policy->worker);
-	kthread_stop(sg_policy->thread);
+	kthread_flush_worker(sg_policy->worker);
+	kthread_destroy_worker(sg_policy->worker);
 	mutex_destroy(&sg_policy->work_lock);
 }
 
-- 
2.47.3

