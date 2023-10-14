Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30860CDB482
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 11:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjJNLN7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNLN6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 07:13:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3EAD
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 04:13:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so29226215e9.3
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697282035; x=1697886835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Hoabk9LgDG7AVtJ/9VbI0K4NvP7rAaguGPxnfhSPGw=;
        b=NlGf57MEqwMAJGxt0hsPXHyJ5vYKBmoWH1WbSkXsJdFelXinnLus4yoxwo3dTKE6Ql
         o+bMWmvh3+meNa7bOgG+935MHCfJcNah59dyZc0+ipJPntX0TcHcqWdWERIbrv1Nxukh
         1qSAg0z6RMnajDhMJfqPIR+7nMa8Vcjbu6QCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697282035; x=1697886835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hoabk9LgDG7AVtJ/9VbI0K4NvP7rAaguGPxnfhSPGw=;
        b=wmJkAXG22lH8KP0bM8jwTfIBXWIh9geet+GvxAf9BkwEwwniMjunfYlkOtYXKwXwNx
         YPIIuE79plIQnnwsdq4k5GuCCKhEvm7unzalsbcIKyTkRIPN6pb1e/SjDSNviU8aXSmv
         Q1zxTnp0wGIrW5iCEbjqVxQ2EMC3WRiFYCa4r/+fQp5SEJHo3oSoIzT0DvdawAHKblc+
         zdR/2UXzoezah4ABPW+pdw7GTH4VffT4m9dsIDyPqrzHlhUk0/q4Vrz53kd1f4oFrJrx
         E/72CJWeGP32G7YPtP+4A3VEtr7LT/rCFt7jP0V/9X3LHX5pyATAfXUUbMNiKyvPJwtz
         p92A==
X-Gm-Message-State: AOJu0Yxwv4vaL1T076tDGW/gXYQwBcPLn+qo/b95QLLSJCK2ZGUtS2+1
        rp/y43GZEXS49+SgsXQ0Gs6EbpBwJh8KcIc8oKk=
X-Google-Smtp-Source: AGHT+IETk0aw9hqoEn4tFp5lP32SpVPRyTIgWwiZ+OYJ6SOoh93lN/8euNp27nFtrND9kctMy4PDrw==
X-Received: by 2002:a7b:c387:0:b0:3f9:b430:199b with SMTP id s7-20020a7bc387000000b003f9b430199bmr25481496wmj.15.1697282034719;
        Sat, 14 Oct 2023 04:13:54 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:66ae:9f57:4dbd:827d? ([2001:8b0:aba:5f3c:66ae:9f57:4dbd:827d])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm1745278wmo.39.2023.10.14.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 04:13:54 -0700 (PDT)
Message-ID: <c85ab969826989c27402711155ec086fd81574fb.camel@linuxfoundation.org>
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
Date:   Sat, 14 Oct 2023 12:13:53 +0100
In-Reply-To: <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
         <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
         <ZSPQY6UYg21Z0PnN@nuoska>
         <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 2023-10-14 at 10:41 +0100, Richard Purdie wrote:
> Brief summary:
>=20
> We're seeing an issue on x86_64 with 6.5.X where data appears to be
> left in the transmission buffer and not sent to the port on the second
> serial port (ttyS1) until we trigger it with intervention.
>=20
> Paul Gortmaker did some painful bisection over a few days down to:
>=20
> serial: core: Start managing serial controllers to enable runtime PM
> https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c118c11=
@gmail.com/T/#t

Having poked around a bit and knowing nothing about any of this, should
this bit of new code added in the above commit to __uart_start() in
serial_core.c:

	/*
	 * Start TX if enabled, and kick runtime PM. If the device is not
	 * enabled, serial_port_runtime_resume() calls start_tx()
again
	 * after enabling the device.
	 */
	if (pm_runtime_active(&port_dev->dev))
		port->ops->start_tx(port);


actually be something like:


	if (pm_runtime_active(&port_dev->dev) || !pm_runtime_enabled(&port_dev->de=
v))
		port->ops->start_tx(port);


since there are uarts that don't enable runtime PM?

I notice that 16550A I'm using doesn't set UART_CAP_RPM and since we
have data left in the xmit buffer (I managed to confirm that), it is as
if during init, there is a race between the serial probing and the
getty putting data in the buffer? If it weren't statrted, that would
explain things...

Keep in mind I know nothing about pm_runtime or serial/uarts so this is
guesswork on my part.

Cheers,

Richard

