Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8374AC07E95
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 19:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642F861CBE
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 19:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhGGTP6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:15:58 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:36526 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhGGTP5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 15:15:57 -0400
Received: by mail-ej1-f45.google.com with SMTP id nd37so5049983ejc.3;
        Wed, 07 Jul 2021 12:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wsQrZJX/JS3gSy95ivb045B6144toShZct45ZBG+Po=;
        b=lJ+NsrcVm1dMmRoJjtVrV/y2k3kBWaZyHbWpEJ2HLO8bmsEyHXnjdZWslH1S6TprhY
         Tsi4GTT2v12tZgqllZ5mz8nMo7oVss3qOWtmhcqDSEBmQpiv4/SCWH3m6LDp/NdrVtW6
         Cr+WcW3poQrtTj99gF3ueXHGun5cLmqotn48fWnanyxFeqrA2YTugZoz5BkI8tQVPzmi
         ZGSkdYLZCjSicqmrvC80tLNs3MvrhrNtIPC93IG3ZmHswr9413aR/PilqiEQ/F/vLW6A
         /lwbzPxKy/MwbJVI3fhdWDT0hUVCBARm9doOxyyXwAcGlElXRegJkBs1Grs7DmDldcpT
         U6bQ==
X-Gm-Message-State: AOAM530VsVEBPFBHwiKANyBnGVFRReyvvt/nEaIMrDJ+I/SdHDDGAsgK
        159RE/PrI2KvRyY1H1TbYjNRNOQXw4yjrw==
X-Google-Smtp-Source: ABdhPJwpLmOpxxatVnoT1IP3+pfPFgxYSjThQvXeGN+3vzqWFVM64YwY9GQ7g48J6rFplniFhzirQg==
X-Received: by 2002:a17:906:49ce:: with SMTP id w14mr25987913ejv.273.1625685195191;
        Wed, 07 Jul 2021 12:13:15 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id v7sm2354edd.4.2021.07.07.12.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:13:14 -0700 (PDT)
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Zheyu Ma <zheyuma97@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
 <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
 <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ffa624c5-fc2a-780a-17d2-404cd94a289a@kernel.org>
Date:   Wed, 7 Jul 2021 21:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07. 07. 21, 14:52, Andy Shevchenko wrote:
> On Wed, Jul 7, 2021 at 10:50 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>> On 05. 07. 21, 14:53, Zheyu Ma wrote:
> 
>> So how it comes an interrupt came before
>> neo_param() in jsm_tty_open was called?
> 
> If IRQ is shared we have a special debug feature to test shared IRQs
> on freeing IRQ stage (*).
> But it doesn't matter, the IRQ handler must survive at any stage after
> the action has been listed.

Yes, but IRQ_NONE is returned from the ISR in that case.

The issue the patch is fixing is for a "malicious" device and I am not 
sure we want to fix this -- if I can put in a malicious device, I can 
use hammer to kill the box too…

thanks,
-- 
js
