Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257432A3E5;
	Wed, 22 Oct 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141640; cv=none; b=CWJluwCYh8+cjw/X3SghN/AGV9AaRCCJCY5PP9k8eFmycyr6cio0ivSoWiUn8g9u6ZHc5kIvg1Me9u3wybBhaDG9mCYCQx9jp3buR+jKZvMkLTfdNXrG4qKyi3QjHarZzH0iNymW+WNgvcQnIVVtylhM3dtPqDe8N/nsSQt0vkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141640; c=relaxed/simple;
	bh=zIIiNf2cHEfC9zcHd0O6OLmQhc1t9tun7LtoZJYeZag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dEvXQqqblx4lib/Pf4+kxjwqFD7AZZGKzlsPZWqMuA5iPD2remif/3IIg87Q6LXykVLBjEnGe+6ONX2+sLQby2jnooSwOqJFFj9hcBU/BwlVATDxBCxFif4C1kGThL1Z0lFWvSK08P0Rpc7ady3+LowiPppXRjysIvbXZ0pb2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g+UZKXX8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g+UZKXX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tP
	Xou8UozitAgzTiw07XxRNgqZCXX5BLf3Rz2g1evkQ=; b=g+UZKXX8RkjGACabyr
	sOxVO1kWnaY5BR3PLC7k/y1Xo9eJYx/8EH7IsgS9hP8IXLtJHMjfM/j/wyXL2R9q
	+6mjOdX1gpDvbzF05VKqNhpV2YXFlBz1RSga+bcHiznOmcx0j4gkNwM7v/ZP7fxG
	379OokX3y6jzDG+N5o9qqWwjg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHjfRg4_ho4VIZCA--.7951S2;
	Wed, 22 Oct 2025 22:00:01 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Wed, 22 Oct 2025 21:59:59 +0800
Message-Id: <20251022135959.127893-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aPfV6IXPk-j59AhQ@slm.duckdns.org>
References: <aPfV6IXPk-j59AhQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHjfRg4_ho4VIZCA--.7951S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyDJr1fArWfCrWDWF1fCrg_yoW5Kw48pF
	WY9FW5ta1kJa4xArZrCw4xXFyrG3y8Xr47GryfG3WUAwsIg398ZryfKFy5Xas7Crn2q34j
	vryqk3yqya4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRnSdDUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAFpc2j442FsLgAA3L

On Tue, 21 Oct 2025 08:50:16 -1000 Tejun Heo <tj@kernel.org> wrote:

> > I also agree that tasks requiring continuous real-time execution should be
> > handled by kthread workers. However, while the ideal situation is appealing,
> > the reality is challenging. A large amount of driver code in the system uses
> > the system's pwq and worker_pool management, as this API is very convenient.
> > Refactoring the code carries significant change risks, and even with a team
> > effort, it's hard to bear such risks.
> 
> kthread_work's API is really similar to workqueue to make it easy to switch
> between the two. We probably didn't go far enough tho and it may make sense
> to allow workqueue to always use dedicated fixed set of workers (e.g. by
> allowing a workqueue to create a private pool of workers) when configured
> from userspace so that this becomes a configuration problem which doesn't
> require code changes.

kthread_work's API is greate for system which do not care about throughput but
concern with real-time performance. It is suitable for scenarios where a single
work instance corresponds to a single workqueue. In situations where a
workqueue corresponds to multiple different works, using kthread_work does not
create threads as needed. To address this, we might consider adding a new
interface, perhaps called kthread_run_workqueue. Unlike kthread_run_worker,
this new interface would determine whether to create a new thread based on the
pointer to the work instance passed in, ensuring that each work uniquely
corresponds to a thread. This approach has several advantages: it allows for
seamless switching between the existing workqueue's queue work logic and
kthread_work, and it can help avoid missing any work associated with a particular
workqueue, especially in large corebase containing multiple layers.
If the kthread_work API does not provide the functionality to create different
threads for different works, then I think a private worker pool is meaningful.
However, it may still lead to potential blocking for subsequent works if multiple
different works arrive concurrently while there is only one active kworker thread.

> > Adding flags like WQ_HIGHPRI or even introducing WQ_RT from a functional
> > development perspective doesn't pose too much concern; we just need to focus
> 
> WQ_RT really doesn't make sense given that you can't even tell whether any
> given work item would have a worker ready for it. What does RT priority do
> when you need to go and create a new kworker?

Indeed, WQ_RT cannot address the issue of multiple different works arriving
concurrently in the same worker pool leading to delays, as just mentioned.
The creation of new threads on demand in a work queue, from the perspective
of the current code implementation, is inherently non-real-time.
It seems that only the kthread_work mechanism can ensure that work tasks are
executed in real-time. I will use it to solve another GPU-related kworker
issue that I encounter in our system.

> Note that workqueue property changes don't need to be hard coded. If you
> make the code use its own workqueue and set WQ_SYSFS, you can change its
> properties from userspace through sysfs interface.

Regarding the current kworker preemption issue with 8250_dma, based on our
current measurements, using the kworker API is sufficient. Additionally, if
we switch to kthread_work, the tty driver layer would require significant
modifications. Therefore, I will adopt the WQ_SYSFS approach you mentioned,
as it is quite convenient for dynamic control from user space.

--
Xin Zhao

