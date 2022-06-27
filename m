Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB070C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiF0Nxn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiF0Nxm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 09:53:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364DC643D
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 06:53:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p14so9089863pfh.6
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OT+NamPZD6/uteew7Rpl/viXgXJn0pata9/96KMVHDo=;
        b=HXevJdkh4uNKXtuYqg3InoWeQ5PsmotCB+p65hOH4LNJQyuhHhy8RFaAm2+vIUU+Ng
         ALZ4S9ZvNRsGCImuF1/cm4D/c5++I7zhudFFj302eWDZICxmG8R61Mx0anDzF0lX8EZ2
         ANeFT3eCMg1Xy+FJjbxg+n/xZeb79ulrbmtL+oHoxXmWDJKQBfLQVaagDc5P3XMFL4QI
         rYJ/1NkEQEXLiCHaXG95vR1Siq4/74aJKLtMEV6i4LfWXmDhiQJS6qJbQf36jA4ru32j
         L2hDRd3qBx2i+8SE3a9HBiFNYiLgKULU6g2oiWlHg74xNB2G6RsEmkugABz+eO1hGrEh
         NuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OT+NamPZD6/uteew7Rpl/viXgXJn0pata9/96KMVHDo=;
        b=OBXI82fz3eVvlY9wpnQ8aKN70US96YYdAugqex/5gQZVDQJuHelvKLJiGubzh30CaF
         NEcB1soOAj2aRB7MQN6uM4lL2kZlAO4weNPb07W7o7jzH88448/SoCEMOzEXknQvBoor
         ULEitClsxOws1syqBbJjl1wL3fj4AM1G/C5a+wPV3CHrYOKuoORhILr7chUquMzDBNXV
         YGTSxzrg2OlVqLKWEO9xlev/3laeEcFFDnkQVxIlpvXufDjPVLV23y5WXnbM1fIFJnGz
         nIADSXUkcI/Rjf0EOk12EW6vDK/69ElR5dIfksKDtbzUKL4S3vzoJXI9XmZSN9HHSZ5I
         CVrA==
X-Gm-Message-State: AJIora+16Ktjjqh+sui2Ccan0JxycyVZQmml10trhXiBfhDF4oc/HvTs
        76eaAvz05aYbbz6o9QnyecY=
X-Google-Smtp-Source: AGRyM1vLEqjF6ppPlpxffOvg+eLmAegEtvBKxWcFcpiAxhuZfW2ndBQ7hZ5J735CWnYlPrvxqmXn6g==
X-Received: by 2002:a05:6a00:22cb:b0:525:ba83:559a with SMTP id f11-20020a056a0022cb00b00525ba83559amr5350849pfj.54.1656338014222;
        Mon, 27 Jun 2022 06:53:34 -0700 (PDT)
Received: from localhost.localdomain ([43.155.90.222])
        by smtp.googlemail.com with ESMTPSA id h9-20020a170902f70900b001663cf001besm7219756plo.174.2022.06.27.06.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:53:33 -0700 (PDT)
From:   juanfengpy@gmail.com
X-Google-Original-From: caelli@tencent.com
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org, juanfengpy@gmail.com,
        caelli <caelli@tencent.com>
Subject: [PATCH v6] tty: fix hang on tty device with no_room set
Date:   Mon, 27 Jun 2022 21:53:18 +0800
Message-Id: <1656337998-30655-1-git-send-email-caelli@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YrmdEJrM3z6Dbvgn@kroah.com>
References: <YrmdEJrM3z6Dbvgn@kroah.com>
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

Signed-off-by: caelli <caelli@tencent.com>
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
	 more obvious;
Patch changelogs between v4 and v5:
	-name is changed from cael to caelli, li is added as the family
	 name and caelli is the fullname.
Patch changelogs between v5 and v6:
	-change from and Signed-off-by, from 'caelli <juanfengpy@gmail.com>'
	 to 'caelli <caelli@tencent.com>', later one is my corporate address.

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

