Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F3C4361B
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB4923AA7
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 11:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLHLDb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgLHLDb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 06:03:31 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A7BC061749
        for <linux-serial@vger.kernel.org>; Tue,  8 Dec 2020 03:02:50 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so22424353lfh.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gAGWJfuDdsXuzwoUiSh4tfqeUYXXKWd0Mt3+HyRPJQA=;
        b=q1kmRMN4ooHif4T8GbEMvPIZ2e7EKD0sK61p/ck4t0ebU/6Vp5F1C3sU23tVoXE7wx
         EiEaQ69stSXCnUeEwdQNXD4qzD6MjrOzmZEdA9WPhV38YeGiyPbvzoR0ySVmmG0KE0+W
         Vakl+ZKJ6aecGHJX4ljLsg9JHVmFAiJo9uPZfjMPzcqGi5c2WGeHEefb5Tmh7oFy+jSA
         CvqiwH85L3I9bM1OSKbKE4q74e9VbdseAodJBoRrACTC1KMKPTl1GEZun4WVoFN1ne6E
         wfFlwrhFxPRDF+5H8EubmPJf3NOgB73ve61HqjqBlh8ztmNJXl1tO80y5JOKWV28U2WR
         tHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAGWJfuDdsXuzwoUiSh4tfqeUYXXKWd0Mt3+HyRPJQA=;
        b=TPav8yN4DmYvTrjLOY+3LOiM0OgCAnLAsFm4Gc479KN9sY2GzRIK/+k/b7nr7YXDzb
         kBiYtIukdN12x8rwgAcb87WLiBgp/oyETti8Uc3eJUkIlRPWtcjsBLRTbgpG8hmijRNO
         y1SRI/0halbG/7BGfX/s1ovjWqvHHbCySh+ps64LUIQVXtFBpbzwzk7BBhVlRIGAnpa3
         wivE7i0+UQT1ZG5vlmTHbohn4xrnwAJVukD0v0AzneuXwjT9tLuaJSV+uoHww1bKgcoW
         QQH9r+DV59WL+JVlMa9vbLtwe7bnej8FZETsaNSpNeKJVySGjz0Fe9MrQkQ4WeX6XcEG
         NXYg==
X-Gm-Message-State: AOAM532ckk2Z2QAaAqU6/z8Csx57QoCPbCCNdR8mycTC3pNY8BGLHaxT
        SHLVHR0Y8FcQKvdVHo7octw=
X-Google-Smtp-Source: ABdhPJxEdW83Z1Lh6K19NsHrMsq3Q4VxYDWZe0uh9M9zgpMCg1V68FLcpqGiQFmrZ32o+Z1tEngIIw==
X-Received: by 2002:a05:6512:2039:: with SMTP id s25mr10271323lfs.558.1607425369126;
        Tue, 08 Dec 2020 03:02:49 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id d18sm3346432ljo.49.2020.12.08.03.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 03:02:48 -0800 (PST)
Subject: Re: [PATCH V2] tty: serial: bcm63xx: lower driver dependencies
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <20201125090608.28442-1-zajec5@gmail.com>
 <CAMuHMdUGNk2U-o5omSW-tOE3HeAUz62ir+vYFUei0o5Vu4cs_g@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <8d2120b4-f064-7f9b-2479-907bd8252773@gmail.com>
Date:   Tue, 8 Dec 2020 12:02:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUGNk2U-o5omSW-tOE3HeAUz62ir+vYFUei0o5Vu4cs_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08.12.2020 11:47, Geert Uytterhoeven wrote:
> On Wed, Nov 25, 2020 at 10:08 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
>> is ARM64. In future more architectures may need it as well. There is
>> nothing arch specific breaking compilation so just stick to requiring
>> COMMON_CLK.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'm happy to fix that once maintainers agree on how to handle deps like
that and ideally we have if officially documented.
