Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959CC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D461241
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 16:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKJQo7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhKJQo7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 11:44:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B30C061764;
        Wed, 10 Nov 2021 08:42:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b15so12809945edd.7;
        Wed, 10 Nov 2021 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfRD0rz25tMThx/BwiIkkgEd/KlpJso7Ze4Lvb9GtgQ=;
        b=PkWEKBIvugLM4cOygl+bQAGLktwfu5jSga5kGzZMwzdOW7UFUYOiYW3u37a/nLdqJv
         anVnS9C4UD7MBkUVk3tS34zLlxbf7MLGKj9fJiAb6GA67FlOKCVVZln3+utfSPNZJYzr
         Bzff+hYGIYugu8WN4bHKzr+og98fLBZcf8f3ZJtdL5kB830JIP7Cf+MZ4FIkQts4Gifa
         DKb9vpsCVYfngmfDJEMcGLdUkPBsEGNbLfryiRDe68zvtoqmcTJ9jzED9kv4VbNzpRD9
         EqJ8EF2bYYVJ6PEX4GRYlEwhFKPPN9uM+N2xL8m0preGEK9rO2P6gmgp1Tq9qtAgfgWV
         GeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfRD0rz25tMThx/BwiIkkgEd/KlpJso7Ze4Lvb9GtgQ=;
        b=fIyoX4ZrK2K/G586KY9Gba9Kyqf37zI0+mfF53OgQ4yeVQe7ZN33Q729E9vMehmRkA
         IV4ER8LWpXzoSOe+5ieW28OtJsIEqxqC66RE+ZAiuxQ83G6gOYuX3vH6Wt9q4/2WmkXE
         eAQCDiKzvwcTKOXua1jVD4vc+Ej92B5tVHaCbjoe+CvYcNPSriQW0EEpdQxFi1OgMDLq
         xUThnUIp0CGvh6SJ+2MVa5qZ0Vx4UZ3HN7EtOEi8XeXOQbej302lgZYwjjNyTi4VKuOO
         C0g6q+n3u6sA1+BBp9Rt24awtBB06yZokdOn/p6+0t2ejBqGgoHxzpvQOq4j6CR4vqzL
         YR1A==
X-Gm-Message-State: AOAM530qBUi38Kg8am/AH9jmwRy4mjq3cVR4ljwDFKEsXcg3b+AK576I
        iGBhGN7eC73vzpfTZGobXNufoqdNtA0dmA/oN5amqy3FsmE=
X-Google-Smtp-Source: ABdhPJxQesTiSTH7GZ8mP0J33LzdzX8/yrJFXEljr74ODZBbPHN39U6V3MJQDQ2I/pvhOpUuiyqeev71xPSK6tmJSlw=
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr303311edt.359.1636562529816;
 Wed, 10 Nov 2021 08:42:09 -0800 (PST)
MIME-Version: 1.0
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com> <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
In-Reply-To: <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 18:41:25 +0200
Message-ID: <CAHp75VcZuN0-zJjQUk5Afgqd-ON5PjVzMSjfM2Mouiq-EXjcWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add UART driver for Suplus SP7021 SoC
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, tony.huang@sunplus.com,
        wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 10, 2021 at 9:51 AM Hammer Hsieh <hammerh0314@gmail.com> wrote:
>
> This is a patch series for UART driver for Suplus SP7021 SoC.
>
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.
>
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html

...

>  drivers/tty/serial/sunplus-uart.c                  | 1591 ++++++++++++++++++++
>  include/soc/sunplus/sp_uart.h                      |  147 ++

Sorry, but I do not believe this driver requires so many LOCs. Please,
try to get it under 1000, I am pretty sure it's possible and
achievable.

-- 
With Best Regards,
Andy Shevchenko
