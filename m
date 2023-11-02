Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9DC4332F
	for <linux-serial@archiver.kernel.org>; Thu,  2 Nov 2023 22:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKBWIs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Nov 2023 18:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKBWIs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Nov 2023 18:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2233191
        for <linux-serial@vger.kernel.org>; Thu,  2 Nov 2023 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698962875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkWJVPJFaRtARApP/xOT73zf0/RfYFWCBPOHT7K33GA=;
        b=F2+sLUbpsKBURhWUq2/y75Rm4V6gCP4imPnqKSIt6Hi81MRmIk0tUP5M6BpS0y0l+vqMzo
        iPi4cf45Vb+OeSv9aqdOhANxqgYiyFjcLhJ4mT0uSL5ZxPm7AzaHQc2vrdAWVtTR3DQ2yf
        H+YunAmcdwvt+ssUF09PcZZvqLQ9Pts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-cdy9wxjTNW-QdvyeITJiCQ-1; Thu, 02 Nov 2023 18:07:54 -0400
X-MC-Unique: cdy9wxjTNW-QdvyeITJiCQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-542d011ca7dso224624a12.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Nov 2023 15:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962873; x=1699567673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkWJVPJFaRtARApP/xOT73zf0/RfYFWCBPOHT7K33GA=;
        b=CzO0V/F1zF1WLY/4wuiV2xT3KdsSQH45ucWFJyoG6DBz/bFUBJgAU9nghM9MpX3VmU
         n7a9G09tRYq+T2j0AIED4am2Cjsr77Djl2B3b1vmkaKiTPQ0BwnhqB2tr9pyvwpXo8VV
         T2MsBmNkyA9PcUcS12nOUSMq234tvLcKRUyK6ryCfeqXR9NV3w5J1GexiMHqZNRDdU1A
         9JbyFhIsIPNx2sy0PxQJYmyYmI7N0zHuGZ1c9KWynzubhy+95tirpZo35PEqbE2RO46l
         DavR7rkK4A3tRJUlfBY0z1oobg2gBYKBenysGF5G9Q0CaAhFCz/elzqQ7sycQtn6+HdR
         hPgQ==
X-Gm-Message-State: AOJu0YyVMcf0z2UDxrQL2AAGQd0W0iswtUCRp8VvkMRodiaS1J3pTVJv
        OUi6YNW2NnTyxsIZg/2ei+Z+KOqcEoYdQIYo0vUc/VD9X174659vAF1gLw1e2vsu8mzQRjJ6KBU
        UKAckCzzVoBPUgK+rPUu5gAO+
X-Received: by 2002:a50:c05b:0:b0:543:83a3:f39 with SMTP id u27-20020a50c05b000000b0054383a30f39mr6383126edd.4.1698962873044;
        Thu, 02 Nov 2023 15:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYB5pMCj8ov2H3l8xfTg6DCVUBcRNCnuF1xlx8YzxWJryLAx/pozKFMTC55qPQqelAfT1XKw==
X-Received: by 2002:a50:c05b:0:b0:543:83a3:f39 with SMTP id u27-20020a50c05b000000b0054383a30f39mr6383110edd.4.1698962872750;
        Thu, 02 Nov 2023 15:07:52 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id u14-20020a50c04e000000b005412c0ba2f9sm212636edd.13.2023.11.02.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:07:52 -0700 (PDT)
Message-ID: <37ab45c67d630b4832912cb8403ce8235f52d9c0.camel@redhat.com>
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
From:   Philipp Stanner <pstanner@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Airlie <airlied@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Thu, 02 Nov 2023 23:07:51 +0100
In-Reply-To: <20231102204903.GM1957730@ZenIV>
References: <20231102192134.53301-2-pstanner@redhat.com>
         <20231102201424.GL1957730@ZenIV>
         <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
         <20231102204903.GM1957730@ZenIV>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2023-11-02 at 20:49 +0000, Al Viro wrote:
> On Fri, Nov 03, 2023 at 06:24:09AM +1000, David Airlie wrote:
> > On Fri, Nov 3, 2023 at 6:14=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
>
> > wrote:
> > >=20
> > > On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> > > > The functions (v)memdup_user() are utilized to copy userspace
> > > > arrays.
> > > > This is done without overflow checks.
> > > >=20
> > > > Use the new wrappers memdup_array_user() and
> > > > vmemdup_array_user() to
> > > > copy the arrays more safely.
> > >=20
> > > > @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc,
> > > > ushort ct, struct unipair __user *list)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ct)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 unilist =3D vmemdup_user(list, array_size=
(sizeof(*unilist),
> > > > ct));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 unilist =3D vmemdup_array_user(list, ct, =
sizeof(*unilist));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(unilist))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return PTR_ERR(unilist);
> > >=20
> > > a 16bit value times sizeof(something).
> >=20
> > So since it's already using array_size here, moving it to a new
> > helper
> > for consistency just makes things clearer, and so you are fine with
> > the patch?
>=20
> Sigh...=C2=A0 OK, if you want it spelled out, there we go.=C2=A0 I have n=
o
> objections
> to the contents of patches; e.g. in case of ppp ioctl it saves the
> reader
> a grep in search of structure definitions, which is a good thing.=C2=A0
> The one
> and only suggestion I have for those patches is that such patches
> might be
> better off with explicit "in this case the overflow is avoided due to
> <reasons>, but use of this helper makes it obviously safe" - or, in
> case
> of real bugs, "the overflow is, indeed, possible here", in which case
> Fixes: ... and Cc: stable might be in order.
>=20

So if you agree the content is improving things a little bit then it
seems the only critical thing is the commit message :)

So let's get that fixed, shifting the focus from security to
readability and general usefulness.

Do you have a proposal for a good wording?

Personally, I would have gone with something minimalistic like here in
my other commit, where the irrelevance of the overflow-aspect was more
obvious for me to see [1]
I can also add a sentence clarifying that it's about improving
readability or sth if you think that's better

Kind regards,
P.

[1] https://lore.kernel.org/all/20231102192402.53721-2-pstanner@redhat.com/

