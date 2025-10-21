Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4381D7999;
	Tue, 21 Oct 2025 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761020516; cv=none; b=ad8LxQijxLnAHxQ7Ft7/DdJhRJkydmC6cKFhHZvYWnX7jMsyQ0JDNEx54tu2gyZ9jShIgPr7zTzhnahynpH+qkvEEl4+TuaMSTws8D09AGYXbFATM/NQvYijtA38nrXKLbkj4pUk0ZurBXuct3RySvY13ue+3AqHhg27Msu9LRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761020516; c=relaxed/simple;
	bh=z/FznAyJJD+XkPA6ofbpMdSSIv1UvmK05KeZAE/Tyf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g50WLW0rkD1Uloqzs9Ja6xHeDcg5UmYZKqsnHLA71J1h6lQXrh9l1+4dx8WkH1A2JLsgoMV1TBd82Rg/M3415e/LEo6yCFhrHxja7rxG6jgVPDj5XiYtHizU7FCdw6D6eZMxrhVkElVf8EAkpAbHpmJ/9hnac0MtLWojK2BIIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GcsOE29M; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GcsOE29M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iH
	fcNb5kIRSrZ27NuOVbIJWLzlrVXSiZIpHFNkZUGeI=; b=GcsOE29MRmZD4tdVOE
	0kApFp9Q+I7spJJGJqe0tCSDcgrl2liqy24vav5Ig4S7BNMYmiIt36oofPQFtdOh
	6ry4+y2pMMtMvR8JNKVACfrPvsTj+WoIH4+9kEMgy4zZV56VFst71aGeIi6ZGeqn
	jlKUzlIPmxjS/GkZ2h7ONRGak=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDn_7k4Cvdo4jKpAA--.23897S2;
	Tue, 21 Oct 2025 12:21:13 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] tty: tty_buffer: add interface to queue work on specific wq and cpu
Date: Tue, 21 Oct 2025 12:21:10 +0800
Message-Id: <20251021042110.513095-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_7k4Cvdo4jKpAA--.23897S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryxGF1UXr47XFyDtw47urg_yoW5KFWUpF
	s0krn0qFs8Jay2krsrGr1xJay3u3Zagry7urWIg3y3trn8Ja4kuFnFgFya9rykCrs3Ww1a
	vrWF9398CFy2vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziEdgAUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgntCmj3AzKXQwAAs6

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. We have customized our own 8250 driver, but
we still need to reuse the kernel's TTY layer. The tty_flip_buffer_push
interface in the TTY layer uses system_unbound_wq to handle the flipping
of the TTY buffer. Although the unbound workqueue can create new threads
on demand and wake up the kworker thread on an idle CPU, the priority of
the kworker thread itself is not high. Even if the CPU running this work
was idle just a moment ago, it may be preempted by real-time tasks or
other high-priority tasks.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Adding the tty_flip_buffer_push_wq interface would allow our 8250 driver
code to push work to a specified CPU. Since CPU tasks, especially real-time
tasks, often have a certain distribution pattern in the system, we found
that by pushing to a specified CPU with a WQ_HIGHPRI workqueue, we can
stably eliminate the jitter and ensure that the frame processing interval
remains between 10 and 15 ms. Furthermore, if we implement an RT workqueue
based on this, using the tty_flip_buffer_push_wq interface to push to the
RT workqueue(FIFO 1) we can further stabilize the processing interval,
significantly reducing the occurrences of 14-15 ms intervals and increasing
the frequency of 11-12 ms intervals.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 drivers/tty/tty_buffer.c | 23 +++++++++++++++++++++++
 include/linux/tty_flip.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b..112a650e2 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -534,6 +534,29 @@ void tty_flip_buffer_push(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
+/**
+ * tty_flip_buffer_push		-	push terminal buffers
+ * @port: tty port to push
+ * @wq: workqueue on which to queue work
+ * @cpu: cpu on which to queue work
+ *
+ * Queue a push of the terminal flip buffers to the line discipline. Can be
+ * called from IRQ/atomic context.
+ *
+ * In the event of the queue being busy for flipping the work will be held off
+ * and retried later.
+ */
+void tty_flip_buffer_push_wq(struct tty_port *port,
+			     struct workqueue_struct *wq,
+			     int cpu)
+{
+	struct tty_bufhead *buf = &port->buf;
+
+	tty_flip_buffer_commit(buf->tail);
+	queue_work_on(cpu, wq, &buf->work);
+}
+EXPORT_SYMBOL(tty_flip_buffer_push_wq);
+
 /**
  * tty_insert_flip_string_and_push_buffer - add characters to the tty buffer and
  *	push
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index af4fce98f..0138b6bfb 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -15,6 +15,9 @@ size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 				      size_t size);
 size_t tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
+void tty_flip_buffer_push_wq(struct tty_port *port,
+			     struct workqueue_struct *wq,
+			     int cpu);
 
 /**
  * tty_insert_flip_string_fixed_flag - add characters to the tty buffer
-- 
2.34.1

