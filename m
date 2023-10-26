Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94903C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjJZNhh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjJZNhg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:37:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA418A
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:37:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7dd65052aso7440577b3.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698327452; x=1698932252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOx8ddXc9Yb3bG6JoRDnlwg8757x2FxWfqO5ucclk30=;
        b=zfDXuaaw4RgQfQ+NkWn5wjm9vPsaP0FnmEdSfI7WMVVRG1Iy1F1metRKnZa14w0cwm
         d4c6HqrI/8AmzdMJfFHOwyPDGoJV46Nl0rQJPRhx7/+5uFWJQMQz3/GFBdLMHPWyFLk4
         RknBqe26GyEeNbOqV0SuWd3sRtJcVaFhwFakkEFRX1cjfCWpBLmfKQYhBUYpvCRKhkaC
         UaiRm0SYOxl+HST8RL75wd/uWmlLjvNOACrhoKaBMlZu1bXTWh2dbBe2jCPAQqrS5Soe
         +MYvesVkIcEGEha42zYv8826W7VcRpQS3pEomJ9ZbuxEF6ATlKXKOPGlaksXU/BONiqO
         DiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327452; x=1698932252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOx8ddXc9Yb3bG6JoRDnlwg8757x2FxWfqO5ucclk30=;
        b=FFH271cxxsAqF42dCbyC4p12N2F0jS0cC3nvVJg0rn40W6+lTImsQLEeOGzVAsqh2u
         zKDB0ZPMCH0dkImGWhAfpyA0R6Sp1W3lUNFdZxUzW7NBGcFIc+mWgETm6/+ZgtNeNJP8
         tPzByAfX06cKWEUX3dKPbPek7jLrufMvZgYf+XUCclcGDSoaUCfUC5ILZDhKWwakrLDM
         lvarOXXpxYwgc/eVh1NT8gjGQ991a2/ezE8sWmWNomiNBxCvHQICmOO9xFdfhF2aJut7
         e0D6g20Did/cWy6Ob6/boMJidVDPacbLUuhcZmqgt28SjhSPniENCv3zd3eRfRqINQ4f
         JYWw==
X-Gm-Message-State: AOJu0YwBxEicLTxyMlYe+GqCZR8by2fRrrK/BDwNisyuJlVXn5tpQ9AC
        RK3hCtHodYPPg1DWgw3k2k3Ar2D7ducYw1oZP92lgA==
X-Google-Smtp-Source: AGHT+IF7yl72QxYny7p60ivvgeD16vtCXalAnDaE7lw9lLxXrLOrIca+EPOAUIhxKK6pLp+OC+111zcBVAAfVBNGvGs=
X-Received: by 2002:a81:a187:0:b0:5a7:ab55:b9af with SMTP id
 y129-20020a81a187000000b005a7ab55b9afmr20163841ywg.35.1698327452521; Thu, 26
 Oct 2023 06:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-2-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-2-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:37:20 +0200
Message-ID: <CACRpkdaBGRsH3q9xY5-YuvgO4jXSr9x-+wZZ4bPXByZbrHt4Qg@mail.gmail.com>
Subject: Re: [PATCH 2/6] tty: serial: amba: Use BIT() macro for constant declarations
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

> The driver uses bit shifts and hexadecimal expressions to declare
> constants. Replace that with the BIT() macro that clarifies intent.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  include/linux/amba/serial.h | 182 ++++++++++++++++++++++----------------=
------

Since you don't know where this header may be included, you should
add #include <linux/bits.h> at the top of linux/amba/serial.h

With that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
