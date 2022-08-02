Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101EC19F2B
	for <linux-serial@archiver.kernel.org>; Tue,  2 Aug 2022 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiHBU1n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Aug 2022 16:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiHBU1m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Aug 2022 16:27:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C37A19A
        for <linux-serial@vger.kernel.org>; Tue,  2 Aug 2022 13:27:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so6312459edd.3
        for <linux-serial@vger.kernel.org>; Tue, 02 Aug 2022 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lby9lvyugHd82C4d0KaHXp3LJIsW6TZwJseJofssqh0=;
        b=dY4VR24PCrKQgsbFRhU1dAE4OtBv7+g3WLBV6S0FMdma0ru6Hreb2eW7/GMoGlAU2N
         +H3WCgfto09f7rg2xmE2XndfDGLlP1XP9cH6qP0XE5OsnuzLQ6/RGW78tSovVY8cjzqo
         yB9f0OUxFUU+z39N6BBZEGLX0BRV57fefxMM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lby9lvyugHd82C4d0KaHXp3LJIsW6TZwJseJofssqh0=;
        b=g0HGGHsTxi2/ynJpNhO6G1Ct9duQAwcrRe+p2oZOuPJoWKfK8na8b1xQEOvQDhHSWP
         Q7VdGKW1FjYssatQFsktbISJt+W6BxUi1Vhnhtpo6DnosyFgABJX4p+1YV/4KnRUi5G1
         3FVNAwswIbQByGlRhqhrZ6zjeKPJQ567YTUFoeh8tXzLH8+3/5VvX2y3FZNtFp6o79US
         0vlFh9A94NH0/wICKy19x0Z5VhZu0MdhMM8oX2wqYMdjpzRjZD5+dcGnVYi3tZK7C6qu
         7u+ITRwtrBJ/r9lrWe2TknVY4jT3Mr+M02kLUbhaSL0VKLRRSk5wiFD4IUo0KsFXxVUA
         AaJg==
X-Gm-Message-State: AJIora/zDpYnKyzH4zIrussJfaO+jVVSth0il5O1/++2z2wd33NrSdqC
        /NEuA5Hb/a5l5kjyzCZLGbhsEatEwXCoN8QJ
X-Google-Smtp-Source: AGRyM1vvZZxmyYJQHKvqDhnteDhNDWXKTo6cD0qJVTViiBzuDMgv5Ol/wuDWu50ypVaV7sVEsQBgaQ==
X-Received: by 2002:a05:6402:2756:b0:43b:fda4:abc6 with SMTP id z22-20020a056402275600b0043bfda4abc6mr21970311edd.274.1659472059660;
        Tue, 02 Aug 2022 13:27:39 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id d6-20020aa7ce06000000b0043ba24a26casm8688628edv.23.2022.08.02.13.27.38
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 13:27:38 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l4so19217942wrm.13
        for <linux-serial@vger.kernel.org>; Tue, 02 Aug 2022 13:27:38 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr13824780wrf.659.1659472057895; Tue, 02
 Aug 2022 13:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220802200649.2122084-1-broonie@kernel.org>
In-Reply-To: <20220802200649.2122084-1-broonie@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Aug 2022 13:27:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2aPq8Zsv-GSfj8Kz_9+MFxmejchoF4LUUY3tOLx3Ntw@mail.gmail.com>
Message-ID: <CAD=FV=X2aPq8Zsv-GSfj8Kz_9+MFxmejchoF4LUUY3tOLx3Ntw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Aug 2, 2022 at 1:07 PM <broonie@kernel.org> wrote:
>
> Caused by commit
>
>   c474c775716edd46a5 ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")
>
> I have used the tree from 20220727 instead.

Posted a fix: ("tty: serial: qcom-geni-serial: Fix %lu -> %u in print
statements") [1]

[1] https://lore.kernel.org/r/20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid
