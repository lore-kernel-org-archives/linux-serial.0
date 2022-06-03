Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812FEC43334
	for <linux-serial@archiver.kernel.org>; Fri,  3 Jun 2022 19:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349277AbiFCT26 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244845AbiFCT25 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Jun 2022 15:28:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA1580FE
        for <linux-serial@vger.kernel.org>; Fri,  3 Jun 2022 12:28:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n28so11412255edb.9
        for <linux-serial@vger.kernel.org>; Fri, 03 Jun 2022 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLcd3Cw3hjI1NfLbhZ7+1EK5axo7GcECogVJtB2kQoo=;
        b=n63Lg6qyTjWXwuTeS8v+72aLJUJKw4vX/fzlGVF9KlWhmWjFlvsfSiHMmLjmJq8wL+
         J1+x0KJSnIYLk4zcB8ymTQjBIInkv9QNNiGw+gbTuk6Agp3JicslpgubNSGLpQP5/Qnp
         V13l+3GFTz3kWlwBXsM4/d9NyoyY6+LvUMNLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLcd3Cw3hjI1NfLbhZ7+1EK5axo7GcECogVJtB2kQoo=;
        b=QawffSVlXc0aiWvD4qFAi/UfIjbHid+7TfHjJIUmfuJXIqdzGiAnYyUw0YwRtComql
         NO2JsXfhae2vVuC1xvxqobV0/pS+k2O2xAhM3eVYnfkdM4d9OjFroKd6w6jIj9+G/zIF
         cNsqGRZF+Z1QA1SxRnuubWSIjJO1wV+oo4JS0jE/957Q6LjR8lYI1aTIesjcQYICK6GG
         +tCygBpVdt0B3R4Y6DZiHRU3TGfxg1xeCkNoi/ZEgpp2jtMv6+Y6qBYkY+hgTyLDDNJV
         P4B++rT5jz6ukPsD0g/mXkovWOva0liDQ1AWvAe5yTLVtWKd+kcKP4YSQ9QR1Sai6rSZ
         vJKg==
X-Gm-Message-State: AOAM532butnex4P6JRwMI/R4eQH61cfdEAsotLZl+KGJecbjMSdLh6J9
        9xvJizqBkY9sTDLv4lC/1DblERp/3w9ZQmaWMVU=
X-Google-Smtp-Source: ABdhPJzbWqqWch8L1eUpW4SiAuXksbiEoyhb68BqLLvDX+lrr1Th5Qrt+75oo1WXJtu/VbX3K0IwHA==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr12337068edz.195.1654284534700;
        Fri, 03 Jun 2022 12:28:54 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906094300b0070ad296e4b0sm2018112ejd.186.2022.06.03.12.28.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 12:28:52 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h5so11637010wrb.0
        for <linux-serial@vger.kernel.org>; Fri, 03 Jun 2022 12:28:51 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr9544675wri.342.1654284530598; Fri, 03
 Jun 2022 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com> <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
 <3866c083-0064-ac9a-4587-91a83946525d@samsung.com> <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
 <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com> <cb802fb1-d0b8-68af-1c04-f73bc1beca77@quicinc.com>
 <f525c352-d995-0589-584f-0e9acf419f80@quicinc.com>
In-Reply-To: <f525c352-d995-0589-584f-0e9acf419f80@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
Message-ID: <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 11:54 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> >>> Add a start_rx in uart_resume_port after call to set_termios to handle
> >>> this scenario for other drivers.
>
> Since start_rx is not exposed it doesn't seem like we will be able to
> handle it in core.
>
> In your drivers, Can we add a call to stop_rx at begin of set_termios
> and then undo it at end?
>
> That would ensure that set_termios functionality is unaffected while
> fixing the broken cases?
>
> If that's not an option we will have to go back to a previous version of
> limiting the change to qcom driver.

How about this: add an optional start_rx() callback to "struct
uart_ops" and then only do your stop_rx() logic in uart_suspend_port()
if you'll be able to start it again (AKA if the start_rx() callback is
not NULL). That keeps the logic in the core.

-Doug
