Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B7C43463
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D152100A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600415801;
	bh=oO715/HpRiUMNzizx1aCANuY18d1YuqSVm+tLPjr7jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EiXvBYCUz/gpZ7B1X/BalHrKOcqdCg8X21sHdlinD9AEo9qW0HHVhTvJD0m9XlewB
	 YKPj6StGGtJ7VTyDzJEpHDn9ZDNbr+Awq6Ou3DumGXq71xY2SGl0BxhKtomCoxZdY1
	 oiXlA4dlXJO//g2uDIMS7LkQiIP6Uq0x+yD/dV6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgIRH4k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 03:56:40 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37519 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgIRH4k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 03:56:40 -0400
Received: by mail-lf1-f42.google.com with SMTP id z19so5133000lfr.4
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2020 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oO715/HpRiUMNzizx1aCANuY18d1YuqSVm+tLPjr7jw=;
        b=gjaaoW2nBE6XR7xMd0288rUgjhN9SUV4IKao7cUjbmkPJW4yYb25SYZ1zmLfiUWk+L
         ef1Jhz1OQIm0TsviJNw2j5sESnykmoTSBEuuK88zUUsNFY4kc4DiduriOMpu+3YjNW5n
         kcY9SDriX7+ZCHiAaT3qALCpI6D+E4kRWasmTc+TLKCzlT05BPhHlEqeObU8ulJLvS/A
         o8s/r0plWsE/Cketiepapo488obACDwKcAfiKz7r3F2E/RFKHCAbhrxahdufpMI6RpPb
         QNEtPmtTeUzf4/4g6yW6c9l4cMZa2HK30mhM5Svmxpm1ev+DP+hv0CwUUTdO/8BCkP7S
         4B/A==
X-Gm-Message-State: AOAM532+qJZgqZG1sVEWPQrTp13+1UTBXo8lH8nws+zSWpFPLsCFotqM
        MHoO51XmNK6Apg+wvdoY07KivNcyGIQ=
X-Google-Smtp-Source: ABdhPJwuGVJ98OYTxXbiIcqWS91Xo4nxZSGbCf8mlfENzHKaPjhzRfewLW2hHyCbZhhP4vdMkwLHvQ==
X-Received: by 2002:ac2:5e2a:: with SMTP id o10mr10036069lfg.315.1600415798468;
        Fri, 18 Sep 2020 00:56:38 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q24sm439840lfo.149.2020.09.18.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 00:56:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kJBFx-00079O-GN; Fri, 18 Sep 2020 09:56:33 +0200
Date:   Fri, 18 Sep 2020 09:56:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Barnett, Andy" <Andy.Barnett@nttdata.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20200918075633.GQ24441@localhost>
References: <CY4PR1201MB25321441CB372AD9068F8C458D2C0@CY4PR1201MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1201MB25321441CB372AD9068F8C458D2C0@CY4PR1201MB2532.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 03, 2020 at 05:36:34PM +0000, Barnett, Andy wrote:
> Title - Edgport/4 compatibility question

> Disclaimer: This email and any attachments are sent in strictest confidence for the sole use of the addressee and may contain legally privileged, confidential, and proprietary data. If you are not the intended recipient, please advise the sender by replying promptly to this email and then delete and destroy this email and any attachments without any further use, copying or forwarding.

Please resend with a proper Subject line and without the above
disclaimer.

And remember to CC the USB list (linux-usb@vger.kernel.org).

Johan
