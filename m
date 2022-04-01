Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B06C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Apr 2022 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiDAQfG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiDAQew (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Apr 2022 12:34:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BC22EE49;
        Fri,  1 Apr 2022 09:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 603C2CE2414;
        Fri,  1 Apr 2022 16:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F380DC2BBE4;
        Fri,  1 Apr 2022 16:07:06 +0000 (UTC)
Date:   Fri, 1 Apr 2022 12:07:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, andy.shevchenko@gmail.com,
        David.Laight@aculab.com, jonathanh@nvidia.com, phil@raspberrypi.com
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
Message-ID: <20220401120705.533896e5@gandalf.local.home>
In-Reply-To: <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
References: <20220331190257.101781-1-wander@redhat.com>
        <20220331190257.101781-2-wander@redhat.com>
        <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 1 Apr 2022 06:35:58 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> > With the help of the function tracer, I then noticed the serial
> > controller was taking around 410us seconds to dispatch one single byte:
> > 
> > $ trace-cmd record -p function_graph -g serial8250_console_write \
> >     ./sertest -n 1 /tmp/serco
> > 
> > $ trace-cmd report
> > 

Note, the function graph tracer can add a noticeable amount of overhead to
these timings. If you want a more accurate time for a function, just trace
that one function:

	trace-cmd record -p function_graph -l serial8250_console_write ...

As that will only trace the serial8250_console_write() function (think of
-l as "limit"), and the overhead of function graph for tracing a single
function becomes negligible, and then you can see the true time of that
function.

-- Steve
