Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5DEC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B04961002
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhJZNcP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 09:32:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:10709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJZNcO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 09:32:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216812117"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216812117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:26:21 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="596927438"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:26:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfMSk-001869-Rn;
        Tue, 26 Oct 2021 16:25:58 +0300
Date:   Tue, 26 Oct 2021 16:25:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Replace custom pci_match_id()
 implementation
Message-ID: <YXgB5vt8+r/Tdo07@smile.fi.intel.com>
References: <20211025124533.29977-1-andriy.shevchenko@linux.intel.com>
 <202110262029.9bqOz12y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110262029.9bqOz12y-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 26, 2021 at 08:45:48PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tty/tty-testing]
> [cannot apply to v5.15-rc7 next-20211026]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/serial-8250_pci-Replace-custom-pci_match_id-implementation/20211025-204752
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: i386-randconfig-a003-20211025 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project a461fa64bb37cffd73f683c74f6b0780379fc2ca)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/24a32531ba63f472ec6f40c4d431cb5369b29818
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/serial-8250_pci-Replace-custom-pci_match_id-implementation/20211025-204752
>         git checkout 24a32531ba63f472ec6f40c4d431cb5369b29818
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_pci.c:1268:6: warning: variable 'amcc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>            if (match)
>                ^~~~~
>    drivers/tty/serial/8250/8250_pci.c:1273:6: note: uninitialized use occurs here
>            if (amcc) {
>                ^~~~
>    drivers/tty/serial/8250/8250_pci.c:1268:2: note: remove the 'if' if its condition is always true
>            if (match)
>            ^~~~~~~~~~
>    drivers/tty/serial/8250/8250_pci.c:1265:11: note: initialize the variable 'amcc' to silence this warning
>            bool amcc;
>                     ^
>                      = 0

Clang gives a right and wrong advice at the same time.
Thank you for the uninitialized case, but variable is boolean, what's 0 here?

I'll send a fix ASAP.

>    1 warning generated.

-- 
With Best Regards,
Andy Shevchenko


