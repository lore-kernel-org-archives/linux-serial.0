Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098717C20F
	for <linux-serial@vger.kernel.org>; Thu, 14 Nov 2024 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731555659; cv=none; b=UPaJuyXAyX1C5UN/cCJJI4W9LoLo7lynecvSgihtz+Nm0bBDrsVTM6QDtAkFy0+tnfntETqkXyR8Gozi29jwilsk/ROWIoMi0JZlMeiWF/QrZ8wmZIDEzXFTij4S9FbQJCQx/jGbmF3PlQSArmIZvtDXeTIpnqofSoNrrbOA1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731555659; c=relaxed/simple;
	bh=Vg10oOdypvN4V+wRFHVWNeaIJ8VpdXzuZfYHdcEl1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=WfNsbMxpcRINan4S/CFmNDkaErlggh6OcG8rFhzW6UxVB9wD0G8A1KClFw/WQGZq/9EFRXgsA0njfcOVCEy6Cg16VsclCjpxkWXWwrkok3p6iodsYEJ4OfmGHvWNdxsaTLXxgZAU1GKsPexl+UgpB7KdgfqMXJygyDyi4Cz5cDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI5tcTP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI5tcTP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731555656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhylS66R5SeTqdFfYXNl+PmcWaIw9xImV9c1LIXspqw=;
	b=KI5tcTP2bhgXIYKJKJzGNOYH5A1WEuPWDQCZbmMnBd49ZC+Z8cBTnA6MGbwTP0zfW6rS8o
	4T+I9n1HZgQHAB8qnypcyD4K8aa0hfKP6k8ZNVaZQRZmkELHZK7Lo+Bq7gbUhWwSmcev2W
	HjTA88J2pjJiKKwDiJHAk/Qrn9aZPXc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-mMhmwoLROueqIqZkBzwRIw-1; Wed, 13 Nov 2024 22:40:55 -0500
X-MC-Unique: mMhmwoLROueqIqZkBzwRIw-1
X-Mimecast-MFC-AGG-ID: mMhmwoLROueqIqZkBzwRIw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ea086ba1d5so96984a91.0
        for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 19:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731555654; x=1732160454;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhylS66R5SeTqdFfYXNl+PmcWaIw9xImV9c1LIXspqw=;
        b=oPBxAdlomy68NWqg+zA7sVzcj6np6S6BdIyG71FCo5r04P0qx5Xmq1Q5dzILpz/z1C
         zKdxR2jsxRxZ0vbJ59UV+0H8riPJ238erpP9D7fn54Y3tnL89lCaLDFubUDszX4YG2p9
         rAts7Bkw9S4E3u/Sv556GZZyctPwG5DN7hY4NxWyKZueoxffHtAQUPMGOkHkyHXpdzVi
         ttaLSGfAYAw0kx7awLEZCsUzAAjqucetyeNG8Z25ifonFFdOZIJVwiLXAzXUu9nPGWyx
         huylyPK1PHFtatilE1ggdUNAiXwRBKNEwy4jlXBbfELDVYO1G685PNmG5fzNiUVNOG+t
         uiZA==
X-Forwarded-Encrypted: i=1; AJvYcCVJrl6Dbby0L3j0ImEepBXpR/NLqFxtfjqVN/tRutt1lTf+/vryJwK4RlVd4jaoTCDaOtFZjt9qbgeEe/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4y3s1klOhSyWCFntJu1qc9t5ORBtk+QivlEp7X7OQJtyy8RI9
	uX4X0aMZf6Zm7n3peBzilIG/EOeYfIEZJ8kbxxwKeaVaE0tpjZgILOM+nMaJAV/+Rdy7CfBrQ17
	zl4g90atlfnoNULPp7AWW+V9EBBNH3oCK5QIoC2qcffGSp+dWF+GiFHtMhAGTMg==
X-Received: by 2002:a17:90b:3b46:b0:2e2:bfba:18d4 with SMTP id 98e67ed59e1d1-2ea0631c431mr867610a91.17.1731555654078;
        Wed, 13 Nov 2024 19:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuy0lvBxyNEX8ED5RzXl//BEkgfKwu+oOaMhnTsC5oaEZoBZu6gsrxeguWvT2RAlmVvuruBQ==
X-Received: by 2002:a17:90b:3b46:b0:2e2:bfba:18d4 with SMTP id 98e67ed59e1d1-2ea0631c431mr867589a91.17.1731555653640;
        Wed, 13 Nov 2024 19:40:53 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:71b8:6b20:9a29:9f06:b676])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06ef6da7sm193140a91.3.2024.11.13.19.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 19:40:52 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Thu, 14 Nov 2024 00:40:17 -0300
