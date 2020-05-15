Return-Path: <SRS0=qiNw=65=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA890C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C3720728
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 19:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnPXgaxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOT1N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 May 2020 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOT1M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 May 2020 15:27:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48BC061A0C;
        Fri, 15 May 2020 12:27:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 8so2770171lfp.4;
        Fri, 15 May 2020 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7E4qCSn8oxzjOFDM+y/8aBx6q/mStgeLmNNkLN6O2YE=;
        b=PnPXgaxgJcJ1zI/iJwPLheVYxyuwB5vSys0IhWKE+ReVyxhbGIYG+/w1Fq6+38JNi+
         avEJuToJU5mGXmCrMserZ9Anx5CTfttitC/ve6wuX/BR/WpfVkjU+Lysuq0gT42N6kjM
         iB3sa1AS+rojJK2vy4ewPybVlAVITQVnIacwY7qfVqVh8jsmO+bcRCyKEhMu5BLCyWcX
         poJlyby8vVkZiR5mXyCPXasC1F8/zQw39R9eTVjk+KqnuP+7/OelgORAmQ5OggULLkyH
         MCN7dAXZbJBRLbas/b+nc6Ys67+H+cYlo+Uw44TylSjuSHXhOwxR2G5eArahPLOT0INi
         62XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7E4qCSn8oxzjOFDM+y/8aBx6q/mStgeLmNNkLN6O2YE=;
        b=sb1RbZMI9bjdW2TAAo2LbJnXdYFPz0BZpf7hZfnhUJm5L8T0snsU+T9Dabic8DbulT
         U6HcusuR/38HQnYvClMXh9CCVjb7osG5vTv2PF3x6FrpM9+aXp34yH3UPXzOMfmxkDRj
         3gnSz1l7UYLpVgMzwg/Htjx8q1/ZryHPx+bu67FYNQA57GewpqgtbjctfSX+mtYuKUQE
         WWIg7oifY01nEBFerH5YvN42Zch7FxI2UlKIUWmjKakyigdFsdWevTr0+CkHZKWsWkwV
         mRDGiaixmad+NcGEhSElAOvngZcjIrMyv6EgwwUju3O1x85waeJaMjY2vxgkJud+Je5M
         S3Ug==
X-Gm-Message-State: AOAM533OllbQo19ntAp+vdbG4u4AJe9Vz7kWW8ghUllVZN4h7NXIWIAO
        vt8lT+sUCbvNuOymUFDZrmk=
X-Google-Smtp-Source: ABdhPJwnqVU1YyjUD8x5ydVPwEj7EJSzVUtMDTSJGgGDHWg+Hzlw/B1vJKtRsSmzCc51+lcYYmSPKg==
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr3426972lfg.150.1589570830859;
        Fri, 15 May 2020 12:27:10 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id s11sm1831143lfo.86.2020.05.15.12.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 12:27:09 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
 <20200513143755.GM17734@linux-b0ei>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <dd19946d-32e9-89e8-3b35-faea9941f107@gmail.com>
Date:   Fri, 15 May 2020 22:27:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513143755.GM17734@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/05/2020 17:37, Petr Mladek wrote:
> On Thu 2020-04-30 19:14:34, Alper Nebi Yasak wrote:
>>                      |     "console=tty0"    |    (no console arg)   |
>>    ------------------+-----------------------+-----------------------+
>>    QEMU VM           | tty0     -WU (EC p  ) | ttyAMA0  -W- (EC   a) |
>>    (w/ SPCR)         | ttyAMA0  -W- (E    a) |
>>    |
> 
> The SPCR handling is inconsistent over architectures, see
> https://lkml.kernel.org/r/20180830123849.26163-1-prarit@redhat.com
> 
> IMHO, arm developers decided that consoles defined by SPCR are always
> enabled when existing.

