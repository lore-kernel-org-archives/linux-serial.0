Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15018C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 02:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiEXCVS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 22:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiEXCVR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 22:21:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5B7672
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 19:21:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i68so12931599qke.11
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uf2Jdsip0ywvu8mLU9XReWchD1u3huP01v2DKhSll3g=;
        b=X81R8zYPfroNkR9HHoF6rEVi2xjM2I0P630wizJ0RnOiHByp9v8tkrpG4i2isl55ig
         Udh7YObYXYxz7vB6+FryTlyCdZzGJk+m8kc8yEDoWeWLI7FLdlb9e/KUFuScGPPRmF24
         jKJq0qT8eo039F+U8HFa5DytbRAXrbFSUHhsM1yv953LoHZRvfcDBWB1HMPmCCWrvmUA
         RC4GOW5LqsD57Z9V6vuFB/jZ7VXoIDR/547ejKxOjaGZvUcIUBA7pEHSoJ1sRrqxCEdV
         RrmJAkZEO6YNOBYBFFEvthdl3r23OFhZrmQL0i9m6CpoEOUetQg+cSJALwB1hc/bhw/m
         Z86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uf2Jdsip0ywvu8mLU9XReWchD1u3huP01v2DKhSll3g=;
        b=VoArWE4a6imgTwhr2kHJQFhrgx07Lw56B+7Xx7EZC+VaVv7Hchao3VVyanuj9g2hIx
         6S0z8cAtC0Sz4wsjgttxXsylAPq4NY8gaFk7fUMUc3jPdLFRXkWf3Y6O54HARMljFf0E
         hAz+AoNehepIjXpfISo3H6tiwQn9lczP/vXTcP29ktiptkcrjyQrM+43zuRA96cMwveg
         rtoO3loLbvRITzx3FX+d60HUzo/JlY50CymerkMRxTrhKoGBq7Fh1zkl7+V+VVkYVoRp
         B99edm86MjwexrGzu0dYgbQyOuhCXr7EHooOIIQQ5fA1KJq/FoPX702OibFzg5ClCyvM
         hDkQ==
X-Gm-Message-State: AOAM531L2g3JeN2B92WSD0ZgaE+pwy6tCM8TW6u2OittUgQRTdiQNc6i
        IMa6iPzv9FqE4A61HQMsodmKOyDKULCgtyvXtVhWgI4vxKw=
X-Google-Smtp-Source: ABdhPJyAh/B2rIKt18ap79MAF4IulCN+Ft1hLwMwVC4qIWRdZszA48gynVj3RimOhf8E8wKfxXLcl5Lk4bkqpvq1cLs=
X-Received: by 2002:a05:620a:b0b:b0:6a3:5f9a:1b80 with SMTP id
 t11-20020a05620a0b0b00b006a35f9a1b80mr9353747qkg.283.1653358875671; Mon, 23
 May 2022 19:21:15 -0700 (PDT)
MIME-Version: 1.0
From:   cael <juanfengpy@gmail.com>
Date:   Tue, 24 May 2022 10:21:04 +0800
Message-ID: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
Subject: tty: fix a possible hang on tty device
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have met a hang on pty device, the reader was blocking at
 epoll on master side, the writer was sleeping at wait_woken inside
 n_tty_write on slave side ,and the write buffer on tty_port was full, we
 found that the reader and writer would never be woken again and block
 forever.

We thought the problem was caused as a race between reader and
kworker as follows:
n_tty_read(reader)| n_tty_receive_buf_common(kworker)
                  |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
                  |room <= 0
copy_from_read_buf|
n_tty_kick_worker |
                  |ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <= 0 is met. At this moment,
reader consumes all the data on reader buffer and call
n_tty_kick_worker to check ldata->no_room and finds that there
is no need to call tty_buffer_restart_work to flush data to reader
and reader quits reading. Then kworker sets ldata->no_room=true
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if writer buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

We think this problem can be solved with a check for read buffer
inside function n_tty_receive_buf_common, if read buffer is empty and
ldata->no_room is true, this means that kworker has more data to flush
to read buffer, so a call to n_tty_kick_worker is necessary.

Signed-off-by: cael <juanfengpy@gmail.com>
---
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..36c7bc033c78 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (!chars_in_buffer(tty))
+               n_tty_kick_worker(tty);
+
        up_read(&tty->termios_rwsem);

        return rcvd;
-- 
2.27.0
