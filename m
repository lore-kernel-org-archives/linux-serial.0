Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C3CC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 15:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbiFHPjS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbiFHPjN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 11:39:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2391B9A68
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 08:39:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so10955702edj.11
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pwvu2vstIFuDbmoLlIWPg/mZg51nUvruTLPNLTKmJS4=;
        b=UE8t6cShY61wMWjfBUo2llFLOvRxnFzadwxYtpIfrsJBoaeB9l44NeHhs3KGGNHo/V
         NWF7NiBYCPVw2/PpbZ8LkvHOEUfJZPmQTy1hgG1LbGzz5brEVJcZHXK1B26P3BFbeGn8
         OUNdwu0Np6qZ68dvFX1cQQT8CmhFPQLtBFJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pwvu2vstIFuDbmoLlIWPg/mZg51nUvruTLPNLTKmJS4=;
        b=FcBvrmKyMrKQQWaXV++r8Td6GKyEQZ5fRnrRjkR93H+jgkSLNa3hrw2MDayM4CyPq/
         fZl0/WWadnmXK7Eq43OJ7bkU4xw/8v0lv/MxhDaIFOfdIW8NxKGc9CLRJI7SOrjWFr28
         +NsongxLM9xQyneo0/R9DJZbsdZqhIji5alNdMR3qa+ck2L9kSsDhZzisB3Lm9c/vzH7
         HiRciMyHxwYzJLclaLJ6josm7UPyzUUB7IUor15T+drSHRvgAtBSaxMTWsQjIOY0W3OC
         OmxcGPYtX3vPFWXBJgfYXtGYdPsuMaJN07U3UURVbMWD/IIywJzelLkU17AChkz/IRI/
         7YfQ==
X-Gm-Message-State: AOAM532/XhIcmftHHV9EmjpiySLybbz5e/D2KM7NbBnMeTeOdlHSlMHH
        1GO4Pcs4KKzl/fs13c1lYQx3NNlsVHlwTLoVUsk=
X-Google-Smtp-Source: ABdhPJwvnZxbNq6Ky87yzSP5q7q1mXY+3EUYvz+NrF2828ZW8LC6TwVVFwri/NgqM/ZTTIiMz4ZNMQ==
X-Received: by 2002:a05:6402:2548:b0:42d:dd95:5bfe with SMTP id l8-20020a056402254800b0042ddd955bfemr39796629edb.285.1654702750283;
        Wed, 08 Jun 2022 08:39:10 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id ee36-20020a056402292400b0042bca34bd15sm12432009edb.95.2022.06.08.08.39.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:39:08 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id k16so28896351wrg.7
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 08:39:08 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr33588969wri.342.1654702748098; Wed, 08
 Jun 2022 08:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com> <1654627965-1461-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1654627965-1461-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jun 2022 08:38:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD-ruxBK3TarJCSP8zkCQ37kCO5=cbYBJzou5GSqN63Q@mail.gmail.com>
Message-ID: <CAD=FV=UD-ruxBK3TarJCSP8zkCQ37kCO5=cbYBJzou5GSqN63Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: core: Introduce callback for start_rx and do
 stop_rx in suspend only if this callback implementation is present.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Jun 7, 2022 at 11:53 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In suspend sequence there is a need to perform stop_rx during suspend
> sequence to prevent any asynchronous data over rx line. However this
> can cause problem to drivers which dont do re-start_rx during set_termios.
>
> Add new callback start_rx and perform stop_rx only when implementation of
> start_rx is present. Also add call to start_rx in resume sequence so that
> drivers who come across this problem can make use of this framework.
>
> Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for console if console_suspend is disabled")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/serial_core.c | 9 ++++++---
>  include/linux/serial_core.h      | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
