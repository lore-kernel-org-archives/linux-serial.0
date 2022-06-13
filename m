Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A16C43334
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jun 2022 17:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiFMRRy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiFMRRk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jun 2022 13:17:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1782F688B
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 05:32:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c196so5637081pfb.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZ5VZzsljkigqioi3VWFd7hz7DH2WAUyfbFhcQhQd9I=;
        b=l1QV1QzOl7MGqLLJVz1k67s1ICsnqMpbuk0dasqMvLTFzOOPxTolOu7H30rOi2LSM5
         TMVxTNj+z1N9W9J00k7FJyr07WcZNFyRMN4PBkLCfnGenVXGD1E7GJHFFmBrWWGIxR11
         PB/HjVhrjcTu8ecGeIbk5ESNI0RtVjB/QMQgxv4IyoJbJIyhkULr73D1PUPhw9xHOpa8
         KaAr3qA3w4cBM6xQ9nRl8l2yFAylF8Q4JsBMbyWEAk6SbCGsTU8X/1ygbYsKg32Ez8iJ
         +O71vKbbxIuyJFPbdjdBKqYjAqxPqs+PIQB9KMcwYy83KBy45bFaJb2j8WHz/jrp1wAr
         jIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZ5VZzsljkigqioi3VWFd7hz7DH2WAUyfbFhcQhQd9I=;
        b=CIb8iX+XWCrkMzhg5cylgFw9n9G/y/EgjAI72Ob34hfkGZ5o7KmiLbu9V7wjIqpgqv
         /TXKQwgu3zC7Nxeob1TJ6QFMiN6ed+8v/ja5lgHe8XkB6w1y1i7J+o8TdsJyTC4zREaE
         KebJIwwGuMGrgRTr00bPhrA44aTK74rOKJ2febLfCXV/nJZTtEziA969LZs/efbGKoAi
         diI1LwRxM0xA6dG/UcGqYEBPKohLOrb4jHGPS2btKAWqeJfBwhQWJlzdkiyHqaHfepj+
         ce79aOoNRdMa720GsBYV321RoK9wxluOQL7Ymk8170QGflcAvQew/BWtqehEjqyCIFiW
         94WA==
X-Gm-Message-State: AOAM533aFAltYVkIUUGStK5vsQu96Ug8y3+TKlsp5vBug+eT5+jHiHEo
        b29UlDySNOzsrGw2MLj5OLM=
X-Google-Smtp-Source: ABdhPJzaPPhIO+OEHXxysHesoacyWTz4Y6WBy99IM/usq/Kf6e1zB88S4fzt8o5jvrhEh5YawCQlRA==
X-Received: by 2002:a05:6a00:16c1:b0:520:6ede:24fb with SMTP id l1-20020a056a0016c100b005206ede24fbmr15516342pfc.7.1655123514173;
        Mon, 13 Jun 2022 05:31:54 -0700 (PDT)
Received: from localhost.localdomain ([43.155.90.222])
        by smtp.googlemail.com with ESMTPSA id c14-20020a170902848e00b001678ce9080dsm4966223plo.258.2022.06.13.05.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2022 05:31:53 -0700 (PDT)
From:   juanfengpy@gmail.com
X-Google-Original-From: caelli@tencent.com
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org, caelli <caelli@tencent.com>
Subject: [PATCH v3] tty: fix hang on tty device with no_room set
Date:   Mon, 13 Jun 2022 20:30:29 +0800
Message-Id: <1655123429-15376-1-git-send-email-caelli@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YqRFBMXz7/9SkL5F@kroah.com>
References: <YqRFBMXz7/9SkL5F@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: caelli <caelli@tencent.com>

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
reader consumes all the data on reader buffer and call
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

Signed-off-by: caelli <caelli@tencent.com>
---
Previous threads:
https://lore.kernel.org/all/CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com/t/

I corrected some format problems as recommended and switched client to git send-email,
which may be ok. And subject is changed from 'tty: fix a possible hang on tty device' to
'tty: fix hang on tty device with no_room set' to make subject more obvious.

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

