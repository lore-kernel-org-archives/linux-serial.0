Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26398C25B6E
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJZNij (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNii (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:38:38 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB018A
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:38:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7c011e113so7317537b3.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698327516; x=1698932316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW0IaiCDGPtfg501Nw8p6UpGLwS2ZUBRonlHE2LLZzs=;
        b=x9+2I1elp0NtJ/7n3Lq5bsXDYJ22d7FQ3CIwYlL/bAWTq6Fly7DG+90wSXYHNibwno
         M8SCWrBgF6P2wREpmxfuXu7puQfp3SurlxI9kTp36Np35XQrLX/FcW/gke59c5H7CISs
         dTrAH2Twacm0j2ccQJRYGRRxCNgFtSTjya1GcTaI45mRoX1x4TmT9zeEdOxjvPhelVOA
         Oj65dQQVGYW5gOPooEz1vz7ncNj9YROA797GPRlCSz8ofyimAy44wsvHMU4Mj0AYxSfV
         eeyjrcpZjwrPNNWmnREcJ6QF1OnOOaj/1lTxZxOKuyzrk7J/1FvHngvKtZn29nsDWCHT
         dQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327516; x=1698932316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uW0IaiCDGPtfg501Nw8p6UpGLwS2ZUBRonlHE2LLZzs=;
        b=rOdYuQ/BGSuoMMUGJzjk3wGFkLLruAxVRk83xliUN1vA9uQSxdpn7ctJpHdM3p18ZT
         8s2NuYKMNYC/mRr0kqzJ96KeghUiBrZP9HwttfIRnetiZnNzgsklWb9DY2ZHK5mbTLv7
         gH0GCmYzr7gDZTmNwUuLXr1MlLEWaF4rn8KuhZjPnfp018s6Hqk43Tq4oJIIZGpDLGH2
         EJlDtn0I7iHJyfpmZboL2hCBWsgx3J1+ggLeFJ8QuFBuqDH72DCn0DZnYsrvYebXt6in
         OYs9iIk5YGmGzuCEFHO/6qK0nZQ5WV6OUUaZPyS94vDkDQHv4mll0w8umVEeS7lfhmIg
         tznw==
X-Gm-Message-State: AOJu0Ywp80iovzIjJICelCRI6JboupVt6xB3Ys3cG5fx4lLuwilqu4Ky
        NyZSIYOWf4Wu6keWvZTZmpm/XCnpx9Qi5PMrDOwr0A==
X-Google-Smtp-Source: AGHT+IGniiZ+KAxKfAUBm/LTzqfB6hvkLHRlM0D1QsLMcILZ735k3hAKAdypCFeMnj5XsdasrMZtYIBxfs4MJ1az3/I=
X-Received: by 2002:a0d:e2c9:0:b0:5a8:286d:339e with SMTP id
 l192-20020a0de2c9000000b005a8286d339emr20086367ywe.4.1698327515767; Thu, 26
 Oct 2023 06:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-3-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-3-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:38:24 +0200
Message-ID: <CACRpkdYant-8UGXMVFSTMxz-VRmD=iNiKiskAGbF1Bd-TyBMsA@mail.gmail.com>
Subject: Re: [PATCH 3/6] tty: serial: amba-pl011: cleanup driver
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:


> Follow recommandations from:
>
>     $ ./scripts/checkpatch.pl --strict --file \
>             drivers/tty/serial/amba-pl011.c
>
> It does NOT fix alerts relative to TIOCMBIT which will be dealt with in
> another patch. Fixes following alerts:
>
>     CHECK: Alignment should match open parenthesis
>     CHECK: Blank lines aren't necessary after an open brace '{'
>     CHECK: Comparison to NULL could be written [...]
>     CHECK: Lines should not end with a '('
>     CHECK: Please don't use multiple blank lines
>     CHECK: Please use a blank line after function/struct/union/enum decla=
rations
>     CHECK: Prefer using the BIT macro
>     CHECK: Unbalanced braces around else statement
>     CHECK: Unnecessary parentheses around [...]
>     CHECK: braces {} should be used on all arms of this statement
>     CHECK: spaces preferred around that '/' (ctx:VxV)
>     CHECK: spaces preferred around that '|' (ctx:VxV)
>     ERROR: do not initialise statics to false
>     WARNING: Comparisons should place the constant on the right side of t=
he test
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then =
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
>     WARNING: quoted string split across lines
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

These look harmless enough to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
