Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF953B0AF0
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729562; cv=none; b=DTyNg1tj1lf5CP5HGjroZbk301DxiV/QPF/9MkFZcsmjE8t22LF2t5ZqjrVZJJK+4RsU+xGKq7q+BGPG54fFAlGFVp8AmFcT3oIJyHfAvRNuNrFOHm7npHC/xD6MuSKjmG16Tz0HPBj80BbARkkPTVWNukJ8+ng/I0iiJZGQqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729562; c=relaxed/simple;
	bh=/KrtSiS5MivC3u0JqMMRfaAggd3pNZKQnsME6DgWEPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxQ+ga8Lih4qPZiDPiOoykaiFSrwjJ4m2Ht/AItug/vd7YKhFXGL55HV4dv/8O6GMCSLXjyk2Ego3ZvNey2Ei+ce4mHpLQzGdiiJ8XS3k5cU7i3FI5Xpl8z0aM2pstaan73CDJvp2gVthIn1zTbisIaLSbW/WZsIddGB2Xo3QGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEaZzt6V; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEaZzt6V"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso980167a12.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787729559; x=1788334359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPWaGeR1MUDdLk1lsk2+05G43PRnssA/Efn40Sg+GhI=;
        b=fEaZzt6VXEHZgp72Yo20uOQCDl9EGDpAKAxxSprh7bFQ19Easv3dYNAB2wksIFcKLi
         ij6pa+7+HF/vAYuG/wUlbcMuRl5rcQ8dOKVtHlVO/Pjm0pZDGJCGmMTrHFz2EKeME7V+
         IcD3zUqcoJz0cPWl7TwVruLAHjd69RxZQhTMxAhbxMIrj0L+ZE+mJ166NWcDDNN7AcUj
         V2L06vvaEt7qCJCsRie8bjK43F1Fz2rHGS+I+uCzPj2cdhpXB7arFnISvnP6whbOjCLF
         noMiJMg0kKthL6TDTPey+42k31z4d3qltrEeAULIWb9u8HVjjwh/RWQEiDE+mJ9kofdA
         nueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729559; x=1788334359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPWaGeR1MUDdLk1lsk2+05G43PRnssA/Efn40Sg+GhI=;
        b=AzhynulQZG1OHRN9W4IMNFwSDuHtRwT5SR/ty45Tu1ywERlN9PKSyCV2jV6/eWhEd7
         vVYU0RrnW4fFQwL7caKEFk1omfo7JcjSjZGo3qqal71tESLtxiaRhS5R4mBCvZDlgvqg
         HKZsQ4f+5yrVeTLLzHA0b7r8gsoasuxtlEiDyO4TiaNB1CpIlj9JWQLpfR3oLfCSnJu8
         j6ceWJhyzo1Ip13JR1HqcoW/2UmszbukzuyZQh+nliNgkzjzbvqdyJZpArnnjGeC0APk
         Vs0l36Z4sxD4CAGfCUCkAzM5cV9AE7bvLLXe2Ou6OuM1WyIvIenPF8goJDRc1AoMqimx
         88jQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQ3WD4NSWRwE3GTN/Aeuo1naOnIdtyYrA/3WDso78DQwRfPUcZZeGPX6DxoZ4yKioOUBep2hhqKcoAEBI=@vger.kernel.org
X-Gm-Message-State: AFuF++nqoIX6rLnyJ8H0TAAybAX++BUHhLPNMtEj/BUGRx8N1BEte6yb
	LMu6iT3w0ULPmNcyw+Hwa/HidO9nkc+AOYoNjK8tPeTK6ALdrpWIe2qK
X-Gm-Gg: AR+sD13CJw+Q2x3G8TAyXKsCda85EzDAXSGUCxfSzt6YYqsF1hrk0lo3iJGeEWv7sGV
	r45gYcm0dH4zkh+cCWiB//sHKHfN6msHoELHTuUKk5xZk7TYSaL1ir+wFFg4n8M7Eq0LcRQIp4s
	g8J7fhEwLR71WdmlYQ3IPn/ISvtl3zrzRhVkt2lbTZIOWyrow3QAGbv1soDdDuDMUpGs9rDzrPX
	vWwenmnzvk4BTbpTmLCJM9ijKKDcALqYeEg+LobBPZEbVi5195rpM47OKIlKYHdHYhu1x5+fWbU
	E3s/8nQJuM7rQBqFHqzLZk+PMsAB4jKChBw/I3Wr+qKdufsSaWZHt2eebpgLTynWAUj3zOVV52Y
	gxOsxOPHxX+mYa/rETScNCXFAO7VgWxLgOrb0wleZbVMj7y+JT1gns3Y/C6GGfX/SQVEs6L1UZy
	nGWwQ1BAtozDLhpOc5YPdTLmLBqX+pXwkj3LuEHxFDdTIZSE876cmxMRFZ5SO67KwVy1A=
X-Received: by 2002:a05:6402:254c:b0:69f:b1d3:3903 with SMTP id 4fb4d7f45d1cf-6a5df5e323amr4944312a12.8.1787729559117;
        Wed, 26 Aug 2026 00:32:39 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deae9a75sm2655883a12.28.2026.08.26.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:32:38 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ruslan Valiyev <linuxoid@gmail.com>,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] serial: core: fix NULL pointer dereference in serial_core_unregister_port()
