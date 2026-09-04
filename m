Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41746F482;
	Fri,  4 Sep 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518667; cv=none; b=V3SZRolSX1BZI4WmKeUV/vxKGJnyqJyASv1RI85Q989ag5P49thlqXZLgKTIvDN7kbcvZXbP+mInS+ha4xa1OIf8Cx1WgqGJTF+uTQcY5R4DILn5ZtjmIw0+KNkPWJxlUL5cHSGjYrjy/wZ3KjXuNUQYRwPSlBvsBWeiI+/1Hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518667; c=relaxed/simple;
	bh=G14Lzq9Qi4XCUCFm9XXWnTnB0IkpsPFg4lGADGENDdg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tvXG/ZVmmyl17Dk0NnJBUcWIyDmrSSi49daSxtFXzoDs+Yn3DKReUPLR4jBB1XKNoV9KjFF4r3FXS1/daPVIVjmk4V1sI+vYaCUZDpTIUZo/iOzIX2qv1VyoNo/Ju4ymaXvpskXCOhfxpB96W3PTjzIA+KSvTjam2YswC+Nsoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ECozwkZQ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=IwlJtkKb; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ECozwkZQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="IwlJtkKb"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788518657; bh=EWZuWsUgu2bHHcuM8B3QShe
	KsetrSgEqm+sSAvJNm0k=; b=ECozwkZQlQGujmRR9gTwe66RlxGYaiBpnvIiKQroyYcntppArZ
	3cgx9vb2d3P4ZPd79Ss5FKZHRt1uak84voQUmzg5dkm7KCopByzDA+E4wttEVlCIekaAmcz2sl1
	6Qo6hL0czxoahiIzvt4Wse1t7BlXlFKYYxpU5iwWRq47hXZxMt7qydzpQGGWHTHomJTzUSXXfjI
	HyPrJ13oujlrpXMNUTrAq8aqpTHpC/mRivyGUzCrbh6E5ELtUEkf85M4r5rbQtlXFtnVQhxP0zv
	hEBEauQXd7pmsAIQaV9iWpgEsN0dpAIhax4vHsuoyS+09zmkJ8TMZuBsE7Lv03qIEJA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788518657; bh=EWZuWsUgu2bHHcuM8B3QShe
	KsetrSgEqm+sSAvJNm0k=; b=IwlJtkKbGBYqsKfo6D+oT2L5+G+JOE+2uHj6JoD+/VJ5af1Uyx
	ra8GeqJ9Ne3pM6jcAnZM7qednjLK3ObpZYCA==;
Date: Fri, 04 Sep 2026 11:44:17 +0100
From: Bradley Morgan <brads@mainlining.org>
To: linux-kernel@vger.kernel.org
CC: Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] media: ivtv: convert to kthread_run_worker
In-Reply-To: <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org> <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org>
Message-ID: <6D89FAFC-72C0-4838-A086-C9C9CB46D264@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 10:37:53 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>Convert ivtv to use kthread_run_worker() instead of the deprecated
>kthread_run(kthread_worker_fn) pattern. The new API sets worker->task
>before the worker starts.

This doesn't compile, I'm aware. Fixing in V3, everything else should
compile.

Received a off list mail from the CI.


>
>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>---
> drivers/media/pci/ivtv/ivtv-driver.c | 14 ++++++--------
> drivers/media/pci/ivtv/ivtv-driver.h |  3 +--
> 2 files changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
>index b9ea56ec9593..6f0e0e46deb5 100644
>--- a/drivers/media/pci/ivtv/ivtv-driver.c
>+++ b/drivers/media/pci/ivtv/ivtv-driver.c
>@@ -703,15 +703,13 @@ static int ivtv_init_struct1(struct ivtv *itv)
> 	spin_lock_init(&itv->lock);
> 	spin_lock_init(&itv->dma_reg_lock);
> 
>-	kthread_init_worker(&itv->irq_worker);
>-	itv->irq_worker_task = kthread_run(kthread_worker_fn, &itv->irq_worker,
>-					   "%s", itv->v4l2_dev.name);
>-	if (IS_ERR(itv->irq_worker_task)) {
>+	itv->irq_worker = kthread_run_worker(0, "%s", itv->v4l2_dev.name);
>+	if (IS_ERR(itv->irq_worker)) {
> 		IVTV_ERR("Could not create ivtv task\n");
> 		return -1;
> 	}
> 	/* must use the FIFO scheduler as it is realtime sensitive */
>-	sched_set_fifo(itv->irq_worker_task);
>+	sched_set_fifo(itv->irq_worker->task);
> 
> 	kthread_init_work(&itv->irq_work, ivtv_irq_work_handler);
> 
>@@ -1232,7 +1230,7 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
> 	v4l2_ctrl_handler_free(&itv->cxhdl.hdl);
> 	exit_ivtv_i2c(itv);
> free_worker:
>-	kthread_stop(itv->irq_worker_task);
>+	kthread_destroy_worker(itv->irq_worker);
> err:
> 	if (retval == 0)
> 		retval = -ENODEV;
>@@ -1372,8 +1370,8 @@ static void ivtv_remove(struct pci_dev *pdev)
> 	timer_shutdown_sync(&itv->dma_timer);
> 
> 	/* Kill irq worker */
>-	kthread_flush_worker(&itv->irq_worker);
>-	kthread_stop(itv->irq_worker_task);
>+	kthread_flush_worker(itv->irq_worker);
>+	kthread_destroy_worker(itv->irq_worker);
> 
> 	ivtv_streams_cleanup(itv);
> 	ivtv_udma_free(itv);
>diff --git a/drivers/media/pci/ivtv/ivtv-driver.h b/drivers/media/pci/ivtv/ivtv-driver.h
>index 000e8beecc7c..091bc44f13bc 100644
>--- a/drivers/media/pci/ivtv/ivtv-driver.h
>+++ b/drivers/media/pci/ivtv/ivtv-driver.h
>@@ -668,8 +668,7 @@ struct ivtv {
> 	/* Interrupts & DMA */
> 	u32 irqmask;                    /* active interrupts */
> 	u32 irq_rr_idx;                 /* round-robin stream index */
>-	struct kthread_worker irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
>-	struct task_struct *irq_worker_task;		/* task for irq_worker */
>+	struct kthread_worker *irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
> 	struct kthread_work irq_work;	/* kthread work entry */
> 	spinlock_t dma_reg_lock;        /* lock access to DMA engine registers */
> 	int cur_dma_stream;		/* index of current stream doing DMA (-1 if none) */
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
