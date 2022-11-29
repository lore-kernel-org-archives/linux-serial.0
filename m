Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6896C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 10:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiK2KOk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiK2KO0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 05:14:26 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D62E9FD
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 02:13:35 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y18so4850447uae.8
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/QzDW2d1Cs4mC6YU3nOgkgXahHnX/LojCaovyJcwNQ=;
        b=biYhLlnFfQu5qbIvH6K6dxXUh9531anxej8Wa6rlutOAmz9PFvMAzbQJCn662NBeZ/
         Qf34dK6UJ0inR8mxfyAZKbXX2yOLX1Do2iYoCK+AozJJj75XsoNTkrrkdwGw6hqUugiz
         kc7X7SrrXxeqxCmymm7/aZe/DyG2J5xfkxBxMxcdTsUhoRRNe37KG0tJ06q3EBhp9UnR
         nHz+d4F44d9fluRwRUVQN/IDqvFfJlsnnqGU0gv5K6UsAlZou4NobkRUaNzAE5g4EUtq
         qXNTTUDFqAIN8o4WaIVz7JuBdQlkik53HgjE5Ng+nDwEDXNYyaj9gqidMEdRnexgQ7zv
         AN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/QzDW2d1Cs4mC6YU3nOgkgXahHnX/LojCaovyJcwNQ=;
        b=a/93kK3weNPEFZo2UzAIygoIJYWedXSPpNoQ85tpTerUU7S1wtWxKxQSN4YU3Izbqp
         psz9La7VZGZ8e4ckQs3wsSRH9zhUaxgeulKPmexPw+Bt4Zur3M5IJgThxou/FnsCNInr
         mmDJzDh+hb00eCxuTH0QcKY+HscL0BI38b5vR1uQlem3vNBVJzi6JOeeUJoDEcnI4tgK
         soyiNhL5WyUSky5vTKEXLE5jDHYJpwR3gFvRopI5KZc/Rho56eIzS9E/htAELPFeYKDg
         xbtzEy1WebD3O12dyuxaMFdbk+g3l7aBjUENg54xEPKIL5gJE+Se58R6sbakYFjiSDz3
         GBfA==
X-Gm-Message-State: ANoB5pkEbWbeaIayw0l8sF74maDhnqzKoOdMIrefjABcXo3OHRn5Pk57
        IibbNjXLUXC4kWtKBA+x2AqGTXTs3Q9mcrtQC528Ow==
X-Google-Smtp-Source: AA0mqf707P6Kmly5KCwDCM/FQLqA7B2S9xjQRRs0Dqoia9yp+q8vbzEuqLIgGiZas6uFYrbC0zJH3q5ugx2zYpdsYGE=
X-Received: by 2002:ab0:5a6e:0:b0:415:715c:1e70 with SMTP id
 m43-20020ab05a6e000000b00415715c1e70mr24352734uad.81.1669716814427; Tue, 29
 Nov 2022 02:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20221123110759.1836666-1-brgl@bgdev.pl> <20221123110759.1836666-14-brgl@bgdev.pl>
 <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
In-Reply-To: <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Nov 2022 11:13:23 +0100
Message-ID: <CAMRc=Mdo-a3sxaTg=AM_dMMNyV_sw9VxGF-T5RPD2Vhxe2pQOw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] tty: serial: qcom-geni-serial: add support for
 serial engine DMA
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 25, 2022 at 3:37 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>

[snip]

> > +
> > +static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port = to_dev_port(uport);
> > +     struct circ_buf *xmit = &uport->state->xmit;
> > +     unsigned int xmit_size;
> > +     int ret;
> > +
> > +     if (port->tx_dma_addr)
> > +             return;
> Is this condition actually possible?
>

So it turns out, it's possible that the subsystem calls start_tx when
this is already set but the main engine is not yet in active state (so
we can't simply test that bit). This needs to stay then.

Bart