Date: Wed, 26 Aug 2026 09:32:36 +0200
Message-ID: <20260826073237.1377668-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_unregister_port() dereferences port->port_dev before it has
been checked:

	struct serial_port_device *port_dev = port->port_dev;
	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);

serial_core_get_ctrl_dev() takes &port_dev->dev and reads dev->parent
straight away, so a NULL port_dev faults at offset 0x40.

port_dev is NULL whenever no port device is installed:
serial_core_remove_one_port() clears it on teardown, and it is never
set if registration failed before serial_core_port_device_add().

serial8250_unregister_port() reaches that state. It calls
uart_remove_one_port(), which clears port_dev, and then re-adds the
port with uart_add_one_port() without checking the return value. When
that re-add fails, port_dev stays NULL while port.dev still points at
the ISA platform device, so unbinding that device once more calls
serial8250_unregister_port() again and oopses:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  RIP: 0010:serial_core_unregister_port+0xef/0x990
  Call Trace:
   serial8250_unregister_port+0x1e4/0x8a0
   serial8250_remove+0x8c/0xb0
   platform_remove+0x5f/0x80
   device_release_driver_internal+0x46b/0x640
   unbind_store+0xf8/0x110
   sysfs_kf_write+0xf2/0x150
   vfs_write+0x6ac/0x1050

Return early when there is no port device to remove, and read
port->port_dev under port_mutex, since every other update of that
field is serialised by it.

Also clear port->port_dev on the serial_core_register_port() error
path. serial_base_port_device_remove() frees the port device but left
the pointer behind, so unregistering after a failed registration read
freed memory instead. That is the use-after-free variant of the same
crash, and matches the title syzbot first reported this under.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
Cc: stable@vger.kernel.org
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
Reproduced and verified on 8d3ae59288f1 (Linux 7.2) with syzbot's config,
under QEMU/KVM x86_64. Over six runs of the reproducer:

  stock:   6/6 oops at serial_core_unregister_port+0xef, with the same
           Code: bytes and RDI=0x40 as the syzbot report
  patched: 0/6 oops at serial_core_unregister_port

checkpatch.pl clean, W=1 build of serial_core.o produces no new warnings,
and the patch applies cleanly to current mainline.

Please note the reproducer does not run to completion on a patched kernel.
It goes on to hit two further problems. Both look pre-existing and neither
is addressed here; I am describing them so the remaining crashes are not
mistaken for this patch failing.

1) tty_cdev_add() drops the last reference to the cdev when cdev_add()
   fails, but leaves driver->cdevs[index] pointing at it, and
   tty_unregister_device() then calls cdev_del() on the freed object:

     WARNING: lib/refcount.c:28 at refcount_warn_saturate
     Call Trace:
      kobject_put+0x26f/0x6f0
      tty_unregister_device+0x118/0x1c0
      tty_port_unregister_device+0x60/0x70
      serial_core_unregister_port+0x333/0x9a0

   tty_unregister_device() also calls cdev_del(driver->cdevs[index])
   unconditionally, and that entry is NULL when registration failed
   before tty_cdev_add() ran:

     KASAN: null-ptr-deref in range [0x60-0x67]
     RIP: 0010:cdev_del+0x26/0xa0

   serial_core_add_one_port() reaches both: it treats a failed tty
   registration as non-fatal, flagging the port dead and returning
   success, so the port is still unregistered later.

2) Registration is not failure-atomic. serial_core_add_one_port() links
   state->uart_port before the kasprintf() and tty_groups allocations, so
   a failure there leaves the port half registered. The state is never
   released, and because serial_core_add_one_port() starts with

           if (state->uart_port)
                   return -EINVAL;

   that line can then never be registered again. Unwinding it properly
   means undoing uart_configure_port(), which claims resources and can
   register a console, so it did not look like something to bolt onto a
   crash fix.

While here I also noticed serial8250_unregister_port() ignores the return
value of the uart_add_one_port() call that re-adds the port to the ISA
device, which is what produces the NULL port_dev this patch guards
against.
 drivers/tty/serial/serial_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b434..5bf71d7bbd223 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3327,6 +3327,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	port->port_dev = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3341,12 +3342,24 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct device *phys_dev = port->dev;
-	struct serial_port_device *port_dev = port->port_dev;
-	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct serial_port_device *port_dev;
+	struct serial_ctrl_device *ctrl_dev;
 	int ctrl_id = port->ctrl_id;
 
 	guard(mutex)(&port_mutex);
 
+	/*
+	 * A NULL port device means there is no registered port device to
+	 * remove: serial_core_remove_one_port() clears port_dev on
+	 * teardown, and it is never set if registration failed before
+	 * serial_core_port_device_add().
+	 */
+	port_dev = port->port_dev;
+	if (!port_dev)
+		return;
+
+	ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+
 	port->flags |= UPF_DEAD;
 
 	serial_core_remove_one_port(drv, port);

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

