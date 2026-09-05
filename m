Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295563C10A2
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601239; cv=none; b=gFEo7DGpBCI5wIq/in3A0IwcMY8gTxZhGVtOwmcrqFu50QWqFbZg+cHkwdGIddY/NMBMsfewxv+48ro0D2+inIKi6545IMI9G5PO1t7tu0kA8zWvB2kGj3jMc+JxpFGRdSoZMK0AUszO5/qC19F1+R9vUQMRKjv/n5m/G6QOhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601239; c=relaxed/simple;
	bh=0N6smQU99/PNSNl4jr0m4L2IwWsRMRsidZz8lP99S4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGWjyF8duKXvimlSx23QIY4Hkhs7voZ6grjiqZzz19t6Bc5dEspjL1F2tRnK6BbJiKJE76iPNRukC56EJTpfw1M2d1iUJOvhL3NsqRGAHyqoWvORh9pcCs3nSlo420cmD3GxDCYqa16QA0fKRlVyz2Tqsd6d/+oxGP3TtGBDyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a89GNSy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a89GNSy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7E01F00A3F;
	Sat,  5 Sep 2026 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601237;
	bh=JZF4QZxYVWWZjffYvYJTSMUnNk40SSNjGx+fw/GqvsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a89GNSy8DWaCjvv6P4fxskEc9xmUArGmpSxQ1nxJoecyTgtaW52+i124UhUjkMNg4
	 5P+2bIOvngLruav6LHMjKFi6T1WeLlS1rMljBLJHdrnyt4jptALU3FaPyvPKeOiVlj
	 Vc+NJqGrOTLlA9YaHviP4+hTgmWy2uWF39ZdhxsFTNEPRzF/wzqXQlXg1t8zXRZcgy
	 KfK3/fc81z9E0m2ztiFST5q2J8ngtP0kKHqQOtIPK1qqDgXBKGB4+vT80KtQi9DaaJ
	 UccQpmyyyrAA6ADecdcTTSJzE0Z/0TWz/l54uvZPrIDz5YrxRemyQED0GDRxmpzTkk
	 oZ9h9ZghwWCAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] media: ivtv: convert to kthread_run_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: linux-serial@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
 <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:40:37 +0000
Message-Id: <20260905094037.AF7E01F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kthread_queue_work() receives a double pointer instead of a pointe=
r to kthread_worker, leading to a build error or runtime memory corruption.
- [High] kthread_destroy_worker() is called before free_irq(), creating a U=
se-After-Free race condition with the interrupt handler.
--

commit a504d2685cd2f4c4e6b93a81c847d55367eae1c0
Author: Bradley Morgan <brads@mainlining.org>

media: ivtv: convert to kthread_run_worker

Convert ivtv to use kthread_run_worker() instead of the deprecated
kthread_run(kthread_worker_fn) pattern. The new API sets worker->task
before the worker starts.

> diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivt=
v/ivtv-driver.c
> index b9ea56ec9593f..6f0e0e46deb5b 100644
> --- a/drivers/media/pci/ivtv/ivtv-driver.c
> +++ b/drivers/media/pci/ivtv/ivtv-driver.c
[ ... ]
> @@ -1372,8 +1370,8 @@ static void ivtv_remove(struct pci_dev *pdev)
>  	timer_shutdown_sync(&itv->dma_timer);
> =20
>  	/* Kill irq worker */
> -	kthread_flush_worker(&itv->irq_worker);
> -	kthread_stop(itv->irq_worker_task);
> +	kthread_flush_worker(itv->irq_worker);
> +	kthread_destroy_worker(itv->irq_worker);

[Severity: High]
Does this create a use-after-free race condition with the interrupt handler?

kthread_destroy_worker() frees the dynamically allocated worker structure h=
ere,
but free_irq() is called later in ivtv_remove():

drivers/media/pci/ivtv/ivtv-driver.c:ivtv_remove() {
	...
	kthread_destroy_worker(itv->irq_worker);
	...
	free_irq(itv->pdev->irq, (void *)itv);
	...
}

Because free_irq() is the synchronization point that guarantees no interrupt
handlers are still running, an in-flight ivtv_irq_handler() on another CPU
can survive past kthread_destroy_worker().

If the handler subsequently attempts to queue work, it will dereference the
already-freed irq_worker pointer, causing a kernel panic.

> =20
>  	ivtv_streams_cleanup(itv);
>  	ivtv_udma_free(itv);
> diff --git a/drivers/media/pci/ivtv/ivtv-driver.h b/drivers/media/pci/ivt=
v/ivtv-driver.h
> index f1f18911332e8..41789a50d1ca6 100644
> --- a/drivers/media/pci/ivtv/ivtv-driver.h
> +++ b/drivers/media/pci/ivtv/ivtv-driver.h
> @@ -668,8 +668,7 @@ struct ivtv {
>  	/* Interrupts & DMA */
>  	u32 irqmask;                    /* active interrupts */
>  	u32 irq_rr_idx;                 /* round-robin stream index */
> -	struct kthread_worker irq_worker;		/* kthread worker for PIO/YUV/VBI ac=
tions */
> -	struct task_struct *irq_worker_task;		/* task for irq_worker */
> +	struct kthread_worker *irq_worker;		/* kthread worker for PIO/YUV/VBI a=
ctions */

[Severity: High]
Does this change from a struct to a pointer cause a build error or memory
corruption in ivtv_irq_handler()?

Because irq_worker is now a pointer, the unmodified call site in
ivtv_irq_handler() now passes a double pointer:

drivers/media/pci/ivtv/ivtv-irq.c:ivtv_irq_handler() {
    ...
    kthread_queue_work(&itv->irq_worker, &itv->irq_work);
    ...
}

This violates the API contract and will cause a build failure with modern
compilers due to incompatible pointer types.

If the warning is ignored or coerced, kthread_queue_work() will treat the
offset within struct ivtv as a kthread_worker object, corrupting adjacent
fields when it acquires the spinlock, leading to a kernel crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788513591.gi=
t.brads@mainlining.org?part=3D1
