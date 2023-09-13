Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DBEEB595
	for <linux-serial@archiver.kernel.org>; Wed, 13 Sep 2023 05:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjIMF7i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Sep 2023 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjIMF7h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Sep 2023 01:59:37 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 32E31F2
        for <linux-serial@vger.kernel.org>; Tue, 12 Sep 2023 22:59:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 25CE440FC8;
        Wed, 13 Sep 2023 00:59:30 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id j2ziCQ0S_mE7; Wed, 13 Sep 2023 00:59:29 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 8D9D440FCC;
        Wed, 13 Sep 2023 00:59:29 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0vnUpMJ4h0NQ; Wed, 13 Sep 2023 00:59:29 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 5146E40FC8;
        Wed, 13 Sep 2023 00:59:29 -0500 (CDT)
Message-ID: <865e96d7-c8ff-1fa2-0fa2-634587e83ae2@foxvalley.net>
Date:   Tue, 12 Sep 2023 23:59:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <2023082515-scored-rage-50a3@gregkh>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <2023082515-scored-rage-50a3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/25/2023 2:06 AM, Greg KH wrote:
> Better!  But please, look into using the tracing infrastructure and
> functionality first.  Only if that is somehow not workable at all should
> we regress into using stuff like debugfs for this.
> 
> thanks,
> 
> greg k-h


I took some timing measurements to compare the overhead using
different tracing techniques.  The measurements were taken by
executing the rdtsc instruction at the entry and exit of the
serial_in() and serial_out() functions in 'struct uart_port'.
My test environment is a Celeron M clocked at 1GHz so each clock cycle
is 1 nanosecond.  Also note that the rdtsc instruction takes 43
clock cycles so that should be subtracted from each measurement to get
the actual time.  For each of the numbers below 100 measurements were
taken and averaged.

1183 cycles using io_serial_in (no tracing)
1192 cycles using io_serial_out (no tracing)
1382 cycles using serial_in_wrapper and rdtsc (this patch)
1564 cycles using serial_out_wrapper and rdtsc (this patch)
1484 cycles using serial_in_wrapper and ktime_get_boottime
1980 cycles using serial_out_wrapper and ktime_get_boottime
2484 cycles using serial_in_wrapper and trace_portio_read
4411 cycles using serial_out_wrapper and trace_portio_write

The last two measurements used the existing kernel tracing
infrastructure.  TRACE_EVENT() macros were created and tracepoints
were used to generate trace events that could be collected from
/sys/kernel/tracing/trace.

My first observation is that the I/O instructions themselves
(inb/outb) are fairly slow on this architecture so even with no
tracing each operation takes around 1200 nanoseconds.

The tracing technique used in this patch adds between 200 and 350
nanoseconds of overhead to that.  Swapping ktime_get_boottime() for
rdtsc() adds another 100 to 200 nanoseconds.  Using the existing
kernel trace infrastructure incurs 1300 to 3200 nanoseconds of
overhead.

Memory usage was difficult to determine exactly.  The technique in
this patch uses fixed length records that are 8 bytes each (6 bytes
for the timestamp, 1 byte for the register offset, and 1 byte for the
register data).  But the memory used by the kernel trace
infrastructure varied depending on how many records were collected.
When I set the buffer size to 64 kilobytes (by writing 64 to
/sys/kernel/tracing/buffer_size_kb) I was able to collect 4062
records.  That averages to a little over 16 bytes per record.
