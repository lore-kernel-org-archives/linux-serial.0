Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33452C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139CF61186
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhJEMQ3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:16:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:18523 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233808AbhJEMQ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 08:16:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205845392"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="205845392"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:14:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="589333436"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:14:33 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXjL4-008sJh-A2;
        Tue, 05 Oct 2021 15:14:30 +0300
Date:   Tue, 5 Oct 2021 15:14:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
Message-ID: <YVxBphzSDG2VmM4I@smile.fi.intel.com>
References: <20210930124950.3069638-1-daniel@0x0f.com>
 <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
 <YVYmTL8WsgYnxPwc@smile.fi.intel.com>
 <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 09:16:24AM +0900, Daniel Palmer wrote:
> On Fri, 1 Oct 2021 at 06:04, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > Doesn't this mean the ACPI table ends up in kernels that will never use ACPI?
> >
> > Yes. Is it a problem (*)? If so, you need to use ifdeffery, since __maybe_unused is
> > not for the ID tables.
> 
> Ok, is there a reason it's not for the ID tables? Does it break something?

It will look ugly. Why we define a table that may or may not be used?
Sounds fishy.

On top of that why you should tell linker to waste resources on something
that you may well know beforehand will be thrown away?

> > *) while justifying this you also need to show why it's a problem specific
> > to the ACPI IDs and not a problem for OF ones, which we have tons of in the
> > Linux kernel without any guards (ifdeffery).
> 
> To be honest I don't care about this too much. I just wanted to cut
> down some of the noise when I build my patch backlog so that warnings
> in the stuff I'm trying to mainline are more visible.

Which is good intention and thanks for doing this!

> For what it's worth I think the OF ids are a bit wasteful.

Exactly my point, but fixing one driver of zillions does not solve the issue
in general.

> For some
> drivers where there are tons of broken variations they add a few K of
> unneeded data. But since everyone now has gigabytes of memory I doubt
> they care...

Some actually cares.

> I'm working with 64MB. :)

Then I would imagine that you already using as less kernel configuration as
possible and have as many modules as you want for the hardware that might
appear to be connected to that board, right? Then again one driver with 100+
bytes doesn't affect really your case. Disabling, for example PRINTK, will
win much more for you.

-- 
With Best Regards,
Andy Shevchenko


