Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537EDC4724C
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F4B208C3
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+7irlew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEALJJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728532AbgEALJJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 07:09:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F373C08E859;
        Fri,  1 May 2020 04:09:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id f8so3613418lfe.12;
        Fri, 01 May 2020 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JbMZH52YEWSxdCQl8+jIQlPQEAuYbjyzNeqiNbuukKE=;
        b=U+7irlew5ltgB9neJ2IUW9PFrMwsCCgcyWeEJKaaQtm1AN/QWS8zwTw5fMSCNsLDag
         A4bQA4vEuetXw/3nPDcycMnRS0CZdgF10nDi8vKpNePilWT0vFCalcmGy6eyQSrpiCn9
         GAdlJhJhJsJD7/sRBPHjcKe4F6G5b6I0SrFci4/YYke7JHMBqNuXaQVxZiv4C4OEY8ND
         i1+mNIM2n+t7osIVAz+hwD3HG4cDIbDbec9CYYoO6OF5RjjFx2WNN3yghLU5XlLjOKWL
         z71GvyadUkZIo/D5hP7/rpXHuTXrrOh0msvzT1rJCtDXKkgKFheJi4IDnmoBHlhI74DT
         IKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JbMZH52YEWSxdCQl8+jIQlPQEAuYbjyzNeqiNbuukKE=;
        b=OGC957zT2vZHwZVtSFDpA4UD3Gg7Dy7SOHlToYUkrZScsK0LAn+3vZtW6zssw0dFqv
         7y7RreQ2A3tyIHPuzuTNyyAElKUvspVSmJmPLlRMXIGLbYQTZdqdhaLH3gPNhj3gl41O
         hIY2uCvg51meWNnWvz5cKy/2W/iGjNZjRn7ICVDsvgNTu5iU/1dgZWXxD+yZQ1b+LkwV
         o9kDssRNsz0LfHUHAi2fd+hNgBUyWieh0rj3eOSAwk0wVp7R1XH12Z+vyfRht5r6TWKW
         fpQ1f39qZQxcVFBcTW1sBO9cKZuRjGPoVeZn/OHOslbTcicdVMpuAs5UtqMi1PZX3+Mq
         jApg==
X-Gm-Message-State: AGi0Pua2sU1lmzJ1GdF2/XMGlYNp6quI8d7VHU27hac7hiNnPVO85vNH
        vymqVYeb1MTJuHMm1RtOFfw=
X-Google-Smtp-Source: APiQypIsazxBBI9m765GGp7qZdwhkRJkVk9sBcmxyN15Eo1/skHafCF+d9fBKRIPWxxi6ZBDSafi7Q==
X-Received: by 2002:a05:6512:44d:: with SMTP id y13mr1940676lfk.118.1588331345952;
        Fri, 01 May 2020 04:09:05 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id t16sm1755806ljg.41.2020.05.01.04.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 04:09:05 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <818ba356-ba35-68de-b7bf-f145a89280f1@gmail.com>
Date:   Fri, 1 May 2020 14:08:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501013044.GA288759@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/05/2020 04:30, Sergey Senozhatsky wrote:> Well, if there is a "mandated console", then why would we prefer
> any other console?

From what I understand, the firmware provides serial console settings to
be used as the preferred _serial_ console (where it would be OK to
switch to graphical consoles later on) and the kernel currently
understands that such a console should be the preferred _system_ console
(always preferred over even graphical ones). By "mandated" I'm referring
to the kernel's current behavior, not to (in my understanding) the
firmware's intentions.

Even if the firmware/specifications is really asking the kernel to (tell
userspace programs to) always use the serial console instead of the
framebuffer console, while on e.g. a laptop-like device intended to be
used with a keyboard and display -- is that the correct thing to do?

From the userspace, under the conditions:

- CONFIG_VT_CONSOLE is enabled
- There is a working graphics adapter and a display
- There is no console argument given in the kernel command line

I expect that:

- tty0 is included in the /proc/consoles list [1]
- tty0 is the preferred console and /dev/console refers to it [2]

With SPCR both are false, and with stdout-path only the second is false.
Again, I'm OK with these being false during earlier stages until
graphics start working, but I'm arguing they should be true after then.

In the patches I tried to keep these serial consoles still enabled and
preferred during early stages of boot, by trying to switch to vt only
after a real working graphical backend for it is initialized.

I mean, if my expectations are unreasonable and the current kernel
behaviour is considered correct, these patches would be conceptually
wrong; so please tell me if I got anything right/wrong in all this.


[1] From the descripion of CONFIG_VT_CONSOLE:

> [...] If you answer Y here, a virtual terminal (the device used to
> interact with a physical terminal) can be used as system console.
> [...] you should say Y here unless you want the kernel messages be
> output only to a serial port [...]

and by "as a prerequisite of [2]"


[2] From the descripion of CONFIG_VT_CONSOLE:

> If you do say Y here, by default the currently visible virtual
> terminal (/dev/tty0) will be used as system console. You can change
> that with a kernel command line option such as "console=tty3" which
> would use the third virtual terminal as system console. [...]

I'm assuming "by default" here means "without console arguments"
regardless of firmware requests. This paragraph (with small changes) is
repeated on many other Kconfig descriptions (drivers/tty/serial/Kconfig,
drivers/tty/serial/8250/Kconfig, arch/sparc/Kconfig from grepping for
'/dev/tty0' on **/Kconfig).

From Documentation/admin-guide/serial-console.rst:

> You can specify multiple console= options on the kernel command line.
> [...]
> Note that you can only define one console per device type (serial, video).
>
> If no console device is specified, the first device found capable of
> acting as a system console will be used. At this time, the system
> first looks for a VGA card and then for a serial port. So if you don't
> have a VGA card in your system the first serial port will automatically
> become the console.

and later on:

> Note that if you boot without a ``console=`` option (or with
> ``console=/dev/tty0``), ``/dev/console`` is the same as ``/dev/tty0``.
> In that case everything will still work.
