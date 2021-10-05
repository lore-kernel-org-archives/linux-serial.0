Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D9C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17558613B5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 19:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhJETvI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhJETvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 15:51:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C5C061760
        for <linux-serial@vger.kernel.org>; Tue,  5 Oct 2021 12:49:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t9so699266lfd.1
        for <linux-serial@vger.kernel.org>; Tue, 05 Oct 2021 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSuSoFxOGCn2dKc1HCjcYz8H8NJV0h0NOInNBU1gpMA=;
        b=r5wtOsIeugQcbSyjEU/905zrWR2yTnrfd3lG/w4v8yln/ZETnNb15iirXrqb21Q/SO
         TEkfrPxqqAWodYR8/iZ0w+09qmRwPy7SPYIbNrIieEdDujUiMOG0kyqZv85hzLj98DXH
         y2issgbN9WDO+jaoPuyZ2Bw995Nwtlvn7qQs+2QC1QtjPEruZLJ6h1NVwg90mo0swtGl
         Gqtzl3zB1FwcLxIZqLbQa28WNWcdigta1v0d0BTNgYIo4l82y7hJdMvDVTwuYpWgugRB
         q5IGQRWZ6oYxSo7vVocD3QCq5TzZLWiRn/S2Ud82TfBBpk/5ZtIb4oG/hk30EUA43SXm
         xwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSuSoFxOGCn2dKc1HCjcYz8H8NJV0h0NOInNBU1gpMA=;
        b=cXtHIlUPps457tLgt3xCGZ2bqrDthdQ9Nk/0VAjXYXVxleDtx9dfdCNHsgl0hgtROG
         4wEhBT02HznmEsiIeDcfdZ6EAeofcMjwTW/stpcQdHU15CAdl865IQddfTothh5J1Xjo
         KmQmAOyrKw083Aot28wEGlydsPfP0d3tVpX/A6qATyxCJK9pBj7kTxAtpjAh0FMki0Um
         8MtV+k732W13NylIlXdpHlYzwc6nZ7knT8b49nSe67SzJJnapladd7c3Hq2MQ6I0puBP
         mu0c4qIS3WWyIK7oj/IyFI6J9qP5V2HHXVeUvltn7NdSJiaSUV5u/dlqf5g3rdkJ3aCu
         Qa5A==
X-Gm-Message-State: AOAM532+f7Z87pRw/R7X27J5nhE1qu35ToQYBPt4D4ddNmsD1xGyxo8F
        6r3056FfBf+UW6fbt6wI/n2WHq2KXW6frB/891rwlA==
X-Google-Smtp-Source: ABdhPJykTThNIeCyH9BpbVcn03w3Un13AqDopS7RhmmTGPabmxfsRDhqrRXTaLxBykgm3tcdjFmpnL7g7PfeGoPlFYI=
X-Received: by 2002:a2e:7f05:: with SMTP id a5mr23623339ljd.261.1633463354742;
 Tue, 05 Oct 2021 12:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-4-marcan@marcan.st>
 <CACRpkdanbovvXXLAGGZEEiKXXrNnW+8p1sCONQYWmAjVi-m-9A@mail.gmail.com> <3bad7bc3-30ac-851f-57a3-7781dfa23521@marcan.st>
In-Reply-To: <3bad7bc3-30ac-851f-57a3-7781dfa23521@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Oct 2021 21:49:03 +0200
Message-ID: <CACRpkdaZ5p1P1S6j5cphVB8dC6JZT+nc9VMdy7qTmT2EFExqng@mail.gmail.com>
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state controls
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 5, 2021 at 6:15 PM Hector Martin <marcan@marcan.st> wrote:

> We already broke tradition with the "apple," DT compatible prefix (used
> to be AAPL for the PowerPC Macs), and these chips aren't even just used
> in Macs (e.g. the iPad, which in theory people would be able to run
> Linux on if someone figures out a jailbreak), so perhaps it's time for
> another break here?

Yeah fair enough. It's probably more intuitive under drivers/soc anyway.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
