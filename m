Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E7C47253
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EDF20857
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guUWyREb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgEAPHY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgEAPHX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 11:07:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE11C061A0C;
        Fri,  1 May 2020 08:07:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f11so2900376ljp.1;
        Fri, 01 May 2020 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upOUdSA1Qa3kRXGYSaZZPrHtnJP9z+HJ8x8GQ4kRPF8=;
        b=guUWyREbg1v99mp5JVpch/N8xFP0yadNEcjMtY4Pxt/EXZ0urMvwoGSVC9EvNyIyOW
         YYFdd+dKaAAjCGrr+awTct9/wUlUWLp+RkgMsok1KKhFb5jyFUXLfJj6AIXE1qorG7RE
         c+sdRcadiPRsq8NqlzxNMAec03sEEPXhYQHSe1ElCszSakwXTszYYsLTPpJLZ3Lh9wsz
         qGAwDDllm6eUquPi+JtmZZcrvXRQl1XwDC2kR2cusSIUolWZX2R+wNdMrYjRemti1Cx9
         iB7zuvjbkarND9uY35ZaNnnS/ETdSYb5aevq/TNwMwyKAOpzwCXHS+btJhjwtv4AaaWP
         QptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upOUdSA1Qa3kRXGYSaZZPrHtnJP9z+HJ8x8GQ4kRPF8=;
        b=W4n5aWZ7yOcY3kZ182AOL+P+8ubnetL/kYr4wYeUQeUBoxmpi79DdSsHCc+hnYDXUZ
         UWFtL612KnjZDoNkQPr6uLiDMyMajbDObu7o1nb399kdkbCuplbTyYmQIMx/Xvwv+JE6
         N/O0wtW7ik49BcNqxIMVy87XjLqYyYiX1iDQ/R1TbQ0HYRqtVvogo5B/MDCut2kVMpiA
         VCehYZ/oMijxPiMoQL6t4Nve51zw64kIAVqtQ93vTjEarSQumQ7+FypUJ3gemDW2u4Dz
         18oBufoJR/wsRuEMXrYGgVyYHCnMgsy5eCxFtpbF4xjEhobTpdd+/QeseisJLR5pW5AE
         2TvQ==
X-Gm-Message-State: AGi0PuYwayT7pUTBOHiF/Ipl0wgOh2MIb+lMt/mXi6MFC2pWQ4SALQ72
        WEmyxA/dgVjzJG+WcbSrwNI=
X-Google-Smtp-Source: APiQypKlGD+iUIY9mDeLIe59axBBk5YzG667ZkaJqGWQfXMpFrhBLjtlipoZCkeeAPnYUSiTg5zyEA==
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr2699038ljg.248.1588345640064;
        Fri, 01 May 2020 08:07:20 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id o18sm2393090lfb.13.2020.05.01.08.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 08:07:18 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200501013044.GA288759@jagdpanzerIV.localdomain>
 <818ba356-ba35-68de-b7bf-f145a89280f1@gmail.com>
 <CAHp75VeZRwUp+CpOct4dCAQAfyJZBAY7=qSKwRQh935KEMWw+g@mail.gmail.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <3cd630dd-9bb9-e975-7466-c3125aa6afa3@gmail.com>
Date:   Fri, 1 May 2020 18:07:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZRwUp+CpOct4dCAQAfyJZBAY7=qSKwRQh935KEMWw+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 01/05/2020 16:16, Andy Shevchenko wrote:
> On Fri, May 1, 2020 at 2:11 PM Alper Nebi Yasak
> <alpernebiyasak@gmail.com> wrote:
>> I'm assuming "by default" here means "without console arguments"
>> regardless of firmware requests. This paragraph (with small changes) is
>> repeated on many other Kconfig descriptions (drivers/tty/serial/Kconfig,
>> drivers/tty/serial/8250/Kconfig, arch/sparc/Kconfig from grepping for
>> '/dev/tty0' on **/Kconfig).
>>
>>  From Documentation/admin-guide/serial-console.rst:
>>
>>> You can specify multiple console= options on the kernel command line.
>>> [...]
>>> Note that you can only define one console per device type (serial, video).
>>>
>>> If no console device is specified, the first device found capable of
>>> acting as a system console will be used. At this time, the system
>>> first looks for a VGA card and then for a serial port. So if you don't
>>> have a VGA card in your system the first serial port will automatically
>>> become the console.
>>
>> and later on:
>>
>>> Note that if you boot without a ``console=`` option (or with
>>> ``console=/dev/tty0``), ``/dev/console`` is the same as ``/dev/tty0``.
>>> In that case everything will still work.
> 
> I'm wondering if behaviour is changed if you put console=tty1 instead
> of console=tty0.

Just tested again with the QEMU aarch64 VM. Comparing console=tty1 and
console=tty0 cases: /proc/consoles has tty1 instead of tty0 (both also
has ttyAMA0), and `echo '/dev/console is here' >>/dev/console` goes to
vt1 instead of the currently visible vt. Same difference before and
after this patchset.
