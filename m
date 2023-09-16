Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E77CD37AF
	for <linux-serial@archiver.kernel.org>; Sat, 16 Sep 2023 00:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjIPAEc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjIPAEX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Sep 2023 20:04:23 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 717C22102
        for <linux-serial@vger.kernel.org>; Fri, 15 Sep 2023 17:04:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 0A97D40EE2;
        Fri, 15 Sep 2023 19:04:18 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jkb_dfx-cqyP; Fri, 15 Sep 2023 19:04:17 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id C1DFA40F0B;
        Fri, 15 Sep 2023 19:04:17 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lxKlFKQE-kKk; Fri, 15 Sep 2023 19:04:17 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 926D840EE2;
        Fri, 15 Sep 2023 19:04:17 -0500 (CDT)
Message-ID: <80762c3a-2192-5384-8960-6b1cb54cab94@foxvalley.net>
Date:   Fri, 15 Sep 2023 18:04:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
From:   Dan Raymond <draymond@foxvalley.net>
To:     linux-serial <linux-serial@vger.kernel.org>,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@intel.com
References: <515ad583-5692-d4e0-6fee-cd242dd422b1@foxvalley.net>
In-Reply-To: <515ad583-5692-d4e0-6fee-cd242dd422b1@foxvalley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I took Andy Shevchenko's suggestion and added port I/O tracing in
a similar manner as the memory-mapped I/O tracing enabled with
CONFIG_TRACE_MMIO_ACCESS.  I'll be submitting another patch for
that shortly.  It works well and it provides another way to trace
UART register accesses.  For most purposes it is probably superior to
the method used in this patch because it leverages the existing kernel
tracing framework.

However, this patch might still be useful for debugging issues that
are sensitive to timing because it uses less CPU resources.  It also
uses less memory so a larger trace can be collected.  I did some more
timing analysis and tried to minimize the impact of cache misses by
reading the MSR register 100 times in a loop.  I added this test to
serial8250_do_get_mctrl() and ran 'cat /proc/tty/driver/serial' to
exercise the test.  Here are the results (trace overhead is measured
in CPU cycles at 1GHz):

overhead   method
--------   ------------------------------------------
       0   serial_debugfs disabled
     158   serial_debugfs enabled without pipe reader
     367   serial_debugfs enabled with pipe reader

       2   portio_tracefs disabled
     461   portio_tracefs enabled but filtered
     713   portio_tracefs enabled and collected

I made a few changes to v4 of this patch to support pipe semantics
similar to how /sys/kernel/tracing/trace_pipe works.  You can now get
unlimited trace depth by piping the trace buffer to disk as follows:

cat /sys/kernel/debug/ttyS1/trace_pipe > trace.txt &

The 'cat' process will run in the background and it will terminate
when tracing is disabled.  This doesn't come for free, however.  The
wake_up() call adds a fair amount of overhead when a pipe reader is
present as you can see in the measurements above.
