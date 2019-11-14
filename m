Return-Path: <SRS0=2UiA=ZG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A17C432C3
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE482071F
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DqCtJziY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNJAN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:00:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36845 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNJAN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Nov 2019 04:00:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id x22so243665lfa.3
        for <linux-serial@vger.kernel.org>; Thu, 14 Nov 2019 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlNrN2GhAvRY7IW8hzvOGZWhxEVtG6SWuwKkUSlWRyI=;
        b=DqCtJziYkryUZAUqd2xAAGwJFBCGTywmDlEpqjTs1//7QvPdR0AwIUntDfUsmL7VXt
         inp5/f3kzSiCI/REeaZwhuroE7fO4RLz1hNiMXce1uHOOoWd/krMOrPvIsHk8VUu/Idx
         CVhp6Qxtadp2q8Bf0VYuQFMBrMOjcRmWU1E3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlNrN2GhAvRY7IW8hzvOGZWhxEVtG6SWuwKkUSlWRyI=;
        b=o/NCiS8vivo7rzt2FZq4LnlPa+/DfF0Gz9UpqWZzmk28nDBE82G4sHiIR9AnaFklxx
         3D1EJx2Ohs1lB7avCFEQm/NiJFEZXNGkVLf/nqfDQthn8QFGCowmFihHjC/baHc8K4ZH
         xHwGYO5XNfhqdK/ZZwPQ2w5Z+WWfVMCF22guG2cSbcKg2N2K8bQpEJ+IXXESNJbi6im/
         a/2KPJ1AI4vSpx3vxlJkWyg/1OTN4RVvzqUIQFVkGD3PnFCsRu4sL+2eCWIpLFpV/hxc
         0cwplGv7bkmavg0/eBoFjMx4kTE3ZyFIJgQVxl34ipLN679cDdKtac99+lsolUMcWWKV
         faTA==
X-Gm-Message-State: APjAAAXKFLJvOCbgN9f5rPsW368maz1nWTVa+f7DsKkIlnlXmTsSY6Bb
        aRzsnZOwprZnHM8/d/eKj4wYQ+eA7NqIanqb
X-Google-Smtp-Source: APXvYqziuBwUwTFwvFITVp9Y42/Pf1aEQFfzH3vqpE2R1SKDE+E1rudpEqbbReFJja9okUlvGnJRkA==
X-Received: by 2002:a19:c386:: with SMTP id t128mr2627137lff.7.1573722009265;
        Thu, 14 Nov 2019 01:00:09 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2073916lfi.57.2019.11.14.01.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:00:08 -0800 (PST)
Subject: Re: [PATCH v4 30/47] serial: ucc_uart: factor out soft_uart
 initialization
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-31-linux@rasmusvillemoes.dk>
 <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <73337067-953c-55e2-986a-24116fb10544@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 10:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/11/2019 06.14, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> -       /*
>> -        * Determine if we need Soft-UART mode
>> -        */
>>         if (of_find_property(np, "soft-uart", NULL)) {
>>                 dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
>>                 soft_uart = 1;
>> +       } else {
>> +               return 0;
>>         }
> 
> How about:
> 
> if (!of_find_property(np, "soft-uart", NULL))
>     return 0;

of_property_read_bool() if anything. But I didn't want to do that kind
of transformation - just a pure "move this code out and fix the
indentation" with the minor edits needed to hook it back up where it
came from.

> And I think you should be able to get rid of the "soft_uart" variable.

Eh, no, it's used in several other places in the driver. I kind of hope
gcc is smart enough to see that in the !PPC32 case it is a static,
never-assigned-to, never-escapes variable so all the "if (soft_uart)"
branches go away, but that's not really very important.

Rasmus



