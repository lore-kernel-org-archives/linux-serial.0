From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [REPOST-v2] sched: Prevent wakeup to enter critical section
 needlessly
Date: Wed, 21 Nov 2012 13:47:47 +0000
Message-ID: <20121121134747.261c426a@pyramind.ukuu.org.uk>
References: <1351159974-980-1-git-send-email-meltedpianoman@gmail.com>
	<1353310211-3011-1-git-send-email-meltedpianoman@gmail.com>
	<20121119151050.GA4270@redhat.com>
	<CAMSQXEF9BGBVRRtuz88XFqVmPBdbWisepq4qjah3vM05_7hztw@mail.gmail.com>
	<20121119154940.GA6354@redhat.com>
	<CAMSQXEGfQE_vcvk9MvP-aJD2jeF7vU+84yx_fEn==v2Jve9w0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34355 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab2KUNm6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 08:42:58 -0500
In-Reply-To: <CAMSQXEGfQE_vcvk9MvP-aJD2jeF7vU+84yx_fEn==v2Jve9w0A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>

> But we try to understand your fault scenario: How can the LOAD leak
> into the critical section? As far as we understand the spin_unlock()
> function also contains a memory barrier to prevent such a reordering
> from happening.

It does - it would be very interesting for someone to look at the assembly
if this is making a difference.

Alan
