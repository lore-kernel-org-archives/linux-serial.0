Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF49CC433FE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D238761139
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhJENrP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:47:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:2990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235063AbhJENrO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 09:47:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="224514276"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="224514276"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 06:30:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="458055582"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 06:30:48 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXkWr-008tDS-Fa;
        Tue, 05 Oct 2021 16:30:45 +0300
Date:   Tue, 5 Oct 2021 16:30:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/2] serial: 8250_lpss: Extract
 dw8250_do_set_termios() for common use
Message-ID: <YVxThfAznxsJVi+n@smile.fi.intel.com>
References: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
 <YVxKyOODe3ZWmnFZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxKyOODe3ZWmnFZ@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 05, 2021 at 02:53:28PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 02, 2021 at 09:51:40PM +0300, Andy Shevchenko wrote:
> > Some of the code currently used in dw8250_set_termios(), byt_set_termios()
> > may be reused by other methods in the future. Extract it to a common helper
> > function.

...

> > -		 * Premilinary set the uartclk to the new clock rate so the
> > +		 * Preliminary set the uartclk to the new clock rate so the
> 
> Different change, not mentioned in the changelog, please make this a
> separate patch.

Done, v2 has been just sent.

-- 
With Best Regards,
Andy Shevchenko


