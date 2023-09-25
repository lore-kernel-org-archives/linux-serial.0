Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CDECE7A81
	for <linux-serial@archiver.kernel.org>; Mon, 25 Sep 2023 11:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjIYLze (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjIYLze (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Sep 2023 07:55:34 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267CCF
        for <linux-serial@vger.kernel.org>; Mon, 25 Sep 2023 04:55:27 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3adbcfd059aso14684758b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 25 Sep 2023 04:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642926; x=1696247726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJysYUBTudzCJaC5ycCUZJm2e0YF/I5kcWtF15e4Fdc=;
        b=Kkx1BcXaDA+03PupinCNZ4KZA+IKOYl1ZP45b8K+pQTeyw74eCoR1AaE7anTF2h4F7
         k3ayMDMT2X1maR9L/MEH55f7UMKKvARegDY14iC8Ji5ewi0t2LGjHytMXv3NMr3dpLW2
         83sy/S2EvEyNzMGKxGvpXwx3jjNrWfQtC3xWKa001uOax4leeE02oD0YC8FZBwLmllSI
         uX6MmXNiecakqjT6mODzvw5h3FVihOVSG8rAo75mYfKFFzcegYCw6hRAElS/WWaM4n8p
         kL1QoQc4zubmuS3zw2YAF5t5f0MN7pA108D+KToY2V9f4BZ8OU+1M0ypcY7KBcWLhWP0
         10gg==
X-Gm-Message-State: AOJu0YzLqxlrouVCP2NQDoa+Bq1GRjfqh30QAPXuIOGS5iJAN8nMDIc5
        tQklMfXgj8XQzkFZ3StN2ddyB5o+wXomnzw7iHQb5PpbjdpI
X-Google-Smtp-Source: AGHT+IFAcAn45kItchAUgSWnxHagzXzt3p5LJ66zKO8Mh4B2rhrC/tnR+O9EXoGAIhW/7FdiZUGHPECMYUufV71m7IQn1sjj2jDB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2199:b0:3ae:c95:ad2c with SMTP id
 be25-20020a056808219900b003ae0c95ad2cmr3860207oib.0.1695642926434; Mon, 25
 Sep 2023 04:55:26 -0700 (PDT)
Date:   Mon, 25 Sep 2023 04:55:26 -0700
In-Reply-To: <00000000000035aab005ec690a00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bd00c06062da279@google.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot has bisected this issue to:

commit 01aecd917114577c423f07cec0d186ad007d76fc
Author: Daniel Starke <daniel.starke@siemens.com>
Date:   Fri Jul 1 06:16:45 2022 +0000

    tty: n_gsm: fix tty registration before control channel open

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d431ea680000
start commit:   a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d431ea680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d431ea680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b1ca83880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1023c5e3880000

Reported-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com
Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
