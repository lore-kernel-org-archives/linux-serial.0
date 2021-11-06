Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A0FC433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E70D610E9
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhKFTXM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhKFTXL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 15:23:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5CC061570;
        Sat,  6 Nov 2021 12:20:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so18526994ott.4;
        Sat, 06 Nov 2021 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ibHe0bg8yrjy+eEkaeet+vUrHDpvSYjM5LvxS0CthM=;
        b=Dn0m554hhGaLvJaP2djE45v57NJ5EfYuTqyzaBxB9JKUktHBmbJLkPz52DVtGIldC3
         luBRCa5d5Cft/L1ilAx9uP4TqmJe35+n/YBBM68qa/BebVBVvHOn49eIMKp7+igpkocd
         bgd/0LKTU63N7zEv76mnyC9bdEJ4Jjpvl72a+ia5fWh4ffqVwznazvBnVsBfC8LO6FTZ
         qADYaEp20T9it9x6E+UTguK8P7GmbmTxpvJtIqsg7QvLws8+cxHbmqjfTPrYW+f0oOWr
         W/lqnF+V4W/mNSCohQfcJVlkcIXkWURIiq7LexCAzYb/588aM4YdO8C9/OD4FoH7R/u1
         6eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ibHe0bg8yrjy+eEkaeet+vUrHDpvSYjM5LvxS0CthM=;
        b=UQNtDDcaemyYQmGzL2mhmouGLRXeLf8g/Wj4OIhvDjNmvcgeRJiMbxUeyU4XyKz8Il
         nQmVnVYGbf73msTytmhiO/nGZ9xrLi/+Yc/CqpZV4f24e+uopPrsNxkSPQaY25JDVu7o
         QJz8e+idOKHBS7DhULYi8UtbTwSMGsn2u8nXyrBnGwL7owa9gagUf6kUAEgNb6AcvMB5
         Tphtl/DTr5lNbMyYcRusTlKzSjh+jXnyM6AJdvOu4WU9TIjRMfREDmPR+fkpKmdSGwkl
         Kl7CTUtQ3WWCsvDclxjb7ll8wGpaNwAQ/rA1rCAK2a82g8hxiUHvFv+K45xxzroyJ+at
         NToA==
X-Gm-Message-State: AOAM532IMHf8rGQCk++m5ffpw8DgYNHRQQEHplc2z9TxSpIAYboqMGL1
        4jPWN4zD0bdkXq+hOPS2arH1ZrdsyvyM9dsVf9U=
X-Google-Smtp-Source: ABdhPJybSJ4nQFconpFtDlxaTBInuVnAjg5dmuCtJM5aIwH6eu0uM2NlsogsDxI7Hc4ROPBmmpnUyHhEX+ILZRwauA0=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr1486634otq.173.1636226429641;
 Sat, 06 Nov 2021 12:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
In-Reply-To: <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 00:50:17 +0530
Message-ID: <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Pavel, Andy, David for the help.

Andy,

There is no compilation/runtime blocker.
There were warnings reported by smatch.

My intention is to make the method "vt_do_kdgkb_ioctl" bullet-proof in
itself, without depending upon external clients.

Pavel has explained that currently things are fine, as per :
https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m740fffb7c6ee52fdc98b9ef0b4e32a060b6a3be3

but it seems that there is a big flaw - we are dependent on the length
of "func_table[kb_func]" being ok. If func_table[kb_func] goes awry,
the method will cause overflow.

Since func_table[kb_func]" is not managed by the method, so the method
must not depend on func_table[kb_func]" length-correctness. Instead,
"vt_do_kdgkb_ioctl" must ensure no overflow, without depending how
external entities (func_table[kb_func] behave.



The issue with strlcpy, along with a potential "fix", has been explained in :
https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m1c4aaa4347b02fd4c11ce611ff5029fcb71c37a1

David has provided a simpler fix (usage of strscpy), as in :
https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m63dab1137e593f2030920a53272f71866b442f40


So, we could go with one of the above changes (mine/David's), or
nothing at all (since there is no blocker).

I vote for David's strscpy "fix", as it is simple, and does away with
the dependency on the length of "func_table[kb_func]".


Would like to know what the maintainers think.
If there is a consensus that the method "vt_do_kdgkb_ioctl" be made
bullet-proof in itself, please let me know, I will float the next
version of patch.


Thanks again Pavel, David, Andy.


Thanks and Regards,
Ajay
