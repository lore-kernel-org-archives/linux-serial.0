Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A64C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  2 Nov 2023 20:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjKBUZS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Nov 2023 16:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjKBUZR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Nov 2023 16:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722C1AA
        for <linux-serial@vger.kernel.org>; Thu,  2 Nov 2023 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698956664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcWEoS06f0kWkjZ1YzkPeHLmfqD6IXJBjSAaROXoiz0=;
        b=boLdwsQSQcVsgz1OTErqGIbqGrKDSE8eh+XTYBeN6pVHg7+3EXIq62VOHnTLgtjVNUrDKc
        qli0GYMy1yMIW6/2Ax44xxqgVY0Wdci5Ku5nH18wrem32tSts1cj4dhS2rj6bM5f2HS5dh
        N+RFw8d7/7g/emnvGGR8IlRAWnja5Zw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-9Qh7gt8_M4eXVRcb8qZLhw-1; Thu, 02 Nov 2023 16:24:22 -0400
X-MC-Unique: 9Qh7gt8_M4eXVRcb8qZLhw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6cdb4938072so1598796a34.0
        for <linux-serial@vger.kernel.org>; Thu, 02 Nov 2023 13:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956661; x=1699561461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcWEoS06f0kWkjZ1YzkPeHLmfqD6IXJBjSAaROXoiz0=;
        b=NGjDCBvalK5XDikV9835wgQvn+Qw5gpExqCopujEqIKrf4Is4QaU6F5+hJUAXS6gUM
         7GqjuHpGnSEUSlzX+dFOdNP2UT0LKIbkWlk+r1tz3xU48ut8tNA1qHo4Dd/a7bKeDpzt
         Cft3y8gcvA7sZQ53SsEaHzXGJ71ElV7pwvtMPrJ7J0+zTc70MZTJpW4W7e+rEbTQd6Ms
         jN1PV5aBa8WfaWTWRq2l2u+UCWf+bzV2TZ1ocVZeW8dIHPhL9g4AhjW06NOii+Ii77VR
         DC2UxuF+BjfosGM5oMRKeiFjysjg+KqgIO/ED4jOa7w3Omi8+0cObo1ECWBV0KQbFNTw
         Sjpw==
X-Gm-Message-State: AOJu0YyPF83dVTn93QK3Oxk990ImrSpUAD8qm7RjHZ6tvm2yI3tSPH+1
        n8ilY+OmhP2mGFr7PjEn5I23HYa0R6+1FdaS7MMzD3Jo0n8Y1aYsXw3C6r3nm0+v/haPjaaJ2ky
        J13JxM60Vp82uYInSjM6fgO62+WNtKaxvfYMIJoAa
X-Received: by 2002:a05:6830:4409:b0:6d3:2346:8e0d with SMTP id q9-20020a056830440900b006d323468e0dmr4431825otv.3.1698956661320;
        Thu, 02 Nov 2023 13:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkxOlsUqu5jNE3Q3DjQ8oBDcolX6JJ9/NvKVWr9Alk9XXeokWPfn4hKWgIkHS15eaNXFdtRSE+aO3obb0JX+8=
X-Received: by 2002:a05:6830:4409:b0:6d3:2346:8e0d with SMTP id
 q9-20020a056830440900b006d323468e0dmr4431813otv.3.1698956661128; Thu, 02 Nov
 2023 13:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231102192134.53301-2-pstanner@redhat.com> <20231102201424.GL1957730@ZenIV>
In-Reply-To: <20231102201424.GL1957730@ZenIV>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 3 Nov 2023 06:24:09 +1000
Message-ID: <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 3, 2023 at 6:14=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> > The functions (v)memdup_user() are utilized to copy userspace arrays.
> > This is done without overflow checks.
> >
> > Use the new wrappers memdup_array_user() and vmemdup_array_user() to
> > copy the arrays more safely.
>
> > @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, s=
truct unipair __user *list)
> >       if (!ct)
> >               return 0;
>
> > -     unilist =3D vmemdup_user(list, array_size(sizeof(*unilist), ct));
> > +     unilist =3D vmemdup_array_user(list, ct, sizeof(*unilist));
> >       if (IS_ERR(unilist))
> >               return PTR_ERR(unilist);
>
> a 16bit value times sizeof(something).

So since it's already using array_size here, moving it to a new helper
for consistency just makes things clearer, and so you are fine with
the patch?

Otherwise I'd think you are been a snarky asshole to a coworker.

Dave.

