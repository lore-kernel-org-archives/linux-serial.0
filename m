Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9A19AD90
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601879; cv=none; b=Zzi9DbgaSu3tpwkcXF28aksakpaxlTb1pcm7O2maC0F8SAVTi5wCabknXERo3mqryNL8GwedUdoTvJzTP1qAEQAFBhL+q0LHEYsNIUGpdkcxpanzlt4tHjjC+sKY6IK7hy6BlEGoB8G9JbFvipvdZxdYVzB5/9ssuHBwSHCo10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601879; c=relaxed/simple;
	bh=F/gYL8reWe3uoPYXOCcN8mCyLGwfeCTfazFrKcCWJvo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SDW+v7f6D9Qhuk7mKCMPZfVP0Sux+Qn7qrHH37KEU7HNmlCT00Oa06iwNblWmKI5b1EKm6ViVneqEu67dTBUv9JXQDxV1HnLKrBUxBI4JNjGJ4i8q+4AzlnedzWnbAk0U+zqnBVtKihpY47XyZnvdi8GzBHhWNbXHZaSsfabUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=A/A33Gyw; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dFFXjZJE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="A/A33Gyw";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dFFXjZJE"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601866; bh=eD9LNO2HfvagpQooAKM6yJo
	Gfye1DflgL6D9d62JIMQ=; b=A/A33GywIOkfIZyvy2etRWH5JHmz28gWDpj8KYQ+MLfbetjPMB
	pP4tlA+HE02UZxvhwGrK7FYMBBEDR09c/vdMw/iIMK2a1y5fPGDqwNbwUj8MTd2Loe8CuSK3lhK
	UQ/76DzuYYAZsOQH8oep3XAfcJXYURZVCgPrbHk85EdfqSlmMmiqCDYJn1ASnedwyftXdwO670Q
	myIjmxrs0b4yVMmppBXhNtwXmgy1AXi+dWL4hdpXcJeqYQtjw+jRaR2a024XTGL42h8vKJXOOsH
	GHQuYizaGos3PTHEQSduSTH25zSAYxHutk2aaw8AlOBc+Q5hc3rvSgoT8xnTZUBlHTw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601866; bh=eD9LNO2HfvagpQooAKM6yJo
	Gfye1DflgL6D9d62JIMQ=; b=dFFXjZJEuSXCknI4wufVa3p+cFWql1f9tQ7DGxgRjOgiAlMypE
	yufwmSnUBcwgaH/Y2X0+jl/6Cxw9IHSy60Aw==;
Date: Sat, 05 Sep 2026 10:51:05 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-serial@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v2 1/5] media: ivtv: convert to kthread_run_worker
In-Reply-To: <20260905094037.AF7E01F00A3F@smtp.kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <c38e2e3575040b0a7e580e1d78d8202fe1b8cf06.1788513591.git.brads@mainlining.org> <20260905094037.AF7E01F00A3F@smtp.kernel.org>
Message-ID: <40E3542B-59E3-43F6-8B69-67A0F367F009@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 10:40:37 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential
>issue(s) to consider:
>- [High] kthread_queue_work() receives a double pointer instead of a pointer to kthread_worker, leading to a build error or runtime memory corruption.

Aware (sorta?)


>- [High] kthread_destroy_worker() is called before free_irq(), creating a Use-After-Free race condition with the interrupt handler.

Oh!

>--
>
>commit a504d2685cd2f4c4e6b93a81c847d55367eae1c0
>Author: Bradley Morgan <brads@mainlining.org>
>
>media: ivtv: convert to kthread_run_worker
>
>Convert ivtv to use kthread_run_worker() instead of the deprecated
>kthread_run(kthread_worker_fn) pattern. The new API sets worker->task
>before the worker starts.
>
>> diff --git a/drivers/media/pci/ivtv/ivtv-driver.c
>b/drivers/media/pci/ivtv/ivtv-driver.c
>> index b9ea56ec9593f..6f0e0e46deb5b 100644
>> --- a/drivers/media/pci/ivtv/ivtv-driver.c
>> +++ b/drivers/media/pci/ivtv/ivtv-driver.c
>[ ... ]
>> @@ -1372,8 +1370,8 @@ static void ivtv_remove(struct pci_dev *pdev)
>>  	timer_shutdown_sync(&itv->dma_timer);
>>  
>>  	/* Kill irq worker */
>> -	kthread_flush_worker(&itv->irq_worker);
>> -	kthread_stop(itv->irq_worker_task);
>> +	kthread_flush_worker(itv->irq_worker);
>> +	kthread_destroy_worker(itv->irq_worker);
>
>[Severity: High]
>Does this create a use-after-free race condition with the interrupt
>handler?
>
>kthread_destroy_worker() frees the dynamically allocated worker structure
>here,
>but free_irq() is called later in ivtv_remove():
>
>drivers/media/pci/ivtv/ivtv-driver.c:ivtv_remove() {
>	...
>	kthread_destroy_worker(itv->irq_worker);
>	...
>	free_irq(itv->pdev->irq, (void *)itv);
>	...
>}
>
>Because free_irq() is the synchronization point that guarantees no
>interrupt
>handlers are still running, an in-flight ivtv_irq_handler() on another CPU
>can survive past kthread_destroy_worker().
>
>If the handler subsequently attempts to queue work, it will dereference
>the
>already-freed irq_worker pointer, causing a kernel panic.
>
>>  
>>  	ivtv_streams_cleanup(itv);
>>  	ivtv_udma_free(itv);
>> diff --git a/drivers/media/pci/ivtv/ivtv-driver.h
>b/drivers/media/pci/ivtv/ivtv-driver.h
>> index f1f18911332e8..41789a50d1ca6 100644
>> --- a/drivers/media/pci/ivtv/ivtv-driver.h
>> +++ b/drivers/media/pci/ivtv/ivtv-driver.h
>> @@ -668,8 +668,7 @@ struct ivtv {
>>  	/* Interrupts & DMA */
>>  	u32 irqmask;                    /* active interrupts */
>>  	u32 irq_rr_idx;                 /* round-robin stream index */
>> -	struct kthread_worker irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
>> -	struct task_struct *irq_worker_task;		/* task for irq_worker */
>> +	struct kthread_worker *irq_worker;		/* kthread worker for PIO/YUV/VBI actions */
>
>[Severity: High]
>Does this change from a struct to a pointer cause a build error or memory
>corruption in ivtv_irq_handler()?
>
>Because irq_worker is now a pointer, the unmodified call site in
>ivtv_irq_handler() now passes a double pointer:
>
>drivers/media/pci/ivtv/ivtv-irq.c:ivtv_irq_handler() {
>    ...
>    kthread_queue_work(&itv->irq_worker, &itv->irq_work);
>    ...
>}
>
>This violates the API contract and will cause a build failure with modern
>compilers due to incompatible pointer types.
>
>If the warning is ignored or coerced, kthread_queue_work() will treat the
>offset within struct ivtv as a kthread_worker object, corrupting adjacent
>fields when it acquires the spinlock, leading to a kernel crash.
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
