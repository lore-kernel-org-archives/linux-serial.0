Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886CC47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E01207DD
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOWHisTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD3TcQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3TcP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 15:32:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EAC035494;
        Thu, 30 Apr 2020 12:32:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so2057832lfd.0;
        Thu, 30 Apr 2020 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEqqDal1b2CMBBj1J/IhZlw32+Sg+2HPFFmYoJNFiUw=;
        b=DOWHisTWeBeZBVUEitPME/auY93uAUAgxG6PVUvbHoOc73Sf/iGaOTv49ntHPEtDvD
         N6Cx3OojCejqvLe4o6E9hTqAlmIXN9IKjCBGwAojzTGoRTxhPlEeaxB8hX+NCRBsbnjR
         F+Cm7Ljm2cx7hQof0ILpa+VZV6AbpDx30VM1RD32IIjO2EyCvwZOTF2sLN0ftsLiqEeA
         t3MdhNA3Wamo7wuambjqq5Ow2XfHfE0nzQhnxpOmuckaMZTMpOjWij1o6Eyvaty9gYqP
         /vhzKP3kik+a1rjRP86OqQ6JSbtALthq0PHjWtic9Mz6H1I2kC/Hu6arE2bFmulALd+E
         Q3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEqqDal1b2CMBBj1J/IhZlw32+Sg+2HPFFmYoJNFiUw=;
        b=mzpLgTpyW6G+hUE4GeuraTFulZMzTTMxmKmcyRMa+iHpDCTTyl1b8i3L7h+XtofOFT
         3lySeRVp1iwA+Cs7xkww7IIAzMLssZFE+MBuy8aDfJ9ZxvlYEtC3e2TaLLHusp/6jcT2
         Y9xy3OHxDEKsCAx0czAQIvyxara/61eYjKmSaDDxPAz6SlMFcoqluVHP2Uy33fE6GxfZ
         Opk4dP49BokHa2FFdE0SoXRSzwAtnVpSFJJXHvcbH9scfbUQ5AIiJi9f/XZxrDszn8jN
         +3nzCk0tyXPc8FSCH3ZGFIdqRE035k+RPicSnns2cyY4ZkqimHqS5rZFIbpZZ7h2Ruk4
         g2jQ==
X-Gm-Message-State: AGi0PubhnliPnIssgcfauEiKeUoywlIHs8LBRnxGfK/LihyXfQzGe5Ne
        BLKyuzBPxwpfj/rlr+7y4nE=
X-Google-Smtp-Source: APiQypJNFgSpmaFuLg/GY6Gie6VDzGSq5Rv1WOKs4ZofBix+8BkRN2sAbFhFcYeWgtk6CQXKyG8dyw==
X-Received: by 2002:a19:d:: with SMTP id 13mr114417lfa.167.1588275132329;
        Thu, 30 Apr 2020 12:32:12 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id i124sm429538lji.95.2020.04.30.12.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:32:11 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20200430164413.GV185537@smile.fi.intel.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <f332a19b-e8d1-d2b0-37c8-08381563f41b@gmail.com>
Date:   Thu, 30 Apr 2020 22:32:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430164413.GV185537@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/04/2020 19:44, Andy Shevchenko wrote:
> First of all I see only cover letter and one out of 3 patches.

Apologies, the tool I've used to send the patches (U-Boot's patman)
Cc-ed the scripts/get_maintainer.pl output per-patch, instead of
per-series as I had assumed it would. This was the first time I tried
it, I'll keep that in mind.

Here are links to all four emails:

https://lore.kernel.org/linux-serial/20200430161438.17640-1-alpernebiyasak@gmail.com/
https://lore.kernel.org/linux-serial/20200430161438.17640-2-alpernebiyasak@gmail.com/
https://lore.kernel.org/linux-serial/20200430161438.17640-3-alpernebiyasak@gmail.com/
https://lore.kernel.org/linux-serial/20200430161438.17640-4-alpernebiyasak@gmail.com/

Or I can resend the last two patches to you, or resend all the parts to
everyone again.

>> eventually figured out that the kernel preferred the serial port
>> (inaccessible to me) over the built-in working display/keyboard and was
>> probably asking there.
> 
> "probably". Please, confirm that first.
> Also, without command line it's hard to say what you have asked kernel to do.

I was trying to boot a Debian userspace with cryptsetup, with the kernel
command line:

	root=/dev/mapper/sda3_crypt quiet splash

The Debian initramfs handles most of the work (the password prompt,
device mounts, etc.).

When I used the same kernel/initramfs/rootfs on a QEMU aarch64 VM, it
only prompted on the serial console instead the framebuffer. I'm
assuming the same thing happens on my hardware as well.

I can also ask the Debian initramfs to launch a shell by adding "break"
to the command line, which won't be printed on my device's screen unless
I also add "console=tty0". That shell also only appears on the serial
console on the QEMU aarch64 VM, unless I again add "console=tty0".

This is my primary computer and I'd prefer not dismantling it, so my
findings above are the best I believe I can do to confirm it now. I'm 
hoping other people would be interested in this, and would test more 
than I can.

>> Running plymouth in the initramfs solves that specific problem, but
> 
> What is plymouth?

Plymouth is a userspace program that's famous for showing a splash
animation during boot, but in this context: it handles user-interaction
that might need to happen while the initramfs is running, by printing
messages and prompts and reading user input to/from all consoles.

>>    ------------------+-----------------------+-----------------------+
>>    Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
>>    (w/o either)      |                       |                       |
>>    ------------------+-----------------------+-----------------------+
> 
> either == SPCR or stdout-path?

As in "When the device has no SPCR _and_ no chosen stdout-path".

>> This patchset tries to ensure that VT is preferred in those conditions
>> even in the presence of firmware-mandated serial consoles.
> 
> This sounds completely wrong. serial should be preferred over vt due to very
> debugging on early stages and SPCR is exactly for that.

I'm saying that from a userspace perspective, and the patches explicitly
try to switch to the vt only after a real framebuffer is initialized. So
if I did it right, it would still use SPCR/stdout-path's console during
the early stages. (I admit I haven't adjusted to talking within a kernel 
context yet).

In all honesty, I'm not sure if this is even considered a kernel bug,
let alone my patches a correct solution; hence the RFC PATCH as an
attempt at demonstrating this can be "fixed" in kernel.

> Maybe you should figure out the real root cause?

Thanks for the reply. Any ideas on what else could be causing this 
behaviour?
