Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EDFCCA47E
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbiFHPjy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiFHPju (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 11:39:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D522C6858
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 08:39:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg6so22427153ejb.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1KDk/axUVp21+cddhdnk3LSPy6qbxF3WGn2a8z1Emg=;
        b=FUuw+7ZM3/XXnrhhGij7vnuxOiK6TrpBZ/GHgI9xei+CGe2dYATAna7tls+lZ7pfii
         WvErUgiHuJq5JqU6UfFNSbQJ9Bvw15qeVyFlvEyQb9ydHtbTdswChqeIRvs1iXQqQHd5
         ZXX4rFy8gGNKqDKSUdebNORdv8iYOQNYzcUHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1KDk/axUVp21+cddhdnk3LSPy6qbxF3WGn2a8z1Emg=;
        b=JUzYJaxDaZ1HPGd3b7HohT49QNXZpJ4XGY87wBOvE1BNcDaEQeLI17rCoPd/VICQVU
         m1nat3G8yBdZS6xWRVi7Z9rhYXmcwC+sKtbLnx1LHnGwD6eX9HMUKUMSKNI+98lDq7y4
         dPSFu1w5Wg+Infl8Qr5Hetoht1WzSbJV3fRp/rV5L2SpmvdqNnKbDCCyYRsgSsv/mf2J
         RK9D8xm3HEJO03BiEGxSfv1KrHXocVLDQpgh5BUbO3AYAEEQ3hifrHXYC+scSKunnf2M
         9DyXbQ9v33McupysaxDBPRWZopJOnshN+ErQOCfOIqv7bbT2XqIOvIvwJ++Nh8Vo6AQV
         wQHA==
X-Gm-Message-State: AOAM532Jv+wA/XEBriHoUhU78a37czrF8ihGPkeaW2kiz7AMk3cF1MFW
        7Bz8WaI37AxNMNg5lMflhqY+VsigHFRGoVnCbHM=
X-Google-Smtp-Source: ABdhPJyiIF08vWEjUVX1tsGs347PPidtqfIHYvHyVc0jYIVamp/E9MzSc0azIadGsBh+tAtOGQX8hA==
X-Received: by 2002:a17:907:d0d:b0:711:d554:1c8f with SMTP id gn13-20020a1709070d0d00b00711d5541c8fmr13581069ejc.223.1654702786802;
        Wed, 08 Jun 2022 08:39:46 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0042dc460bda6sm12504928edw.18.2022.06.08.08.39.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:39:46 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id s1so5781121wra.9
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 08:39:46 -0700 (PDT)
X-Received: by 2002:a5d:608d:0:b0:218:3cfa:afe9 with SMTP id
 w13-20020a5d608d000000b002183cfaafe9mr17795611wrt.422.1654702785594; Wed, 08
 Jun 2022 08:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com> <1654627965-1461-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1654627965-1461-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jun 2022 08:39:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1oD60yRvoZohG07Pd62ki32DCGuCrG0R6bPXM=NpY=A@mail.gmail.com>
Message-ID: <CAD=FV=U1oD60yRvoZohG07Pd62ki32DCGuCrG0R6bPXM=NpY=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: qcom-geni-serial: Implement start_rx callback
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
> In suspend sequence stop_rx will be performed only if implementation for
> start_rx callback is present.
>
> Set qcom_geni_serial_start_rx as callback for start_rx so that stop_rx is
> performed.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 1 +
>  1 file changed, 1 insertion(+)

I think you also want a Fixes tag here, right? ...because if only the
first patch is taken then it can actually regress Qualcomm devices.
Thus:

Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for
console if console_suspend is disabled")

Reviewed-by: Douglas Anderson <dianders@chromium.org>
