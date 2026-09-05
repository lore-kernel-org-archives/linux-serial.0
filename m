Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00283E49DA
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601864; cv=none; b=SQbFJWbF6KRSZFrS/p9IttVRApolqScumzzpiipqHDQUVntwtxjbf5dsjLT/QAh44AMx4NGBLtC1aGXvwmrFpCFzFNe6p+Pa96XN9lshnoXDveoFBYNfPRO/4dce78EXQ0A6QValTBjzidjZXO3JvcyBrvqjKnQXRFwLJuyoI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601864; c=relaxed/simple;
	bh=csuWdTnqyG/n0TASGMBG6lV29omdaIVg/Sg908D/84U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Oji3TAHPbCnewicQDCTNe9skpbC0kKhRu2fnx/RnBRNOSSH6DIfAGsS7+ogXcxRv+3rYN84G5V7/1gHQv5BeYEwfku2L/Lh8YMVG5UlNaQhY8GtYR3X1fX6tcT0w0S/XaqteGtvNIM5NZ1aWz7+FyDUO9sxQuGXVf3x63e+80YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=q+rIHq8X; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3uTWI21l; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="q+rIHq8X";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3uTWI21l"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601847; bh=DXsPp7YG0e/E7Kouf5j2j/L
	x2mVjE0RU8AnubTjpMOs=; b=q+rIHq8XQCfKmwjfeDA1jW3/SRDSHOZCmKNsXHradZXhWCpGnD
	RTkSXv+m6YXkWsf/7VfbXHZX6UDuNruXzodLd7ESRRSy1i4lXGwS4L6LTaY4OHmikyz+X5iGQ9P
	A5RSelAg4DWOwKQIKz6mFH8IQGhXYGF4X+cvNdNDise3DFQRJNoi4Qsgpl6Vj6ofZJDv9K2o+QQ
	/pTyEPqiZTsoXPCUUq4SriFtALUI7tr3JrATRh7q4LYFXHTss5+7lNEGZMd4SbjcxQfrTas7KRD
	P/owtFijvMnyrltjDq+FMY27UAi+8MBfvGOi1rSiE7tSguh3RFs3p9URVL5ECcyDknw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601847; bh=DXsPp7YG0e/E7Kouf5j2j/L
	x2mVjE0RU8AnubTjpMOs=; b=3uTWI21lNh0aErUnz7Ajw6K4wjEISTsRchvOCDgcgVfNhZcD09
	opiXHxfDKFQwlrmqiTzcYv1obJ2qYERqRRAw==;
Date: Sat, 05 Sep 2026 10:50:46 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: media-ci@linuxtv.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 5/5] kthread: remove worker->task self assignment
In-Reply-To: <20260905094039.3490D1F00A3E@smtp.kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads@mainlining.org> <20260905094039.3490D1F00A3E@smtp.kernel.org>
Message-ID: <3D57F7A3-3ABC-4396-ACB1-3D5F1DE97588@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 10:40:38 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential
>issue(s) to consider:
>- [Medium] Removing the self-assignment `worker->task = current;` breaks out-of-tree (OOT) users of the old `kthread_run(kthread_worker_fn, ...)` API, causing them to permanently deadlock due to missed wakeups.


Deliberate!!! They deserve whatever crap they get if after all this they
haven't converted their caller.

>--
>
>commit 4e8323d40e4fe5053d4171cbca8193f9bd6080b8
>Author: Bradley Morgan <brads@mainlining.org>
>
>kthread: remove worker->task self assignment
>
>All kthread worker users now create their workers with
>kthread_create_worker*(),
>which sets worker->task before the worker starts. The self assignment in
>kthread_worker_fn() is removed, leaving a warning check for out-of-tree
>users.
>
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 63beb59b7a3d1..643407647e79d 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -987,12 +987,10 @@ int kthread_worker_fn(void *worker_ptr)
>>  	struct kthread_worker *worker = worker_ptr;
>>  	struct kthread_work *work;
>>  
>> -	/*
>> -	 * FIXME: Update the check and remove the assignment when all kthread
>> -	 * worker users are created using kthread_create_worker*() functions.
>> +	/* All workers are created with worker->task set. If this fires,
>> +	 * the caller is broken.
>>  	 */
>> -	WARN_ON(worker->task && worker->task != current);
>> -	worker->task = current;
>> +	WARN_ON(worker->task != current);
>
>[Severity: Medium]
>Does removing this assignment cause out-of-tree users of the old
>kthread_run() API to hang permanently?
>
>Because the self-assignment is removed, worker->task will remain NULL for
>any
>callers still using the old API. When new work is inserted, the wakeup
>will be
>silently skipped in kthread_insert_work():
>
>kernel/kthread.c:kthread_insert_work() {
>	...
>	if (!worker->current_work && likely(worker->task))
>		wake_up_process(worker->task);
>	...
>}
>
>This means the warning intended as a sanity check turns into a silent,
>fatal
>breakage where the worker hangs in TASK_INTERRUPTIBLE and queued work is
>never
>processed.
>
>>  
>>  	if (worker->flags & KTW_FREEZABLE)
>>  		set_freezable();
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
