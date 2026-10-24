Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815828;
	b=LgQz77nu68zJBzKHaN3xccsg1SxxKpJUyIXZgPrxMmaA6iUajJ1Rkct9z/euUtYV7OzS
	 yx7OolH7a2LBABs70yVlt+6V6KDMyEUYE3e7q+KXiqxi6eRcpASgTGbfKPfvhQHSTmBKq
	 z6YYw2CXEy94SbKcC4DZr+dPeqn/hny7euveb+OBZtuSCf9uxzb4oliDIkCdZSRMp1zvq
	 JsblqHWTlJBtQId/5kv91+PQ1DLBfQa/Rrps83nRbL8fMUeIQ57UPMCPwWSQs8YQE/UnM
	 7CfYID1OQx0wOdH8qKtXqshjCKSCoju3FwfEnlGxp1zwyILN6EoEiWHSp3/7Z299GKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
	b=1pV8spOvL8gJ4u1PInQpqtVO4wm+TZAeOAbhIPtoRBPq55/U4vKjOsavvj6e2OhLvA+Z
	 gorg/DH7UBJKMo4iS1irh0W3YCplbviavw3/OJKdpcWt+JB0BqdWM0fOeNmLLdsdQgg7F
	 DO6zq2ObY3sEntlR2igcSY+Jz96EKg4S0LsGN0qPknq+WUK/zPrhIA91eRTuNgHyTHZxm
	 yYPlNldoIRTNkQs+3TEbRFScU0LDqkDVrPTeedCCHPO89Ln1QqFc55amIzzm34UcUq5nc
	 lVPbWCS/oguVcBbTIfq5i3azVQDeBKRCvdNAfMXyRWzg1J0CwDLuSNWfVJDnwPDd8hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=glD74pUq;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC5606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 04:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=glD74pUq
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81ba09a5d23so1662907a34.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 21:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792815827; x=1793420627; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
        b=glD74pUqbkxWRdZnLCx3z60ZiLGN9SkQ82qloBuEp8QYlM9I7Z4/ghs9839ux9Sim3
         h0x6oKvoaSA4mG3EEKuJforRNNCa/VCIJRfUg4fip1q/XJjedlIbwt9+O7/v3W6Hx2Fv
         Xj53HOLbRTTSBbLjHxHRAVakPg/OnQ4nojy3sR3QdukG2RLNbQgZE4Bg5vpB0GXc4Fz0
         Itjqsu8/z5wrMYZVe8Zw0IrKFrK1EBeBou0i5LOCh0K4OP+tRB8i4BNeqzvOZ8Xe9rNM
         7w/tXHYufggjje0ugsQLs4fklpm0wiU1/IRjuY1nPvsp9Dx7hYHvrGowt/vmoMwWl9W4
         mYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792815827; x=1793420627;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
        b=xVx+9Q7eC2A20l/PM5TfTWBWBof63kSncvsBVoNxa9P/1/8Yey+dvaAI0PDJ/qTqZC
         t9V5ePc7UzsEJW1fAcuAjJZxZa8aMGe4I79UDjxjZAPPMAC2/IvkKWHGMCbreOehdYH0
         UKaGR6TLIiSPFStwDV84PpJnCdOgmvVmwUpM0gz9mGm2JEzGLmtk50Uka1/zkRh4I/uW
         A9F6k64djnl8FFyrDqS5mIU2gJ7JLZOs2N4cLqWDIgz7GfvnU4pq882tbhBvM7uUqaSw
         u7IuyP6nRZrvzi03/IruAwBUB15Ghd0bEFcKWAZhomdBvrz04SMPSrMqBQ63XJkXrH/Y
         3bHA==
X-Forwarded-Encrypted: i=1; AKwUvByp48DRuW3euH6g0/VjB9Pv76060G1rrNh1ihBkPcqlrUsUdAIsT7x8i0JwWxQB33T27ARM7BtqBzsu1qY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXh9k1rQOjXmZWz1gfuukTXl6yz/Yy2f9Xk7+8QsURAmJ6NcyQ
	Ypj3bBI4d5Uq32RHQDzaYr8vlA8Wutwj81T83Sc3kgjGmpaixknXBB8lWE2BhtS0
