Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39261F582E;
	Wed, 22 Oct 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144468; cv=none; b=fllk7uJdYEJWrlXmvEFY5Uoty5UdRKDValtaHXjzlA0JxwCQTqB8aU8gYCwLkiAg9pz3ZdaSXRcDnsl5iPjEo8+JtVveE5g/RFfuf8Pj/PhABuhucQHz0ESSqleXXoCHlizvfoOjXJuvSvZzj32gqzbSaP1h2lZGd53f9xr0Zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144468; c=relaxed/simple;
	bh=xd4kL/jXzdOqVEVTeb6/caeOsR6uMZrZNGg1CWFuQUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaM7VQqt+fEaDoynu+waAovYUo8Cms7WzcEwC9ducefcsiRP4AsOvTWVyXnajMKX136C4292Ob2/nLUWaRjFYAI7bnbAeWQXwnEuezqR2piNI01e5P6BYml60r9TdImDPoDzx9Bc0zhZif4TPznMs+0s6x3E1jngZMZJL/uad9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BuqiwOmC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BuqiwOmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f6
	xyuwMavmWKRPX4QfibwgyIlfcPx5ibwjw/2n1TmN4=; b=BuqiwOmCsbrK9nyHVK
	IQavwsnAMoLEnxrpLOGLT9uLGWLkSfoAgZFZ5ZfpL+hLmiRbjhy8SFxlwn10dDWw
	msfvST70CMqQdJou1aE8XUxvvc2bNZdDhoNShKNS8QP5SkBHkKQvImoaEEEvOUxk
	8bccvtN0j/InlKv4U0oGt5rT4=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnjwVr7vho86LUBg--.2882S2;
	Wed, 22 Oct 2025 22:47:08 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Wed, 22 Oct 2025 22:47:07 +0800
Message-Id: <20251022144707.160181-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102107-player-baggie-37fc@gregkh>
References: <2025102107-player-baggie-37fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjwVr7vho86LUBg--.2882S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4xAw15Ar1UCr13try3XFb_yoW5ZFW8pF
	WSga4ft3WkXF4Iy3ZrWr40vFW3Can8KF13Gw1kGrWfAwn8JryFkr1xKFWj9FWUGr1kuFy5
	ZFn09rW0yaykA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRnSdDUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwwvOWj47mxGzwAA3+

On Tue, 21 Oct 2025 18:26:53 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> I do not know, but it was not threaded :(
> 
> Try sending it to yourself and see if the delay maybe caused a problem?
> there should not be an issue sending just 3 messages at once.

Now that I think about it, both patches are small and address the same issue, so I
will combine them into a single patch for the next submission.

> 6.1 is very old, please try the latest 6.17.y release, or 6.18-rc1.
> Lots and lots of RT stuff has been fixed since 6.1.
> 
> I'm saying that the RT selection should cause you not to have those
> larger variants in delays.  Try a newer kernel and see.

I have now clarified, as you mentioned, why there is no issue in the standard kernel
but there is a problem in RT-Linux. In the dma_rx_complete function in 8250_dma.c,
locking is done using uart_port_lock_irqsave and uart_port_unlock_irqrestore, where
uart_port_lock_irqsave calls the spin_lock_irqsave API. In the standard kernel,
spin_lock_irqsave disables both preemption and hardware interrupts, while in RT-Linux,
spin_lock_irqsave does not disable preemption and does not disable hardware interrupts.
This leads to a situation where, after acquiring the spin_lock_irqsave lock, if a
real-time task preempts the current task, the spinlock holding period will lead to
migrate_disable, so if other CPUs back to idle, they cannot pull the preempted kworker
task. The work task can only continue execution after the real-time task releases the
CPU, resulting in high latency. This issue cannot be resolved in any version of the
kernel because the implementation of spin_lock_irqsave in RT-Linux is still defined
as spin_lock in higher version kernels, which means it does not disable preemption or
hardware interrupts. Similarly, in higher version kernels, spin_lock still calls
migrate_disable. Therefore, this issue cannot be resolved by simply using a higher
version of the kernel.

> This should come from a hardware definition somewhere in your DT, not as
> a user-selectable option.  And again, why not just tie it to the cpu
> where the irq came from automatically?

I don't think binding the work task to the CPU that handles the interrupt is feasible,
because, in practice, this hardware interrupt is evenly distributed across all cores
in our system. Moreover, from the ftrace data we captured, the IRQ handler thread that
wakes up the kworker threads in RT-Linux is also distributed across various CPUs by
default.
Considering the current situation is still limited to the RT-Linux scenario, if
possible, I will add the logic to create this workqueue only when CONFIG_PREEMPT_RT
is enabled in the next patch. By setting WQ_SYS, it will allow user space to dynamically
modify it. Additionally, in tty_flip_buffer_push, I will check if a private workqueue
has been created; if so, I will use the private workqueue to queue the work task.
If modified this way, there will be no changes for the standard kernel. For the RT-Linux
system, if user space does not dynamically modify the workqueue's CPU affinity and
priority, the effect will be the same as if this patch were not applied. What do you think
about this approach?

--
Xin Zhao

