Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2AC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FDC2074B
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBM1U14C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFLPms (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLPms (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 11:42:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB7C03E96F;
        Fri, 12 Jun 2020 08:42:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so10166028wru.12;
        Fri, 12 Jun 2020 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ypF+ABDeXj9Pa6nbncrRBAhpmKKQqD9PT/WMFez+uGo=;
        b=WBM1U14Cg6u+NfWuR+fQylDEtXvUhDzHeLoluoCJmR7/NpW4WCqTJ1K+cx4h9n4Eog
         Wq6wg7tSnT0xZdzM+gfBjwv26gmOFX54hAlMAnRopIB3mvZcz8F+Ju/JdlwKG0lvAeg3
         hGzIVmiaP0mm4QRp0J6GbIshg37laSpyz7I7Vi+TJQJfo4BVW6q6upnuZlLqVqIdHMyv
         pwN70NxqToQi06Pol85OQ8zdbjUyum28fHFYlZALM5OVltlmhgAH8kIR8EJ4yzS0vQgF
         KcZMXlFgG3kjKWg7a32UtywsZC00f8Lod34SUPCks8zfympcd/ZVTruMJhep7Agt2+nt
         4NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypF+ABDeXj9Pa6nbncrRBAhpmKKQqD9PT/WMFez+uGo=;
        b=OSqWoM7eKbp8r7UIiCYylmtGBQoLC/nBVFOPmgfbeaciogCk+5UY50NtlMPDpOUOHA
         c/YtCLMLemAwms76iSwXBc5rrmzT0bbSipuctfFuolIcsmgCBmjaVqFjriHM/Mv7c6ms
         zCvucLZe1jVgSWWM8SB1JBGODdkBKBAw1Gyw4KZRhozCKAMmZb/SLft576c/JFM46S4D
         GHBTg+lENboJKmO8toCZaJyGjBQrUbkfP4YT3t+O98wEzhIxP8uYM9mBgWzcsQKf8YLx
         zFuTHzCpQ/otibllpTMMdf91cLnZBKKeU6xJSBv6aLpjuRH77/GYrahelcIFFPPUrY3Y
         EXYg==
X-Gm-Message-State: AOAM531iRMEiUWwxf7sOxI9zeDcz2Q8SgJOBeT6ODQk8K1nmLNQ2ynSA
        cNoRDhTkoOK1IPuxEJj2LVE=
X-Google-Smtp-Source: ABdhPJwQmMM1yTDTZ8xuvYF+YAUtscTKxogtkPpvuo0jq1dOjPlH2DegGktt9WUCUqQALFQ2OLaKHA==
X-Received: by 2002:adf:e749:: with SMTP id c9mr16912819wrn.25.1591976566693;
        Fri, 12 Jun 2020 08:42:46 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n23sm9109031wmc.0.2020.06.12.08.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 08:42:46 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] serial: core: fix sysrq overhead regression
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610152232.16925-3-johan@kernel.org>
 <19008afb-bfbb-35e2-3bd5-e7fd1b7355cc@gmail.com>
 <20200612152921.GP19480@localhost>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <aa34e2f3-5b19-bf70-8a80-703aca5eeaae@gmail.com>
Date:   Fri, 12 Jun 2020 16:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612152921.GP19480@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/12/20 4:29 PM, Johan Hovold wrote:
> On Wed, Jun 10, 2020 at 05:24:57PM +0100, Dmitry Safonov wrote:
>> Hi Johan,
>>
>> On 6/10/20 4:22 PM, Johan Hovold wrote:
>>> Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
>>> file") converted the inline sysrq helpers to exported functions which
>>> are now called for every received character, interrupt and break signal
>>> also on systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being
>>> optimised away by the compiler.
>>
>> The part with ifdeffing looks good to me.
>>
>>> Inlining these helpers again also avoids the function call overhead when
>>> CONFIG_MAGIC_SYSRQ_SERIAL is enabled (e.g. when the port is not used as
>>> a console).
>>
>> But this one, coul you add measures? (it will also help to understand if
>> it's a stable material).
> 
> Interrupt processing takes 2-3% longer without the inlining with
> 8250_omap on a beagleboard for example.

I think the number justifies moving them back to header.

> 
>> If one function call actually matters here, than should
>> uart_insert_char() also go into header?
> 
> Good question, it actually was originally intended to be inlined as all
> other per-character processing. Separate discussion though.

Fair enough

> The point is that we don't want a rarely used debugging feature to incur
> unnecessary additional overhead that can easily be avoided.

Well, it wasn't related to the debug feature, rather I wanted to cleanup
the header from a bit over-grown functions those have realization
details. And couldn't foresee that a function call would matter for some
setup.

Thanks,
           Dmitry
