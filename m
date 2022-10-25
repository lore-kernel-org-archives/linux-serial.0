Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4CC67871
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 01:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJYBQr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiJYBQX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 21:16:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D02D18EF
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:34:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so8756391ejd.9
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23CZ4vA4i98W1nbCbv2ZjLLFBQ1q7plrKRviYMc9dQY=;
        b=gUtM1bX+9AmKX0fN+I2coUZ/gBg5Zmg+i1ZO44YmZLIMFCKsYf5MbCnmv3nYoYBM9T
         Nk+Opwq8i7lXrs6x+2lkbcakPKleOk5ygjBcjiKOAVSA/LVrtj3bPz1Zn+gWXsKa3mV7
         7V0idwlnPxnsM3bKEtlZeAwhPMHKlf5jv1bM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23CZ4vA4i98W1nbCbv2ZjLLFBQ1q7plrKRviYMc9dQY=;
        b=vVSBCW62tNnmVGko18SvTRqv7hOjKwEvKEwU0fMCOtTGeeObmqxsssOz7VbBHJ7d25
         We6RNyHCctYe0RhgsmEkgzJ2YM1jI/W/W54HHLmfQAkSlCx1A/n0Q+jXjDFEFBDhcK9S
         4zH38gfqLm3b6CLrtth+mS7yHomr+inrHweAHvElaEjj81XrnerqqlCe5mBbWiHv2IBX
         jxr+PJyIYE4aLczFY04csxQFFvJcxN6LlFR1+qQ2EWra6zfSqYEQqfUKWpI+0/zUZlDU
         tMuo8Cuw6sxVThXBZXpaj2G4YctYAt/AL71h1Lmy4Plcdd6bZVt2gaCz7fPKxC3hiMVh
         Ek+A==
X-Gm-Message-State: ACrzQf0eJjpx0iutwad82AqNGpozYe5VvFY3+8Dv9l/34VbLbuYTcPrg
        wzMPqv1WuDwsy9TN0ebMifg6s0P/s5IFHOXj
X-Google-Smtp-Source: AMsMyM6L+/Crtod59QBHQpeJorXl7un34Rp3WcMMFQsXdNI7XbMyPAUFyydJh1m14f9JvuqF3H6vPw==
X-Received: by 2002:a17:907:7fab:b0:7aa:97e5:fac2 with SMTP id qk43-20020a1709077fab00b007aa97e5fac2mr3876752ejc.553.1666658069842;
        Mon, 24 Oct 2022 17:34:29 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b0073dbaeb50f6sm532201ejb.169.2022.10.24.17.34.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:34:27 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bs21so2594173wrb.4
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:34:27 -0700 (PDT)
X-Received: by 2002:a05:6000:3c1:b0:236:5779:546d with SMTP id
 b1-20020a05600003c100b002365779546dmr12326195wrg.405.1666658067197; Mon, 24
 Oct 2022 17:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-2-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-2-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:34:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ8WFoZUm=P+kKo2oGAfSGOmadvhDkE4PQe6_-33zi_w@mail.gmail.com>
Message-ID: <CAD=FV=XQ8WFoZUm=P+kKo2oGAfSGOmadvhDkE4PQe6_-33zi_w@mail.gmail.com>
Subject: Re: [PATCH printk v2 01/38] serial: kgdboc: Lock console list in
 probe function
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
