Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B560E748ED
	for <linux-serial@archiver.kernel.org>; Sun,  1 Oct 2023 04:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjJAE31 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 1 Oct 2023 00:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAE31 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Oct 2023 00:29:27 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99414C6
        for <linux-serial@vger.kernel.org>; Sat, 30 Sep 2023 21:29:24 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dce4259823so26453918fac.0
        for <linux-serial@vger.kernel.org>; Sat, 30 Sep 2023 21:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696134564; x=1696739364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3TSr7QqetFYrddy0bCP+Xv3JFmbjCIi8bG/cXjlF+4=;
        b=vW+Q1oR6rtvRLY1mVhde2sbLS0kmiIAUFZ8qGzdBc2aHFJRkybpk/C58vxKuybg6AD
         uQRkWpP07FbIRE+ueFUdWMr8EqgcAWRR2ATpEwJguo3QmPvE+RS7lPE4UdxkQnC+2x/d
         N7Wrowpbbm8Xjn6nFHUfkFrkpk28vHDjPJqTmb8MjuP7ifWBZ0cy9efE2nORZx9V8HKE
         Vytyu5VKfwmyTBzjFuetg6zBdORNlaaHM7JQWIBcLkkCVp+RcuNJfPH+EMMxjWYcMtQ9
         Q0IphRJH8vchnodmOjsEV05fWiOGPHcthvJdUkdkyGxKT0Uto9wM8/t9VIZLODlFvZXF
         3xiQ==
X-Gm-Message-State: AOJu0YzowlU+RTObNXs/jN1kDKu7D8Rm/UQdQuXGSUCPrfz7Z0/W0MuL
        pD4nfzmlukknr38P7tQ3CVpkPU8ZqxvSTfiaS3D1pZGe0+8h
X-Google-Smtp-Source: AGHT+IHVhUA8ZymBFAk8BsF98zbjMMKYoqJFUsnGiF05e3aw9TS378/23ibGl9PBa+BleockCy9LMW1t7jzGzzjuqIwTTpunrdfZ
MIME-Version: 1.0
X-Received: by 2002:a05:6871:4e84:b0:1e1:2ebc:b636 with SMTP id
 uk4-20020a0568714e8400b001e12ebcb636mr2536327oab.4.1696134563838; Sat, 30 Sep
 2023 21:29:23 -0700 (PDT)
Date:   Sat, 30 Sep 2023 21:29:23 -0700
In-Reply-To: <00000000000035aab005ec690a00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b41f10606a01a89@google.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yiyang13@huawei.com,
        zhangqiumiao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 3c4f8333b582487a2d1e02171f1465531cde53e3
Author: Yi Yang <yiyang13@huawei.com>
Date:   Fri Aug 11 03:11:21 2023 +0000

    tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121e6a92680000
start commit:   a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b1ca83880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1023c5e3880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
