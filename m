Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6F288C20;
	Tue, 21 Oct 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035873; cv=none; b=O5N+SS5K0MJMNjwFNLzaZt7amtMPH9vGQpon2Rqjoyw48Ct+BdUAjMcIb2J6/Evz0ezWZhUNL5QYwMewpV9jp1lc7wj2YyYqxf3wCgHourdFmwMbCij6CxBcoo/HdjMI6sDRSShxUDsGg9v+33QlQeWC6u8xqXJr1ciYzp65hys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035873; c=relaxed/simple;
	bh=AwhKynatZJnwvCNrCmD2R56vAgaFxbJKyVleLUecf0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Myeb7lVuvm2YykmhBBw5M0ZkzDkaPvgwiGQG3/OdGGmg5BUG71EmnQIPgXKy8YT0XHy/B3FoyKcMq6l07c1y2EXcQcEKszLZwaFgiLVZENFZ5TrSLQn/OSG/eaMV0ulQGU3Q8QdbYEVSAy9Y+1rkIjWdd/DKxTbAvkv7cVobTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aDydv/F0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aDydv/F0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+n
	7gpRkJkpFlvpmW7QTLjlpV/KtTb0XyIcRlXOub05Q=; b=aDydv/F0y7VJnRQwgi
	7UeoKDbzLUwPM6i3jf0rUpBe6YTqkhbzya99bxjh29+Sf9d84e1qRgYLb6D7JnOM
	mWjYeZnsSrRmWpAfvLEkz5MKPwByZ++JQ+wbRGher07l2/Y7GPEGiH+m6banrDW5
	tvPUP4NGz457g77+jYMpPKeHo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXh59ERvdosEfBAw--.12994S2;
	Tue, 21 Oct 2025 16:37:25 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v1 0/2] serial: 8250_dma: dma rx work optimize
Date: Tue, 21 Oct 2025 16:37:21 +0800
Message-Id: <20251021083721.703242-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXh59ERvdosEfBAw--.12994S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkGrW5WF18Gw13CF1fXrb_yoW8tryfpF
	4rCrn0qF1DJ3ZIywnxXryxJw1fuFn3JFW7urWIgrW5K3Z8CFyq9F4a9FyY9rWkCr93Xw15
	AFWYv3s8CasFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zimsjUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAW6xGj3RkXCgAAA3l

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, the priority of the kworker thread
itself is not high. Even if the CPU running this work was idle just a
moment ago, it may be preempted by real-time tasks or other high-priority
tasks.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Add tty_flip_buffer_push_wq interface to queue work on specific workqueue
and specific cpu. Add module param tty_flip_cpu to queue rx complete work
on the specific cpu by tty_flip_buffer_push_wq. The default value of
tty_flip_cpu is WORK_CPU_UNBOUND which means using the default
system_unbound_wq called by tty_flip_buffer_push, otherwise we use the
newly added workqueue wq_tty_flip which is set to WQ_HIGHPRI to promote
performance.
We set tty_flip_cpu to a specific CPU core that has relatively few
real-time tasks running continuously for long periods. Additionally,
tasks on this core have some correlation with the UART data related to
the 8250 DMA operation. After queuing work to this designated CPU and
set workqueue to WQ_HIGHPRI, we can stably eliminate the jitter and
ensure that the frame processing interval remains between 10 and 15 ms.

Xin Zhao (2):
  tty: tty_buffer: add interface to queue work on specific wq and cpu
  serial: 8250_dma: add parameter to queue work on specific cpu

 drivers/tty/serial/8250/8250.h     |  2 ++
 drivers/tty/serial/8250/8250_dma.c | 46 ++++++++++++++++++++++++++++--
 drivers/tty/tty_buffer.c           | 23 +++++++++++++++
 include/linux/tty_flip.h           |  3 ++
 4 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.34.1

