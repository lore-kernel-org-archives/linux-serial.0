Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A7C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 28 Apr 2021 06:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ECB61400
	for <linux-serial@archiver.kernel.org>; Wed, 28 Apr 2021 06:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhD1GhW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:37:22 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35778 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhD1Ggz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Apr 2021 02:36:55 -0400
Received: by mail-io1-f70.google.com with SMTP id l2-20020a5e82020000b02903c2fa852f92so32869631iom.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Apr 2021 23:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Evc5bVwxwemryzvGzpgDZhtuvWcPA3UvDTqhrxcKzWY=;
        b=WDMQFkKTBviGBATc3UdJLdfuOLWJbuQEuKLu61tbQ7MG+Jk0R1afANlk1/b5pLCW/g
         ZSx9r+1X7Vgt0oex4Q8cpRLCuTPWEEGHFPDFTvxU63mpOfnf5lzJL12BO7FZ+ypQmUIX
         qC0Mb0ruNAHYMr0+lKFAzxbUVIwIFE8t0cRckBRABUz7NeSLzhDD6BB5BKb2B4BoL+n6
         rxwnixnvuzjjn588633Kx/HoPBPcF3oD51QIZ1As77jL/Z4JPKbl+REY6GaXVchJEoAu
         TrrBxeyII8fT12WN2A0TOGyc0V3FDuXRODV0SO+x6DAMc4JewU/wSUtEQiYb1Euve+6u
         jDdA==
X-Gm-Message-State: AOAM533PlkZJnf9XVDPW1CVAQFFUCM+3b4ma/qzVHJptRr5o76c0nSVL
        Kgn/s7hur0uk1ACLRFGl9MK+I25YaaFYYp1OV7lRrfL8K52b
X-Google-Smtp-Source: ABdhPJzJ9o/2K/Iwil0D0KZ4LzyhjGgnGbzsZ02qlcomO6jJoyngCwt3sCUb8/TPKgfNWTguq0sfEzO3AFLDKsXfSJIq0vyTEP3G
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr21450057ilv.47.1619591769638;
 Tue, 27 Apr 2021 23:36:09 -0700 (PDT)
Date:   Tue, 27 Apr 2021 23:36:09 -0700
In-Reply-To: <e3617587-7ff1-720c-00ab-434608705652@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c4f1e05c102989f@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com>
To:     caleb@connolly.tech, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        peter@hurleysoftware.com, syzkaller-bugs@googlegroups.com,
        syzkaller-lts-bugs@googlegroups.com, vegard.nossum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://repo/address.git/commit-hash: failed to run ["git" "fetch" "--force" "b7cf8f2fbfc36c709a08e0b9c77990e491473738" "commit-hash"]: exit status 128
fatal: unable to look up repo (port 9418) (Name or service not known)



Tested on:

commit:         [unknown 
git tree:       git://repo/address.git commit-hash
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7f1a69dfe24c6b3aeb
compiler:       

