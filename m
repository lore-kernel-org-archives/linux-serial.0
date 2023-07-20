Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3ACEB64DA
	for <linux-serial@archiver.kernel.org>; Thu, 20 Jul 2023 07:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGTHTr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Jul 2023 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGTHTk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jul 2023 03:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4542126
        for <linux-serial@vger.kernel.org>; Thu, 20 Jul 2023 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689837532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYGtszuU5wIRpPGldAIwvzXGaeXBUQT3e9Yc1Tmh1Tk=;
        b=VfWerjhVrq3SqJPb78ypstiUCvDKGFZN6+DRfG3QZS+m22Krf/A86latEQkHRBzi6gL/x0
        Wd5LsBdxoQrmkzCVaEgpzYVtEaPIgcNuuuBXKj62f5ekEybYv08JATL5myzq8Em+PFksEH
        MY+QFxj4X7EXO/CNwlF4pHZAF2GHWsM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-aYnQBdWbOqaQGI8Z24ckOQ-1; Thu, 20 Jul 2023 03:18:50 -0400
X-MC-Unique: aYnQBdWbOqaQGI8Z24ckOQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-637948b24bdso1412466d6.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Jul 2023 00:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837530; x=1690442330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYGtszuU5wIRpPGldAIwvzXGaeXBUQT3e9Yc1Tmh1Tk=;
        b=V4E6eAKjxua/Itr7NT2v413NMJ5z4DbzqaIov/GYQjpUY7lj/FKmH3/Mrq8Z47AxmN
         ZWguxlpaJ5759j6oB7oZiUdQnJjhXi6OXhUU/VRYGgs/rNSOHGCWH3qJdC4uDbDywA+T
         8Qbh6qMLdC+6Z6EfMr74RG7kvuIom8AS7D5lWjuWoYTMIKwsvBu13bpTmJB0xpZJtGd0
         lHMEBm9X5IR4v3aPvdYdioc7CtJgAI4wnAzlu386D2FYzMz/CNB1qTfor9jLg+7kg7Sg
         zKSRKmg2ZA0+QYJQCNYTSJ2l4gG+AGeQD+I9JfNeIbfH3lgKRUOk2Q4E4J5K7EOWuLMb
         +UkQ==
X-Gm-Message-State: ABy/qLbUk1Zf1MqgGghqPHR+QnmO+f7o43k8HfnbcCwC0eVsWynO3j+S
        EF7voCeCeCDG9Y2EJiI56P6I6n5pL+KyK9MHWS6gqCimhwUwpgt2+j5Drm2Vc3JvVeIcUs8Y2gk
        NhfCqXM87f3ymt9xQzhw/ZTpe
X-Received: by 2002:a05:6214:762:b0:616:870c:96b8 with SMTP id f2-20020a056214076200b00616870c96b8mr17420013qvz.3.1689837530199;
        Thu, 20 Jul 2023 00:18:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNH0y5bvIQeSocI2GpS8aKw2ULselhDKyztO/OsqWZvlAvU9rCW8Bzkmb5n6WaEJyCUMCrhw==
X-Received: by 2002:a05:6214:762:b0:616:870c:96b8 with SMTP id f2-20020a056214076200b00616870c96b8mr17419995qvz.3.1689837529948;
        Thu, 20 Jul 2023 00:18:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id n14-20020a0ce48e000000b0062b76c29978sm154802qvl.6.2023.07.20.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:18:49 -0700 (PDT)
Message-ID: <e6d1bf573d535612c2be1f45e7197affe92df639.camel@redhat.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS
 too low! (2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
        dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com,
        clm@fb.com, davem@davemloft.net, dsahern@kernel.org,
        dsterba@suse.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        josef@toxicpanda.com, kadlec@netfilter.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Date:   Thu, 20 Jul 2023 09:18:44 +0200
In-Reply-To: <20230719203030.1296596a@kernel.org>
References: <20230719170446.GR20457@twin.jikos.cz>
         <00000000000042a3ac0600da1f69@google.com>
         <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
         <20230719231207.GF32192@breakpoint.cc> <20230719203030.1296596a@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 2023-07-19 at 20:30 -0700, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 01:12:07 +0200 Florian Westphal wrote:
> > I don't see any netfilter involvement here.
> >=20
> > The repro just creates a massive amount of team devices.
> >=20
> > At the time it hits the LOCKDEP limits on my test vm it has
> > created ~2k team devices, system load is at +14 because udev
> > is also busy spawing hotplug scripts for the new devices.
> >=20
> > After reboot and suspending the running reproducer after about 1500
> > devices (before hitting lockdep limits), followed by 'ip link del' for
> > the team devices gets the lockdep entries down to ~8k (from 40k),
> > which is in the range that it has on this VM after a fresh boot.
> >=20
> > So as far as I can see this workload is just pushing lockdep
> > past what it can handle with the configured settings and is
> > not triggering any actual bug.
>=20
> The lockdep splat because of netdevice stacking is one of our top
> reports from syzbot. Is anyone else feeling like we should add=20
> an artificial but very high limit on netdev stacking? :(

We already have a similar limit for xmit: XMIT_RECURSION_LIMIT. I guess
stacking more then such devices will be quite useless/non functional.
We could use such value to limit the device stacking, too.

Cheers,

Paolo

