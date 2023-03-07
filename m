Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90559C678DB
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjCGTBD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjCGTAm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 14:00:42 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F383449F
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 10:47:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p13so8936522ilp.11
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7BUelKDKk+33uckJ7LNeCbNjLijtX6ljbEKj2F7sL0=;
        b=TlR/FyIjWLnMbONWCzB2Z6S+1hskQcmd4MbBShge2gPaXrJlel8FOlsCisvLJ16fFE
         eoBirk5vtVILcDRxPAdzCQqOmjHWQbznyJSidb/BQ+aDLNdkhzl2TMTUscIuKEYpbzL9
         6IIGGFmOGG24sXQsXJId+46gZQ62Npjp0eunE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7BUelKDKk+33uckJ7LNeCbNjLijtX6ljbEKj2F7sL0=;
        b=cH/FjWHdUMsGK1gEW14jMwkOkVsSYEb/1bOY/ZabEs+jYZD9M7ZcqtTjPsR1k00nQ+
         aUvj+UULZNtAf00uq1fWPHvs5g7ddD3NuO2aiA0swkKJlt9y3UGQ+raHS/uVS9JuxPIb
         wgpijk4UOZX2MQEr4zB6qoOChwGdPBQvGjSFAFCOb/hBRRHZVETFRwz2Mf6Qr8fuWwPY
         1sJnoG+PegJC1OeiM9NYhpIdMw/EYtW/GIp/+zzJt4fTQaHXJ8+DhgwHe10VdoHWe/gD
         59UyOM1cA8+dcU9JB1BbU2z0lKdWwuX+4nOdKN8d9muVlwSyZ/NIatRr8JeWULb9+yat
         eiTQ==
X-Gm-Message-State: AO0yUKU2wYzGrBcJZhK8PSoQSfIY3fsfcds4EpPkaVKJY7vqC5D5tYZ7
        l0wp7xj4+v6OY+TZRrtmDK0KY5xY7h36lSFhp94=
X-Google-Smtp-Source: AK7set8QYvcvkoPkN3WrAVKvcClhAuTfFzpgCnek8NuSOKgbSgsW0vLBht1wyXLdkyjCwxWZ8IIu3A==
X-Received: by 2002:a92:cd81:0:b0:317:6591:95fe with SMTP id r1-20020a92cd81000000b00317659195femr13298136ilb.28.1678214840687;
        Tue, 07 Mar 2023 10:47:20 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id o12-20020a92c04c000000b00314007fdbc2sm3887855ilf.62.2023.03.07.10.47.19
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:47:20 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id d12so5777334ioe.10
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:47:19 -0800 (PST)
X-Received: by 2002:a02:aa0b:0:b0:3c4:e84b:2a40 with SMTP id
 r11-20020a02aa0b000000b003c4e84b2a40mr7756944jam.6.1678214839473; Tue, 07 Mar
 2023 10:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-5-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-5-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:47:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VTDHFkSf4qnexNOBoXzV-sMPBRjSqMrB_nrsuCPpO=WQ@mail.gmail.com>
Message-ID: <CAD=FV=VTDHFkSf4qnexNOBoXzV-sMPBRjSqMrB_nrsuCPpO=WQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: qcom-geni: drop bogus uart_write_wakeup()
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 8:43=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the bogus uart_write_wakeup() from when setting up a new DMA
> transfer, which does not free up any more space in the ring buffer.
>
> Any pending writers will be woken up when the transfer completes.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
