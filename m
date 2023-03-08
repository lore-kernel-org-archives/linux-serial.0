Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE050C678D5
	for <linux-serial@archiver.kernel.org>; Wed,  8 Mar 2023 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCHRZU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHRZT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Mar 2023 12:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713061DBBD
        for <linux-serial@vger.kernel.org>; Wed,  8 Mar 2023 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678296275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPQJ89LugumAZFsgY4YTmoOcQfUcQJ8Obmpk4rX3dbQ=;
        b=T+NaaWQ7vOYCruNoU7HNgaHoKgg0mnFDlp9VP0qpAFHwdaJLgEhWDmh3ExxI+H9w1Okx5d
        stpmwHx254Hjh9RxT4ZIuxOSwhQFVnjFVzDafzaPq9FZi0uMxtkmS6mHfhRhYKB4rA2NwB
        O51tTVc5M4N6BrpjF7jMYS06ILsy+zg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-fMdgYnM_P5eeQQm3coSg6Q-1; Wed, 08 Mar 2023 12:24:34 -0500
X-MC-Unique: fMdgYnM_P5eeQQm3coSg6Q-1
Received: by mail-qt1-f197.google.com with SMTP id w16-20020ac843d0000000b003bfe50a4105so9494107qtn.10
        for <linux-serial@vger.kernel.org>; Wed, 08 Mar 2023 09:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPQJ89LugumAZFsgY4YTmoOcQfUcQJ8Obmpk4rX3dbQ=;
        b=myuEtpJNsa0K0l7JSCb5UcmAFdq0QKNmrugEWhUwjWQYHM/8lkm/+t2MTv6BXQWkgJ
         LNVjTKci3cMstUB4Lg1b++m2Kl3r6zfWVS0Fk45b4yVKR8Se+8QvpcxESolOp4snd4X/
         7wonrd+EyCUCu47NrNnID5OOLrTKXZqdMcFib+SfoRQi3RtfW5P3DHZUMlVUS8l4VEdA
         GzfDcKw+WkMbwKmw0k3lGR6LWCN2huSCOFNNEDzh2o+uEHF+LgfU1GuMmPARliUt4ezd
         IJGgw6ydJRGYT0CbMfwY24waTf3ukUSh4xVXxyZzgKnwQpsAIM+pxusR4QfNA4suDWg8
         UIIw==
X-Gm-Message-State: AO0yUKUTfrRB82wF3pb0Kj+kPh9vTa5TB2D2i2+B/Es6/U75X5gtJc/X
        r2+qPuqIorBdJXckWsoBkr+nFYP2S8b7x7fsu9tkzDlZOHM96cbxeYe7vdX0oxMzgu1MTenuzwA
        FkqmKxTu6vrAUdtd3QRH986ey
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id f28-20020a05622a1a1c00b003b86788bf25mr31680507qtb.23.1678296274310;
        Wed, 08 Mar 2023 09:24:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/O2FzdqotFaGnCpsXoZJ+sIqm3xrIxOl15eWdAqcdkdwA+CLA5ctetlB0UcvXYkd3YXuF88g==
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id f28-20020a05622a1a1c00b003b86788bf25mr31680478qtb.23.1678296274062;
        Wed, 08 Mar 2023 09:24:34 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8429a000000b003b8484fdfccsm12094243qtl.42.2023.03.08.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:24:33 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:24:31 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Message-ID: <20230308172431.pcjyhc2dq6geuk76@halaney-x13s>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 07, 2023 at 05:44:01PM +0100, Johan Hovold wrote:
> This series fixes some of the fallout after a recent series adding
> support for DMA transfers to the Qualcomm geni serial driver.
> 
> Most importantly it fixes a hang during reboot when using a serial
> console and the getty is stopped during reboot.
> 
> Doug just posted an equivalent fix here:
> 
> 	https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> 
> but the commit message only mentions the regression with respect to
> kgdb, which is not as widely used serial consoles generally, so I
> figured I'd post my version for completeness.
> 
> Either version of that fix should address the immediate regression, but
> fixing the underlying problems which have been there since the driver
> was first merged is going to be a bit more involved.
> 
> The rest of the series fixes a few bugs in the new DMA support that I
> found while investigating the console regression.
> 
> Johan
> 
> 
> Johan Hovold (4):
>   serial: qcom-geni: fix console shutdown hang
>   serial: qcom-geni: fix DMA mapping leak on shutdown
>   serial: qcom-geni: fix mapping of empty DMA buffer
>   serial: qcom-geni: drop bogus uart_write_wakeup()
> 
>  drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.2
> 

Realized this has been affecting me (with me blaming it on something
else prior) off and on. Thanks for the fix!

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride

