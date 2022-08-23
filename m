Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C690C32772
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 08:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiHWIsc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbiHWIrg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 04:47:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9587C184
        for <linux-serial@vger.kernel.org>; Tue, 23 Aug 2022 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661242907; x=1692778907;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MylI7XOBn/b5O/7vdOnXg859J9QFJyAdC86rcBlOZsw=;
  b=RvVFiD121Ti90HqFDfUX8snXdl/7ad5caF8JrETPQgIbs1L9ainwTkbe
   ZhVOw9Kp++HTK4aunmDnUt05jHGFTsyuIoMXcih1SATjb9LYJGqCIRuxk
   Ha5ftvQte4g46fB79dQnmgbEqrUMJAExI7r2MTz8c/iRyfDLS6U2cC01w
   UhWkQrsuT/rGZWEHOclBuTcy8pxUwOofw3kTWJMqggivH98/WjV6uQ9gN
   iXTIEOTJLs6SYvW/tQ5Mg9YmJscrGgu5LYfk74+peTaVp9aTSoZMUVPnL
   /qRuddI1b0GfmbkNWGuxlAk2SMPayERoi5ejwycckp6QLt0XuSeqdPvOP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="274010458"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="274010458"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:19:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638556695"
Received: from kimtingt-mobl.gar.corp.intel.com ([10.252.42.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:19:10 -0700
Date:   Tue, 23 Aug 2022 11:19:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/8] tty/serial: Convert ->set_termios() related callchains
 to const old ktermios
In-Reply-To: <alpine.DEB.2.21.2208202144450.36368@angie.orcam.me.uk>
Message-ID: <14ce34f-d67-b0ec-753c-8285e85cc473@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com> <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com> <6368fa4b-4232-9e2c-24e3-70115af88d2e@linux.intel.com> <alpine.DEB.2.21.2208202144450.36368@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1735757789-1661242752=:1608"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1735757789-1661242752=:1608
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 20 Aug 2022, Maciej W. Rozycki wrote:

> On Thu, 18 Aug 2022, Ilpo Järvinen wrote:
> 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > for all, but patch 3.
> > > 
> > > I'm not sure we can blindly use old_termios settings, is there any
> > > guarantee that old_termios _always_ has a correct baud rate settings?
> > 
> > Old_termios is just the previous termios the port was using. If the 
> > baudrate in termios was invalid already by then, it's another issue that 
> > should be fixed (but I cannot see how that could occur assuming the 
> > validation works).
> > 
> > How could it get wrong baud rate settings if the kernel sets (old_)termios 
> > (earlier) through these same paths (which validated it)?
> 
>  If the old baud rate in termios was invalid, then we would just resort to 
> 9600 baud, so I wouldn't be concerned here as we need to set the baud rate 
> to something anyway.

I still assert that old baud rate should never be "invalid". When it was 
set (earlier) through dz_set_termios(), it got validated and invalid 
ones were corrected. I think a valid baud rate in tty->termios is an 
invariant we just maintain on each call to dz_set_termios().

> My only concern is whether `tty_termios_baud_rate' 
> can ever return 0 for `old_termios', which would of course never happen 
> with `uart_get_baud_rate'.

dz_encode_baud_rate() disallows 0 as baud rate. I don't understand what 
you're trying to say here.

> But new code seems to me to be doing the right thing anyway.  That is if 
> we're getting out of a hangup (which we don't currently handle with the 
> modem lines anyway, but that's quite a different and complex matter) with 
> an invalid baud rate, then we'll fail to encode it, then fail to encode 0, 
> and finally resort to 9600 baud and write it back to `termios'.  So we'll 
> get out of a hangup with a baud rate different to one requested, but that 
> is as much as we can do in that case: we have fulfilled the request the 
> best we could and `uart_get_baud_rate' would set the rate to 9600 baud 
> anyway.

This I kind of agree with but given the precondition where 0 baud rate is 
always rejected by dz_encode_baud_rate(), I don't think this scenario can 
materialize at all?

>  Given the observation above I have acked your patch.  Perhaps you could 
> put some of the analysis above into the change description.
> 
>   Maciej
> 

-- 
 i.

--8323329-1735757789-1661242752=:1608--
