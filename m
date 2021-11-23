Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B465C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 09:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhKWJEb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:04:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:53263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236329AbhKWJEK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 04:04:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="221865653"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="221865653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:00:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509333818"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:00:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpRfB-009j2x-1U;
        Tue, 23 Nov 2021 11:00:29 +0200
Date:   Tue, 23 Nov 2021 11:00:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 3/3] serial: 8250_pericom: Use serial_dl_write()
 instead of open coded
Message-ID: <YZytrLuhBxn8OGna@smile.fi.intel.com>
References: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
 <20211122133512.8947-4-andriy.shevchenko@linux.intel.com>
 <d7809017-f544-c60c-728b-4f9015fbad43@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7809017-f544-c60c-728b-4f9015fbad43@accesio.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 09:27:11PM -0800, Jay Dolan wrote:
> On 11/22/21 5:35 AM, Andy Shevchenko wrote:

> I tested this change with a few baud rates in my current tree, and I saw the
> correct speeds coming out on the scope.

Thank you! Can you next time use Tested-by tag as explained in Submitting
Patches [1] documentation?

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

-- 
With Best Regards,
Andy Shevchenko


