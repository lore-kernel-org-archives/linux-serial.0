Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2114C001B0
	for <linux-serial@archiver.kernel.org>; Wed, 19 Jul 2023 17:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjGSRLb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGSRLa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Jul 2023 13:11:30 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEC172E
        for <linux-serial@vger.kernel.org>; Wed, 19 Jul 2023 10:11:28 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39fb9cce400so12022711b6e.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Jul 2023 10:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786687; x=1692378687;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiK3UAz0+c77ryW/gb9cMTyS6vAEJ/XrFX6N9k9mOJQ=;
        b=cgqE2jZdpjrHBCrL0tPGqljBGnR8Td36Yy3qgXDaWl6/1aKaboXKEhNBmaBQp6YE7A
         7G0JqTgS9/eAPoRJT+d0JWoLoKNUyrC2YaIbYSXdFzaz1qgvTo0IuueAbgT8prIbxGf0
         6ZK6b3Xud9+t5AtvpP4ASHwR0W6OY7S+iuUryolq5D4YvCmEEhXmkuJy9EO3POk8Pk0l
         STkbRHhV99qcvYqF9qhIL88/UeSTvpTfzP/FuPGQTZG3/eSkb7jmEl8qdYNiilhGntp6
         6QvYhUs+2ywKc0p4PnrLuZiTCdnlmFaFPXEABnKS1Y9oM+45Uyd9JOhgSN5tRn9YBck6
         RiXg==
X-Gm-Message-State: ABy/qLYCuY8ZZ9cI2HhGgLXsEzGuk5hIvSLZTGTYdtOytqN4gf000O7Z
        CY3Z5gpGA0AxycPloymlsMvcEZ4/eJ0sevA7a+KrxEViLW+x
X-Google-Smtp-Source: APBJJlGqZ3iWxxXhT33LNAjfh+QREvkhQDEruriIX1JMirS2inBiRbWmSWpri4JcCeIQNkkHGF5KNA+oUFrsArjTbOfZC6ur6PVu
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15aa:b0:3a4:48e1:3116 with SMTP id
 t42-20020a05680815aa00b003a448e13116mr12661379oiw.0.1689786687593; Wed, 19
 Jul 2023 10:11:27 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:11:27 -0700
In-Reply-To: <20230719170446.GR20457@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042a3ac0600da1f69@google.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
From:   syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>
To:     dsterba@suse.cz
Cc:     bakmitopiacibubur@boga.indosterling.com, clm@fb.com,
        davem@davemloft.net, dsahern@kernel.org, dsterba@suse.com,
        dsterba@suse.cz, fw@strlen.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, josef@toxicpanda.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> On Wed, Jul 19, 2023 at 02:32:51AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15d92aaaa80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2d66a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214348aa80000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz
>
> #syz unset btrfs

The following labels did not exist: btrfs

>
> The MAX_LOCKDEP_CHAIN_HLOCKS bugs/warnings can be worked around by
> configuration, otherwise are considered invalid. This report has also
> 'netfilter' label so I'm not closing it right away.
