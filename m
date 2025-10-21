Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D771355036;
	Tue, 21 Oct 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051944; cv=none; b=FWM9deQBBfI1xrNCjK/7fBY8kdUSXD5m97RSOZ6wWtBL4oxxGh0GPV3HxKFPXsjajkrHGAmRRHm9li/b8LW6EIriI5IsmOo4uVReQiBfearV1o1h+3oUWPbj5eSc78qXsp6TNaL5V8ExcYUuE+AMmSJQuft1S4VdxW1r9eu6idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051944; c=relaxed/simple;
	bh=3UlH00ys6+jMEL4lBTWDD5FUfkNIfv9dmLfE9oU37To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvXZMZvi6hZFKStM+DrgGjLDryOWw0tC5B4i9R2XVilAUbRSKODYhnLOCiSxtCqevjxsMdCFMPp+f8FmLt70/ALm+y0JJfZFBkPs/6URmnY4rZYNrKJComZ5Pnu6MA/ctoF8D8ODkyKPV/pBwEo07+Pl3IkQKurSM6MMEcbTyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zt/XY66q; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zt/XY66q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T3
	4TNqXQ0G+L4ws1wmkzxel3y5y4nrtGZ1uEsb1hyNg=; b=Zt/XY66qSzkQkiHB9h
	Z6kZKfNKl1krq8P8frSF0n6c5adegJW3E8fCm/we//77QEYSUrAg3EPeEVtWOsKI
	SVfoSZiNqSktFpeTX6RastxeMVnCJpIyaAPUfUVh1aIRGPZoKB0VsB7SBf6cZKBm
	0UvhYLiBdKMMEUaSldNHe+aTg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHyjkJhfdofhSuBg--.3671S2;
	Tue, 21 Oct 2025 21:05:14 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Tue, 21 Oct 2025 21:05:13 +0800
Message-Id: <20251021130513.871830-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102157-goal-grandma-36d4@gregkh>
References: <2025102157-goal-grandma-36d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHyjkJhfdofhSuBg--.3671S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4xAFW3Ar4DAr1rCFW8Xrb_yoWrJw17pF
	4rKa90kwsrGFn7Aw17Zw1IqF48ZwsYywn8W345Kry7Arn8Xry7Cr1ag345uayDArs3Ca15
	Xr40yr9YkasxZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pib18DUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwt7hWj3hQtLjgAA3e

On Tue, 21 Oct 2025 13:28:46 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> Meta-comment, this is a v2, and was not threaded with patch 1/1.  Please
> use a tool like b4 or git send-email to send patches out so that we can
> properly review/apply them.

I did use git send-email to send the patches. I have successfully used the
git send-email tool to send a series of patches before, and that series was
later merged into 6.18-rc1. Therefore, I feel that my usage of git send-email
should not be an issue. The only difference of my current submission is that
after sending each patch with git send-email, I waited for the patches to
appear on lkml.org before sending the next one. I had encountered issues before
where sending multiple patches in a row caused only some of them to appear on
lkml.org, with others taking a long time to show up. That's why I specifically
decided to wait a bit after each patch this time. I'm really not sure why the
system didn't group my three patches together; it's quite puzzling to me.

> Are you using the RT kernel?  It seems odd that this is just coming up
> now, given our normal latency issues in the tty layer.  What changed to
> cause this?

> > In our system, the processing interval for each frame of IMU data
> > transmitted via UART can experience significant jitter due to this issue.
> > Instead of the expected 10 to 15 ms frame processing interval, we see
> > spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> > be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> > jitter exceeds the software's tolerable limit of 20 ms.
> 
> Again, are you using the RT kernel?  If not, can you try that?

Our system is indeed RT-Linux, version 6.1.146-rt53. Our project has been
ongoing for about 2 years, and we hadn't paid close attention to these jitter
issues before. It is only recently that we needed to focus on them specifically.

> This is not the 1990's, we don't add new module parameters :)
> 
> This will not work for systems with multiple tty devices/drivers, please
> use a correct api for this if you really really need it.
> 
> But again, I think this might not be needed if you use the RT kernel
> issue.

If user-configurable CPUs are really needed for queueing, do you have any
recommendations on how to implement this? Would it be appropriate to create
a new node under /sys/devices/platform/serial8250/tty/ttyS*?
As mentioned earlier, our system is an RT-Linux system. As you say that
using an RT kernel may not encounter this issue, are you implying that RT-Linux
has priority inheritance logic? However, the logic within work items isn't
always protected by locks. Even if everything is under lock protection, when a
work item starts executing and hasn't yet entered the lock, it can still be
preempted by real-time tasks. In an RT-Linux system, such preemption of kworker
by real-time tasks is more common compared to a standard kernel.

> So you just bound ALL tty devices to the same cpu?  That feels very
> wrong, how will that work with multiple devices on different interrupts
> coming in on different cpus?
> 
> Why not just queue this up on the cpu that the irq happened on instead?

If possible, I will later add a node to separately configure each tty/ttyS*
device. The approach I intend to use is to add this tty_flip_cpu node under
/sys/devices/platform/serial8250/tty/ttyS*. Is it OK?
Based on our project, the DMA RX complete events for tty are almost evenly
distributed across each core. I believe it is necessary to increase the
flexibility of the queue_work to be located on a specific CPU, as it is difficult
to predict whether a core is running many long-duration real-time tasks based on
the driver code or low-level logic strategy.

--
Xin Zhao

