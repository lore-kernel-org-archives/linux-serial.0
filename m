Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EABFC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Apr 2022 20:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiDAUZb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352576AbiDAUZN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Apr 2022 16:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E26F28D2B7
        for <linux-serial@vger.kernel.org>; Fri,  1 Apr 2022 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648844441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moFtzAyOAPoCtp/a6KG0UUQYbtXpxVkTbUnLT2+nfP4=;
        b=jV9XAlXaWr+FUaxhCuGuzifYC27gmSLqYh/6fn4SdbttG9pa2E+gCWemst4csY7cMVwRvX
        9aQJjlF7rEoFIaE3FjNzHBlX/b2+3Vuwvb5R/3HVk95OUnTcEfO+ExZUG/B2DRrOtdpw3r
        ivFAfV6eBg5x8bbDiDjaBxAIaqDieso=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-GDorD9J8Oq6UjksxoGBnlg-1; Fri, 01 Apr 2022 16:20:40 -0400
X-MC-Unique: GDorD9J8Oq6UjksxoGBnlg-1
Received: by mail-lf1-f71.google.com with SMTP id bt40-20020a056512262800b004481fbe2d29so1617592lfb.16
        for <linux-serial@vger.kernel.org>; Fri, 01 Apr 2022 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moFtzAyOAPoCtp/a6KG0UUQYbtXpxVkTbUnLT2+nfP4=;
        b=cSw2X7B2BtlMaLwn6GXvs3udpVvfJJMqmwpvgNxajzWuYMbXgm4CTa5wkisBzzlMUs
         fjkJFqIMhY+nIEJWfI1UH/5N/rUdrIQ4ubEy9m+qXgO5YxmCgaq3/erLDhm2eV4QPp7f
         JRGjqoRC4g+nXhxgXd7DqBJwS9TUMY9/a5qSZhWgIX+u2aVwPNB3KoafHKuH5lX5HJ1V
         vXJDjSRE8+vZHrB8KRDkH0BoZaNUZE4k3FnHH6FU9+2SNTh/KtYe0KtY9z/2oGTnz0Ea
         f5EFsycL1SdFbA3ZjTzWFVt25IBHdWdp1rcy+ePJci4x+9eVyQo6XC3fU6WwRLKSZzIB
         RANA==
X-Gm-Message-State: AOAM531hRqitjszqGrFMOeBtBsFcRC6XYhehJyi2kcG9DeNwCMzW9gX2
        5wDr7XsLZF8HSWsBea7u17ArmwauYg0xpTHWMXsCcYzM5C1SxjYMBPJtFf7RDI8xfNn8XVs/sJS
        vf6GT4sa+kA0QgUAYDFpKp1WwSmAmPPAmrRLjEwBM
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id y5-20020a2e7d05000000b00247ed41690dmr14495548ljc.92.1648844438488;
        Fri, 01 Apr 2022 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6C0nNye6mqstGgicxwQGjK28I/pm5vkMPhiF7HWuofBNDZkh6xMWyCF9ZZ3jNE7SwAsx+BSi2rHs0wjJQeCk=
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id
 y5-20020a2e7d05000000b00247ed41690dmr14495528ljc.92.1648844438292; Fri, 01
 Apr 2022 13:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220331190257.101781-1-wander@redhat.com> <20220331190257.101781-2-wander@redhat.com>
 <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org> <20220401120705.533896e5@gandalf.local.home>
In-Reply-To: <20220401120705.533896e5@gandalf.local.home>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 1 Apr 2022 17:20:27 -0300
Message-ID: <CAAq0SUnFnbo_ABbbAMJRZsa1+30T=-cojgncvnnpCmfrz77U6g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
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

On Fri, Apr 1, 2022 at 1:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 1 Apr 2022 06:35:58 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
>
> > > With the help of the function tracer, I then noticed the serial
> > > controller was taking around 410us seconds to dispatch one single byte:
> > >
> > > $ trace-cmd record -p function_graph -g serial8250_console_write \
> > >     ./sertest -n 1 /tmp/serco
> > >
> > > $ trace-cmd report
> > >
>
> Note, the function graph tracer can add a noticeable amount of overhead to
> these timings. If you want a more accurate time for a function, just trace
> that one function:
>
>         trace-cmd record -p function_graph -l serial8250_console_write ...
>
> As that will only trace the serial8250_console_write() function (think of
> -l as "limit"), and the overhead of function graph for tracing a single
> function becomes negligible, and then you can see the true time of that
> function.
>

Thanks for the tip. I used bpftrace as a low overhead tracer. Then I
used the function-graph tracer to get the details.

> -- Steve
>

