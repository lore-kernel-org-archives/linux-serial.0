Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271AE784A4
	for <linux-serial@archiver.kernel.org>; Mon,  2 Oct 2023 07:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjJBHOK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Oct 2023 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBHOJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Oct 2023 03:14:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580FC9F
        for <linux-serial@vger.kernel.org>; Mon,  2 Oct 2023 00:14:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3215f19a13aso16082201f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 02 Oct 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696230844; x=1696835644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyEJm0Vs8HzMk1ARIArOtOc0lGgfBnw3jKoPIGWI2IU=;
        b=ncQqFiFYJTEqjNv9P80BLA3l77PdKx+KpWNHKabUiEP2S56Le9YynoIv3vJ6U/I35a
         g0htVy2V0Rhc4c/4dJYziE8SO5e0gpxdEaRCNF2ON4VwPPblijzGNadh+C8KGZ/lEcB6
         5pJ4/M2Li3MmyzyP0LYUJ9ZlVwcWjMx1RWE2/XGxltgUvgq718AmqeQmAdCanPbraSTU
         OP35OQJT+ItmomTMLbBUuj3/Rwwkm1RY97gHbcZdOqa9mpOBq4JnNkFMP6jK2MVixfxQ
         igViPAVDbON2q1Bw4eYGZHpLp4SqAy5TdmkT86sn/CgSca7zb+FB228Ff6SoRcVLG6LX
         W6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230844; x=1696835644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyEJm0Vs8HzMk1ARIArOtOc0lGgfBnw3jKoPIGWI2IU=;
        b=FZJHxEEAAV95cEgmhmZTm+OMkAMpHLubOtBkvX2b+ZzoooOmc+eC4h5DzkFenuFg+7
         GCSf6BKN2+YKQvSlvunxQitx3cJkgWD/AtZmw0xQEEPEfW+Awev65Gn3ypJ1JEC9QzfM
         LcdCbptdKfoolx4CIIjHaYNT1kU33nwLRhZkKWqgXr5o2ZkXjFU/GijplOkUXAh+z6oE
         tMZC+MtfOy2zZ5DcDHa8ca+NsAoiA67oB7pJ2HXb/zrvnCwosoO7bG32G/3DN6cl5kum
         wcQRKiXu1neXW+lft5B4SFiZlO9NqxpgT8zt64ipSSoGtr48vefiDkVkvo33MvjfIFEj
         gqAA==
X-Gm-Message-State: AOJu0YzHPWigwm8YS5HietSUdnCHaPqwyYkAv8lqdHkIEd5Y2NzAiKnb
        OAhkXemsIW0FYEn5urkR7TrNtkba15Vb7lndCzxHyQ==
X-Google-Smtp-Source: AGHT+IE1VZdXGHpgzUv4UDd0KzzvuoCETZFBpMqTRickj71vAcjHjYrXq5/yuyrtgxCez/B9xnBlD/+UaNE0EyqoKzE=
X-Received: by 2002:a5d:674a:0:b0:324:7a6b:d4fe with SMTP id
 l10-20020a5d674a000000b003247a6bd4femr9856489wrw.9.1696230843723; Mon, 02 Oct
 2023 00:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHVXubhG2c=ShFHF4hMMFm8=BYDTyDUduOizujbUWQBW+55wTw@mail.gmail.com>
 <20230929230549.45206-2-twuufnxlz@gmail.com>
In-Reply-To: <20230929230549.45206-2-twuufnxlz@gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 2 Oct 2023 09:13:52 +0200
Message-ID: <CAHVXubiBVKJ89fBtV1fvEpoOyLvdvjkWfeDmw2yZsod5ao9hPw@mail.gmail.com>
Subject: Re: [PATCH] Test for riscv fixes
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     alex@ghiti.fr, aou@eecs.berkeley.edu, conor@kernel.org,
        gregkh@linuxfoundation.org, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Edward,

On Sat, Sep 30, 2023 at 1:06=E2=80=AFAM Edward AD <twuufnxlz@gmail.com> wro=
te:
>
> Hi Alexandre,
>
> On Fri, 29 Sep 2023 10:25:59 +0200 Alexandre Ghiti <alexghiti@rivosinc.co=
m> wrote:
> > I'm still not convinced this will fix the kasan out-of-bounds
> > accesses, the page can be valid but the read can happen at an offset
> > not initialized and trigger such errors right? I still think there is
> > something weird about the stack frame, as to me this should not happen
> > (but admittedly I don't know much about that).
> The added check can confirm that the physical page is invalid (whether it=
 is a
> vmalloc allocated page or a slab allocated page), and exit the for loop w=
hen it is invalid.

Yes, but to me this is not what happens in the bug report you link:

| BUG: KASAN: out-of-bounds in walk_stackframe+0x130/0x2f2
arch/riscv/kernel/stacktrace.c:59
| Read of size 8 at addr ff20000006d37c38 by task swapper/1/0

So the read at address ff20000006d37c38 is not "normal" according to
KASAN (you can see there is no trap, meaning the physical mapping
exists).

| The buggy address belongs to the virtual mapping at
|  [ff20000006d30000, ff20000006d39000) created by:
| kernel_clone+0x118/0x896 kernel/fork.c:2909

The virtual address is legitimate since the vma exists ^

| The buggy address belongs to the physical page:
| page:ff1c00000250dbc0 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x9436f

And the physical page also exists ^

So I insist, checking that a physical mapping exists to exit the loop
is not enough, to me, the error here is that the backtrace goes "too
far" at an address where nothing was written before and then KASAN
complains about that, again, we don't take any page fault here so it's
not a problem of existing physical mapping.

>
> Perhaps we can trust the test results of syzbot.
>
> Thanks,
> edward