I'm OK with those being enabled. Though, I hope "not registering tty0"
wasn't an explicit decision, but maybe an oversight/trade-off due to
assuming SPCR code will only run on servers without displays (where tty0
wouldn't matter). (I understand it might be too late to change that.)

So I'd want the 2nd column to be: tty0(EC) ttyAMA0(E) at best, and
ttyAMA0(EC) tty0(E) at worst.

> In 1st column: tty0 is the preferred console because it is defined
> on the commandline.
> 
> In 2nd column: tty0 is not enabled at all because another console was
> defined by SPCR. Note that ttySX and ttyX consoles are registered only
> as a fallback when there is no other console defined.
> 
> The following code is responsible for the fallback, see register_console()
> 
> 	/*
> 	 *	See if we want to use this console driver. If we
> 	 *	didn't select a console we take the first one
> 	 *	that registers here.
> 	 */
> 	if (!has_preferred) {
> 		if (newcon->index < 0)
> 			newcon->index = 0;
> 		if (newcon->setup == NULL ||
> 		    newcon->setup(newcon, NULL) == 0) {
> 			newcon->flags |= CON_ENABLED;
> 			if (newcon->device) {
> 				newcon->flags |= CON_CONSDEV;
> 				has_preferred = true;
> 			}
> 		}
> 	}
> 
> 
>>    ------------------+-----------------------+-----------------------+
>>    Chromebook Plus   | tty0     -WU (EC p  ) | ttyS2    -W- (EC p a) |
>>    (w/ stdout-path)  |                       | tty0     -WU (E     ) |
> 
> Hmm, of_console_check() explicitly ignores the console defined by
> stdout-path when there is a console on the commandline. This explains
> 1st column.
> 
> I am not sure about 2nd column. My guess is that ttyX consoles are
> tried first. tty0 is registered as a fallback because there is no
> other console at the moment. ttyS2 is tried later and it is
> registered because it is in stdout-patch and there is no console
> in the command line. It is somehow consistent with  CONFIG_VT_CONSOLE
> description.
> 
> Sadly, it is different logic than with SPCR :-(

I like the fact that this one has tty0. For example, Debian's installer
iterates over /proc/consoles and launches itself on all the consoles it
finds there, so it wouldn't launch on my chromebook's screen if tty0
wasn't included (just like it doesn't launch on a QEMU aarch64 VM's
framebuffer).

>>    ------------------+-----------------------+-----------------------+
>>    Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
>>    (w/o either)      |                       |                       |
>>    ------------------+-----------------------+-----------------------+
> 
> This variant is easy and everyone would probably expect this.

I think things run roughly in the following order (from what I can
decipher from kernel messages) and I think it matches your explanations:

|            ACPI SPCR            |      dt chosen stdout-path      |
+=================================+=================================+
| acpi_parse_spcr()               |                                 |
| -> add_preferred_console(uart0) |                                 |
|    (if not on x86)              |                                 |
+---------------------------------+---------------------------------+
|                        console_setup()                            |
|                        -> add_preferred_console(tty0)             |
|                           (if console=tty0)                       |
+---------------------------------+---------------------------------+
|                        register_console(vt)                       |
+---------------------------------+---------------------------------+
|                                 | of_console_check()              |
|                                 | -> add_preferred_console(uart2) |
|                                 |    (if no console arg)          |
+---------------------------------+---------------------------------+
|                        register_console(serial)                   |
+---------------------------------+---------------------------------+

> Regarding the description of CONFIG_VT_CONSOLE option. I am afraid
> that it was created and true only before SPCR and device tree support
> was introduced.

OK. Assuming these changes won't go any further, maybe I'll try
documenting the current behavior in relevant places.

> Now, it is really sad that SPCR and device tree have different
> behavior even across architectures. But I am afraid that we could
> not change it without breaking many setups.
> 
> The only common rules are:
> 
>     + The last console on the command line should always be the
>       preferred one when defined.
> 
>     + Consoles defined by the device (SPCR, device tree) are used
>       when there is no commandline.
> 
>     + ttyX or ttySX are used as a fallback when nothing else is defined.
> 
> 
> My suggestion is:
> 
>     + Fix SPCR setting or device tree of your device when the defaults
>       are not as expected.

Maybe I can get QEMU's SPCR use conditional on the existence a
framebuffer, and get distributions to remove stdout-path from certain
device-trees; but that would disable the serial console completely
(instead of having it enabled where tty0 is still preferred).

>     + Use command line to force your value when the defaults are not
>       as expected and you could not change them.

This works; but I'd have to know the machine's serial configuration in
advance to put it in the cmdline as "console=<serial> console=tty0", or
lose the serial console as in the above. (A "console=dt" like that
"console=spcr" patch you linked to would be useful here if it existed.)

Both seem imperfect in that sense, but tolerable.

> I am afraid that we could not fix your problem on the kernel side. It
> would broke other setups that depend on the existing behavior.
> 
> Best Regards,
> Petr

Thanks for the detailed reply.
