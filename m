Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C0C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 25 Jan 2022 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiAYSkx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232880AbiAYSkv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jan 2022 13:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643136051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6xgw7PLLB99kGOm82Md5xSrceAHr+vyHuVH486XnJc=;
        b=QFrDht///ZiAsWtq5NB+5Xfy9GgQOWlmnYsXx1JW/G6PzlBFV3wV/s5PgUddS4dwi7u+JE
        W1JXRW0SeqAoNEEcmg/+cxbgavhtAH0aF1703vWgClKwRp8x8kJL83cRryoKRSfCWbRwIQ
        FnTsjJ/YEmfR+nh5OCG0leEmMooZ5Sw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-iyQY27VGM9y33F0dyfgtLA-1; Tue, 25 Jan 2022 13:40:50 -0500
X-MC-Unique: iyQY27VGM9y33F0dyfgtLA-1
Received: by mail-ed1-f72.google.com with SMTP id w3-20020a50c443000000b0040696821132so8430635edf.22
        for <linux-serial@vger.kernel.org>; Tue, 25 Jan 2022 10:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6xgw7PLLB99kGOm82Md5xSrceAHr+vyHuVH486XnJc=;
        b=4DDoMo55r72Fg/d8B8HolFn8nvn3LYBm1EyMbvhjMgvFDOqc8Fe4uJMowhiK10OV4F
         q4miQ+HPFEpz+Dyb+VeRLCSwuwth3iy0t1MOjI9oTm+H9mk1R/hxjbaKRvkbTxnNkAMZ
         40r4d5gK769nXaMLuXSEuqODFB4AZIxZl0gR3xgQDBvFQOcKXbwndaq+F+Kw+hlgPdEL
         aKGQBNVWgYAtOzCmTsEPUCWoZ0WzE7sjTkjvpCgSZV61/i+4ewhWIXDzQdki4JOSuPgK
         aoPzJGbrwpIe0uRmjdPYwnG3srN96qQYQjWN4yPHmP8ryVAd/N/dW5izvx8OfmC3fkxs
         I/Sg==
X-Gm-Message-State: AOAM531tNlBwx9fYyDPleh9lP2f83qdNBZfnEkDyAooL7QAL2FSFsgmx
        rldSkbqO9MuPO75J6JCdeVLiQ8N/FYtqj3pP58L4sRfER61W6175lnpUg6NuTY5QVs+cwKMx+W+
        yrWyTb3oIrQ0MpA3Hiw9bbZ4p9YIgr63jCIOxX9DB
X-Received: by 2002:aa7:c046:: with SMTP id k6mr18187795edo.9.1643136048742;
        Tue, 25 Jan 2022 10:40:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxya5dJ1miI9SET/rdoVMG9M9jvYhFhoQdOs0j/ZIC5u8/OefiKgy0godTNlvTTkg6wialGZuuOBdiW278y2To=
X-Received: by 2002:aa7:c046:: with SMTP id k6mr18187780edo.9.1643136048545;
 Tue, 25 Jan 2022 10:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org> <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com> <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com> <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com>
In-Reply-To: <YfArWaKJ13+OC/7w@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Tue, 25 Jan 2022 15:40:36 -0300
Message-ID: <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 25, 2022 at 1:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > > On 25/01/2022 10:29, Wander Costa wrote:
>
> ...
>
> > > Andy, does this work for X86?
> >
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> > (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> > ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> > all of them.
>
> Shall I send a revert and we can continue with a new approach later on?
>

Tomorrow (or maybe after tomorrow) I am going to post the fixes I
already have, and an additional patch adding a build option
(disabled to default) so people maybe if they want to use the FIFO on
console write. But I understand if people decide to go
ahead and revert the patch.

> --
> With Best Regards,
> Andy Shevchenko
>
>