Message-ID: <ZzVxIfb5KpL97P4Q@LeoBras>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ZdghE6TNHgZ_bi19@LeoBras>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx> <ZdghE6TNHgZ_bi19@LeoBras>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YvFh-z-NdvP86d9EA3mVHAXdHoJ35GWoGljfRhPt0hw_1731555654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 23, 2024 at 01:37:39AM -0300, Leonardo Bras wrote:
> On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
> > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > > On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> > >> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> > >> >> it back to IRQ_HANDLED.
> > >> >
> > >> > That's not really workable as you'd have to update tons of drivers just
> > >> > to deal with that corner case. That's error prone and just extra
> > >> > complexity all over the place.
> > >
> > > I agree, that's a downside of this implementation. 
> > 
> > A serious one which is not really workable. See below.
> > 
> > > I agree the above may be able to solve the issue, but it would make 2 extra 
> > > atomic ops necessary in the thread handling the IRQ, as well as one extra 
> > > atomic operation in note_interrupt(), which could increase latency on this 
> > > IRQ deferring the handler to a thread.
> > >
> > > I mean, yes, the cpu running note_interrupt() would probably already have 
> > > exclusiveness for this cacheline, but it further increases cacheline 
> > > bouncing and also adds the mem barriers that incur on atomic operations, 
> > > even if we use an extra bit from threads_handled instead of allocate a new 
> > > field for threads_running.
> > 
> > I think that's a strawman. Atomic operations can of course be more
> > expensive than non-atomic ones, but they only start to make a difference
> > when the cache line is contended. That's not the case here for the
> > normal operations.
> > 
> > Interrupts and their threads are strictly targeted to a single CPU and
> > the cache line is already hot and had to be made exclusive because of
> > other write operations to it.
> > 
> > There is usually no concurrency at all, except for administrative
> > operations like enable/disable or affinity changes. Those administrative
> > operations are not high frequency and the resulting cache line bouncing
> > is unavoidable even without that change. But does it matter in the
> > larger picture? I don't think so.
> 
> That's a fair point, but there are some use cases that use CPU Isolation on 
> top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
> workload.
> 
> For those cases, IIRC the handler will run on a different (housekeeping) 
> CPU when those IRQs originate on an Isolated CPU, meaning the above 
> described cacheline bouncing is expected.
> 
> 
> > 
> > > On top of that, let's think on a scenario where the threaded handler will 
> > > solve a lot of requests, but not necessarily spend a lot of time doing so.
> > > This allows the thread to run for little time while solving a lot of 
> > > requests.
> > >
> > > In this scenario, note_interrupt() could return without incrementing 
> > > irqs_unhandled for those IRQ that happen while the brief thread is running, 
> > > but every other IRQ would cause note_interrupt() to increase 
> > > irqs_unhandled, which would cause the bug to still reproduce.
> > 
> > In theory yes. Does it happen in practice?
> > 
> > But that exposes a flaw in the actual detection code. The code is
> > unconditionally accumulating if there is an unhandled interrupt within
> > 100ms after the last unhandled one. IOW, if there is a periodic
> > unhandled one every 50ms, the interrupt will be shut down after 100000 *
> > 50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
> > actually handled interrupts.
> > 
> > The spurious detector is really about runaway interrupts which hog a CPU
> > completely, but the above is not what we want to protect against.
> 
> Now it makes a lot more sense to me.
> Thanks!

Hi Thomas,

I would like to go back to this discussion :)
From what I could understand, and read back the thread:

- The spurious detector is used to avoid cpu hog when a lots of IRQs are 
  hitting a cpu, but few ( < 100 / 100k) are being handled. It works by
  disabling that interruption.

- The bug I am dealing with (on serial8250), happens to fit exactly at
  above case: lots of requests, but few are handled.
  The reason: threaded handler, many requests, and they are dealt with in 
  batch: multiple requests are handled at once, but a single IRQ_HANDLED 
  returned.

- My proposed solution: Find a way of accounting the requests handled.

  - Implementation: add an option for drivers voluntarily report how 
    many requests they handled. Current drivers need no change.

  - Limitation: If this issue is found on another driver, we need to 
    implement accounting there as well. This may only happen on drivers
    which handle over 1k requests at once.


What was left for me TODO:
Think on a generic solution for this issue, to avoid dealing with that 
in a per-driver basis. 

That's what I was able to think about:

- Only the driver code knows how many requests it handled, so without  
  touching them we can't know how many requests were properly handled.

- I could try thinking a different solution, which involves changing only
  the spurious detector.

  - For that I would need to find a particular characteristic we would want 
    to avoid spurious detection against, and make sure it won't miss an
    actual case we want to be protected about.

Generic solutions(?) proposed:
- Zero irqs_unhandled if threaded & handles a single request in 100k
  - Problem: A regular issue with the interruption would not be detected 
    in the driver. 

- Skip detection if threaded & the handling thread is running
  - Problem 1: the thread may run shortly and batch handle a lot of stuff, 
  not being detected by the spurious detector. 
  - Problem 2: the thread may get stuck, not handle the IRQs and also not
  being detected by the spurious handler. (IIUC)


In the end, I could not find a proper way of telling apart
a - "this is a real spurious IRQ behavior, which needs to be disabled", and 
b - "this is just a handler that batch-handles it's requests",
without touching the drivers' code.

Do you have any suggestion on how to do that?

Thanks!
Leo

