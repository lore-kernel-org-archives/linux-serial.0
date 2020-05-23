Return-Path: <SRS0=TiTh=7F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE5C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 10:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A5A20727
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 10:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRWjkFwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgEWKhk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 May 2020 06:37:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgEWKhj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 May 2020 06:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590230258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1yG5ML8gU+AF44yjVtH1IXuLR9xKXu55v9jMt9VYuY=;
        b=PRWjkFwRiUsO5Qu760GvQN7EHWZekco1f3VQECgaKOhhTxDDt/nDqgY6rD4XdnW//az5Ff
        ThdRP8RsZLV4m8k8ogr2jMqmO5zjAJ428Jeg8hnbRTlTS8neFHrah5r2bul1skMwOrZdqH
        mTmqnfUbRJ+v5uk8Y+CZruUH2u0u+Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-x7ZyebtKPveyegm-kpB0bw-1; Sat, 23 May 2020 06:37:34 -0400
X-MC-Unique: x7ZyebtKPveyegm-kpB0bw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DCB800D24;
        Sat, 23 May 2020 10:37:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6195C1D2;
        Sat, 23 May 2020 10:37:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 04NAbVES023352;
        Sat, 23 May 2020 06:37:31 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 04NAbU7q023348;
        Sat, 23 May 2020 06:37:30 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 23 May 2020 06:37:30 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2 v4] alpha: add a delay before serial port read
In-Reply-To: <alpine.LFD.2.21.2005100020530.487915@eddie.linux-mips.org>
Message-ID: <alpine.LRH.2.02.2005230628140.22664@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2005060721450.25338@file01.intranet.prod.int.rdu2.redhat.com> <20200506114711.GB3024358@kroah.com> <alpine.LRH.2.02.2005061122440.16395@file01.intranet.prod.int.rdu2.redhat.com> <20200506154938.GA3537174@kroah.com>
 <alpine.LRH.2.02.2005061152300.16395@file01.intranet.prod.int.rdu2.redhat.com> <20200506160823.GA3559699@kroah.com> <alpine.LRH.2.02.2005061245500.18599@file01.intranet.prod.int.rdu2.redhat.com> <20200506174528.GB3711921@kroah.com>
 <alpine.LRH.2.02.2005070407010.5006@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LFD.2.21.2005100020530.487915@eddie.linux-mips.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Sun, 10 May 2020, Maciej W. Rozycki wrote:

> On Thu, 7 May 2020, Mikulas Patocka wrote:
> 
> > > > I've created this patch that adds a global macro/variable 
> > > > serial_port_needs_delay. I've also deleted UPQ_DELAY_BEFORE_READ and test 
> > > > serial_port_needs_delay directly in io_serial_in, so that the compiler 
> > > > will optimize it out on non-alpha architectures.
> > > 
> > > That's not good, what about systems with hundreds of serial ports?
> > 
> > I doubt that someone will conect hundreds of serial ports to such an old 
> > alpha machine :)
> 
> It would be good if PCI serial ports (on add-on cards) were unaffected.

After reading the Alpha specification, I am convinced that the issue is 
not timing, but reordering or merging of accesses to the MMIO space.

So, we need a barrier before a write (mandated by memory-barriers.txt), 
after a read (mandated by memory-barriers.txt) and between write and read 
(mandated by the alpha spec).

The performance of serial ports could be improved if we changed it to use 
read_relaxed and write_relaxed (the serial port never does DMA, so we 
don't have to deal with DMA ordering).

Mikulas

