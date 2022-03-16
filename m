Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F66C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Mar 2022 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiCPQjK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiCPQjJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Mar 2022 12:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEE0D2603
        for <linux-serial@vger.kernel.org>; Wed, 16 Mar 2022 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647448668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHEVJaqCCqwyj0GRbWELjpndY1ginS3nDRc87SV2N9M=;
        b=eCTUKZyAAE6n7Add0xs4JiDeroGa9cEOJXi6iLPuur88FDl42D6tgoXfZbEG+jD8//Iksd
        /KCze3+mI45MNu5aygXkvKd17nFTs7ME8kPH6H+339A9s5CLLuA/aoUnyx2KBmlImJesWD
        A4aYdTeuMfXtLibvFy7Z48kf4oeHNGs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-WrjKaWyWNmOhVSCrJt-O8g-1; Wed, 16 Mar 2022 12:37:47 -0400
X-MC-Unique: WrjKaWyWNmOhVSCrJt-O8g-1
Received: by mail-lf1-f70.google.com with SMTP id b7-20020a056512218700b0044869874779so935893lft.3
        for <linux-serial@vger.kernel.org>; Wed, 16 Mar 2022 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHEVJaqCCqwyj0GRbWELjpndY1ginS3nDRc87SV2N9M=;
        b=jwT7zIHH4CfJdxQboWmCKAicVSpX3SoS/AXiQhP7RajL/fBSZgb88ynFXIe7LmNBf9
         +kngcJp4DCGQId5N/FqxU51IHj3mAh1mSsuMU7QdwLMn9zyQATbpCSXwKTqi9Zick3Mx
         MqdhRHb2jyfIkdAQC/0slHVoyEybB9u26gI0rlbGqgbD9WxkRgb/D+vYz1S02UAQ0PpZ
         dFY4OByau5fMUfjGVyE93L7IxtNVKl/C7jRunqzYf+HkeWRavvu/s09RzNTVz3psdkTz
         nulZMmmFP9XEpV/eUMFgqej5uz05j+ZSgjaH7jlvZPpj3JjsZqqfUfs87pOMXxwQcZ0W
         g4Og==
X-Gm-Message-State: AOAM531Dnmi0BllNKnaQcWCWnJN8XrK2ug/mNQe9dU9H9WVjBNGF0zWP
        Bdb/WfuN+1ldRQJZixrL3ftDzWC52DBdQG5K+aYPIjJyUCHKEQxaivlL+CZW0pIq0bM1DRJ8Awz
        sHN7MOCEPw3+WLEDLwDfOp7fpVoTiYnKJYRbbyQKv
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id f16-20020a19dc50000000b00448816d2dd8mr264666lfj.1.1647448665993;
        Wed, 16 Mar 2022 09:37:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxON6uSO8M4DAucsY5caNVYsjogOOiaQfUlGsrZZJMxA7xyBy+eOgl0Ss88e2+gcQ9eHOcV+2mXTG1b7tgAWNo=
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id
 f16-20020a19dc50000000b00448816d2dd8mr264654lfj.1.1647448665781; Wed, 16 Mar
 2022 09:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <YjIMn/cBf7STIxBU@smile.fi.intel.com>
In-Reply-To: <YjIMn/cBf7STIxBU@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 16 Mar 2022 13:37:34 -0300
Message-ID: <CAAq0SUkZK_FkCk7k--t6yAh8LcEdMajPetVLGAnSy4VPEwy09g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 16, 2022 at 1:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 16, 2022 at 11:36:39AM -0300, Wander Lairson Costa wrote:
> > This version fixes the bugs reported in version v3. The first patch
> > is the same patch of v3 as is. The following commits fix the issues in the
> > original patch. For details, please check the commit log of each patch.
> >
> > I tested these patches in the following systems:
> >
> > * IBM X3550 M3
> > * HP ProLiant DL380 Gen9
> > * HP ProLiant BL480c G1
> > * Dell PowerEdge R910
> > * Cisco UCSC-C220-M3S
> >
> > I cc everybody that reported problems with the previous version of this
> > patch so they can retest and confirm their systems work flawlessly.
>
> I have got this only message and I don't see any good changelog what has
> been done between v3 and v4.
>

Weird, the patches were sent [1,2,3,4,5] and reached out my inbox.

[1] https://lore.kernel.org/all/20220316143646.13301-2-wander@redhat.com/
[2] https://lore.kernel.org/all/20220316143646.13301-3-wander@redhat.com/
[3] https://lore.kernel.org/all/20220316143646.13301-4-wander@redhat.com/
[4] https://lore.kernel.org/all/20220316143646.13301-5-wander@redhat.com/
[5] https://lore.kernel.org/all/20220316143646.13301-6-wander@redhat.com/

[snip]

