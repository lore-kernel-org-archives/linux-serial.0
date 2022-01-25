Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9638C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 25 Jan 2022 14:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456362AbiAYOgB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1579003AbiAYO0Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jan 2022 09:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643120777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLtIFJjgUtOUVDA99ng5/AGYu7PV8wK1w9Iei4rx6Qg=;
        b=eN7cCiL1RTWtEPi+pCzfJ+JeAsLx6NWd0J5Na1+geEwjo27YSHQEDvWWsZiLz3D3najCzu
        8xR4bJyDHUJY9wHmILqbObrtt4jmu1FWwOZSNFLonykallljz5qs0W8+7yfJNDfhmKs2V7
        NXERGBqOAoE8SD+x1hqZ+/hmL64Is8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-kXmhQ99fMjmy2Ju8Ta9Z7Q-1; Tue, 25 Jan 2022 09:26:16 -0500
X-MC-Unique: kXmhQ99fMjmy2Ju8Ta9Z7Q-1
Received: by mail-ed1-f72.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso13911202edb.5
        for <linux-serial@vger.kernel.org>; Tue, 25 Jan 2022 06:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLtIFJjgUtOUVDA99ng5/AGYu7PV8wK1w9Iei4rx6Qg=;
        b=u4Umn8IIFyG0VV422rxOKOB4gJgQjE2Gp2/DRXtklUtKRvuFnnvLyEd8zN2igSJLdh
         XQYy8vmnEL+4NverNBCnkTUd5h7hkgMWcuj0IEOrlNBug9Ccd9m94k8XIX/+7P4j9YMl
         ChrRd5WsVWabOnMkMIeT5OpwKZhLTvEXtVso+bAWB0FVPwDOOnhvyvCfvYOkRKk4nHG0
         0L3y8UiMqmHwU59jKF0pcVqH+87YQYQgQRK1nATkIgs344M0rd/zZFQcNvfFK7f3bPEi
         qBZtOwZ4nxSR78skEee+ZqV0nO7c1bTedYGfJzzQkg+cWWlRYPuX9JhBWCc48JTnXYc4
         jEjg==
X-Gm-Message-State: AOAM533Z4HwZJGtF5eNjGRR/+edn6NNx7SktCd7aID/UI3QB6+d1Sg6a
        HiMu658RzI80/6tBazdsDgY/gjiJ6Ny3zEASkdiKDwPDyrMQ337OBZWTHT+zYna135Vr2jm9o8k
        wqmC0oMoukcfnugUaquEvka3vEk9zO1mXhmS9+QM9
X-Received: by 2002:a17:906:1f15:: with SMTP id w21mr16253523ejj.205.1643120774971;
        Tue, 25 Jan 2022 06:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9O9o4wfs8N1leHAikkbwJT29Az/OoR2DjwNtoJWQuQqqvtGNb1WTEw1Hy2QO4rGn2JAk000qaKRVjx7pfKF8=
X-Received: by 2002:a17:906:1f15:: with SMTP id w21mr16253499ejj.205.1643120774706;
 Tue, 25 Jan 2022 06:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20211222112831.1968392-1-wander@redhat.com> <20211222112831.1968392-2-wander@redhat.com>
 <Ye/1+Z8mEzbKbrqG@linutronix.de> <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
 <YfAFAcYmJ+Zrontd@linutronix.de>
In-Reply-To: <YfAFAcYmJ+Zrontd@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Tue, 25 Jan 2022 11:26:03 -0300
Message-ID: <CAAq0SUkuG2uyouBhT5yDiq_KbOGUCO=9ondq6dkt1QZLN_C4uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tty: serial: Use fifo in 8250 console driver
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 25, 2022 at 11:11 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-01-25 10:15:04 [-0300], Wander Costa wrote:
> > There is another thread[1] reporting some issues with this patch.
> > There, this diff seems to fix the problems, could you please try and
> > report if it works for you too?
>
> Nope. Still there.

I will check on my side if I see something similar. Do you still get
lines lost as well?

