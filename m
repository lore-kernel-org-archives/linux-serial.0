Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A2C433E3
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E9120885
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="utWOu3oN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHQDJF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHQDJB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Aug 2020 23:09:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC86C061389
        for <linux-serial@vger.kernel.org>; Sun, 16 Aug 2020 20:09:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e6so13633141oii.4
        for <linux-serial@vger.kernel.org>; Sun, 16 Aug 2020 20:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUwWPfMFaK7Ua27x+BYsqt8qSqzZlNaS/aMpIL7yuSw=;
        b=utWOu3oN3/U852PBbErO0/SQKSZMtH2sdGg1SUoskWjy9SksHhb0eu0x0JYcfw1POE
         ayUgUEDG1Jsc1X/GUVJQs9A4GiSI2wEPEw+F9b1Dp4PwLgNCerDA2M37LxkEnYO3mAJp
         DWiqaJB88/LLC5nEz68evEbKCN2vW82kQvA4UIaAYcWHHi0QS3trlukqHjPO0Tlyfdh5
         t9GG7oWgpbHDgjH9eyPmP3IkpprYSY55PgPRT83d+BY/Udgy7SDispFvkXeK8qy/w3Jv
         S20hk8VzedN5H9DYESHpm6qJQO9h0Rs2AfYMyvUEx8XDUGQ4+4uLb/pkuRb5Zwy5WGhr
         9x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUwWPfMFaK7Ua27x+BYsqt8qSqzZlNaS/aMpIL7yuSw=;
        b=bHe0nsxrkWMEj8Qcx5DM1I60Q5dlvuXZQ70hHvddosPJZRhVnR4PtxrCB6Qb7waPjF
         ibVZ5Y/qGKxz0nC4KRqAWoX3LlCh2+lNbIAyySzlLF6IO1k7+y85GSN1k7q4lSbOCAbZ
         ACkqtm0a2a1rYGvenpNSeuvGyOxSeZY/H8f0mYLm0v/x7WCDX0Mvj7Rfo0tGQTufU+JR
         swdEEHZOq7bo+0cq+wJiqJ2ncF/7xHaJf1H1+LDK1bky8lLvP0mXYYg5ZXfGIK0Pyaxa
         I1mw4jf7LJK7Mhc3jlG2faraHGx+Q0UsmuK5GnZgSjZb130a5P02HzUjmxAPI5x9ShjL
         rFHg==
X-Gm-Message-State: AOAM531qBv8AnmY6TWbEOLHUSfSDpHrQtJN10J3+ZwXXEeXTQ1JPwyKo
        CLVtrGI+z3XsBYuPuzIFClN+qw==
X-Google-Smtp-Source: ABdhPJySdNxP09FGzCeHqqHEHRixrNk5nzHWEtuld881QXLgXnsHG18H633vGJGzwpOn5PQv38Bznw==
X-Received: by 2002:aca:eb84:: with SMTP id j126mr8262398oih.30.1597633740038;
        Sun, 16 Aug 2020 20:09:00 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id g34sm1701273ooi.31.2020.08.16.20.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 20:08:59 -0700 (PDT)
Subject: Re: [PATCH] serial: sh-sci: Make sure status register SCxSR is read
 in correct sequence
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hao Bui <hao.bui.yg@renesas.com>,
        KAZUMI HARADA <kazumi.harada.rh@renesas.com>,
        Sasha Levin <sashal@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
 <CAMuHMdW+u5r6zyxFJsVzj21BYDrKCr=Q6Ojk5VeN+mkhvXX9Jw@mail.gmail.com>
 <OSBPR01MB3590E3D12546BC6711CEB542AAC80@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <CAMuHMdXmfQ0x7mCZ-E7OPQFv2z-=mFDT20hJ2_JKax=OePB8eA@mail.gmail.com>
 <CA+V-a8vPn_z_j1Vwr_1F=dCw8H=g5UMWvWxgRqBeVR7dzHPz8Q@mail.gmail.com>
 <CAMuHMdWc9q9NjQuAuy5M=v_x=i8XxVg5JZHswjvPsgNzhHfO0w@mail.gmail.com>
 <CAMuHMdUyV58t3eihBJv2xex5gW1Oef37Jo3FHoJstU=SspmpHA@mail.gmail.com>
 <CAMuHMdU0EiQuk_bWx1yrmbBTXg8mL-PeN2=P61xQ5Ucb5QmYYg@mail.gmail.com>
 <OSBPR01MB50485F5DA2F82E455DCA6B56AA5E0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <b384543f-c80d-aa63-63a6-1b5dbc47885d@landley.net>
Date:   Sun, 16 Aug 2020 22:17:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50485F5DA2F82E455DCA6B56AA5E0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/16/20 11:22 AM, Prabhakar Mahadev Lad wrote:
>> FTR, I gave it a try on the SH7751R-based I-O DATA USL-5P aka Landisk:
>> SCIF is affected, and fixed by commit 3dc4db3662366306 ("serial: sh-sci:
>> Make sure status register SCxSR is read in correct sequence").
>>
> Thank you Geert.
> 
> Cheers,
> Prabhakar

Did we ever figure out how to get linux to talk to the _first_ serial port on
the qemu-system-sh4 r2d board? I'm still doing:

  qemu-system-sh4 -M r2d -serial null -serial mon:stdio

Because I can only get a working console on the _second_ serial port. (SCI vs
SCIF I think?)

Rob
