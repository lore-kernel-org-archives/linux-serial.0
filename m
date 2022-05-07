Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2886C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  7 May 2022 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiEGJPe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 May 2022 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiEGJPd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 May 2022 05:15:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A033152E
        for <linux-serial@vger.kernel.org>; Sat,  7 May 2022 02:11:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x22so7670015qto.2
        for <linux-serial@vger.kernel.org>; Sat, 07 May 2022 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=InIUFO2xPCGgMqAwMXEOJPcVlLbbEQaW5WMSlm16vJ0=;
        b=Tq4M7kNPza0Y+JgmxvjzNWgRfpwRcMbYX1jls/xdfunsx50SWw3SV1s1fOX9KXP7ZY
         xeHpdXMWEz1Wah3kdpdJ2NA8PZe0MGcxu9TA4XxQRzCc8I7UlzA7Zf8pqvxy6JGvnyIJ
         Jhlhzx8IPcqxJjjpIcd6mT8UMzVghiwJK5BFFo+tQEBMwLVexdOsp1Fe+qC+qjtj7R5o
         BdtrYh6NViAiDPNBXNnzb3+V6VKY4wxOOrzu/IfLcEqrCyqGqbNMwFRKGmBlu75ubtXG
         9CHMWIm1aEfywAjKu4moG1GyzYxeL5mACyA8kcPvgglGQxsrTsQbsJwRCkOuBZ1qPKLt
         FEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=InIUFO2xPCGgMqAwMXEOJPcVlLbbEQaW5WMSlm16vJ0=;
        b=bm8qKlJixBlgvm2A+k6xMm3awz0GWPHftP+iQslYK2NeKhPIblWEyqLQuLNJng5uS3
         jfkia7FcYY2pUJeFYwsdSgHFFuDogmQrk/gU1RlUDHixGjPfYSPOIOgFzlmtBnLa8QHZ
         c+3TupWWC95Pn57IGekdfVRRkQxmDj3lXyj1bgzWbkxvM24L1s53UxP6fkz3ysvLQcu4
         X+GCwpoqa3vAkrQn46cHiHEIHmC9JKG+rCc1oSsP/pLGMtAWMZs5dI/9XKJ8jQG8Ri7n
         bq4duivLTWQ49QACNHMsdq3U1vQIA1nzlSqBRcRZzEnzPRQOL68sZVHj340oCoDrU8Ni
         J1yg==
X-Gm-Message-State: AOAM531XRHJH6GeYH81cLxcyqyVVFBE7SfDNfe+5IStKi0hFwBKcVsaf
        2S1HSdTcAXfYmtUmLb1PdKkTzcru8lGt+4aZLyPqVsIaOw8=
X-Google-Smtp-Source: ABdhPJwtTZE/CQUL1wAnjKsTZim8Owu2U+Hihhqpd3h9mBxavfD3dqjaYQoHSGzPi1CoCPG5NbOsQv8IDiWWsH/vhTY=
X-Received: by 2002:ac8:57d1:0:b0:2f3:b340:1e2e with SMTP id
 w17-20020ac857d1000000b002f3b3401e2emr6592746qta.52.1651914706783; Sat, 07
 May 2022 02:11:46 -0700 (PDT)
MIME-Version: 1.0
From:   cael <juanfengpy@gmail.com>
Date:   Sat, 7 May 2022 17:11:35 +0800
Message-ID: <CAPmgiUJkzZacYnMOFU+SsEoLZPdiSaOxiugOcLCj88OQUvJm_A@mail.gmail.com>
Subject: tty: fix a possible hang on tty device
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have met a hang on pty device, the reader was blocking at epoll on
master side, the writer was sleeping at wait_woken inside n_tty_write
on slave side , and the write buffer on tty_port was full, we found
that the reader and writer would never be woken again and block
forever.

We thought the problem was caused as a race between reader and kworker
as follows:
n_tty_read(reader):                            |
  n_tty_receive_buf_common(kworker):
                                                           |
              room = N_TTY_BUF_SIZE - (ldata->read_head - tail);
                                                           |
              room <= 0
copy_from_read_buf(tty, &b, &nr);     |
n_tty_kick_worker(tty);                       |
                                                           |
              ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush data
on tty_port to reader, and the kworker finds that reader has no room
to store data so room <= 0 is met. At this moment, reader consumes all
the data on reader buffer and call n_tty_kick_worker to check
ldata->no_room and finds that there is no need to call
tty_buffer_restart_work to flush data to reader and reader quits
reading. Then kworker sets  ldata->no_room = true and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if writer buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

We think this problem can be solved with a check for read buffer
inside function n_tty_receive_buf_common, if read buffer is empty and
ldata->no_room is true, this means that kworker has more data to flush
to read buffer, so a call to n_tty_kick_worker is necessary.

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f9c584244..4e65e2422 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1760,6 +1760,8 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (!chars_in_buffer(tty))
+               n_tty_kick_worker(tty);
        up_read(&tty->termios_rwsem);

        return rcvd;
