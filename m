Return-Path: <SRS0=TiTh=7F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C9C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924F92073B
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByNJxVs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgEWULZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 May 2020 16:11:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29664 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387593AbgEWULY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 May 2020 16:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590264681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qnRCIXxHF6BhP+2IkXpbnLjh8zaRORpqHMG3dWu3u0=;
        b=ByNJxVs+ouT9Q/bKWB6ic3HxU0K3R7Hm7ODj7uUGvDZJ1xZkU1GsOf7JlCsBoaAOcVrEo7
        vzvFOQL+W7PYCJpRVS3a/jsaXyxuPi70/upnRYngjDTUqQQ6dYfxNYwBSkQ9NwNB3ITjuY
        +onihjEuUkyCRrnE5fpKXlKAFTpfaMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-6Hs4ARt5NaWnaAgew9bW4g-1; Sat, 23 May 2020 16:11:19 -0400
X-MC-Unique: 6Hs4ARt5NaWnaAgew9bW4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 232AA1009441;
        Sat, 23 May 2020 20:11:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C519C19C71;
        Sat, 23 May 2020 20:11:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 04NKBBKb030518;
        Sat, 23 May 2020 16:11:11 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 04NKB9fs030510;
        Sat, 23 May 2020 16:11:09 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 23 May 2020 16:11:09 -0400 (EDT)
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
In-Reply-To: <alpine.LFD.2.21.2005232024500.21168@redsun52.ssa.fujisawa.hgst.com>
Message-ID: <alpine.LRH.2.02.2005231610360.30482@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAK8P3a1qN-cpzkcdtNhtMfSwWwxqcOYg9x6DEzt7PWazwr8V=Q@mail.gmail.com> <CAK8P3a3UdCJL6C07_W7pkipT1Xmr_0G9hOy1S+YXbB4_tKt+gg@mail.gmail.com> <alpine.LFD.2.21.2005100209340.487915@eddie.linux-mips.org> <alpine.LRH.2.02.2005101443290.15420@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LFD.2.21.2005111320220.677301@eddie.linux-mips.org> <20200513144128.GA16995@mail.rc.ru> <alpine.LRH.2.02.2005220920020.20970@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2005221344530.11126@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2005230623410.22664@file01.intranet.prod.int.rdu2.redhat.com> <20200523151027.GA10128@mail.rc.ru> <alpine.LRH.2.02.2005231131480.10727@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LFD.2.21.2005231739440.21168@redsun52.ssa.fujisawa.hgst.com>
 <alpine.LRH.2.02.2005231307470.18038@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LFD.2.21.2005232024500.21168@redsun52.ssa.fujisawa.hgst.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Sat, 23 May 2020, Maciej W. Rozycki wrote:

> On Sat, 23 May 2020, Mikulas Patocka wrote:
> 
> > >  A statement expression would do though, e.g.:
> > > 
> > > #define readb_relaxed(addr)	({ mb(); __raw_readb(addr); })
> > > 
> > > and might be preferable for code brevity to adding a zillion of inline 
> > > functions.
> > > 
> > >   Maciej
> > 
> > I know, but that file uses inline functions everywhere else, so I wanted 
> > to make it consistent.
> 
>  Fair enough, fine with me.  I still can't access my Alpha system, have 
> you verified your latest version at run time?
> 
>   Maciej

Yes - it runs without any hang.

Mikulas

