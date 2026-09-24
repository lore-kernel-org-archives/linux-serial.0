Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB7420486
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277761; cv=none; b=He+dpK1OkTv+iFyMFoaXpf7ps0XLQCFWZY6mlJiLfN2r6lXC0JND9RT6724l1DnFDHtfdjV4BGMgdZunr0D0dP80HnyaKaOO/VxLEj26Dp2vqeArV98rMwTK5tp0flgs+U7CTAh/rHW3cJV68j20bYfILfylUNjRSgfxJ0TkS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277761; c=relaxed/simple;
	bh=iVnn/yWYt0uoOwaIx73gymaQbCmlXyeA4KKM5jbjgZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHEm1mDUEa9HJSAAIxwivThc83kVpEeyt+IwTZfpkeEFFfbbyBeo4nf+1CQzgz3w2IJgh/T1v61ojcJbw4gNh5pWnbqa949Bq9yhw1Ch60aX0hzjALOfSVD1Oye41dQmDmyWg/l+xGxfqHSkfq0VPP8E4B3hrOKjFy3xOQL+1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvpDw5su; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvpDw5su"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c1b8d7b5so170027e87.0
        for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277755; x=1790882555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gD+Y3tWn5iaTX1eAHi+6XyiDWI/B2Sv0Ag166lzTeY=;
        b=IvpDw5sunj7vaZvnMnWlaI6Sb89Nr8qywMp4BD2beTccAO2rS24Q+mLATs8GpWD6i7
         RzIPnNZ4PI7FJe6lBKS3by81PqUXRDTICMWHYzH+aDpANfLj3fAiFsGyrCb43TBZoMM0
         Uslr7x/iHJ2qKDUprhbNvj+HVW2yR45JsBeD6KGHHDRXhZEzAf5W2K4rfVKsY1ZZaiSb
         7DoAKu5JEVF4qZg48Rx9ITEVoAyGFWtDbUgt815uqlK5wQ24nUluoyoBaG5+xAo9HTYT
         Whg7Zvm6dLrhYVbOcmA30V4hQlWLVyKAhCF1xBEfdInAY2DvkxeCYG2JRXDGvrMLbin5
         Z9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277755; x=1790882555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gD+Y3tWn5iaTX1eAHi+6XyiDWI/B2Sv0Ag166lzTeY=;
        b=JZHdHDr19QnsoG398AOQr8JRqEZSRF7dIxJgg7AsjJ+zqUgEim0LMZyW0e2oTBUFw+
         xcg7zoQbT2+CUGmq2Ad3KGSubzaL0X5qYu4nIrba3IhI05W2pA1IXvWRsLTYFQXAiE2E
         zKKz7hPLDcYXHThngbGb3WuZt++8h0rk+J+Akqz+Te4V7iFTZsvfp3xmuEllsZVP9AjD
         EeIO1uMAUAQJN6Q/jtpK8Rs0CIjyfSz1kgEGJzn+sJ8DdHy9op5/kwwKM6WXcSzyehRM
         Po7fcVqMgBjy2XfdvCY22p9dK9eSzvB9R7Ntw1cPgumStMhXCfvCjILmEbZ2jetZ9zfG
         /ydg==
X-Forwarded-Encrypted: i=1; AKwUvBwh01NQoBc2LjjmT9wogKEHytCp9ASmUJ++VMkzgzH9lpTMOEPbaweG32jYQS7+DBmonhfr7Z/sWiQZrhI=@vger.kernel.org
X-Gm-Message-State: AFuF++nEogQRbmxBmPEK/nP0Etsr++8sXUO7vgZE1tuY5MWUQOo+00wr
	bu08ByENyDgz2OxvdfYzGayYYzbNpVlRvAJ9C0mB2ewJ1TFVFC0f6kRJ
