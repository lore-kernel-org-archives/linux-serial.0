Return-Path: <SRS0=5qHh=DE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FEC4346E
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 15:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B586923899
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 15:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqnMTfgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgI0PB7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Sep 2020 11:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgI0PB6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 11:01:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601218917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hs5rdUJVOmzg99SVlEBJlBQFGXQLPQJ2GLdFN3MjFs=;
        b=ZqnMTfgAjasze6mCvo/28IVH7A5gf58YIwpj/Oo2oiBprfFaoumtJcq3dsrtyZpeJuDNXh
        rVHom251RK3ICJWXR5PN/ULHma36fUzuxe+FDivwQ/S09fL8Jr2hDAPrji7xwB7rz7R1pe
        6csiYIKWuaVASfcONKcJWXhjLp/ZHNg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-hGZadloEPYulMLrv5GCF7Q-1; Sun, 27 Sep 2020 11:01:55 -0400
X-MC-Unique: hGZadloEPYulMLrv5GCF7Q-1
Received: by mail-ed1-f72.google.com with SMTP id x23so3321935eds.5
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2020 08:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0hs5rdUJVOmzg99SVlEBJlBQFGXQLPQJ2GLdFN3MjFs=;
        b=ZouXp019+lkieKS2StA5bb4SSosGUAfeuFB379yzS0Fira8etnO5No13QFy3PT2hX4
         G9EGRK/GmHINac+Ka2tZWRo4rBS6P9gjt6ChdVoOaopOS+5pjIu717CAdzwwzfR3IboZ
         nmvsZnM4rgl38wrpDbwliNyTGQROa8vdJNmVmW0XbhkmERb9Lc6KRlUzTZ4Y5PXHXkm1
         j+lHVQqFpwOs6+wEjmn/ViCpZSdaEMeLOC/MM9H0yxIhMGml5/VAINxKtu+ROx82lpLm
         XXoVyFtPSClKbOfmbo3ho2uaZcHtYLw1t+e8oYm/bTnCdqqZbn6LqtWCPbsDsA0qWfn1
         ajwA==
X-Gm-Message-State: AOAM533zikEPobV0URy7oa4NI5M81a3RlbkGN3zQvEFz9SwAlIinTxWm
        VVgKMyKSGdXrGH6yfAYXKRH03pc6zNVYk0/PzvygJfLhgvbpM1gZCa5Uk/TBXQaRROSZ3F2XsQs
        f69uyKdSgGXoNoXpwvT9CojsZ
X-Received: by 2002:a50:bb65:: with SMTP id y92mr11310097ede.53.1601218914367;
        Sun, 27 Sep 2020 08:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9xBEE4fL9o6SH/mCyn1ClksiNMLfDL1ho7Cw9z0Iz424ysBl96z0clzUKT7OhlnwXh9r6fA==
X-Received: by 2002:a50:bb65:: with SMTP id y92mr11310082ede.53.1601218914188;
        Sun, 27 Sep 2020 08:01:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y14sm6602549eje.10.2020.09.27.08.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 08:01:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] serial: 8250_dw: Fix clk-notifier/port suspend
 deadlock
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e508b9c8-bcc4-00a6-0ca0-0b4a0c34f626@redhat.com>
Date:   Sun, 27 Sep 2020 17:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 9/23/20 6:19 PM, Serge Semin wrote:
> Hans has discovered that there is a potential deadlock between the ref
> clock change notifier and the port suspension procedures {see the link at
> the bottom of the letter}. Indeed the deadlock is possible if the port
> suspension is initiated during the ref clock rate change:
> 
>      CPU0 (suspend CPU/UART)   CPU1 (update clock)
>               ----                    ----
>      lock(&port->mutex);
>                                lock((work_completion)(&data->clk_work));
>                                lock(&port->mutex);
>      lock((work_completion)(&data->clk_work));
> 
>      *** DEADLOCK ***
> 
> So the CPU performing the UART port shutdown procedure will wait until the
> ref clock change notifier is finished (worker is flushed), while the later
> will wait for a port mutex being released.
> 
> A possible solution to bypass the deadlock is to move the worker flush out
> of the critical section protected by the TTY port mutex. For instance we
> can register and de-register the clock change notifier in the port probe
> and remove methods instead of having them called from the port
> startup/shutdown callbacks. But in order to do that we need to make sure
> that the serial8250_update_uartclk() method is safe to be used while the
> port is shutted down. Alas the current implementation doesn't provide that
> safety. The solution described above is introduced in the framework of
> this patchset. See individual patches for details.
> 
> Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com
> 
> Hans, could you test the patchset out on your Cherry Trail (x86)-based
> devices? After that we can merge it in into the kernels 5.8 and 5.9 if
> there is no objections against the fix.

Done, I can confirm that this fixes the lockdep issue for me, so you
can add my:

Tested-by: Hans de Goede <hdegoede@redhat.com>

To the entire series.

Regards,

Hans

