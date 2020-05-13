Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC66C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE12064E
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 14:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgEMOiB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 10:38:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgEMOiB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 10:38:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F268ADF8;
        Wed, 13 May 2020 14:38:01 +0000 (UTC)
Date:   Wed, 13 May 2020 16:37:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200513143755.GM17734@linux-b0ei>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu 2020-04-30 19:14:34, Alper Nebi Yasak wrote:
> I recently experienced some trouble with setting up an encrypted-root
> system, my Chromebook Plus (rk3399-gru-kevin, ARM64) would appear to
> hang where it should have asked for an encryption passphrase; and I
> eventually figured out that the kernel preferred the serial port
> (inaccessible to me) over the built-in working display/keyboard and was
> probably asking there.
> 
> Running plymouth in the initramfs solves that specific problem, but
> both the documentation and tty-related kconfig descriptions imply that
> /dev/console should be tty0 if graphics are working, CONFIG_VT_CONSOLE
> is enabled and no explicit console argument is given in the kernel
> commandline.
> 
> However, I'm seeing different behaviour on systems with SPCR (as in QEMU
> aarch64 virtual machines) and/or a device-tree chosen stdout-path node
> (as in most arm/arm64 devices). On these machines, depending on the
> console argument, the contents of the /proc/consoles file are:

I dug many times into the history of the console registration code.
The following table mostly confirms my expectations.


>                     |     "console=tty0"    |    (no console arg)   |
>   ------------------+-----------------------+-----------------------+
>   QEMU VM           | tty0     -WU (EC p  ) | ttyAMA0  -W- (EC   a) |
>   (w/ SPCR)         | ttyAMA0  -W- (E    a) |
>   |

The SPCR handling is inconsistent over architectures, see
https://lkml.kernel.org/r/20180830123849.26163-1-prarit@redhat.com

IMHO, arm developers decided that consoles defined by SPCR are always
enabled when existing.

In 1st column: tty0 is the preferred console because it is defined
on the commandline.

In 2nd column: tty0 is not enabled at all because another console was
defined by SPCR. Note that ttySX and ttyX consoles are registered only
as a fallback when there is no other console defined.

The following code is responsible for the fallback, see register_console()

	/*
	 *	See if we want to use this console driver. If we
	 *	didn't select a console we take the first one
	 *	that registers here.
	 */
	if (!has_preferred) {
		if (newcon->index < 0)
			newcon->index = 0;
		if (newcon->setup == NULL ||
		    newcon->setup(newcon, NULL) == 0) {
			newcon->flags |= CON_ENABLED;
			if (newcon->device) {
				newcon->flags |= CON_CONSDEV;
				has_preferred = true;
			}
		}
	}


>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | ttyS2    -W- (EC p a) |
>   (w/ stdout-path)  |                       | tty0     -WU (E     ) |

Hmm, of_console_check() explicitly ignores the console defined by
stdout-path when there is a console on the commandline. This explains
1st column.

I am not sure about 2nd column. My guess is that ttyX consoles are
tried first. tty0 is registered as a fallback because there is no
other console at the moment. ttyS2 is tried later and it is
registered because it is in stdout-patch and there is no console
in the command line. It is somehow consistent with  CONFIG_VT_CONSOLE
description.

Sadly, it is different logic than with SPCR :-(


>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
>   (w/o either)      |                       |                       |
>   ------------------+-----------------------+-----------------------+

This variant is easy and everyone would probably expect this.


Regarding the description of CONFIG_VT_CONSOLE option. I am afraid
that it was created and true only before SPCR and device tree support
was introduced.


Now, it is really sad that SPCR and device tree have different
behavior even across architectures. But I am afraid that we could
not change it without breaking many setups.

The only common rules are:

   + The last console on the command line should always be the
     preferred one when defined.

   + Consoles defined by the device (SPCR, device tree) are used
     when there is no commandline.

   + ttyX or ttySX are used as a fallback when nothing else is defined.


My suggestion is:

   + Fix SPCR setting or device tree of your device when the defaults
     are not as expected.

   + Use command line to force your value when the defaults are not
     as expected and you could not change them.


I am afraid that we could not fix your problem on the kernel side. It
would broke other setups that depend on the existing behavior.

Best Regards,
Petr
