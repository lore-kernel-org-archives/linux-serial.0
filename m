Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE865C4320A
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A800D61002
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 12:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhHDMHg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:07:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:30393 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236857AbhHDMHf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 08:07:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213889133"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="213889133"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 05:07:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="467087460"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 05:07:19 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mBFg0-0056Cy-3X; Wed, 04 Aug 2021 15:07:12 +0300
Date:   Wed, 4 Aug 2021 15:07:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/5] serdev: Split and export
 serdev_acpi_get_uart_resource()
Message-ID: <YQqC8JOfH6BqTpW6@smile.fi.intel.com>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
 <035d2579-f64c-b5c2-45ff-4421ad7db6ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <035d2579-f64c-b5c2-45ff-4421ad7db6ca@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 04, 2021 at 10:08:01AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> > The same as for I²C Serial Bus resource split and export
> > serdev_acpi_get_uart_resource(). We have already 3 users
> > one of which is converted here.
> > 
> > Rationale of this is to consolidate parsing UART Serial Bus
> > resource in one place as it's done, e.g., for I²C Serial Bus.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> *for this patch*
> 
> We do need to talk about how to merge this series, I've
> NACK-ed patches 3/5 and 4/5 (see my reply there) so that
> leaves just 2/5  as depending on this one. I believe it
> would be easiest to just merge 1/5 + 2/5 to the tree
> which caries serdev patches, which I guess is Greg's
> tty tree ?

I can resend a v2 with tags and dropped mentioned patches.
I think it will be easier to everyone to handle.

-- 
With Best Regards,
Andy Shevchenko