X-Gm-Gg: AYBFou0fm3n1vp0UDwDNwE7tSNPheMyOFyQfZNvsZBYuCjdXq9XLBPI7F5Z3lCJSvSk
	7SQ/JN/Pz+TFp6ZRaGBx5a6tKNudIAyexUxIRhKqiTOxbW24qdzWZv4KbKLNdVhGHLPzAXQHpsz
	QPG+Li+G8jzfWuvn+a/PBTL2QFugLAuBe+PoPL6TklH6VGQbkLqi+rulbIjxPqWJIfDyej5uJNd
	URDt+DVxDqKDX3fE91IK51MYDlLoEysEWU0iHWqkH8O4EeBype8Yi4c7cH9n9e/RejE9cXciJEZ
	+kvXu8BjL3B0lWAe79YBBg8cZmKD/rLrpyvlHCVTuuQv7nnExxYiGUkrZpdd2CbgJJZrzWsKyV0
	uH41d0EWC/QVOmYEDh6ntfs3qDZ9rOZxXDrq1SeJQJTlkClX8k8Vp9SVrEh5Jy+m/TjjsxuhhfJ
	zOWBOt+zNled9j11fLh4is2fvrySXQF6pcMbFcW008J3SkaWzV5YhHscXtlqGnzmdc6FCHfj5jD
	T47+PB/l8ZhxWbk7hXSeMVZBCsOLDbaEQOc5MYl9x64xFsxDgwGSolVMiF4fhnQOLHfumF55Z8T
	6hzQ4u4=
X-Received: by 2002:a05:6512:3401:b0:5b8:bc5e:d0fe with SMTP id 2adb3069b0e04-5b8df09adb0mr1266044e87.40.1790277754785;
        Thu, 24 Sep 2026 12:22:34 -0700 (PDT)
Received: from localhost.localdomain (95-25-156-252.broadband.corbina.ru. [95.25.156.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e68d2302sm17273e87.29.2026.09.24.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:22:34 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Vignesh R <vigneshr@ti.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
Subject: [PATCH] serial: core: shut down initialized port on removal
Date: Thu, 24 Sep 2026 22:22:24 +0300
Message-ID: <20260924192224.3175-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a serial port configured as a console is opened and subsequently
closed, tty_port_shutdown() skips invoking port->ops->shutdown() because
port->console is true. As a result, tty_port_initialized() remains true
and the port's interrupt handler stays registered in the irq subsystem.

If the underlying device is later unbound or removed (e.g. via sysfs
unbind), serial_core_remove_one_port() unregisters the console, frees
uport->name with kfree(), and clears state->uart_port without ever
shutting down the port or freeing its IRQ. Consequently, the irqaction
remains linked in the genirq descriptor with action->name pointing to
freed memory.

When another device later requests the same IRQ line, __setup_irq()
encounters the stale action, detects a flags mismatch, and attempts to
print old->name in pr_err(), triggering a KASAN use-after-free read:

  BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:648
  BUG: KASAN: slab-use-after-free in string+0x471/0x4d0 lib/vsprintf.c:730
  Read of size 1 at addr ffff88802643b8a0 by task syz.0.818/8415
  Call Trace:
   <TASK>
   string_nocheck lib/vsprintf.c:648
   string+0x471/0x4d0 lib/vsprintf.c:730
   vsnprintf+0x422/0x1300 lib/vsprintf.c:2949
   vprintk_store+0x3b3/0xbe0 kernel/printk/printk.c:2307
   vprintk_emit+0x139/0x6b0 kernel/printk/printk.c:2455
   _printk+0xcf/0x110 kernel/printk/printk.c:2504
   __setup_irq.cold+0x3be/0x3f1 kernel/irq/manage.c:1821
   request_threaded_irq+0x261/0x3e0 kernel/irq/manage.c:2184
   pcl812_attach+0x1b62/0x2300 drivers/comedi/drivers/pcl812.c:1174
   ...

Fix this by clearing port->console after unregistering the console and
calling uart_shutdown(NULL, state) under port->mutex if the port remains
initialized, ensuring the interrupt and hardware resources are freed
before kfree(uport->name).

Reported-by: syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=843bf2f48f4d12e6682e
Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 drivers/tty/serial/serial_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..030735da6b8c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3210,8 +3210,15 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	/*
 	 * If the port is used as a console, unregister it
 	 */
-	if (uart_console(uport))
+	if (uart_console(uport)) {
 		unregister_console(uport->cons);
+		port->console = false;
+	}
+
+	guard(mutex)(&port->mutex);
+
+	if (tty_port_initialized(port))
+		uart_shutdown(NULL, state);
 
 	/*
 	 * Free the port IO and memory resources, if any.
@@ -3227,7 +3234,6 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
 
-	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
 	state->uart_port = NULL;
-- 
2.47.3

