Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23497C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 25 May 2022 08:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiEYIFf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 May 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiEYIFb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 May 2022 04:05:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C007CB20
        for <linux-serial@vger.kernel.org>; Wed, 25 May 2022 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653465929; x=1685001929;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=74PHQlJUAJmv4LGXxWkI6XsDAcLt95vXGwrxVJrC0iE=;
  b=ckCdmTI13L9eCsVfT3J2wsnauWFbw32HAY03cHUuZnnIyc/R6ZwbP9Xv
   3pL+6WA0FmmktQT7HSroXID0jxr0n6B4VFQGe/fzrXl7diuG0EeyogJDE
   X5fGUM1i+mlkxU/z/fGp1D1peXE0vTHnEsj3BODd6xQskPl8FJXUmakw+
   OL9dHoaFtNpRdI9NY/inphBAd0fu08oTQseSTHqKvhoX477sE8iEEuU6V
   AFHlBdmS2U1+aQYYYZ6JcZqOgpBKSe0DedmXfd0mwEKqdVqlkku43rOWl
   M387dkgtqdZ2bXPPh+ERJn3TVl+MFYdtzo6Ac9yRtPEzmNdTE6kkIXDlf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255813583"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255813583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 01:05:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="573089431"
Received: from jeremykx-mobl2.ger.corp.intel.com ([10.249.37.64])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 01:05:25 -0700
Date:   Wed, 25 May 2022 11:05:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-imx@nxp.com, linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
In-Reply-To: <20220524192315.cs7ry4bops45yyli@pengutronix.de>
Message-ID: <251e5eb8-48f-6e4f-7256-959e86469582@linux.intel.com>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de> <20220512012910.GB37988@windriver.com> <20220512061724.4guiyqa6vcdru4iw@pengutronix.de> <20220512154621.GC37988@windriver.com> <20220512161316.5pknsjgl6lb75vva@pengutronix.de>
 <4d72e94d-f527-976d-c1b7-2258bf14437@linux.intel.com> <20220524192315.cs7ry4bops45yyli@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-686857401-1653465928=:1599"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-686857401-1653465928=:1599
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 24 May 2022, Uwe Kleine-König wrote:

