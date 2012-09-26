From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 08/11] ARM: Move some macros from entry-armv to
 entry-header
Date: Wed, 26 Sep 2012 15:32:59 -0700
Message-ID: <20120926223258.GA5768@lizard>
References: <20120924212648.GA27605@lizard>
 <1348522080-32629-8-git-send-email-anton.vorontsov@linaro.org>
 <50637C24.90206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59538 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab2IZWfx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 18:35:53 -0400
Received: by ggnr5 with SMTP id r5so327885ggn.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 15:35:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50637C24.90206@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, linaro-kernel@lists.linaro.org, patches@linaro.org, Brian Swetland <swetland@google.com>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, John Stultz <john.stultz@linaro.org>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, kgdb-bugreport@lists.sourceforge.net, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Wed, Sep 26, 2012 at 03:05:24PM -0700, Stephen Boyd wrote:
> > Just move the macros into header file as we would want to use them for
> > KGDB FIQ entry code.
> >
> > The following macros were moved:
> >
> >  - svc_entry
> >  - usr_entry
> >  - kuser_cmpxchg_check
> >  - vector_stub
> >
> > To make kuser_cmpxchg_check actually work across different files, we
> > also have to make kuser_cmpxchg64_fixup global.
> >
> > Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> 
> Why can't we put the fiq entry code from the next patch into
> entry-armv.S? Sorry if this has been asked before but I don't see any
> reasoning in the commit text.

Thanks for taking a look!

This is a prerequisite to just logically separate KGDB FIQ code from the
entry code.

Or to put it the other way around: KGDB FIQ is just another user of the
FIQs, nothing quite special in it to put it alongside the entry code. :-)

But if Russell or other folks feel that having KGDB FIQ asm code in
entry-armv.S makes sense, I'd definitely do this.

Thanks,
Anton.