X-Gm-Gg: AYBFou0fsrn1/AMn8jBW2TnyHTGlgJy0RZaJbMs1NhT3sUYZ8mEHYzCv6QM/LtM9x9D
	6dbmWX5lnYqRaCZ+nn5RNo3veqm1DDHOjtq5y+3onp4mfwU8YBZEhavrhQ01Fy0mbHSNR98t4ow
	Idd8uKxvR8UCTW7Whc3cMxDtAI7HaXrKmFcj/2elgGhFMoJ6UsuX/zw9VynccJFkhJWdXO1JV85
	IhI155A7TA7TsAOBRfHH7bwIuBuktQldP2HpmcI/BNI7LEfN8nUXwgeSbiJvnchGzQUJcwV6A28
	1lV8+EJidFzzrR4yaXBwlsmDFFCyVVAGrSjFQSBSfmftvJwKbONTs5oCuWFDQdg8v+lpcvNqZtC
	fwipE7/f4qT/JePel5FZfi4tlp0pO+FwUx8Rt9DjyuLYAcVmYK9kXSRCplZyTDu01i7ooHwNJDF
	zWfyYGhXkCCUDrFzjtIMrw098CXrShsuB6BGeLE7VGFhpToAE1OSlVZYSphOWJPGtz6YKVMeW9o
	bn+1Y5r7f5ocpc7AnUb+KFz0ipKF62x1yVmh6riXp9cw838rtrqMEMuFugXa1mP+R7rZavAvsjO
	gRTZLPe1l47g7SzcweeIznMtSVYJHlyncBwQF20Y/ow9fq08MqLnWllBV0DieZaOkQ678J2Prhq
	AjBqIEEHlPEr82ennxa1cq+U+NLO608K7Ibe/I+m8MMlSlG1/gzSTq/J7BWnghlU76OrcSqEnmh
	/+dgJP
X-Received: by 2002:a05:6808:e89:b0:539:a2c2:aba3 with SMTP id 5614622812f47-55c00366527mr677126b6e.52.1792815827190;
        Fri, 23 Oct 2026 21:23:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c040806a7sm691649b6e.2.2026.10.23.21.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 21:23:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 22:23:44 -0600
Subject: [PATCH] Input: serport - defer write wakeups to a worker
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7DIAxErxJ5XauQSln0KlUXEEzjfggykESKc
 vdCu3yjmTc7JBKmBNduB6GFE8+hgj51ME4mPAjZVYZe9YNW/QVTsR/OWGdxloyrcCZczYtKxEW
 jts5ppQZvvIEqiUKet9/B7f7nanjSmJu1NaxJhFZMGKcWcYgln/0s+OZQEhzHF6qWmPqkAAAA
X-Change-ID: 20261023-submit-serport-write-wakeup-v1-1bdd1006fafa
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

UART drivers can invoke the line discipline's write_wakeup() callback with
their port lock held. serport forwards the notification directly to the
serio driver. I-Force's callback can transmit a queued packet through
serio_write(), which calls back into uart_write() and tries to acquire the
same port lock. A notification after I-Force queues a packet but before it
sets IFORCE_XMIT_RUNNING can therefore deadlock.

Defer the serio notification to a work item, as required for transmitting
from a line discipline's write-wakeup path. Keep the SERPORT_ACTIVE check
and callback under serport->lock to serialize with serio close. Cancel the
work before freeing serport in line-discipline close, where the TTY layer
has already excluded further line-discipline callbacks.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/input/serio/serport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index cabe3876c168..24c0d0c0c9aa 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -18,6 +18,7 @@
 #include <linux/serio.h>
 #include <linux/tty.h>
 #include <linux/compat.h>
+#include <linux/workqueue.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Input device TTY line discipline");
@@ -33,6 +34,7 @@ struct serport {
 	wait_queue_head_t wait;
 	struct serio *serio;
 	struct serio_device_id id;
+	struct work_struct write_wakeup;
 	spinlock_t lock;
 	unsigned long flags;
 };
@@ -66,6 +68,16 @@ static void serport_serio_close(struct serio *serio)
 	clear_bit(SERPORT_ACTIVE, &serport->flags);
 }
 
+static void serport_write_wakeup(struct work_struct *work)
+{
+	struct serport *serport = container_of(work, struct serport, write_wakeup);
+
+	guard(spinlock_irqsave)(&serport->lock);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		serio_drv_write_wakeup(serport->serio);
+}
+
 /*
  * serport_ldisc_open() is the routine that is called upon setting our line
  * discipline on a tty. It prepares the serio struct.
@@ -85,6 +97,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
 	serport->tty = tty;
 	spin_lock_init(&serport->lock);
 	init_waitqueue_head(&serport->wait);
+	INIT_WORK(&serport->write_wakeup, serport_write_wakeup);
 
 	tty->disc_data = serport;
 	tty->receive_room = 256;
@@ -101,6 +114,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
 {
 	struct serport *serport = tty->disc_data;
 
+	cancel_work_sync(&serport->write_wakeup);
 	kfree(serport);
 }
 
@@ -249,10 +263,8 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 {
 	struct serport *serport = tty->disc_data;
 
-	guard(spinlock_irqsave)(&serport->lock);
-
-	if (test_bit(SERPORT_ACTIVE, &serport->flags))
-		serio_drv_write_wakeup(serport->serio);
+	/* A serio driver may write to the TTY, so defer the callback. */
+	schedule_work(&serport->write_wakeup);
 }
 
 /*

---
base-commit: 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
change-id: 20261023-submit-serport-write-wakeup-v1-1bdd1006fafa

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