> On Tue, May 24, 2022 at 07:01:18PM +0300, Ilpo Järvinen wrote:
> > On Thu, 12 May 2022, Uwe Kleine-König wrote:
> > 
> > > Hello Paul,
> > > 
> > > On Thu, May 12, 2022 at 11:46:21AM -0400, Paul Gortmaker wrote:
> > > > [Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 12/05/2022 (Thu 08:17) Uwe Kleine-König wrote:
> > > > > On Wed, May 11, 2022 at 09:29:10PM -0400, Paul Gortmaker wrote:
> > > > > > [[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 11/05/2022 (Wed 11:32) Uwe Kleine-König wrote:
> > > > > > 
> > > > > > > Some Freescale 8250 implementations have the problem that a single long
> > > > > > > break results in one irq per character frame time. The code in
> > > > > > > fsl8250_handle_irq() that is supposed to handle that uses the BI bit in
> > > > > > > lsr_saved_flags to detect such a situation and then skip the second
> > > > > > > received character. However it also stores other error bits and so after
> > > > > > > a single frame error the character received in the next irq handling is
> > > > > > > passed to the upper layer with a frame error, too.
> > > > > > > 
> > > > > > > To weaken this problem restrict saving LSR to only the BI bit.
> > > > > > 
> > > > > > But what is missing is just what "this problem" is - what applications
> > > > > > are broken and how?  What are the symptoms?  This is a 15+ year old
> > > > > > platform and so one has to ask why this is just being seen now.
> > > > > 
> > > > > The problem is "However it also stores other error bits and so after a
> > > > > single frame error the character received in the next irq handling is
> > > > > passed to the upper layer with a frame error, too." which is just the
> > > > > sentence before. I hoped this would be understandable :-\
> > > > 
> > > > I was trying to get you to describe symptoms at a higher level - as I
> > > > said above, at the application level - what were you using that wasn't
> > > > working that led you down the path to investigate this?   Transfering
> > > > data wasn't reaching the expected max for baud rate, or serial console
> > > > was showing lags and dropped characters, or ...?
> > > 
> > > The situation where the problem was noticed is: The 8313 is supposed to
> > > periodically receive a burst of a small (and fixed) number of
> > > characters. In the field it sometimes happend that there was a peak on
> > > the data line between two such telegrams which the UART interpreted as a
> > > character with a parity error. After that the first character of the
> > > next telegram wasn't received in userspace, because the driver claimed
> > > it was received with another parity error. So effectively a dropped
> > > character.
> > > 
> > > > The false positive error bits description is fine, but it isn't
> > > > something that a person in the future could read and then say "Oh I'm
> > > > having the same problem - I should backport that!"
> > > > 
> > > > > > > Note however that the handling is still broken:
> > > > > > > 
> > > > > > >  - lsr_saved_flags is updated using orig_lsr which is the LSR content
> > > > > > >    for the first received char, but there might be more in the FIFO, so
> > > > > > >    a character is thrown away that is received later and not necessarily
> > > > > > >    the one following the break.
> > > > > > >  - The doubled break might be the 2nd and 3rd char in the FIFO, so the
> > > > > > >    workaround doesn't catch these, because serial8250_rx_chars() doesn't
> > > > > > >    handle the workaround.
> > > > > > >  - lsr_saved_flags might have set UART_LSR_BI at the entry of
> > > > > > >    fsl8250_handle_irq() which doesn't originate from
> > > > > > >    fsl8250_handle_irq()'s "up->lsr_saved_flags |= orig_lsr &
> > > > > > >    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
> > > > > > >  - For a long or a short break this isn't about two characters, but more
> > > > > > >    or only a single one.
> > > > > > 
> > > > > > I've long since flushed the context required to parse the above, sorry.
> > > > > > But the part where it says "is still broken" stands out to me.
> > > > > 
> > > > > The current state is (assuming the errata is accurate and I understood
> > > > > it correctly): 
> > > > >  - You get a problem for sure if there is a frame error (because the
> > > > >    next good char is thrown away).
> > > > >  - You get a problem for sure if there is a parity error (because the
> > > > >    next good char is thrown away).
> > > > >  - You get a problem for sure if there was an overflow (because the
> > > > >    first good char after the overflow is thrown away).
> > > > >  - The code is racy for break handling. In some unlikely cases the break
> > > > >    workaround is applied wrongly.
> > > > > 
> > > > > (Where "thrown away" is really: passed to the tty layer with an error
> > > > > indication, which depending on tty settings results in dropping the
> > > > > character or passing it on to userspace.)
> > > > > 
> > > > > My patch only fixes the first three issues. A part of the reason for the
> > > > > uncomplete fix is that I don't have a platform that requires the workaround.
> > > > > (I thought I had, but it doesn't show the described behaviour and
> > > > > instead behaves nicely, i.e. one irq per break and no stray bits are
> > > > > set.)
> > > > 
> > > > I was hoping that with the full description of the issue from 12+ years
> > > > ago that you'd be able to reproduce it on your platform with the WAR disabled.
> > > > I take it that you tried and SysRQ still worked fine?
> > > 
> > > I think I did. I have to plan a bit of continous time to reverify.
> > > 
> > > > I also found a copy of an earlier proposed fix from 2010 on patchworks:
> > > > http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20100301212324.GA1738@windriver.com/
> > > > 
> > > > Maybe there are some additional details in there of interest?
> > > > 
> > > > I wonder if some other intervening change in that wide time span happens
> > > > to mask the issue?  Who knows.  I'm not sure if you are that interested;
> > > > enough to go try an old kernel to find out...
> > > > 
> > > > > That the patch I did is correct is quite obvious for me. Currently the
> > > > > fsl8250_handle_irq() function sets the bits BI, OE, FE and PE in
> > > > 
> > > > If I recall correctly, it just clears BI - are you sure it sets bits?
> > > 
> > > Not explicitly, but it does
> > > 
> > > 	orig_lsr = up->port.serial_in(&up->port, UART_LSR);
> > > 	...
> > > 	up->lsr_saved_flags = orig_lsr;
> > > 
> > > So whatever error bit is read on function entry is reused for the first
> > > char in the next irq run.
> > 
> > Yes, it is clearly leaking extra flags (if those are set) both in the case 
> > of break workaround and without it.
> > 
> > > > > lsr_saved_flags, but only evaluates BI for the workaround. The commit
> > > > > that introduced that only talks about BI, the mentioned erratum also
> > > > > only mentions BI.
> > > > > 
> > > > > I can try to make the commit log more convincing. Or if the ability to
> > > > > test this code on an affected platform is declared a requirement, I will
> > > > 
> > > > I'm not in any position to declare any requirements - just that when you
> > > > are bit-bashing to work around some "black box" silicon errata, any
> > > > changes might impact whether the WAR is still working or not.
> > 
> > C code is not "some black box". On the next irq, only BI in 
> > lsr_saved_flags is looked at by the driver, that can be seen from the C 
> > code, no need to look at the errata.
> > 
> > And then the C code also tells on the next next irq, the other bits (if 
> > any were set) are taken into use for a real character, which is 
> > undesirable (= BUG!).
> > 
> > > > Your change alters lsr_saved_flags for *every* event, even when no breaks
> > > > or workarounds have been in play.  I'm not sure what that might trigger.
> > 
> > Indeed, fixing a bug alters behavior such that the bug no longer occurs :-).
> > 
> > Or are you saying that leaking old FE, PE and OE into the next char 
> > using lsr_saved_flags when no break nor workaround isn't in the play
> > is an event that should _not_ be altered???
> > 
> > If no extra flags are set, the proposed change is no-op.
> > 
> > Maybe Uwe's fix could be scoped down to clear only FE, PE and OE if one 
> > really wants to make a minimal fix? That would leave (mainly) DR out of it 
> > which could impact the behavior a little (the difference seems a bit 
> > theoretic to me but it is there)?
> 
> Is this an Ack for my patch?

It wasn't but now that I took a further look into it I've managed to 
prove myself that there are no changes at all in the _interactions with 
the device_ so Paul's concerns on making subtle changes are not valid!
The reason is as follows:

1) If BI is not set in lsr_saved_flags, the old lsr_saved_flags is 
recalled no earlier than in serial8250_read_char() at the point where the 
code is already past the only serial_in() there.

2) If BI is set in lsr_saved_flags, fsl8250_handle_irq() first clears BI 
and returns due to the workaround. On the next next irq, the old 
lsr_saved_flags is again not recalled before past the only serial_in() 
serial8250_read_char().

3) If execution does not even enter serial8250_read_char(), the old 
lsr_saved_flags value is not used at all and lsr_saved_flags is 
overwritten.

serial8250_read_char() only does bookkeeping and higher-layer stuff with 
the bits from lsr_saved_flags which does not impact how the kernel 
interacts with the device! 

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-686857401-1653465928=:1599--
