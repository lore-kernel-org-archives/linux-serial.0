Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B5C43334
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 03:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiFODpd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jun 2022 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFODpc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jun 2022 23:45:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7154F9C8
        for <linux-serial@vger.kernel.org>; Tue, 14 Jun 2022 20:45:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cx11so10125972pjb.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Jun 2022 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Ij0HeSRkan/+wey0vwv6gSX6CvJy1hzGRjbCjEEi0Q=;
        b=qjCUrFHlnegDisybMGm1kPk0yBV8sPt4VgivPoRadfTH2hN9Z/I9ac3qqER/NAhZpD
         wVlwLa9lrR/s+FC+ScKiz5BrgySbWS4cO0w4YpKAH08ZEzLnGlclsw+QAQUkDB3/fHlC
         XD0Ffzo2aBH5TTSoaCXX0cq9reHMChFZEQ9x2SUVCbh4F0R957GKjMU5+LsTB0H1LEEQ
         r1YMwKpYdd/3fgFzY83WCiOu8K8o4nBhKok4dwe7sX9FNYSEo6fnQTf3vdPNipCBt4dZ
         r7bYnRNaLTZR9buufKOkZ8XtuXvRo71bDYMoGui6p2WReBtMs5UJLNVPYF6MKT776Xyw
         Ihew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Ij0HeSRkan/+wey0vwv6gSX6CvJy1hzGRjbCjEEi0Q=;
        b=IhAE+RpZBqbCwDmroyfVu9zeGcgh3Q3WGTgomJRAMf8BAIGab+3dlxyElzKzg+aHsy
         kJESM1AA7YpRXXdUAxWkoiAAhs2gpeYewDBUr0ORrnPoBh5bWXgf83RAbM/VqEoy/p3S
         4zQv5arw2eNdiUo1hAvGz8rwFi4oi22NmhZIGLrMfsbqGuQVy9jQCzwoe9UCiSTHczqJ
         vWzmsErrKhGq6/WLYVx+LsJobe0t+JEKdSlyEZJF8W1cwAeRmp69oC2AbcR4hT/1WXa+
         y+q3uw8fO9zZKILH8gcMGA8NYPFE0f51KKxbK5hyG35ltWcrXV4tUmNpRBtQEgr5n9e6
         gtKQ==
X-Gm-Message-State: AJIora8AhYkSOh2l4NZijeMhrVQFb7fN6KU1TeNgmWvfF6Vd+EGJk3Lk
        MxaKd/hTekqBeVEn1cCByD4=
X-Google-Smtp-Source: AGRyM1tP9cLBvxoQyB5wuk5m4Amb+DVQKPeggzt4UYjXDUvK2DCXUGqGHsaOkqcMwcX741j5yb1PFg==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id s11-20020a17090302cb00b0014f4fb62fb0mr7512290plk.172.1655264731426;
        Tue, 14 Jun 2022 20:45:31 -0700 (PDT)
Received: from localhost.localdomain ([43.155.90.222])
        by smtp.googlemail.com with ESMTPSA id t4-20020a1709027fc400b00163fa4b7c12sm8077585plb.34.2022.06.14.20.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2022 20:45:30 -0700 (PDT)
From:   cael <juanfengpy@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org, juanfengpy@gmail.com
Subject: [PATCH v4] tty: fix hang on tty device with no_room set
Date:   Wed, 15 Jun 2022 11:45:10 +0800
Message-Id: <1655264710-26055-1-git-send-email-juanfengpy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Yqdx0W8HhvT5qZlP@kroah.com>
References: <Yqdx0W8HhvT5qZlP@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have met a hang on pty device, the reader was blocking
at epoll on master side, the writer was sleeping at wait_woken
inside n_tty_write on slave side, and the write buffer on
tty_port was full, we found that the reader and writer would
never be woken again and blocked forever.

The problem was caused by a race between reader and kworker:
n_tty_read(reader):  n_tty_receive_buf_common(kworker):
                    |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
                    |room <= 0
copy_from_read_buf()|
n_tty_kick_worker() |
                    |ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <= 0 is met. At this moment,
reader consumes all the data on reader buffer and calls
n_tty_kick_worker to check ldata->no_room which is false and
reader quits reading. Then kworker sets ldata->no_room=true
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if write buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

This problem can be solved with a check for read buffer size inside
n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
is true, a call to n_tty_kick_worker is necessary to keep flushing
data to reader.

Signed-off-by: cael <juanfengpy@gmail.com>
---
Patch changelogs between v1 and v2:
	-add barrier inside n_tty_read and n_tty_receive_buf_common;
	-comment why barrier is needed;
	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
Patch changelogs between v2 and v3:
	-in function n_tty_receive_buf_common, add unlikely to check
	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
	 is removed here to get locality;
	-change comment for barrier to show the race condition to make
	 comment easier to understand;
Patch changelogs between v3 and v4:
	-change subject from 'tty: fix a possible hang on tty device' to
	 'tty: fix hang on tty device with no_room set' to make subject 
	 more obvious.

 drivers/tty/n_tty.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..544f782b9a11 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	/* Did the input worker stop? Restart it */
-	if (unlikely(ldata->no_room)) {
-		ldata->no_room = 0;
+	if (unlikely(READ_ONCE(ldata->no_room))) {
+		WRITE_ONCE(ldata->no_room, 0);
 
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
@@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			if (overflow && room < 0)
 				ldata->read_head--;
 			room = overflow;
-			ldata->no_room = flow && !room;
+			WRITE_ONCE(ldata->no_room, flow && !room);
 		} else
 			overflow = 0;
 
@@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+	if (unlikely(ldata->no_room)) {
+		/*
+		 * Barrier here is to ensure to read the latest read_tail in
+		 * chars_in_buffer() and to make sure that read_tail is not loaded
+		 * before ldata->no_room is set, otherwise, following race may occur:
+		 * n_tty_receive_buf_common() |n_tty_read()
+		 * chars_in_buffer() > 0      |
+		 *                            |copy_from_read_buf()->chars_in_buffer()==0
+		 *                            |if (ldata->no_room)
+		 * ldata->no_room = 1         |
+		 * Then both kworker and reader will fail to kick n_tty_kick_worker(),
+		 * smp_mb is paired with smp_mb() in n_tty_read().
+		 */
+		smp_mb();
+		if (!chars_in_buffer(tty))
+			n_tty_kick_worker(tty);
+	}
+
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
@@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (tail != ldata->read_tail) {
+		/*
+		 * Make sure no_room is not read before setting read_tail,
+		 * otherwise, following race may occur:
+		 * n_tty_read()		                |n_tty_receive_buf_common()
+		 * if(ldata->no_room)->false            |
+		 *			                |ldata->no_room = 1
+		 *                                      |char_in_buffer() > 0
+		 * ldata->read_tail = ldata->commit_head|
+		 * Then copy_from_read_buf() in reader consumes all the data
+		 * in read buffer, both reader and kworker will fail to kick
+		 * tty_buffer_restart_work().
+		 * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
+		 */
+		smp_mb();
 		n_tty_kick_worker(tty);
+	}
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);
-- 
2.27.0

