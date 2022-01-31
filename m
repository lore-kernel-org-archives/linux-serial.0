Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEEEC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jan 2022 13:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378630AbiAaNXZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378633AbiAaNXR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jan 2022 08:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643635396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KAyT9rBVY+T+dfrdXo9p7KiG3uUpwYacibY8D080RQ=;
        b=LvtOJSwdkJsT1KgZk5SpwqoMFSyOIX+pQjBzwyXoeHHHPTMEt6HWVR6nWkz+dmgvKifsf4
        +YqsRsGRe+IBKClxAW0JzBQmsk6itwIQpgoi3XHEi9oLQf3Jud8S7pdA915AY1V1CguBjG
        5l7qrlX67th0WrEXpdf0DoUwrtVQYA8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-jZH7vzQZNGeBwGrfCszdow-1; Mon, 31 Jan 2022 08:23:12 -0500
X-MC-Unique: jZH7vzQZNGeBwGrfCszdow-1
Received: by mail-ed1-f70.google.com with SMTP id bc24-20020a056402205800b00407cf07b2e0so6961700edb.8
        for <linux-serial@vger.kernel.org>; Mon, 31 Jan 2022 05:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KAyT9rBVY+T+dfrdXo9p7KiG3uUpwYacibY8D080RQ=;
        b=kQGq52bby07XlCnEvOKFFguqPh5WTDFj1kJw75FP+0K/gNnO5KwK6UT7yRulGaTcA8
         NDQaCk8ST18WhcTFQbj/DQNzKfisIz3AUXEyYHixrgHmkyhK+7XDY8RyYYAdROEnFaDb
         NVynUNO466PXnS/FEGxscJmV648f2fOIxdnUTUUAS5R+uc3SbjgHIjVt1YuJKcxL+JL/
         dfE6ZUJW1x7akAQ81laLsUoBX3SVhty9i4Be5e/rGwj1aZdyBqU3OWiHaTqy7wUje7JP
         SbHYjEmVsWno12tGysXbtkVKYhGEzgNaf7R+LcYkQW5vMH4UOaC7TEsOa2/TuGdV7owO
         TL7g==
X-Gm-Message-State: AOAM531Fqpvv6y8pJIA7rG0JtxrgzVf/PW0o1WhCw+127zOsyxUoSM4V
        FL3a0eLTgM42l0XimcI3BONP9ozn4z6DiyWaXQiEEiCO16o79ewh1mcHHzGj2e/FqOaOA5Rsatv
        b7Fk2fSKJyaISit30bqtEGrfzBwMt/TqTLOyjM+D5
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16888735ejc.205.1643635391435;
        Mon, 31 Jan 2022 05:23:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVhHivHRPtNJZPlnaUFUN2LqTF3Kv/MxIn/+ozkQARm7ix/MOw/YseOo8lcsRT/+7AnsqD3YtAzozBgjPg1Ug=
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16888719ejc.205.1643635391226;
 Mon, 31 Jan 2022 05:23:11 -0800 (PST)
MIME-Version: 1.0
References: <YfMpk7DM9zA7NfmI@debian> <CAAq0SUnNtS8b3419egw-WVH8ic+MxH8oQELm1K0s4iqt8pYKnQ@mail.gmail.com>
 <CADVatmM5=sZLaT8SWcvmFtcMhVJsuVCu66nCnhL6i2p062ZhXA@mail.gmail.com>
In-Reply-To: <CADVatmM5=sZLaT8SWcvmFtcMhVJsuVCu66nCnhL6i2p062ZhXA@mail.gmail.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 31 Jan 2022 10:22:59 -0300
Message-ID: <CAAq0SUnJVhmo_-o=UBcKbr1OzHkvcWJt_b-TAvcOanQmHaCZ2g@mail.gmail.com>
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 31, 2022 at 9:59 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Wander,
>
> On Fri, Jan 28, 2022 at 12:31 PM Wander Costa <wcosta@redhat.com> wrote:
> >
> > On Thu, Jan 27, 2022 at 8:24 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi Wander,
> > >
>
> <snip>
>
> >
> > Thanks for the report. As Greg said, the patch has been reverted. In
> > the meantime, could you please apply this patch and report if the
> > problem still happens:
>
> Thanks for the patch, and I can confirm after applying the patch the
> problem is not there any more.
> Log at https://lava.qa.codethink.co.uk/scheduler/job/602
>

Thanks for testing!

>
> --
> Regards
> Sudip
>

