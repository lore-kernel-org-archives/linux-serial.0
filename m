Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EE6C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 21:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F7561037
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 21:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhI3VGO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:06:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:14523 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhI3VGL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 17:06:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="224944442"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="224944442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 14:04:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="564452544"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 14:04:14 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mW3Dw-007G1g-5v;
        Fri, 01 Oct 2021 00:04:12 +0300
Date:   Fri, 1 Oct 2021 00:04:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
Message-ID: <YVYmTL8WsgYnxPwc@smile.fi.intel.com>
References: <20210930124950.3069638-1-daniel@0x0f.com>
 <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 12:31:34AM +0900, Daniel Palmer wrote:
> On Fri, 1 Oct 2021 at 00:24, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > And incorrect fix. See my patches regarding to the topic
> > (`git log --grep ACPI_PTR`) and do accordingly, i.e. drop
> > ACPI_PTR() for good.
> 
> Something like 349bff48ae0f5f8aa2075d0bdc2091a30bd634f6?
> 
> Doesn't this mean the ACPI table ends up in kernels that will never use ACPI?

Yes. Is it a problem (*)? If so, you need to use ifdeffery, since __maybe_unused is
not for the ID tables.

*) while justifying this you also need to show why it's a problem specific
to the ACPI IDs and not a problem for OF ones, which we have tons of in the
Linux kernel without any guards (ifdeffery).

-- 
With Best Regards,
Andy Shevchenko


