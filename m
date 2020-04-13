Return-Path: <SRS0=NZaJ=55=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B6C2BB86
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D3820731
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 09:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD88jc+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgDMJYx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728234AbgDMJYn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Apr 2020 05:24:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41023C0A3BDC;
        Mon, 13 Apr 2020 02:17:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o1so2742367pjs.4;
        Mon, 13 Apr 2020 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Es/1kSX+2DTfIEl11xOgF+dKXSLyBYadIDMkf6JWRY=;
        b=uD88jc+H5svxYWnFnmOVmZGhizFVGLAqr3CGeRWDO71LcsasJpC+gS6bTbGRjKJPM3
         oZ9POJtkVxjLCFTbcL+p8nnQySxbLL31W4FoXcAJX3ZzjWVGDARV0SImqIOX2W/pEOon
         VNWH55nNVoBjMsIDFb8wwRfiKr0nqmZqI1/dBsNbIj2R9CC6u/yGTisg10eG5ytX8cMI
         EvG8HXr+df/G5G78N96KOfukqqYSuC0n4PXJR38NSI3N1XwImkZhSlFym87QkkP6mlcN
         uuEiLWJ+0805c7VirFoRpj+kz8ZQJXGK5w90D5bDCpywG0dKP5HsHGALfFUSO/gVPw4l
         oR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Es/1kSX+2DTfIEl11xOgF+dKXSLyBYadIDMkf6JWRY=;
        b=PboJL/GaMRxuS+S8dzjyhq521H20gI6TkBUiQMEji9oHiBj4QZpVYjzPnxXl8qlgv4
         pqxbLhIMs4qFm2b25pN7s2HgCtsV0NWTDaihxesL08L+UvW4kVQ73Q7L3XneLwryOy1W
         +4Ym2qLLxCwHCi4sZeMSL7GRErWrB/Xvxkmu9R+8WlNKg4TnDlU/e5yfHGLd1DURtNnv
         uCsH9V62WouYdHsfpLZg04IqKP7/Q65MDm3T4Sw1Mwt8s7HrH4MtR4KTT4FLsv4sy3wq
         0Quob7c2CmDPk+kj7V7dmeBYSB1bbqZF/ctLZPfeDDUmVBKWRnCeS2isnKDG0p3vJnVb
         erZw==
X-Gm-Message-State: AGi0PuYxMGyNCL9mX62yKq5PU84rOFXNbLT3ydVduh8gf4i2IWv+jzAb
        AUSr5CfINISJ55BMDHzvmKPbYAkd27E19LNj5CY=
X-Google-Smtp-Source: APiQypKrhwIBdb9K5xK6+BTvgkhgXaWgjvsbqf2WCnQLazfGOFLVhIlgZpBJQNARmhWX7ScRLGvI/AGMLB5ktOM49e0=
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr16330033plb.255.1586769453549;
 Mon, 13 Apr 2020 02:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200412180923.30774-1-mani@kernel.org>
In-Reply-To: <20200412180923.30774-1-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 12:17:21 +0300
Message-ID: <CAHp75VfDUoFMWg42OFHZtKQ972eoR3UDLVAs+BQjJm3h3-fOGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add software flow control support for STM32 UART
To:     mani@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 13, 2020 at 7:06 AM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Hello,
>
> This patchset adds software flow control support for STM32 UART controller.
> This is necessary for the upcoming STM32MP1 based board called Stinger96
> IoT-Box. On that board, a bluetooth chip is connected to one of the UART
> controller but the CTS/RTS lines got swapped mistakenly. So in order to
> workaround that hardware bug and also to support the usecase of using only
> Tx/Rx pins, this patchset adds software flow control support.
>
> This patchset has been validated w/ Stinger96 IoT-Box connected to Murata
> WiFi-BT combo chip.
>

I think it's a mix of terminology or so. Looking into the patches I
found that it's required to have GPIOs for SW flow control.
No, SW flow control does not require any additional signals, except RxD/TxD.

On top of that, it seems you adding mctrl-gpio functionality. Why
can't you use that one? And thus no bindings needs to be updated.

> Thanks,
> Mani
>
> Manivannan Sadhasivam (2):
>   dt-bindings: serial: Add binding for software flow control in STM32
>     UART
>   tty: serial: Add software flow control support for STM32 USART
>
>  .../bindings/serial/st,stm32-uart.yaml        |  15 +-
>  drivers/tty/serial/stm32-usart.c              | 143 +++++++++++++++++-
>  drivers/tty/serial/stm32-usart.h              |   4 +
>  3 files changed, 155 insertions(+), 7 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
