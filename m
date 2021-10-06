Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBECEC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B60610CC
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 16:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhJFQIS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:08:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:28648 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhJFQIP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 12:08:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226340677"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226340677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:01:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439942003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:01:51 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY9Ma-009FT7-5E;
        Wed, 06 Oct 2021 19:01:48 +0300
Date:   Wed, 6 Oct 2021 19:01:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
Message-ID: <YV3IbKBrK0C7GtG0@smile.fi.intel.com>
References: <20210930124950.3069638-1-daniel@0x0f.com>
 <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
 <YVYmTL8WsgYnxPwc@smile.fi.intel.com>
 <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
 <YVxBphzSDG2VmM4I@smile.fi.intel.com>
 <CAFr9PXkN-6MAExF-P8-Biej2yoQYB6eQDezwfPRX4bcXaayZfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkN-6MAExF-P8-Biej2yoQYB6eQDezwfPRX4bcXaayZfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 05, 2021 at 09:41:33PM +0900, Daniel Palmer wrote:
> On Tue, 5 Oct 2021 at 21:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > > For what it's worth I think the OF ids are a bit wasteful.
> >
> > Exactly my point, but fixing one driver of zillions does not solve the issue
> > in general.
> 
> I looked into making OF ids smaller globally. There seems to be 64
> bytes wasted from the start for the name and type fields as nothing
> uses them as far as I can tell.
> Then you have the array for the compatible string which is currently
> 128 bytes but the longest compatible string in the kernel is less than
> 64 from what I can tell.
> I understand that it's for future proofing etc. Adding a few hacks to
> my kernel to remove the unused fields and reduce the size of the
> compatible string saved a few tens of K.
> Which isn't a lot but might be the difference between the kernel
> fitting in a tiny SPI NOR partition or not.

What can you try is to somehow cut the sections during linking phase
if you know, that OF=n, or ACPI=n. Not sure how it would work, because
basically we will need to replace them with stubs to prevent drivers
from crashing. Nevertheless, One terminator entry is much better than
full bloated ID table(s)!

...

> Anyhow, thankyou for the interesting discussion. I'll just leave this
> in my tree for now so I don't have to see the warning.

You're welcome!

FWIW, I have sent my version of the patch, you are in Cc list there,
can you test and confirm that warning is gone for you?

-- 
With Best Regards,
Andy Shevchenko


