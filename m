Return-Path: <SRS0=1HLL=2I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A741C43603
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 06:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BBE2176D
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 06:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCKxWaqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLRGyB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:54:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43304 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfLRGyB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Dec 2019 01:54:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so696243qke.10
        for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2019 22:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLhxFx+jYmIZ0dYYbr+qydoGkkvW1VLfq/seDNzPJWU=;
        b=vCKxWaqe61Gj4oUaAFoGj5KHvdRR2QDJRyHlQeJAsFyDeOPcUtrixSXVLEqSdmlhIo
         JadsIrHS6C5LA0kPytkBXnzg9ogSnw5zdyr/vJ5kv1MVnmDT24+EEfYZt1rQLNx0sbQ/
         0erg3Fx9aqK2u+CBtXwULMumfUpLspJD69N+Z8JgKWc09WGKr8u1pHXC/Fp7guKgz3/d
         gJ5PtyXP1NW1fXw1WCrS5kxQLBud8nPd5Ij4rZw/MnQgj7VDG0FM9MTo+EFXeY+Dz0nU
         p6BH73VrkN384uPrKqlKszGNGSw8MN+4gy3487Jg+XiUiNCdKVsNqGZFFG/QdAcxfEG/
         hR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLhxFx+jYmIZ0dYYbr+qydoGkkvW1VLfq/seDNzPJWU=;
        b=Gc7sEQAYHKFvrlGAd4rGr2LLxLQ6h5MQzT30h2W2lkwqC7HvPP2jDORtP1rsZxYrcg
         8yNgHcrteP3a/9UK+MYGLXzD70vf9Zc6crxMN2VEmDE901DlMjdJbvNUFJ3UmsWLJimv
         eXpT1z/bMJD1zi8Gdj5afWi8ZfgxRmMpBydsvlG6a4ly9PXwAXkCSHu9YL1/wQAkqref
         s5kfJMF7mRexiR58SUiHgTAOKBY+xIm5z0W+MO4gsD+oZJzsGfa7FuhcfrjTT6OtnFSI
         YCNHk39SOLli73Nfs9Bs9uAFHiLMo/9w9tNqIZlKECkBpCjCM9Bb+lXplM58+GbHsFFr
         OgZw==
X-Gm-Message-State: APjAAAW+uIK3rwA5YTMIbCA5ruAdwnq5OQHbZFDLVKzL+JIk8xiLV9Jj
        8of6/Qd4MbHZ11p1N8+HcCtrfVUkAsiC9f5sbFeMlQ==
X-Google-Smtp-Source: APXvYqybdHW/P5et8aH9D7M2aQAATxvAXQBdGqmtOGxAufJjrRSMrEuzLcDymgw9/pBO1vejyiMtVW6iYsHlskS0C2E=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr950493qkg.43.1576652039963;
 Tue, 17 Dec 2019 22:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20191213093357.GB2135612@kroah.com> <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <201912180055.xBI0txro079201@www262.sakura.ne.jp>
In-Reply-To: <201912180055.xBI0txro079201@www262.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Dec 2019 07:53:48 +0100
Message-ID: <CACT4Y+ZiOF0cwy4sDVw7T5wCpX-M9KarRj5S=rFY8zrHbrLFxA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem_serial_out
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 18, 2019 at 1:56 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hmm, this is a surprising bug. syzbot provided a C reproducer, but the definition
> of "struct serial_struct" used in that reproducer is wrong. As a result, syzbot was
> reporting crash caused by passing wrong arguments. ;-)

We are on it:
https://github.com/google/syzkaller/blob/master/sys/linux/dev_ptmx.txt.warn#L20-L25

> close_delay field used in the C reproducer is sizeof(unsigned int) bytes rather than
> sizeof(unsigned short) bytes, thus fields after close_delay field are incorrectly
> interpreted.
>
> ----------------------------------------
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <linux/serial.h>
>
> struct bad_serial_struct {
>         int     type;
>         int     line;
>         unsigned int    port;
>         int     irq;
>         int     flags;
>         int     xmit_fifo_size;
>         int     custom_divisor;
>         int     baud_base;
>         unsigned int    close_delay; /* Correct type is "unsigned short". */
>         char    io_type;
>         char    reserved_char[1];
>         int     hub6;
>         unsigned short  closing_wait;
>         unsigned short  closing_wait2;
>         unsigned char   *iomem_base;
>         unsigned short  iomem_reg_shift;
>         unsigned int    port_high;
>         unsigned long   iomap_base;
> };
>
> int main(int argc, char *argv[])
> {
>         struct bad_serial_struct ss = { };
>         int fd = open("/dev/ttyS3", O_RDONLY);
>         ss.type = 0xa;
>         ss.line = 0x400000;
>         ss.port = 0x100;
>         ss.irq = 0;
>         ss.flags = 0x400000;
>         ss.xmit_fifo_size = 0;
>         ss.custom_divisor = 0;
>         ss.baud_base = 0x80000;
>         ss.close_delay = 0x200ff;
>         ss.io_type = 0;
>         ss.reserved_char[0] = 0x41;
>         ss.hub6 = 3;
>         ss.closing_wait = 0;
>         ss.closing_wait2 = 0x7c5;
>         ss.iomem_base = NULL;
>         ss.iomem_reg_shift = 0;
>         ss.port_high = 0;
>         ss.iomap_base = 0;
>         ioctl(fd, TIOCSSERIAL, &ss);
>         return 0;
> }
> ----------------------------------------
