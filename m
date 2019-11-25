Return-Path: <SRS0=Up7l=ZR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426FC432C0
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 02:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3CF2073F
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 02:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKYClC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:41:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37655 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfKYClC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 Nov 2019 21:41:02 -0500
Received: by mail-io1-f72.google.com with SMTP id p2so9943127iof.4
        for <linux-serial@vger.kernel.org>; Sun, 24 Nov 2019 18:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=F6ESBQ5BrJgEXe13MibsQZiG8CziRMl+GW1tZsPwxAk=;
        b=cnzJTk19JlLa25DaLkGxkHePP3gzM5gBpyVxhgzLrmcXfjj9ik7qMhJBFoxAo5nN0G
         rGI9TkLrb5ZwpEEMdHMsIAhE6/8Hqwu6rVM9JjL833U/xtUEH/hbe2iBsz0ynGNp0bRt
         aj/JzQTWMrJqE8qRiN1vLcQKNwSRy9SB4FJi4bOKcv8cxPZmXE4HomWZx6mjrnIKCIcI
         B3S1Pzdgj4dq8xm7WYMCkxMQ9bKG3VTaGvszFs25lu++xY34mJKxctVpEmJRU9/gqB6s
         bTRxphnRsuu5gNZ3FfT0m4xZutkumpnUHUgleKtlU4lCp3ZKraRbYhl7LecDnfQj40Wr
         NN/A==
X-Gm-Message-State: APjAAAVSDEI9YEA87ZXGvHktD4mwgjGQ9qXgZeGW940TrG3TlyEECKA8
        18ghkhmqFJLWZ7C7z6wN6zCdixMowOLWPm7Wj9IKP12zZ/Hw
X-Google-Smtp-Source: APXvYqzgktbuH19cOR1hGiNDDr9llthRGZ7kDd0HTaEUVdWfkRmuL4IAoR7sjdNEMnGGhyMwqsAMmAbAlIu4rV3hOgC0XgNBFuHt
MIME-Version: 1.0
X-Received: by 2002:a92:d289:: with SMTP id p9mr9707923ilp.201.1574649661538;
 Sun, 24 Nov 2019 18:41:01 -0800 (PST)
Date:   Sun, 24 Nov 2019 18:41:01 -0800
In-Reply-To: <00000000000087008b056df8fbb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8c995059822b10d@google.com>
Subject: Re: possible deadlock in console_unlock
From:   syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com,
        syzkaller-bugs@googlegroups.com, threeearcat@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot has bisected this bug to:

commit b6da31b2c07c46f2dcad1d86caa835227a16d9ff
Author: DaeRyong Jeong <threeearcat@gmail.com>
Date:   Mon Apr 30 15:27:04 2018 +0000

     tty: Fix data race in tty_insert_flip_string_fixed_flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d9bc0ee00000
start commit:   0ad39cb3 Merge tag 'kconfig-v4.18' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11d9bc0ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d9bc0ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9a1f3aa8b8ddd16
dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c89b9f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167f596f800000

Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com
Fixes: b6da31b2c07c ("tty: Fix data race in  
tty_insert_flip_string_fixed_flag")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
