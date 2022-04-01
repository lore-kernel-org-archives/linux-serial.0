Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8FEC4332F
	for <linux-serial@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbiDAO2b (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346968AbiDAO2U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE8671BE137
        for <linux-serial@vger.kernel.org>; Fri,  1 Apr 2022 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648823189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2UVV1ZX1y9UdjpKVLfQDZGpGG6d6q550euWe10BEY9E=;
        b=WNmUOXRsUEtKfadbWfO7RiYXPjXQH1Uy3NbXAQ9/K9rE85uVr9LE03BRiRihIKuWqomw0m
        NRRgHdKBJbgPmlfUNkjWlZ331niBovAzZMICD6Hph4suHFIuOymw/v70tCn+OxHeiT3Jns
        t/eVbYFPLe5cLs5mmDWYlplR6kqUyT0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-qAf-tTgZPT6SDR-NSwWC0A-1; Fri, 01 Apr 2022 10:26:28 -0400
X-MC-Unique: qAf-tTgZPT6SDR-NSwWC0A-1
Received: by mail-lj1-f199.google.com with SMTP id bd10-20020a05651c168a00b0024af35c4d56so971793ljb.3
        for <linux-serial@vger.kernel.org>; Fri, 01 Apr 2022 07:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UVV1ZX1y9UdjpKVLfQDZGpGG6d6q550euWe10BEY9E=;
        b=XLC67S4IODCT+bEaHgTEVLxLw8gpBV1p7GMhZBYOUWKyf8BcfeisVdrquIs5BD0RNJ
         rbaf1XcCHaXKI0vjUY4Aas2Pxw0B3bTmTK/oTkd1sNydY5sPw+l58wRCTxHU54lSFvik
         m1JG+NzVSGHZNd8j6adhYSOYC6UCWjA3ICYm0J9kzRkkyz76h+S7ualbHLemNwafEVdM
         6xNRGlHLUsMSLPXDK/hTP/XAC1fJHFQXzp94hjC/sIjU5Q5YEpo4TnZ3LtfhBlbIbA3A
         dIVJaJcb6TI/abed1b7puuOKWHT2DfEBDN5hWL04HJ5KX6WpZCEI8Njx5xFVL+9qeAGp
         yaPQ==
X-Gm-Message-State: AOAM532qSZwPXbyDsMxml1bQ8Zdd/9LO9p57jP2hKygi3U/YbEAGUfYy
        TtEcg7Mm1k3pjoSBQLV2xxQuF17KEqqqp/3D7qXjMj1SUKGJ9O3IbJ7Ap29tRUxMz7ftcLsUCtw
        9HJ+dPZ6J27ciAquMzbRrJW98CTKIYuHrHVZuEBOt
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id z10-20020a056512308a00b0044a96cf7cebmr13936442lfd.1.1648823187410;
        Fri, 01 Apr 2022 07:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEZVCL9DRSUlkJcPMDBd0xC2u70/SZJFXNSHYEoLpznTZMmi9QE8ctwQW8FDrNG5W5P8YwVfpONL2yFm35WK8=
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id
 z10-20020a056512308a00b0044a96cf7cebmr13936426lfd.1.1648823187229; Fri, 01
 Apr 2022 07:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220331190257.101781-1-wander@redhat.com> <20220331190257.101781-2-wander@redhat.com>
 <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
In-Reply-To: <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 1 Apr 2022 11:26:15 -0300
Message-ID: <CAAq0SUmZ1u0TLTOq9fcn68oTZ6iHmpALbjhhy3zh6T=Kz1afxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Fri, Apr 1, 2022 at 1:36 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>

>
> ">" missing here. Doesn't a compiler warn about subtracting different types?
>

My local machine doesn't generate a warning; it causes a build error.
So my question was, how was I able to build and test yesterday in a
remote server? It turns out I built it with make -j40, so I missed the
error message because of the parallel build, and I didn't pay
attention that the output didn't display the modules_install typical
output. Usually, I do my tests in an RHEL9 machine, which ships with
kernel 5.14, but this time I tested in a Fedora machine, which ships
kernel 5.16. And for a moment, I forgot that. So when I booted with
kernel 5.16, I believed I was running my custom kernel. Luckily, v5
mainly was a squash of v4 with this port->state check added. Anyway,
sorry about the typo. v6 is on the way.

