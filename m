Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2B442393;
	Fri,  4 Sep 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514699; cv=none; b=NSzZ0HP7v9YvqHMGLESjfmFO3+4zEr6mo6MT84iOg6y0K8qGGU81rkkxuBQ942EB35t+j1r1vPRvu+WyxrBFjYBJxVeRrPzbqCHcv7HqH1a03TmpDzCUu9U95tEU64SbmuLDB8LaxA+T9RGRj5bzyaUmLbMlD0nPljEvUKrUcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514699; c=relaxed/simple;
	bh=M/rqZnW0Aj+mun6UPSvz5lbv6fydtqZDPNVJKad1C3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbRGd4cKKXg6P8yGFBbirAI5oCz31nbQbe6k84O6b2VltfH63fRL2mILteItHgV/7GYkBl9Ft/lzQvCUvUitkce3fBnVMRAZFTDGSk2O4e1C1zMod5eEyFSZRS30Cq2R77DYpcms603ycgm2PJM0JWUZxNreSm+hsS/MTvX47M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RU84nqOB; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=yLvnaCvx; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RU84nqOB";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="yLvnaCvx"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514676; bh=pq5PPVVOvt/eLwlTPFKwC3x
	UFnDaXiY3OXuMlaGkD7E=; b=RU84nqOBZoFI2AjC4PSH3QxYRSw9SFEgUCo6mSrvM/dRxjs/e7
	tNUKkq8R/lOaOHNgYrM9azVQaMIT5bYvVZqFE8J85FmxtwuJSRX3cL7t8mR8NvRgXH2S+gzaRAw
	xad+vmPitTMgbVc2hpfoYCG3Zur8AsLYDuK3D9y9OChvYqewzqXjVoqfWzsUKHJJ+5ytkTSw0qf
	4KOYDj5LdHW9/nyyiCCMn8XL6hfg/QxN/Kt2kK4H6mosgTwJaUZFJufZ2AB9gTwqfXieGO2plqY
	gxmpObXyRUAY0EchVtYLwzqVBdsGt6NZGytbFaztrbAs5rb48WAGk4yo7K0kbc1aB5Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514676; bh=pq5PPVVOvt/eLwlTPFKwC3x
	UFnDaXiY3OXuMlaGkD7E=; b=yLvnaCvxb8bC4Gbmiw6kjm8ARQjoVGKbupaWOFy6jZyHJu6QjQ
	pyBnOlgDWPyhp6dFM454qXUp9hFNscb7ihDw==;
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
Subject: [PATCH v2 1/5] media: ivtv: convert to kthread_run_worker
Date: Fri,  4 Sep 2026 09:37:53 +0000
Message-ID: <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org>
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

Convert ivtv to use kthread_run_worker() instead of the deprecated
kthread_run(kthread_worker_fn) pattern. The new API sets worker->task
before the worker starts.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c | 14 ++++++--------
 drivers/media/pci/ivtv/ivtv-driver.h |  3 +--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index b9ea56ec9593..6f0e0e46deb5 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -703,15 +703,13 @@ static int ivtv_init_struct1(struct ivtv *itv)
 	spin_lock_init(&itv->lock);
 	spin_lock_init(&itv->dma_reg_lock);
 
-	kthread_init_worker(&itv->irq_worker);
-	itv->irq_worker_task = kthread_run(kthread_worker_fn, &itv->irq_worker,
-					   "%s", itv->v4l2_dev.name);
-	if (IS_ERR(itv->irq_worker_task)) {
+	itv->irq_worker = kthread_run_worker(0, "%s", itv->v4l2_dev.name);
+	if (IS_ERR(itv->irq_worker)) {
 		IVTV_ERR("Could not create ivtv task\n");
 		return -1;
 	}
 	/* must use the FIFO scheduler as it is realtime sensitive */
-	sched_set_fifo(itv->irq_worker_task);
+	sched_set_fifo(itv->irq_worker->task);
 
 	kthread_init_work(&itv->irq_work, ivtv_irq_work_handler);
 
@@ -1232,7 +1230,7 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 	v4l2_ctrl_handler_free(&itv->cxhdl.hdl);
 	exit_ivtv_i2c(itv);
 free_worker:
-	kthread_stop(itv->irq_worker_task);
+	kthread_destroy_worker(itv->irq_worker);
 err:
 	if (retval == 0)
 		retval = -ENODEV;
@@ -1372,8 +1370,8 @@ static void ivtv_remove(struct pci_dev *pdev)
 	timer_shutdown_sync(&itv->dma_timer);
 
 	/* Kill irq worker */
-	kthread_flush_worker(&itv->irq_worker);
-	kthread_stop(itv->irq_worker_task);
+	kthread_flush_worker(itv->irq_worker);
+	kthread_destroy_worker(itv->irq_worker);
 
 	ivtv_streams_cleanup(itv);
 	ivtv_udma_free(itv);
diff --git a/drivers/media/pci/ivtv/ivtv-driver.h b/drivers/media/pci/ivtv/ivtv-driver.h
index 000e8beecc7c..091bc44f13bc 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.h
+++ b/drivers/media/pci/ivtv/ivtv-driver.h
@@ -668,8 +668,7 @@ struct ivtv {
 	/* Interrupts & DMA */
 	u32 irqmask;                    /* active interrupts */
 	u32 irq_rr_idx;                 /* round-robin stream index */
-	struct kthread_worker irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
-	struct task_struct *irq_worker_task;		/* task for irq_worker */
+	struct kthread_worker *irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
 	struct kthread_work irq_work;	/* kthread work entry */
 	spinlock_t dma_reg_lock;        /* lock access to DMA engine registers */
 	int cur_dma_stream;		/* index of current stream doing DMA (-1 if none) */
-- 
2.47.3

