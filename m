Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F0C43463
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019FD21534
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600439784;
	bh=gVmXYfLiwZCsarxdOHI8x974iAWlEt/GUiUG5umSaKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IavxyMuJtUA1kFEjcjFp9Yxn/DZNgiMx2WFS+CKjgEuO1Y6tnwY1yuKZcXko7CEWO
	 v8v+kBS9SgDQHUuyFNaj5Es/AHTZvtAys2NV0tA6GldWFhzavEumbw7Z9zUdTI81c6
	 L0FnwByfYq9a+Gl7pytDGdGWqGZ6vSuM9zZjR0GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIROgX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:36:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43208 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROgX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 10:36:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id u4so5264317ljd.10
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2020 07:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxqL4ffaBPms3YakHac8IIQR8LF9MNzq1jylguIQnUI=;
        b=MnFkHYHYKs+O2tpsW6tHOdrfC7jN3Nqy3k1ucDRbwHRtOWvy3ve2NEvzzxm0pZmXdb
         Pp/7cqQTHx6iNkI9A3MZb/gulhxFhqdH9KkyiGO1454vN13VfyORr/x3uc0c9Bp4QNul
         nPUEWVwDa+zALXaMCfCzx8eKfNK1IbfsxkETpluGqyX1fV9WcGJwoP5nKfEFjpFfr7dt
         kc+TracebwHcslZusApAcn4Yp+yYJ17fGc50bzaL1kmvz7BBu8fcQMVbiVecrMOv7qMx
         scxpFxs/BSearhK+99Ts0OGXZOFNkGfrVV6JUgETCXjDW5zCGy6VRHx7OFfKk4rZ0vWa
         C9Vg==
X-Gm-Message-State: AOAM530f2IU9621IWHVGi+1kP8gJSCMCUWUNvdQhefY9emJfxo16IkJq
        y+1E1valhAbg6DZp746sMZs=
X-Google-Smtp-Source: ABdhPJwpJ/K43Iynvp1XKOH8h7/IqKCEIfwaQuUxWN4Up5S930hvKrCNN4G8w4xIqZl6N/aoBySTfw==
X-Received: by 2002:a2e:a494:: with SMTP id h20mr10993692lji.116.1600439780789;
        Fri, 18 Sep 2020 07:36:20 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id w12sm616539lfk.193.2020.09.18.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:36:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kJHUm-0000xg-Em; Fri, 18 Sep 2020 16:36:16 +0200
Date:   Fri, 18 Sep 2020 16:36:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy KN4UCL <kn4ucl@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: Edgeport/4 Compatibility Re: your mail
Message-ID: <20200918143616.GB21896@localhost>
References: <CY4PR1201MB25321441CB372AD9068F8C458D2C0@CY4PR1201MB2532.namprd12.prod.outlook.com>
 <20200918075633.GQ24441@localhost>
 <CA+H6KCm1YJ_-X6D61ujqWZDJzTyMBGKCR7W07QpWz9J6CSEwVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+H6KCm1YJ_-X6D61ujqWZDJzTyMBGKCR7W07QpWz9J6CSEwVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 18, 2020 at 06:54:17AM -0400, Andy KN4UCL wrote:
> Hello Johan - resending without disclaimer :-)

Thanks. Also try sending without HTML so that your messages reach the
mailing lists (e.g. gmail's plaintext option).

> I emailed Greg and via automated email indicated I should post my
> question here.

I've added linux-usb on CC as well.

> I am trying to get some legacy EdgePort/4 and 8 devices to work on
> Linux using Raspberry Pi OS.
> 
> I notice in the kernel.org notes, compatibility with Edgeport seems to
> be a good possibility.
> 
> Can you advise?  I get "cannot send clear loopback command" messages
> in dmesg and these seem to be directly from the driver code I found
> while googling. I assume these errors prevent the serial connection
> from starting up.  Devices seem to behave fine under Windows 10 (if
> that's any kind of validation.)

First, what are the VID and PIDs for these devices?

Perhaps you can include the full output of "lsusb -v" for both types as
well for completeness.

> I do not have any problems with several Keyspan USA-49W devices which
> are also referenced in the Compatibility section in the notes, so I
> think my Linux machine is good.
> 
> Apologies - I am not a Linux expert, just an end user.
> 
> Any guidance or tips would be appreciated!
> 
> Thanks in advance

Johan
