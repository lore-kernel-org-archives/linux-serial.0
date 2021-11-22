Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B085CC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhKVL6T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:58:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:55307 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236711AbhKVL6T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 06:58:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="221653662"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="221653662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="674040540"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:55:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mp7uc-009QHv-SA;
        Mon, 22 Nov 2021 13:55:06 +0200
Date:   Mon, 22 Nov 2021 13:55:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 0/2] serial: 8250_pci patches to address issues with
 pericom_do_set_divisor()
Message-ID: <YZuFGik6oinuTX3z@smile.fi.intel.com>
References: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
 <89c2f319-b0b9-3c64-e9f8-6c4081cdcce4@accesio.com>
 <CAHp75VcboxaNnSnt1wKvE9JefSsLtMReZkMDVEpUVOJnd_oQnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcboxaNnSnt1wKvE9JefSsLtMReZkMDVEpUVOJnd_oQnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 18, 2021 at 11:52:06AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 8:09 AM Jay Dolan <jay.dolan@accesio.com> wrote:
> > On 11/17/21 6:55 AM, Andy Shevchenko wrote:

...

> > > Jay, can you retest this, please?
> > I was able to verify that the fourth port was placed at the fixed
> > address for the card that previously had it at the wrong offset.
> > I was also able to verify all of the standard baud rates for 24 and
> > 14.7456 MHz crystals from 50 to their respective uartclk speed on the
> > oscilloscope.
> 
> Thanks!

Greg, there is a subtle bug found in the second patch, I'll issue the v2 soon.

-- 
With Best Regards,
Andy Shevchenko


