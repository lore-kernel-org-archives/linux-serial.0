Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E52C64E7B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3313B20725
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRuOpBoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgK3S35 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgK3S35 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 13:29:57 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A0C0613CF;
        Mon, 30 Nov 2020 10:29:11 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so98294pjz.3;
        Mon, 30 Nov 2020 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljgiRzIjbtfqnKwQGVUF4QGCQ8KiYkemhgNQAWqg54U=;
        b=pRuOpBoELbZhMkYnyZceTlEgFysZrq88uLHJchyQABvReZXCmeYfRVflaTqtMs0ITR
         Ik8CE3AJHgIA3y2WdZL5rBTBMs+aMd1TbBOx3wo/pNTi05RoEEjw4dZlKo3VV6J1ZlOf
         A1UwWUE8bxEfDK/FLMf/QMGjmPu29pFuEW/F67I+L4jPI+CgF6Hq4Hmvrf76yahDH1o3
         9CuSEI2EFV7GYcaZZ1Of2S+tHrj3h26EwYzFFrX7+DrPqsBPavQliH+I+4msv9q7Vh8Z
         ZcDoeXG/Pjg/EjZONVc9NlRBiLIpBq1VlaDqOJycUNnbmeyC4AgjLhpiSbSBTrFXU/wC
         RCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljgiRzIjbtfqnKwQGVUF4QGCQ8KiYkemhgNQAWqg54U=;
        b=CEwFHMlsLKy9/8UqZVhV8rL0fRiCedzH1nLX9nJH2EQQgdxefW3iR3FYv3LSvrHxqs
         a7iHS5pvezDY0QMXXFNMdVK9AeUuxm5gLTGR7Zb0ZIVD/voqsq91Hblg1t/Mjl/iMdTa
         qA7kH/b3J3xkkscNBbpFE1E3013V20MyekrqYzEHMU4emviMu7yamNmI19HZpD/W35o1
         rgcd4HTZkQR4BqWqiTlZ7lU8vnTZmd+GX3Wq/EsOGVApV4rVifyYv1IVa8Ugsn7l1FFr
         ZZQifY2p9RUNCriFZIu//Iq2XUb0xhiTFzul0WFi/vqlqo0MM8xwecMhd4Ez8o2XQIpF
         QrNQ==
X-Gm-Message-State: AOAM530LGDUDj0Qkn+yexj8SSevoB1PGaTIXvKSm4CsYpj1gcw8W/r4A
        hC/E7KLpkFLnPOGByhG098BFydzxNWHPOyb1/e7F0oumj5k=
X-Google-Smtp-Source: ABdhPJzxBUnmYUW9odezMnsFA9pn/Qok+oFoVEv4GGQQU4DskiAiK5jztOfhd3N+KuQbzZ+ySvLxZc/BGErscZ8AeHA=
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id
 v3-20020a170902b7c3b02900da76bc2aa9mr6607915plz.21.1606760950864; Mon, 30 Nov
 2020 10:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-4-johan@kernel.org>
In-Reply-To: <20201130153742.9163-4-johan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 20:29:59 +0200
Message-ID: <CAHp75VdSW890kHsFbHGmLeOX=oPNU2SJ4_iyvxEO-574u1S9Tw@mail.gmail.com>
Subject: Re: [PATCH 3/5] USB: serial: add sysfs attribute to suppress ready
 signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
>
> Add a nordy sysfs attribute to suppress raising the modem-control lines
> on open to signal DTE readiness.
>
> This can be use to prevent undesirable side-effects on open for
> applications where the DTR and RTS lines are used for non-standard
> purposes such as generating power-on and reset pulses.

...

> +       ret = kstrtouint(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val > 1)
> +               return -EINVAL;

kstrtobool() ?

-- 
With Best Regards,
Andy Shevchenko
