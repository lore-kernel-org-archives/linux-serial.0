Return-Path: <SRS0=ccOi=4O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104AC4BA0B
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE124689
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 11:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jd4SW1ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgBZLzT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:55:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBZLzT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 06:55:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2658264wru.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2020 03:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N/HLqG1dDlxTZQOlF1kclM4FtV82gw6thx5C0eMWXL8=;
        b=Jd4SW1MEdw3BSr+tOW0A+g5GDh/5NIN6p8HFxfdQD0AG53vvR26K+JTeoHXcVpncYU
         a8ox8IpPTfE458plItqoaoD3it0krStsnGcVmXcAklK5U6tbeyxghsAfi+0JQds6MRF/
         2M2uvLQC1wDniPmj7PvaeskE8u3HmsBuwWKViakuKMA9X3mHlF0GybGYFWvaPTp+RFiJ
         GWMujk4YauLTNAMp6OaNsAaS6uVegu0B12PlP2CqTUh1pyeYiIT8NwP7ubtvFXjjZSht
         Vz8kK1NRahOs3HqSl3LBnVDdoMtetjDvR8Z8trL0j5PY/mvwR07KlLeIxKKjyh08uD/F
         qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N/HLqG1dDlxTZQOlF1kclM4FtV82gw6thx5C0eMWXL8=;
        b=E0bXk9rkKketBb6xHjgVK/IdE9z1JjtCsGIEf72HB8zBJNTqkosVv5EjVJVyb1vZCD
         Ckor9Tsi4AB2ZSJyXqKTj1xKSglYb9icvXcMcPeScPZ/9Az9wx205v1j1g7xvfr0GauS
         EjNyZ5YwRd3y5Rs0wM9MNW/olkMBRs2myC2ghiJgMe8dUbr3xgUoM63CmX2CgTC//VyA
         fne7bbpDLYCeVUU5XeMYb7iAe33o4jT97V25gi8Juh/JCwJ7MFj7exEjqifS45JDgLY5
         gGeE+Hzp7S0bkymhvyf2M9FIEnjwk2RrtfA1GUZapS8I0wQIaimdbPHJ3RKQkjZmBhGg
         fX2Q==
X-Gm-Message-State: APjAAAU5r2k41EHX0EgiARX30HFdTDyW6E2G8zAhuk7EPtxoi9CEP7fV
        qNiBYe4wZGfw3v5v34Xe3+UGPw==
X-Google-Smtp-Source: APXvYqyOyu7h7SWranUtz1CxDuJHk1JwDhHHx449iyciKg+Pc/m9qo1aavmL3kb/JkZa8Oq7/4G7iA==
X-Received: by 2002:adf:df0c:: with SMTP id y12mr5159445wrl.257.1582718117234;
        Wed, 26 Feb 2020 03:55:17 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id a13sm2820475wrt.55.2020.02.26.03.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:55:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:55:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: motmdm: Add Motorola TS 27.010 serdev modem
 driver for droid4
Message-ID: <20200226115548.GO3494@dell>
References: <20200220195943.15314-1-tony@atomide.com>
 <20200220195943.15314-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220195943.15314-3-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 20 Feb 2020, Tony Lindgren wrote:

> Many Motorola phones are controlling the modem using a custom variant
> of TS 27.010 serial line discipline. Devices on these modems have a
> dedicated TS 27.010 channel for features like audio mixer, GNSS, voice
> modem, SIM card reader and so on.
> 
> This driver allows using various devices on the modem. In order to do
> that, we need to take care of the following three things:
> 
> 1. Provide /dev/motmdm* character devices for apps to use for talking
>    to the various devices on the modem
> 
> 2. Handle Motorola custom protocol over TS 27.010 to make the channels
>    usable for userspace
> 
> 3. Coordinate PM runtime with the USB PHY because of shared GPIO pins
>    with the USB PHY
> 
> With this patch, folks with droid4 can place a voice call with just:
> 
> $ printf "ATD%s,0\r" "${phone_number}" > /dev/motmdm1
> D:OK
> ~+CIEV=1,1,0
> ...
> $ printf "ATH\r" > /dev/motmdm1
> H:OK
> 
> Also SMS can be sent with this patch using /dev/motmdm3 for sending,
> and /dev/motmdm9 for receiving messages.
> 
> Note that the audio mixer needs additional patches though. I will be
> sending those as a separate series of patches.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/Kconfig        |    9 +
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/motorola-mdm.c | 1200 ++++++++++++++++++++++++++++++++++++

I'm not even going to start reviewing this as I can see, without even
looking at the code, that this has too much functionality (stuff that
does stuff) contained.

Please move as much functionality out into the subsystems as
possible.  Ideally, MFDs should be responsible for obtaining and
registering shared resources and registering child devices.  Anything
else should be shifted out to an appropriate subsystem.

MFD is not Misc.

>  3 files changed, 1210 insertions(+)
>  create mode 100644 drivers/mfd/motorola-mdm.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
