Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63507C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jan 2022 11:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiACLmh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jan 2022 06:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231760AbiACLmg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jan 2022 06:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641210155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSNOI5ql8oXZVvuzD0ppCtwWNeddD2uNEOgMzwq7yWs=;
        b=cmdow/FWHRgbM6aSxs/xTctjtcIMiH4QlG036cY7wdoBRm6ldaHP0OiJawl8UnBYAfPjg8
        3QCKr8q83OcMsDq0Gtq9lUwnS1d4UI653YmVrg5G4b+E4dm6YYLafARmZTqxDDDxuCLK4B
        qWD+nQk1TC7MUQtw2DciR0i99U9buqA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-rWM2n-kSNpOCOTnGIT_l4g-1; Mon, 03 Jan 2022 06:42:34 -0500
X-MC-Unique: rWM2n-kSNpOCOTnGIT_l4g-1
Received: by mail-ed1-f70.google.com with SMTP id ch27-20020a0564021bdb00b003f8389236f8so22469484edb.19
        for <linux-serial@vger.kernel.org>; Mon, 03 Jan 2022 03:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gSNOI5ql8oXZVvuzD0ppCtwWNeddD2uNEOgMzwq7yWs=;
        b=HQz5AP7zq0NnbSsiHK4CKJc4VZz0ctAZCefZNipRQFM4exL7eJAgf9o8ycICy+b1dp
         n4yfWlYuFoYT7SF+hgicsbrY1Vg51yJ2D4pMISSdV1Z+pLZp+DlA0hK+S3kB0tOOa183
         mTBXwTHRj/tFOSZESmXNm7HdXCdBOGD9d2ySvJgZQ5SHeYh2IGNmSspAzBOQ+ustYpZj
         1/3xUysCLaFVWctlOOIhcnTO//+SaBOMU+CclPalnSVHqpqSeRzr92e4Kl+2n0I5TFtF
         2MhEYNHrJPDlDOIlK3ms9SlSFCsD2EBTkzv9VC+qSGBwIqnn6UA2ej8iEUKdAxwza8bf
         42dA==
X-Gm-Message-State: AOAM533PrGow8nZnEB01Rb9YX/HYDPJNMO4TUpuANsCoAFP+QGNrBp0Q
        +abrpd4YMWOZMNMUfxLoA3QHtq6ZtNFq8QLNdkVcA+A2HhFbKqXfsIpx/AZMcEg+wmigcw7tdnL
        RjKdjIZjB2Xn7sg/4uzU42Y6/
X-Received: by 2002:a17:906:9491:: with SMTP id t17mr34874583ejx.667.1641210153014;
        Mon, 03 Jan 2022 03:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIi4yBcIp+Imi4nqsCAFS4wrZ7x5Z4CdDD0XwShkPowGrJPzk/hjb7Xh+egDpsRHbtUE5ZNA==
X-Received: by 2002:a17:906:9491:: with SMTP id t17mr34874574ejx.667.1641210152871;
        Mon, 03 Jan 2022 03:42:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id sc7sm10590939ejc.87.2022.01.03.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 03:42:32 -0800 (PST)
Message-ID: <464b14f9-3df8-5651-7268-80f9fe0df3d4@redhat.com>
Date:   Mon, 3 Jan 2022 12:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/12] ACPI / pdx86: Add support for x86 Android tablets
 with broken DSDTs
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org
References: <20211229231431.437982-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211229231431.437982-1-hdegoede@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi All,

On 12/30/21 00:14, Hans de Goede wrote:
> Hi All,
> 
> As a small(ish) hoppy project over the holidays I've been looking into
> getting some (somewhat older) x86 tablets which ship with Android as the
> only OS on their factory image working with the mainline kernel.
> 
> These typically have pretty broken DSDTs since the Android image kernel
> just has everything hardcoded.
> 
> This patch-series makes most things on 3 of these tablets work with the
> mainline kernel and lays the groundwork for adding support for similar
> tablets.
> 
> Since the ACPI tables on these devices clearly are buggy this series is
> written so as to add minimal changes to the ACPI core code, leaving all
> of the heavy lifting to the recently introduced (in linux-next)
> drivers/platform/x86/x86-android-tablets.c module, which when built as
> a module only autoloads on affected devices based on DMI matching.
> 
> And when this module is disabled the added acpi_quirk_skip_*_enumeration()
> helpers are replaced by inline stubs and even the minimally added core
> code will be optimized away.
> 
> The ACPI core changes are in patches 1-3 of this series. Since the
> i2c and serdev ACPI enumeration changes are very small and depend on
> patch 1, I believe it would be best for patches 1-3 to all be merged
> through Rafael's ACPI tree.

I've added patches 4-12 to my pdx86/review-hans (soon to be for-next)
branch now.

Regards,

Hans


> Hans de Goede (12):
>   ACPI / x86: Add acpi_quirk_skip_[i2c_client|serdev]_enumeration()
>     helpers
>   i2c: acpi: Do not instantiate I2C-clients on boards with known bogus
>     DSDT entries
>   serdev: Do not instantiate serdevs on boards with known bogus DSDT
>     entries
>   platform/x86: x86-android-tablets: Don't return -EPROBE_DEFER from a
>     non probe() function
>   platform/x86: x86-android-tablets: Add support for PMIC interrupts
>   platform/x86: x86-android-tablets: Add support for instantiating
>     platform-devs
>   platform/x86: x86-android-tablets: Add support for instantiating
>     serdevs
>   platform/x86: x86-android-tablets: Add support for registering GPIO
>     lookup tables
>   platform/x86: x86-android-tablets: Add support for preloading modules
>   platform/x86: x86-android-tablets: Add Asus TF103C data
>   platform/x86: x86-android-tablets: Add Asus MeMO Pad 7 ME176C data
>   platform/x86: x86-android-tablets: Add TM800A550L data
> 
>  drivers/acpi/x86/utils.c                   |  96 ++++
>  drivers/i2c/i2c-core-acpi.c                |  17 +
>  drivers/platform/x86/Kconfig               |   2 +-
>  drivers/platform/x86/x86-android-tablets.c | 562 ++++++++++++++++++++-
>  drivers/tty/serdev/core.c                  |  14 +
>  include/acpi/acpi_bus.h                    |  16 +
>  6 files changed, 698 insertions(+), 9 deletions(-)
> 

