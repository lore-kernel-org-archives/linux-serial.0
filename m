Return-Path: <SRS0=TiTh=7F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D6C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCDB20738
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB4SG++7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgEWRJY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 May 2020 13:09:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388051AbgEWRJX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 May 2020 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590253759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pt1Iu4wzJS7HbC6OHxqO6Iyg6x2zTpH3ashaPREeSXw=;
        b=UB4SG++785PeZVSc0JXvRUMfrwyW4gO388ylF1XoU+Eh6QxbCw0V0rTGhss2ulrNXz/iz3
        kh85AuFzbbsrW5h8ysxXzv3fyYbvkYqNhwbEYGXEmA0zzjB1yaKFFWqvh3dDL74dRljmnD
        V9maN98CspvgdF8vz+Pak6Vb5qG564o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-yo8jGxvDO4ayp8WASBaLDg-1; Sat, 23 May 2020 13:09:15 -0400
X-MC-Unique: yo8jGxvDO4ayp8WASBaLDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0AD6835B8B;
        Sat, 23 May 2020 17:09:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57DA25EE0C;
        Sat, 23 May 2020 17:09:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 04NH9C9m018382;
        Sat, 23 May 2020 13:09:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 04NH9BXu018374;
        Sat, 23 May 2020 13:09:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 23 May 2020 13:09:11 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Maciej W. Rozycki" <macro@wdc.com>
cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4] alpha: fix memory barriers so that they conform to
 the specification
In-Reply-To: <alpine.LFD.2.21.2005231739440.21168@redsun52.ssa.fujisawa.hgst.com>
Message-ID: <alpine.LRH.2.02.2005231307470.18038@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAK8P3a1qN-cpzkcdtNhtMfSwWwxqcOYg9x6DEzt7PWazwr8V=Q@mail.gmail.com> <alpine.LRH.2.02.2005070931280.1718@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a3UdCJL6C07_W7pkipT1Xmr_0G9hOy1S+YXbB4_tKt+gg@mail.gmail.com>
 <alpine.LFD.2.21.2005100209340.487915@eddie.linux-mips.org> <alpine.LRH.2.02.2005101443290.15420@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LFD.2.21.2005111320220.677301@eddie.linux-mips.org> <20200513144128.GA16995@mail.rc.ru>
 <alpine.LRH.2.02.2005220920020.20970@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2005221344530.11126@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2005230623410.22664@file01.intranet.prod.int.rdu2.redhat.com> <20200523151027.GA10128@mail.rc.ru>
 <alpine.LRH.2.02.2005231131480.10727@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LFD.2.21.2005231739440.21168@redsun52.ssa.fujisawa.hgst.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Sat, 23 May 2020, Maciej W. Rozycki wrote:

> On Sat, 23 May 2020, Mikulas Patocka wrote:
> 
> > ... and I also broke the *_relaxed macros and didn't notice it, because 
> > they are unused in my config. This won't compile, because mb() is a 
> > statement, not a function.
> > 
> > > > +#define readb_relaxed(addr)        (mb(), __raw_readb(addr))
> 
>  A statement expression would do though, e.g.:
> 
> #define readb_relaxed(addr)	({ mb(); __raw_readb(addr); })
> 
> and might be preferable for code brevity to adding a zillion of inline 
> functions.
> 
>   Maciej

I know, but that file uses inline functions everywhere else, so I wanted 
to make it consistent.

Mikulas

