Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE70CDB47E
	for <linux-serial@archiver.kernel.org>; Sun, 15 Oct 2023 12:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJOM3y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 Oct 2023 08:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOM3x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Oct 2023 08:29:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12CA9
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 05:29:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso33760575e9.0
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697372990; x=1697977790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jd4dGzeuShlvV9q6icZG+R3G0Op506/3I5rmGPuLIck=;
        b=fbc0u0vCBoB9vxAu69S4AIVSgvgrzS5WYKXo8q/SlkuzBfUvNrBYIxG1/4otiqofdc
         dgjRTdrYsgr/PM98S6D7SgZ+smHobB0VnT4XAL47EFs2MfsZwAEU7LZmsX3LerMuVCMa
         ZwKJQLKiS+rqbUh3Q3Ln1iXPoZ+1y1ildR9og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697372990; x=1697977790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jd4dGzeuShlvV9q6icZG+R3G0Op506/3I5rmGPuLIck=;
        b=SIydFAdES8miEb6M7uGeTesE3gmTdgrJBTitSGC11PDMMqG3RmbmCjf9TtnHy0uxwT
         3MQF1pzHrXxRzDFH+alhcOB5MvWuAK80qXQAwYfgE32yo0oeQulsyF3NltSQswBf/ln+
         3heYh111ym7eF3p5epw5H1RsD9PmpZMYKX4bb6MHJxkJEDnVgsoLEgMHeMczoSakBwo6
         yu/pI7DO8KOOvJ3Lox7pWa516R+zwZTbqQb/EndpidqzqX7cEdo+zueURPYhA7t0tZru
         Y8fRDFpcwY6xZOfprSCvH3mm+rfcQ6Voxs4r0Sxq6hftbJJQG74HdM1OqXmfxg5m8PVx
         B1+A==
X-Gm-Message-State: AOJu0Yx1zrX+TDiDK6/yO99RYo8dz8ImjDrFyBBQK8NHrGFV45gwOm/B
        gQgqRqYdpGeZ9gD2BgoFdz1eUR7vD8Hi4rj1PUQ=
X-Google-Smtp-Source: AGHT+IFDQJ6yoRoHRgbmhjCTUTFtgDStDsEt0yK9tDFAw7vEVws7HAkZDhWf+R0B7uw+7QAlprMd2w==
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id x14-20020a05600c2a4e00b0040549aad578mr27882419wme.37.1697372989770;
        Sun, 15 Oct 2023 05:29:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7e01:6bdd:8c85:9c17? ([2001:8b0:aba:5f3c:7e01:6bdd:8c85:9c17])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b0040586360a36sm4386647wmi.17.2023.10.15.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 05:29:49 -0700 (PDT)
Message-ID: <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Sun, 15 Oct 2023 13:29:48 +0100
In-Reply-To: <178DF50519C11C84.8679@lists.openembedded.org>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
         <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
         <ZSPQY6UYg21Z0PnN@nuoska>
         <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
         <178DF50519C11C84.8679@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 2023-10-14 at 12:13 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Sat, 2023-10-14 at 10:41 +0100, Richard Purdie wrote:
> > Brief summary:
> >=20
> > We're seeing an issue on x86_64 with 6.5.X where data appears to be
> > left in the transmission buffer and not sent to the port on the second
> > serial port (ttyS1) until we trigger it with intervention.
> >=20
> > Paul Gortmaker did some painful bisection over a few days down to:
> >=20
> > serial: core: Start managing serial controllers to enable runtime PM
> > https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c118c=
11@gmail.com/T/#t
>=20
> Having poked around a bit and knowing nothing about any of this, should
> this bit of new code added in the above commit to __uart_start() in
> serial_core.c:
>=20
> 	/*
> 	 * Start TX if enabled, and kick runtime PM. If the device is not
> 	 * enabled, serial_port_runtime_resume() calls start_tx()
> again
> 	 * after enabling the device.
> 	 */
> 	if (pm_runtime_active(&port_dev->dev))
> 		port->ops->start_tx(port);
>=20
>=20
> actually be something like:
>=20
>=20
> 	if (pm_runtime_active(&port_dev->dev) || !pm_runtime_enabled(&port_dev->=
dev))
> 		port->ops->start_tx(port);
>=20
>=20
> since there are uarts that don't enable runtime PM?
>=20
> I notice that 16550A I'm using doesn't set UART_CAP_RPM and since we
> have data left in the xmit buffer (I managed to confirm that), it is as
> if during init, there is a race between the serial probing and the
> getty putting data in the buffer? If it weren't statrted, that would
> explain things...

The above change didn't work but what does appear to be making a
difference is making this code call start_tx unconditionally which is
what it did prior to the patch. That does cause a "wake" when there
might not be any data but the code handles that gracefully.

I therefore suspect this is the place the issue is, the question is
what the right conditions for calling start_tx are?

I'll keep going with testing of that as the intermittent nature does
make this hard to know if any change helps or not.

Cheers,

Richard
