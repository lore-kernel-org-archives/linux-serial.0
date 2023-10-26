Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9935CC25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 12:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZMFg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZMFg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 08:05:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7D8B9
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:05:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6cf65093780so487893a34.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698321930; x=1698926730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOM36eG6x55qm5hFHiPcwx8zvGUUpSK0/o99XjcsvCc=;
        b=cjR4vBpE6iysT32K/U0mxIiXSFGJNSDvCj00liuN/SC5nlmF8E/z2BEvz/A1mp0jPL
         cym+S1MDe2hf0M6MkyCMGfoTYTF7Kmi3xacB0gTofkk6/9mmYjA0lhSP2aXhbHKnqq5L
         Y/v2Z2O3NySdnCQnD10ipO63NrL4sl4x5LdU1gouK0cm/e3ZxUvDtc2sahOt1GeMclqH
         aYfElKnZ6KZD0s3m62cfNVMCyv+q4ZOcHMaNv9xDeW3zf5QgF5OvMcs01UrZrXA0Cr5W
         4LyfFQDRX5nlZTVz0EmXJS453Vlz1rP2wHCjyKRjnyP5j/0pCRqoDwYLoiMxn53Iv0wT
         c0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698321930; x=1698926730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOM36eG6x55qm5hFHiPcwx8zvGUUpSK0/o99XjcsvCc=;
        b=mvAZVvEeK60YPJNO2rGdqgktY1M2znuW/cFNuQ65yWSKV38BpV3f42BB8pfzKEDcvq
         YxNAdG1ZtpR6140n9jP2bPCi0sX6t/7S7kswjutAXiQ3ReF0e4LUkA0ZBzXCTTRJkx0E
         Y+n9NPT/TYfnKzpNosUyb0D1sMJuNZm4cUTjVwO3ub3Ba06UZ3vcvZ1dWYUcypd/hPCk
         xo7T0S4TStxmbGxT4lCLtBB8Bem2iMWJRYQqCdhNrx2ZxdfGviI6Y0PnzfmJGdwcEB0p
         iEiC4IwHr1SSQzijla/iiSzrn+TJsql5/FHLur5PJNvrO0bTTVczYV672sFT10HPuUce
         AepQ==
X-Gm-Message-State: AOJu0YyBfCa+vDBtwHyqitHIkVEhAK61NRVsVaGPF0rJ2eoIy+vlfvOG
        deN0sxvssl9uLeJSyUV3SXytCdqxlmGPwed3h+mdVg==
X-Google-Smtp-Source: AGHT+IHp7bO2FdByca9u/F+zGBfnvtRjJaEuzVSihY2H7X5qenrgr+SbRPtZDA0+9PYxr6YEPjR52xAFVK9l4nEKhl4=
X-Received: by 2002:a05:6830:4117:b0:6c0:e5c3:40b5 with SMTP id
 w23-20020a056830411700b006c0e5c340b5mr22589652ott.6.1698321929778; Thu, 26
 Oct 2023 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-1-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-1-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 14:05:18 +0200
Message-ID: <CACRpkdZgxjJMKgp+r3MZwEnYX2C3hvidaGYvdxV5rbQDCXfAPA@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: serial: amba: cleanup whitespace
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

> Fix whitespace in include/linux/amba/serial.h to match current kernel
> coding standards. Fixes about:
>
>  - CHECK: spaces preferred around that '|' (ctx:VxV)
>  - ERROR: code indent should use tabs where possible
>  - WARNING: Unnecessary space before function pointer arguments
>  - WARNING: please, no spaces at the start of a line
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
