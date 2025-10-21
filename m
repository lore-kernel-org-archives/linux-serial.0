Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A034C137;
	Tue, 21 Oct 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068403; cv=none; b=S8Gq3t2Npm48JUPVHbQKVCfCNJ9wE1HHEjQ/zI7c9izE+p4YAo0M8kD8EqjFr/pZj29eyuAcvhBDRNCXpB4eJC46RA3dJQKSqpaJGFrn8cn/epVHABrxYvhOlzLW+T65QBWTpri75dNtqFbPQdZ6D35wwApAZVf7UF13ZGpu03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068403; c=relaxed/simple;
	bh=unjjgmF57TNACe+Xjat1+NlIgmvvKyfS2nRWnXqlQ9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8pPVmaRzyqxLpiKP/XkMwAtJFOO67VnwWNUI6QOz3B6FHp4Jn85jfc2TxCwcMwMEpASFMXCqJ+6CfYJ2u+wNyRzeDBa1XKRuF93Z4tnNALXAxVbRRfRl4U63oZFgMjwROiHFltxXsnKcixoWzZGphyBceFYEcc182hoXOur8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fMPyjWpA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fMPyjWpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lw
	ZwYDkdZriiEU3fooZ1PmsCHRlFRSaUEjgODePLjsE=; b=fMPyjWpA5C9ppdCX0s
	Z97ldgAvS459/x9d8+U1HLnCUWCqrTwe6KimRkgMEVz36C0ee8PBd3CQUgMTo+/X
	R8Mfx7IdSIyksAd+n+pMqhF28VhbXtJNdXpyNhT1Z/Y3+w4ImUMJv9mTmb5JNOQm
	wBJdek6CSLGBhPkrfalOgc3/Y=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHoIhVxfdoyEzmAA--.1516S2;
	Wed, 22 Oct 2025 01:39:35 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Wed, 22 Oct 2025 01:39:33 +0800
Message-Id: <20251021173933.1077124-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aPe3ZBCcyc5XR7TO@slm.duckdns.org>
References: <aPe3ZBCcyc5XR7TO@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHoIhVxfdoyEzmAA--.1516S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8uryrXF43Ar4DXF45trb_yoW5XFy5pF
	WakF4YkFWkJ3W8Zw4xAw1xGa4093WfAFW3JF95Gr4UAws8JwnIyry7K34avFy2vr40yw1j
	vFWqvrn0y3Z0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pio7KxUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRw-tCmj3qqmyuQABs5

On Tue, 21 Oct 2025 06:40:04 -1000 Tejun Heo <tj@kernel.org> wrote:

> > True, which is something that the rt changes should have addressed.
> > This sounds like an overall rt issue, not a serial port issue.  Have you
> > asked about this on the rt mailing list?
> 
> Maybe it's mostly RT; however, because of the shared worker pool
> implementation, workqueue can introduce high tail latencies, especially
> depending on what mm is doing. When a work item is scheduled, there would
> usually be a worker thread that can service it right away; however, there's
> no guarantee and when it gets unlucky it may have to create a new kworker
> for the pool, which can easily add some msecs of delay. If the system is
> under even moderate memory pressure, that can shoot up considerably too.
> 
> I'm not convinced WQ_HIGHPRI is a good solution tho. It changes scheduling
> priority and it likely reduces the probabilty of having to create a new
> kworker as highpri pools are a lot less utilized. However, that can still
> happen. If consistent low latency is really important, it should use
> dedicated kthread workers with appropriate priority bump.

Thank you for your insights about high tail latencies. However, the spikes
I'm encountering in the project related to kworker still stem from RT
processes preempting kworker threads that are already executing. In our
project, I have already implemented my optimization approach by queuing
work to CPU0, since there aren't as many long-running real-time tasks on CPU0.
Moreover, some logic on CPU0 replies on the tty uart data, which provides a
degree of complementarity from the perspective of CPU resource usage. From
the experimental data results, the most significant optimization effect comes
from queuing work to this fixed CPU0, rather than using the WQ_HIGHPRI flag,
although WQ_HIGHPRI does provide some improvement.
I also agree that tasks requiring continuous real-time execution should be
handled by kthread workers. However, while the ideal situation is appealing,
the reality is challenging. A large amount of driver code in the system uses
the system's pwq and worker_pool management, as this API is very convenient.
Refactoring the code carries significant change risks, and even with a team
effort, it's hard to bear such risks.
Adding flags like WQ_HIGHPRI or even introducing WQ_RT from a functional
development perspective doesn't pose too much concern; we just need to focus
on whether there is any impact on performance. In other words, for developers
working on the tty driver in this context, it might be difficult to practically
accept changes to a large portion of the current work code in tty, making
implementation quite challenging.


--
Xin Zhao

