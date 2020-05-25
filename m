Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2780C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09412073B
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgEYNEZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 09:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:34560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390583AbgEYNEZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 09:04:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CA91B03C;
        Mon, 25 May 2020 13:04:24 +0000 (UTC)
Date:   Mon, 25 May 2020 15:04:19 +0200
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
Message-ID: <20200525130417.GN3464@linux-b0ei>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200513143755.GM17734@linux-b0ei>
 <dd19946d-32e9-89e8-3b35-faea9941f107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd19946d-32e9-89e8-3b35-faea9941f107@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 2020-05-15 22:27:02, Alper Nebi Yasak wrote:
> On 13/05/2020 17:37, Petr Mladek wrote:
> > On Thu 2020-04-30 19:14:34, Alper Nebi Yasak wrote:
> I think things run roughly in the following order (from what I can
> decipher from kernel messages) and I think it matches your explanations:
> 
> |            ACPI SPCR            |      dt chosen stdout-path      |
> +=================================+=================================+
> | acpi_parse_spcr()               |                                 |
> | -> add_preferred_console(uart0) |                                 |
> |    (if not on x86)              |                                 |
> +---------------------------------+---------------------------------+
> |                        console_setup()                            |
> |                        -> add_preferred_console(tty0)             |
> |                           (if console=tty0)                       |
> +---------------------------------+---------------------------------+
> |                        register_console(vt)                       |
> +---------------------------------+---------------------------------+
> |                                 | of_console_check()              |
> |                                 | -> add_preferred_console(uart2) |
> |                                 |    (if no console arg)          |
> +---------------------------------+---------------------------------+
> |                        register_console(serial)                   |
> +---------------------------------+---------------------------------+


I was first a bit confused by the above table. The order looks fine
but I was not sure about the indentation. I think that some more
details are needed to get the picture and context.

I see the following order in start_kernel():

1. Add spcr consoles: by acpi_parse_spcr() called from setup_arch().
2. Add and register early consoles: by parse_early_param()
3. Add normal consoles from command line: by parse_args()

4. Register tty console: by vty_init() called via long chain
   from fs_initcall(chr_dev_init). It seems to be init call
   in 5th round, see include/linux/init.h

5. Register other (serial) consoles are most likely registered from
   device_initcall() in 6th round, see include/linux/init.h.

The consoles defined by the device tree are not added directly.
Instead, the probe() callbacks checks whether such console is
selected in device tree by of_console_check() called from
uart_add_one_port().


> > My suggestion is:
> > 
> >     + Fix SPCR setting or device tree of your device when the defaults
> >       are not as expected.
> 
> Maybe I can get QEMU's SPCR use conditional on the existence a
> framebuffer, and get distributions to remove stdout-path from certain
> device-trees; but that would disable the serial console completely
> (instead of having it enabled where tty0 is still preferred).

I am afraid that this is a problem with many defaults. They might be
good enough for many people but others would want something else.

It might be acceptable to add consoles. But it might be a problem to
remove consoles or change the currently preferred one.

The only exception would be when most people are annoyed with the
current default. But this need to be discussed with people familiar
with the given architecture or device.


> >     + Use command line to force your value when the defaults are not
> >       as expected and you could not change them.
> 
> This works; but I'd have to know the machine's serial configuration in
> advance to put it in the cmdline as "console=<serial> console=tty0", or
> lose the serial console as in the above. (A "console=dt" like that
> "console=spcr" patch you linked to would be useful here if it existed.)

The generic parameters: console=tty, console=serial, console=dt, console=spcr
looks fine to me. IMHO, the only problem might be when a particular
serial console drive is not able to guess reasonable defaults for the
baud rate, etc.

Best Regards,
Petr
