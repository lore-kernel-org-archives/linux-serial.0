Return-Path: <SRS0=qPbX=6I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6042C54FCB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 18:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDD3206A1
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 18:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PF+kY+n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDXSSR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSSR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Apr 2020 14:18:17 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D434DC09B048
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 11:18:16 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i22so10413866uak.6
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyAAaOwFK7ul7d9czQcmoPsUFdvkN9A5K/n4TydUE7s=;
        b=PF+kY+n18N6Y8sxBrsgfpMsiJrDvPdLp7v6zKmnMnR+nF9jYyMmXusEJ65ZmgOTgo7
         jaIYJG5iBR3nlo17YckUo9KEvEJsZ4SQDkGJbHsPinLM670SN8oDB5nrrstzmRzRoLGx
         URl+TGalt+yIGIzbDtOZv8ZfmyO19a4tV2XLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyAAaOwFK7ul7d9czQcmoPsUFdvkN9A5K/n4TydUE7s=;
        b=ozx7i9y9obgjgVmKenWs8e7TRm/6ylKUweVbBV4I9IjzDcbMz2MunhmMrUENzwJLzX
         /xz2sgvajxvmV/ZbT06Ut3nVRg/ZlJmxNN5Ox/MqbpaT2NzB4eyvLu1h2sdqMpxNtOMN
         B+unk26WovFUjgV52ban8j6XmMoq9LH4ABff9MDX9emR52LySnRAo7oLneyIJkDvUYdn
         zTlmnpbh/Tqt5it1YfwSGtpy1qZ08tlDu5xe/kEPsUUctLuvZ2mFcA16z+riF0t5aIMU
         CuPnyeDXsI/UqfFUAu3AaHcjYiAvmFxvkMLFAwd5wAgYTIVjinIF/aBlgGO2/0owaSCM
         YWAQ==
X-Gm-Message-State: AGi0PuYerN+ES0V1/9yEvd6OG6HlvWBtO7vymFKqIkjRDAJGLqFeVLSK
        hmIyOvPIzuJlEhEDn47wSCW5NEGIdgg=
X-Google-Smtp-Source: APiQypJRY42A6hajUro7VT8tV5jI4rzXg/JkkdsTtjFz8PP9xGSeaaya2nrGPI274riX3H42IYZ7PA==
X-Received: by 2002:ab0:21ce:: with SMTP id u14mr8932992uan.80.1587752295011;
        Fri, 24 Apr 2020 11:18:15 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id g25sm1590803vsq.21.2020.04.24.11.18.12
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:18:13 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id 36so6346060uaf.9
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 11:18:12 -0700 (PDT)
X-Received: by 2002:ab0:b88:: with SMTP id c8mr8784752uak.0.1587752291944;
 Fri, 24 Apr 2020 11:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 11:17:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8NY+3pECsF27SC80FQmzewJ1gSs48wzB=PTYRZ4pCaA@mail.gmail.com>
Message-ID: <CAD=FV=X8NY+3pECsF27SC80FQmzewJ1gSs48wzB=PTYRZ4pCaA@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: Support earlycon_kgdboc
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 1:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Implement the read() function in the early console driver. With
> recently added earlycon_kgdboc feature, this allows you to use kgdb
> to debug fairly early into the system boot.
>
> We only bother implementing this if polling is enabled since kgdb can't
> be enabled without that.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Depends on kgdb patch series: https://lkml.org/lkml/2020/4/21/1179
>
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

This is the first time I've ever looked at the code for this
particular serial driver, but with that caveat your patch looks right
to me.  Specifically:

* Code, naming, and style of your new read routine match the existing
write routine used for earlycon.

* The read routine looks to read the same registers / works the same
as the main "polling" read routine, pl011_get_poll_char().

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
