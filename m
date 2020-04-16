Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6853C2BA2B
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F61F221F4
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 21:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+76JoX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDPVao (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVal (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 17:30:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E227C061A0C;
        Thu, 16 Apr 2020 14:30:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e12so14990pgj.6;
        Thu, 16 Apr 2020 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F59MCAy9LQ39t9b94uz/vF55cBc/ty5ftnkMrjUeMVI=;
        b=F+76JoX2R7sUagBs5MiZtTABq0cgtV+vyQR+Pq0aOKntIcRM+e75S9VZPbYgX+4O35
         r2iDAKA9feHsDg2oq2V8HbPB7rb1IbMWWnV91YEmvAeuS/wb00lNv8S/b59cVyCbNmoI
         v0qg2uie9OZvu/aEKifWzzNGkDiYsvXl/ebCuzDMJyooHo9v9plc0T5enusQhD1HRJhQ
         NCib4b4yxg03NdKVXBqT7s7sudY8OZINEnlICKS38rHSiBGGhrFq0m2JNNfJ7smKua9c
         uMwPAEVQOM/3xroHC415fZ323fbfwaGmYwSIWFfIdLZdinMSTPCmG5svP9sswxgVc2Wx
         QHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F59MCAy9LQ39t9b94uz/vF55cBc/ty5ftnkMrjUeMVI=;
        b=fzWv5GWkjlU65LKtulrmQiwM3hluoVFKmTRsJ/pb/SkJ681FYflzWwPBWrOzY9kpL3
         3XUqu+eMgqadwiP9DqhcNTIe62roDF6NhrBdRPhEAgr2WSYp1qux6eyhW99gp19o+Svo
         5qVdk9ZS1Dg0Bsq4+SR5FpXJQPJ6JQCUo5j7uEGD4uhaHcOSUyuhZqvauMb6Kw82iFxN
         N2KGjmVX3aZJVlLVirW+H+Pjs6kkPFCXFInhE93+5tpXieCUyZO4XTzJb16KoCFifVlm
         HsebLmm/4mb344/p68TAVQy/ZACGeqoO1C991PC7iqnIRBxwK59Bln9HnT0kH04inFDE
         D6lw==
X-Gm-Message-State: AGi0PuaTBrzEPQoTwBm7Ud6Wdy7qLEUWwkaqKSHDsFkWfJtXqTL9hu8a
        joHdgEDcv9DEWM0rlRmB8q9mYJ/w6aysLUDCdvqmocPXGYA=
X-Google-Smtp-Source: APiQypKbsEwv7dyMRMPJoBQNj/KvDFB5w7W5P0FHGG1weQUmw4bO5gMc9e2umvdhLDeoCPYVHjIesY8EPzX4ASZJHQA=
X-Received: by 2002:a63:5511:: with SMTP id j17mr17300739pgb.4.1587072641114;
 Thu, 16 Apr 2020 14:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200416175729.5550-1-mani@kernel.org>
In-Reply-To: <20200416175729.5550-1-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 00:30:28 +0300
Message-ID: <CAHp75Ve6V+gm_KXqMpG8bn7KtHjOctomZwk8n_6xwtx6cFdKfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add CTS/RTS gpio support to STM32 UART
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 16, 2020 at 8:58 PM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Hello,
>
> This patchset adds CTS/RTS gpio support to STM32 UART controller.
> Eventhough the UART controller supports using dedicated CTS/RTS gpios,
> sometimes we need to use different set of gpios for flow control.
>
> This is necessary for the upcoming STM32MP1 based board called Stinger96
> IoT-Box. On that board, a bluetooth chip is connected to one of the UART
> controller but the CTS/RTS lines got swapped mistakenly. So this patchset
> serves as a workaround for that hardware bug and also supports the
> usecase of using any gpio for CTS/RTS functionality. As per the sugggestion
> provided by Andy for v1, I've now switched to mctrl_gpio driver.
>
> This patchset has been validated with Stinger96 IoT-Box connected to Murata
> WiFi-BT combo chip.
>

Looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks,
> Mani
>
> Changes in v2:
>
> As per the review by Andy:
>
> * Switched to mctrl_gpio driver instead of using custom CTS/RTS
>   implementation
> * Removed the use of software flow control terminology.
>
> Manivannan Sadhasivam (2):
>   tty: serial: Add modem control gpio support for STM32 UART
>   dt-bindings: serial: Document CTS/RTS gpios in STM32 UART
>
>  .../bindings/serial/st,stm32-uart.yaml        | 14 ++++++
>  drivers/tty/serial/Kconfig                    |  1 +
>  drivers/tty/serial/stm32-usart.c              | 43 ++++++++++++++++++-
>  drivers/tty/serial/stm32-usart.h              |  1 +
>  4 files changed, 58 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
