Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A6C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C9A6108B
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJZNiQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 09:38:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:5637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJZNiQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 09:38:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="290740359"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="290740359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:35:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="596931413"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:35:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfMby-0018Ep-CN;
        Tue, 26 Oct 2021 16:35:30 +0300
Date:   Tue, 26 Oct 2021 16:35:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Replace custom pci_match_id()
 implementation
Message-ID: <YXgEIhCGXjDUNDU0@smile.fi.intel.com>
References: <20211025124533.29977-1-andriy.shevchenko@linux.intel.com>
 <202110262029.9bqOz12y-lkp@intel.com>
 <YXgB5vt8+r/Tdo07@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXgB5vt8+r/Tdo07@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 26, 2021 at 04:25:58PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 26, 2021 at 08:45:48PM +0800, kernel test robot wrote:

> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386

> > >> drivers/tty/serial/8250/8250_pci.c:1268:6: warning: variable 'amcc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >            if (match)
> >                ^~~~~
> >    drivers/tty/serial/8250/8250_pci.c:1273:6: note: uninitialized use occurs here
> >            if (amcc) {
> >                ^~~~
> >    drivers/tty/serial/8250/8250_pci.c:1268:2: note: remove the 'if' if its condition is always true
> >            if (match)
> >            ^~~~~~~~~~
> >    drivers/tty/serial/8250/8250_pci.c:1265:11: note: initialize the variable 'amcc' to silence this warning
> >            bool amcc;
> >                     ^
> >                      = 0
> 
> Clang gives a right and wrong advice at the same time.
> Thank you for the uninitialized case, but variable is boolean, what's 0 here?
> 
> I'll send a fix ASAP.

Hmm... GCC haven't showed anything here.
In any case, v3 has just been sent out.

-- 
With Best Regards,
Andy Shevchenko


