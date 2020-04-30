Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0FC47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E432070B
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD3Qqa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:46:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:16091 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Qqa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:46:30 -0400
IronPort-SDR: njh/nMJkAHFXT4KukT+qaQtKv4LLNVSKpPVQfUulgt305F0JZjDaY1LHSxjTFF8vt5WhTXOqA9
 LnSpsG+c7NzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 09:46:30 -0700
IronPort-SDR: o/9FP73hLdrecg6plLPSE4BE260RONmdIVJjsa1Po+2BWeMaxxs+vdPEJruOsCeuYxZUbCf/5S
 4/zhGE4GywRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="368202826"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2020 09:46:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jUCKT-003xBR-KK; Thu, 30 Apr 2020 19:46:29 +0300
Date:   Thu, 30 Apr 2020 19:46:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC PATCH v2 1/3] printk: Add function to set console to
 preferred console's driver
Message-ID: <20200430164629.GW185537@smile.fi.intel.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200430161438.17640-2-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-2-alpernebiyasak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 30, 2020 at 07:14:35PM +0300, Alper Nebi Yasak wrote:
> Currently, add_preferred_console sets a preferred console, but doesn't
> actually change /dev/console to match it. That part is handled within
> register_device, where a newly registered console driver will be set as
> /dev/console if it matches the preferred console.
> 
> However, if the relevant driver is already registered, the only way to
> set it as /dev/console is by un-registering and re-registering it. An
> example is the xenfb_make_preferred_console() function:
> 
> 	console_lock();
> 	for_each_console(c) {
> 		if (!strcmp(c->name, "tty") && c->index == 0)
> 			break;
> 	}
> 	console_unlock();
> 	if (c) {
> 		unregister_console(c);
> 		c->flags |= CON_CONSDEV;
> 		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
> 		register_console(c);
> 	}
> 
> The code above was introduced in commit 9e124fe16ff2 ("xen: Enable
> console tty by default in domU if it's not a dummy"). In short, it's aim
> is to set VT as the preferred console only after a working framebuffer
> is registered and thus VT is not the dummy device.
> 
> This patch introduces an update_console_to_preferred function that
> handles the necessary /dev/console change. With this change, the example
> above can be replaced with:
> 
> 	console_lock();
> 	add_preferred_console("tty", 0, NULL);
> 	update_console_to_preferred();
> 	console_unlock();
> 
> More importantly, these two calls can be moved to vt.c in order to bump
> its priority when a non-dummy backend for it is introduced, solving that
> problem in general.

Even w/o looking into the code I believe it breaks more platforms than fixes
anything. It was not first time one tries to do something about preferred
consoles and it appeared to break working configurations.

I would wait for PRINTK maintainers to tell, but to me it sounds like papering
over the real issue which you don't understand (yet).

-- 
With Best Regards,
Andy Shevchenko


