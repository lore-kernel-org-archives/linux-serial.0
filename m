Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001B30CD9F;
	Tue, 21 Oct 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035973; cv=none; b=lY2IT6nyav8BJwV5y+ti05zs4hN6s+/vJgY7WonzbUzq2d7/HKsrFdMRWYWaYOXqS14rzyeCZE/OAZgpvo5anP6Ab+g4P7H9TXA3haeIZMN8YWMhvYnKwTegYjQWBNx9KA76V7P48QhYZLwBvmVyTRkTGyxDER4VCZOEvf27DNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035973; c=relaxed/simple;
	bh=5mvJZLRCE6qQFNtgg0ixmtP2qEAu5j/b+DtFPUipRWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1YNJaNFI9dke+3m764MPdbAdlWBu+yzkTYxmrPRqPPVjl/qOcri2AfQPT5TXWqmfGWwdMGuj3fhYBPXcwC1VMxSuplJdq38tqNN8F55m7DnMJtimQbOVb909xyUkJPQFeXo/6WVV16eUD75+O7DaHQWPJmHJ6PCxhlBGBFcnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eiQ5U+pp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eiQ5U+pp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HP
	kCgO+dtwR2sSHnMG+37aQKBPks/wWWyZdgP9BtMv8=; b=eiQ5U+ppHu2pxaxQGV
	BBecT00HEOg1dGc8iiPIIJz+aUzl3Y29f1HEw57qMfH3K/GbD/apjY0AxI77jJdy
	j+KQzMPwskuRmM/Q5htxo9skFHOKgQ5t05XT1ihY9KKO/flgPmpjflXLbhjJuR3s
	F2jQDJ7Mn9ciZQjaL1rH/iEPY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v4+lRvdoaOIBBw--.9646S2;
	Tue, 21 Oct 2025 16:39:02 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v1 1/2] tty: tty_buffer: add interface to queue work on specific wq and cpu
Date: Tue, 21 Oct 2025 16:38:59 +0800
Message-Id: <20251021083859.704472-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v4+lRvdoaOIBBw--.9646S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkGrW5WF18Gw48WrW3KFg_yoW5JF1DpF
	s0kr1YqFs5Xay29rsxGr17Jaya93Z3WFy7CrWI93ySyr1DJ3WruFnF9F9I9rn5Crn7Ww1a
	yrZ5uws5CF12vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zikpnPUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRw3tCmj3QkFbDwAAsl

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, the priority of the kworker thread
itself is not high. Even if the CPU running this work was idle just a
moment ago, it may be preempted by real-time tasks or other high-priority
tasks.
Add tty_flip_buffer_push_wq interface to queue work on specific workqueue
and specific cpu.

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

