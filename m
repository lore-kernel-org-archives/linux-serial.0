Return-Path: <SRS0=Y54r=2A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7332C2BD09
	for <linux-serial@archiver.kernel.org>; Tue, 10 Dec 2019 01:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAE12077B
	for <linux-serial@archiver.kernel.org>; Tue, 10 Dec 2019 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLJBiC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:38:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38855 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfLJBiB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Dec 2019 20:38:01 -0500
Received: by mail-io1-f72.google.com with SMTP id l25so3454441ioh.5
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2019 17:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d/rLwgpGcOLrJAfYzylpfLq8TO3Ppq0ukiadwzb7btY=;
        b=pmYBkPHGMULhEs43A9Eu2TzhHoEnY4aP1bp+ggRsnmp3Bd6pLz/9WUqB+7fLZYn2H8
         U3FqxombfIOQYsps0vnPyvQb+gYbKwtThkr7TOyaUg71vc47vwBL8nApNhEKic5n02eL
         Zjwy1RMZ5saqEVkU2rGzCIEHU+IbTFph6hT7hSsr20RzUdEi/ft0G4DdFJa8H9N1eRx/
         YIYfplXKw9VhhHdDkp1GI3b90tsR/LTzt0a+pK1l0lUhPwxbc3UwfFSSgbC5FKkFxoYT
         kIc8Bm+K3Ozgk+aSe1CjePVOV/yFB3CgSPTdEQtd8YibN7Xhtk8I1aT5GoIUv1Z00Eq3
         bayA==
X-Gm-Message-State: APjAAAU5I5gci274JU031uBIxNyhP098j0wVaz/ACxPQZ2PHy6Urxg9y
        cOi2OTKRgwuU5mnx8+K/yOs+qGXD0fd/VHFOOQqrjmlesdMx
X-Google-Smtp-Source: APXvYqx3F0Ru+DmMowW3EN6d2QYATYtlFpjQe/HbQv1AYpW3UNnTiZ8L2MNSyTDTtQA/qzP66Ug/fqFZPiweGeK/5P/FGvCtPAyx
MIME-Version: 1.0
X-Received: by 2002:a6b:5b12:: with SMTP id v18mr24150486ioh.112.1575941881185;
 Mon, 09 Dec 2019 17:38:01 -0800 (PST)
Date:   Mon, 09 Dec 2019 17:38:01 -0800
In-Reply-To: <00000000000044a65205994a7e13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003cc8505994f9036@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        corbet@lwn.net, ext-kimmo.rautkoski@vaisala.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        kai.heng.feng@canonical.com, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com,
        paulburton@kernel.org, peter@hurleysoftware.com, sr@denx.de,
        syzkaller-bugs@googlegroups.com, yamada.masahiro@socionext.com,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot has bisected this bug to:

commit bd94c4077a0b2ecc35562c294f80f3659ecd8499
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Oct 28 03:46:05 2015 +0000

     serial: support 16-bit register interface for console

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13723196e00000
start commit:   e42617b8 Linux 5.5-rc1
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f23196e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17723196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=92f32d4e21fb246d31a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136f7e41e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b7c82e00000

Reported-by: syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com
Fixes: bd94c4077a0b ("serial: support 16-bit register interface for  
console")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
