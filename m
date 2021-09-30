Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740DAC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A50261A3B
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbhI3PZm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:25:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:55863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343577AbhI3PZl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 11:25:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="223323356"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="223323356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:23:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="555816408"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:23:57 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mVxub-007Bh5-Jg;
        Thu, 30 Sep 2021 18:23:53 +0300
Date:   Thu, 30 Sep 2021 18:23:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
Message-ID: <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
References: <20210930124950.3069638-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930124950.3069638-1-daniel@0x0f.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 30, 2021 at 09:49:50PM +0900, Daniel Palmer wrote:
> When building kernels without ACPI support the table is declared
> but is not used because ACPI_PTR() turns it into a NULL.

Okay.

> Add the __maybe_unused attribute to stop the compiler whining.

And incorrect fix. See my patches regarding to the topic
(`git log --grep ACPI_PTR`) and do accordingly, i.e. drop
ACPI_PTR() for good.

-- 
With Best Regards,
Andy Shevchenko


