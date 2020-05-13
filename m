Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE96C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DC02054F
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 22:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgEMWYf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 18:24:35 -0400
Received: from kernel.crashing.org ([76.164.61.194]:58346 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgEMWYd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 18:24:33 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 04DMMYir028068
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 May 2020 17:22:38 -0500
Message-ID: <2b67927057455bc91310f88a1952f808339f14cb.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Thu, 14 May 2020 08:22:33 +1000
In-Reply-To: <20200513143755.GM17734@linux-b0ei>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
         <20200513143755.GM17734@linux-b0ei>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 2020-05-13 at 16:37 +0200, Petr Mladek wrote:
> The only common rules are:
> 
>    + The last console on the command line should always be the
>      preferred one when defined.
> 
>    + Consoles defined by the device (SPCR, device tree) are used
>      when there is no commandline.

With the exception that on x86, SPCR is only used for early_con, we
don't do add_preferred_console() at all for it.

I sort-of understand why... the track record on BIOS quality out there
being what it is, I could see this causing a number of systems start
sending the console to a non-existent or non-wired serial port instead
of the tty/gpu because the BIOS leave SPCR set/enabled for no reason.

It may or may not be the case in practice but I don't see how we can
figure that out without either a large campain of data collection from
tons of systems (which will miss plenty) or just taking the chance &
breaking people and see who screams :-)

Cheers,
Ben.


