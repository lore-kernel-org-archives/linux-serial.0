Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4317C6FD1C
	for <linux-serial@archiver.kernel.org>; Mon, 13 Mar 2023 20:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCMUx7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCMUx0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Mar 2023 16:53:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AC199ED
        for <linux-serial@vger.kernel.org>; Mon, 13 Mar 2023 13:53:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id nf5so9070853qvb.5
        for <linux-serial@vger.kernel.org>; Mon, 13 Mar 2023 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678740802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXlzN006xu3ZBfFq7erm402Or2NyISMhbX+wHGYXkEM=;
        b=oJVMobxQTq/fK7Mcw93LhfePaKHEdZb+5Dk0NZWNkLvoafPLA5ilrwCVU1+hj9F3bm
         9aGicSUT/WW4whH+nZ6a6/MdF20/28OZ7q5BZ0l+YHMnrKOhV3cgeU0wUL1FPepSgDP1
         ZvYdhT7QFMMlfof+AVTV7VyIpCzNau11JfmHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXlzN006xu3ZBfFq7erm402Or2NyISMhbX+wHGYXkEM=;
        b=B/tGIssQUHBTfUnx/sxSBpMXnA9YZj6raTLQhsB4ULj0iV0F85LWCTPidoYB9VSLFv
         4guljs2DtqZWEkpKgL6B34GytRX2W/BN8xL4vbhM6FJeD8SNxyiSceXmJggTeiTWdGqd
         B7PFLTAUJMs3nSrEazlrT9w0StT8o9S3+ZK8qwCjnj8MuOZ6NWvuHbAYAcy3RCzia+B/
         I6WQhZ5UdkDAp8uI9cwFuH3D7+ADUY0+e74uP0cs3JZM8F9MZlJJAywnAvKEAqUGhdK6
         9PRGYf3IFm7+al4Dcc4SZ9OJM8yzQK9IzUuYhgYrJiE7V9YL3hQ8XyfxSS9+i4XmPgWl
         XQOA==
X-Gm-Message-State: AO0yUKWqokpFqYMY8Ps6MBZujMfDduEqCcUaPCsIalU9rrEFuC808IJf
        4Y/ojMlO9XEoRG1jw3bCg3QbuA5/xRdRw93e/R4=
X-Google-Smtp-Source: AK7set9K/yAqOIDcFgNHKQbv00oByBScG/kvfHxFFf65Sx0+rOsT1aXKRrL5LHgo9da1fMlePxuwZQ==
X-Received: by 2002:a05:6214:c6c:b0:5a9:d6dd:271e with SMTP id t12-20020a0562140c6c00b005a9d6dd271emr4166649qvj.18.1678740802582;
        Mon, 13 Mar 2023 13:53:22 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b007436d0c60ecsm413104qkp.65.2023.03.13.13.53.16
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 13:53:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5416698e889so144407167b3.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Mar 2023 13:53:16 -0700 (PDT)
X-Received: by 2002:a81:ed06:0:b0:540:e6c5:5118 with SMTP id
 k6-20020a81ed06000000b00540e6c55118mr6945254ywm.2.1678740794346; Mon, 13 Mar
 2023 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
 <20230307073155.2.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
In-Reply-To: <20230307073155.2.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Mar 2023 13:53:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
Message-ID: <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: uart_poll_init() should power on the UART
To:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 7:32=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> On Qualcomm devices which use the "geni" serial driver, kdb/kgdb won't
> be very happy if you use it but the resources of the port haven't been
> powered on. Today kdb/kgdb rely on someone else powering the port
> on. This could be the normal kernel console or an agetty running.
> Let's fix this to explicitly power things on when setting up a polling
> driver.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/serial_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Just in case it's not obvious, even though we ended up going with
Johan's series [1] instead of patch #1 of my series, patch #2 and #3
of my series are still relevant. I can repost the series without patch
#1 if it's helpful.

[1] https://lore.kernel.org/r/20230307164405.14218-1-johan+linaro@kernel.or=
g

-Doug
