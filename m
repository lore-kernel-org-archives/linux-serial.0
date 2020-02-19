Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C00C34056
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F301220801
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOhn+mov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRuW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:50:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35687 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBSRuW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 12:50:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so381183pjc.0
        for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2020 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Z7a7oA5rHpxM92NoMV2XbtQ4b8rn3jd4JC722SrafmQ=;
        b=fOhn+mov0gBaTRqLZ28SsD4CaCbe4sYywxzU+0IQdXyYqPRfDWIHD0a6QUaOAOvzcO
         +twk639IUbq5BbbwJlBgLtSPQl3/KPAompTFw5Vek33dwfaGACR7YQMl/X0TM7bcrb45
         J+EeoyrNddqMnQYwbeNYcnQyugCFOVIR3Lthg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Z7a7oA5rHpxM92NoMV2XbtQ4b8rn3jd4JC722SrafmQ=;
        b=J8/tNUwzQ9yJpfJOVB1hVwAgmgZ7UguiQmMLFlTiCIuMkssziR2pb/eaqK47UiePuG
         CvEbvyx6uJlpL3GTPO6INRuMLRGIBNM8LkCS7b0K2lgJxdTgTuwsSS4Ptzdt7wAzxF4V
         d6LPcACeQWP0OKbE1mQvzxdzNlM0v3GV1oLXgw76Qxainph2uZDG1+BwgXXCgsCn+ceN
         glSAm/z6TpJveavh5gkWKU2+nWZVlrWgxxQFdgg0qmzgW+2PyFh8QBSFDLithpwOSSw6
         WrVXw/NUcHPrb8sNBV4ImyDnJh5FCDCj6TJsfc0+6saqfTBwOz0fbUIEoJezsm7mfr3o
         nYiw==
X-Gm-Message-State: APjAAAWlUl5JqNPoGWddVGaeh22BqRF11uXtprDBauE4d4wu97GRjUwV
        DMf25lGpm0Ui+Z293GVy+WPDxyR+22w=
X-Google-Smtp-Source: APXvYqx2fiqjZ6AKNyrvLHc9HhmGOYJRsA7+KslntBNJvlRCCgTz4zgI0jq4BtqJ1jnmFpB76/+gpA==
X-Received: by 2002:a17:902:d898:: with SMTP id b24mr27181684plz.133.1582134621518;
        Wed, 19 Feb 2020 09:50:21 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q7sm321684pgk.62.2020.02.19.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:50:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <254d7b003fdcd6f5fc0c45ab75b4b5f2@codeaurora.org>
References: <1581415982-8793-1-git-send-email-skakit@codeaurora.org> <158154775640.184098.13898240474253130921@swboyd.mtv.corp.google.com> <254d7b003fdcd6f5fc0c45ab75b4b5f2@codeaurora.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix RX cancel command failure
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     gregkh@linuxfoundation.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        akashast@codeaurora.org, rojay@codeaurora.org
To:     skakit@codeaurora.org
Date:   Wed, 19 Feb 2020 09:50:19 -0800
Message-ID: <158213461988.184098.7165493520823815160@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting skakit@codeaurora.org (2020-02-14 05:17:01)
> On 2020-02-13 04:19, Stephen Boyd wrote:
> >     driver_probe_device+0x70/0x140
> >     __driver_attach_async_helper+0x7c/0xa8
> >     async_run_entry_fn+0x60/0x178
> >     process_one_work+0x33c/0x640
> >     worker_thread+0x2a0/0x470
> >     kthread+0x128/0x138
> >     ret_from_fork+0x10/0x18
> >    Code: 1aca096a 911e0129 b940012b 7100054a (b800450b)
> I think the most probable explanation of the crash is, set_termios call=20
> is starting RX engine and RX engine is sampling some garbage data from=20
> line, and by the time startup is called, we have few data to read.
> How frequently you are able to see this crash? because internally we are =

> unable to reproduce it.

How is set_termios involved? Is that starting the RX side before
uart_startup() is called? Sorry I haven't looked into the code flow very
deeply here.

It seems to happen when the bluetooth driver probes so maybe constantly
adding and removing the hci_uart module will cause this to happen for
you? I also run the kernel with many debug options enabled, so maybe try
enabling all the debug stuff? I see it randomly right now so I'm not
sure.

> >=20
> >=20
> > This seems to be the problematic line. We didn't call handle_rx() from
> > the stop_rx() path before. And this qcom_geni_serial_stop_rx() function
> > is called from qcom_geni_serial_startup(), but most importantly, we=20
> > call
> > into this function from startup before we allocate memory for the
> > port->rx_fifo member (see the devm_kcalloc() later in
> > qcom_geni_serial_port_setup() and see how it's after we stop rx).
> >=20
> > Why do we need to flush the rx buffer by reading it into the software
> > buffer? Can't we simply ack any outstanding RX interrupts in the
> > hardware when we're stopping receive?
> We can't simply ack RX_LAST interrupt, there is a sticky bit that get=20
> set on HW level(not exposed to SW) with RX last interrupt. The only way=20
> to clear it is flush out RX FIFO HW buffer. The sticky bit can create=20
> problem for future transfers if remained uncleared.
> How about we allocate buffer to port->rx_fifo in probe itself?

Ok. If we have to read the rx fifo to flush the buffer then perhaps
write another function that qcom_geni_serial_stop_rx() can use to
indicate that it wants to throw away whatever is in the rx fifo? Or
adjust handle_rx() to check for a NULL fifo pointer and throw it away in
that case? When we're setting up this device I don't understand why we
would want to read anything out of the rx fifo that was there before the
driver started.
