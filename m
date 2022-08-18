Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD42C00140
	for <linux-serial@archiver.kernel.org>; Thu, 18 Aug 2022 10:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiHRKA2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiHRKA1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Aug 2022 06:00:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD506AA1B
        for <linux-serial@vger.kernel.org>; Thu, 18 Aug 2022 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660816826; x=1692352826;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TA7Q7UrZ6sDgkSOxC3BB5iNdD1bXVxpUauvm1SEW2E0=;
  b=MbJpmW6N6FZWSdvWPH2GVkWpmb0aPbRh9WJBaJUDMFBctIBPvs7GapnM
   clVfHnmxC3VxdtaupZWlkKsfK1IKmbnKjG8lCW0p5MauRT5lDoonTqd4x
   VOn58RO+cxfqsTzQHJ+xk4G7B/tplyVZ4zD3/HGUhOwEvHDZNnRWMopcV
   7/z9EkhAAIGLD0OIzE6pBDR8bNI8CfvBp8VXHfmzhxVuxOM2nYA/yMKhk
   PlhbgR1F4E52i3r+CdOq/2VTi1YgHO0LA8GPfEBu1hV2xHmjP3jcv3XyN
   Ee/2X7W1dw7rip5oHMOpj7oJ2NAjfhHyD0iRwa7/9ICTP3qY68kX5nVVf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="291473483"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="291473483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:00:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668038108"
Received: from dursu-mobl1.ger.corp.intel.com ([10.249.42.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:00:24 -0700
Date:   Thu, 18 Aug 2022 13:00:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/8] tty/serial: Convert ->set_termios() related callchains
 to const old ktermios
In-Reply-To: <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com>
Message-ID: <6368fa4b-4232-9e2c-24e3-70115af88d2e@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com> <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1720101563-1660816826=:1604"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1720101563-1660816826=:1604
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 18 Aug 2022, Andy Shevchenko wrote:

> On Tue, Aug 16, 2022 at 3:11 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > ->set_termios() callchains input old ktermios (mainly used as fallback
> > and feature compares). It is discarded right after returning from the
> > calls and should therefore not be modified by drivers because any such
> > change will get lost (instead, the changes must be applied to the new
> > ktermios). While doing this patchset, I found a few such issues that
> > were fixed earlier.
> >
> > Now enforce old ktermios constness. Another goodie is that "get" named
> > functions in tty_baudrate.c that previously mucked with the old
> > ktermios can no longer have such side-effects. I found out that the
> > ktermios adjustments made were dead-code for all in-tree archs anyway.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for all, but patch 3.
> 
> I'm not sure we can blindly use old_termios settings, is there any
> guarantee that old_termios _always_ has a correct baud rate settings?

Old_termios is just the previous termios the port was using. If the 
baudrate in termios was invalid already by then, it's another issue that 
should be fixed (but I cannot see how that could occur assuming the 
validation works).

How could it get wrong baud rate settings if the kernel sets (old_)termios 
(earlier) through these same paths (which validated it)?


-- 
 i.

--8323329-1720101563-1660816826=:1604--
