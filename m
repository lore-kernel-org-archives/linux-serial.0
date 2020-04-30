Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD49C47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345862070B
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgD3QoR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:44:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:9480 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgD3QoR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:44:17 -0400
IronPort-SDR: rgiIKLwiPOpnf4LPEtiylAAHcMLOaX57HxRXFRw1JLFM6J96A3suPTWQNShQ9vX4kYm8AuFq3l
 32c/wVDpcfAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 09:44:16 -0700
IronPort-SDR: 9DyQWhpBuuB0EPtN+8MsdJdwmHdFmXWAlbcmymPWP7YQRJK7krA0SwkhvajSwkCXTgSY4jIRDT
 stT9S+135+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="276576064"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2020 09:44:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jUCIH-003x9f-Sx; Thu, 30 Apr 2020 19:44:13 +0300
Date:   Thu, 30 Apr 2020 19:44:13 +0300
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
Message-ID: <20200430164413.GV185537@smile.fi.intel.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 30, 2020 at 07:14:34PM +0300, Alper Nebi Yasak wrote:

First of all I see only cover letter and one out of 3 patches.

> I recently experienced some trouble with setting up an encrypted-root
> system, my Chromebook Plus (rk3399-gru-kevin, ARM64) would appear to
> hang where it should have asked for an encryption passphrase; and I
> eventually figured out that the kernel preferred the serial port
> (inaccessible to me) over the built-in working display/keyboard and was
> probably asking there.

"probably". Please, confirm that first.
Also, without command line it's hard to say what you have asked kernel to do.

> Running plymouth in the initramfs solves that specific problem, but
> both the documentation and tty-related kconfig descriptions imply that
> /dev/console should be tty0 if graphics are working, CONFIG_VT_CONSOLE
> is enabled and no explicit console argument is given in the kernel
> commandline.

What is plymouth?

> However, I'm seeing different behaviour on systems with SPCR (as in QEMU
> aarch64 virtual machines) and/or a device-tree chosen stdout-path node
> (as in most arm/arm64 devices). On these machines, depending on the
> console argument, the contents of the /proc/consoles file are:
> 
>                     |     "console=tty0"    |    (no console arg)   |
>   ------------------+-----------------------+-----------------------+
>   QEMU VM           | tty0     -WU (EC p  ) | ttyAMA0  -W- (EC   a) |
>   (w/ SPCR)         | ttyAMA0  -W- (E    a) |                       |
>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | ttyS2    -W- (EC p a) |
>   (w/ stdout-path)  |                       | tty0     -WU (E     ) |
>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
>   (w/o either)      |                       |                       |
>   ------------------+-----------------------+-----------------------+

either == SPCR or stdout-path?

> This patchset tries to ensure that VT is preferred in those conditions
> even in the presence of firmware-mandated serial consoles.

This sounds completely wrong. serial should be preferred over vt due to very
debugging on early stages and SPCR is exactly for that.

> These should
> cleanly apply onto next-20200430.
> 
> More discussion due to or about the console confusion on ARM64:
> - My Debian bug report about the initramfs prompts [0]
> - Fedora test issue arising from ARM64 QEMU machines having SPCR [1]
> - Debian-installer discussion on what to do with multiple consoles [2]

Maybe you should figure out the real root cause?

> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=952452
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1661288
> [2] https://lists.debian.org/debian-boot/2019/01/msg00184.html

-- 
With Best Regards,
Andy Shevchenko


