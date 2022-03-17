Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF62C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 17 Mar 2022 12:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCQM2m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCQM2l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Mar 2022 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6E3E1CABF5
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647520045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrgWgBIoJfzLisqsnqNuO2T4Ox23yYSbOeMePAqRbx0=;
        b=bBTfDoQgSbMGI7SoDrs6ZM0k65VEYeQbDlBG9vJv3ZT7vCRVdRelT8ux9+fbAtEYFNAJfg
        3L6rJ+gVRN2fA5WFD3R3ej6FoTGichSnTtyZXPR9pGz6bo1lYsV/W2qpYtmuKSyEQnP13V
        r3eJqTIPISef/164oqMLHCqN4FZxYOw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-UEIgK4xKOpSV0EwYLQ1XNQ-1; Thu, 17 Mar 2022 08:27:23 -0400
X-MC-Unique: UEIgK4xKOpSV0EwYLQ1XNQ-1
Received: by mail-lj1-f199.google.com with SMTP id j7-20020a2e3c07000000b00247f8eb86a4so2025359lja.3
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrgWgBIoJfzLisqsnqNuO2T4Ox23yYSbOeMePAqRbx0=;
        b=bIdXgsH19Ht8YTwqYAZTBIB701I9YBPE/lHXw2Uegu06Rw40TaUmvrmCwcDrWQAP4j
         rdsVqZFQhlr6dE/7Ce8F5lSNUqGPPkcPBencwoG14vrt7D9jEZR6hHWHX41QW4+B3bgI
         qSZIBm8ROyy68CaulcBTqGrUFr1aMWzJppjgpeHgDuUDbDh//ol/bwTHPrEDSZq1Fwss
         V6yJmOPZVF4S6v1pCNKCU0zgk0za6o8O6HErF4Q19DDLWuQpR4WH/4q6eWkjg3nI6p/X
         /m4YK07rjMS8UNEup3nEDChweo0fNxfKPcSFrrEh4n6LW9OFGMv4C26uMXSkplC/0pkc
         44sQ==
X-Gm-Message-State: AOAM532uVbnNdgv+UMVUq3MPUCraYoonTh7iUMgGYV5ohRc4wnnur+c9
        145taUQ7KEGOBFbXX9EiFX9NYPe7hUnNhKNtY39uE1Vys/O7nv6ykPXp6n/Wt6/MTPo8Rs66cbL
        xCimWhcyOHIB76GFcTpY8MCWJYyWaf3cX8087NAc4
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id f16-20020a19dc50000000b00448816d2dd8mr2648350lfj.1.1647520042118;
        Thu, 17 Mar 2022 05:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2dlOWq1WsEvaFd/fI5iXCgVuOFH/IMSoSaQ5HcG/HFbLEshYRc4GQrRKi3PVGw5rYMSPnEtv/ni99n4bLH0E=
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id
 f16-20020a19dc50000000b00448816d2dd8mr2648335lfj.1.1647520041938; Thu, 17 Mar
 2022 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-2-wander@redhat.com>
 <bb5f03ec092f462c9656f224895bb224@AcuMS.aculab.com>
In-Reply-To: <bb5f03ec092f462c9656f224895bb224@AcuMS.aculab.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:27:10 -0300
Message-ID: <CAAq0SUnGtOgJ5PWZXZ8QHoOxMJEPi1kuuuNeEhGq2iu73oF9AA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] serial/8250: Use fifo in 8250 console driver
To:     David Laight <David.Laight@aculab.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andre.goddard@gmail.com" <andre.goddard@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "phil@raspberrypi.com" <phil@raspberrypi.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 16, 2022 at 12:27 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Wander Lairson Costa
> > Sent: 16 March 2022 14:37
> >
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n bytes
> > to the serial console using the serco driver.
> >
> > While investigating a bug in the RHEL kernel, I noticed that the serial
> > console throughput is way below the configured speed of 115200 bps in
> > a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> > I got 2.5KB/s.
> >
> > $ time ./sertest -n 2500 /tmp/serco
> >
> > real    0m0.997s
> > user    0m0.000s
> > sys     0m0.997s
> >
> > With the help of the function tracer, I then noticed the serial
> > controller was taking around 410us seconds to dispatch one single byte:
>
> Did you verify the baud rate?
>

Yes.



> Or is there some horrid serial redirection going on.
> It is even possible there is a bios smm interrupt
> chugging through on another cpu core.
>

I would be surprised if that were the case because I see the problem
even in low system activity. Someone in a previous patch-revision
theorized this might be due to a bad serial controller emulator
implemented in hardware (or something in this line of thought).

