Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C172C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZNsY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZNsY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:48:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34E187
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:48:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a398f411fso671504276.3
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698328101; x=1698932901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S/Bb/tPpH94M8WXhMx2lGTSS2CQLvVdb8TajQ5C6MI=;
        b=DSJhD4MSKTR/G/8XCL+a3ONUPgnwMLz+/q9C4g+A52CivCDNXLHose+ro5t0/GpHeF
         m8kjq/Imh1km2mx3bGWq1vLe2kCc2EYvcgNpYjrFvkqmmaS9PAwfFDUxJr2FCA648b6O
         yi3WGaiM9Fa77SXeaFVKOtKgMJfLYtbw6EhqwFBRRszd5g1ZzTuLuu909J+Q4fKA0OFQ
         o4hjt1OSt6/pecVsySPLWFAKLJo0zcVYJ0/GivjFh1LpuMlWM4/2lqa627zWcsIKSIcg
         zAnfB26VJXy7JUHqPYM1C2GE1gQtpNKXUQGiHkNVVfRrAYSmRkdnSXuDaLQ3UnF3DsQI
         5jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328101; x=1698932901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S/Bb/tPpH94M8WXhMx2lGTSS2CQLvVdb8TajQ5C6MI=;
        b=weZIema0A399BFkCNoKSS8Z5VS0+D1bBhGzc3rJztkbYaTUILF8fx49QWHQgISHP8o
         UA+DQnVCA0E+hp55UZFiYZc6BKGe1KHP/xqsLWnt+LudSomTFmFjOcyD3dsLvYW3mRNv
         uCFAh4oitZ0bJwN1084IA73t4zuYreZWLF0E2oHgvR4jtjAEdxDJ9fMKCpLGfcLbYV60
         0BnM3OIcsGCl/2GLdG1XfxHS6XMsDfkdJa4MW25GKVrqn7wgBZyCKxhEyVHCjlNtW14Q
         Tnht4MMwhvSoClEkycdNedjJwNXDOelj3sp17mymE4osBQ1SXZuVIoB2u/8Y7f1R/+jn
         VNMg==
X-Gm-Message-State: AOJu0Yyv2DYlXKKC65zD0ZcnLAoQNhpwZC+norh5mvRSVOnZw4zGzsfg
        9AjfHItHOfAEoDzYVuet01Qq01to/5VCk0//J6ChVg==
X-Google-Smtp-Source: AGHT+IHOlQXdKvdG6dDhTf58GtbNr/n/7+CCGsIIeBqRMx8FFpsP7RTgjGl6yZz1+3P57Q39kPZ6cYfB9llghQvkuzc=
X-Received: by 2002:a25:4c1:0:b0:d9c:aa17:2ae3 with SMTP id
 184-20020a2504c1000000b00d9caa172ae3mr17257498ybe.64.1698328101477; Thu, 26
 Oct 2023 06:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:48:10 +0200
Message-ID: <CACRpkdYkgg91HXuZ6LVymwHvLTRGzb5ubU-7k3wUm3DDRwkmww@mail.gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6, 7
 or 8 in _get_options
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

> pl011_console_get_options() gets called to retrieve currently configured
> options from the registers. Previously, LCRH_TX.WLEN was being parsed
> as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> inclusive, which pl011_set_termios() exploits for example.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

With Ilpo's comment fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
