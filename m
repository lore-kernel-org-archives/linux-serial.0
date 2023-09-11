Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED32ACA0EC7
	for <linux-serial@archiver.kernel.org>; Tue, 12 Sep 2023 01:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjILBnX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjILBnK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 21:43:10 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4BF43A3D1B
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 18:19:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id E938740032;
        Mon, 11 Sep 2023 17:14:49 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id cm4CMsWrm4o4; Mon, 11 Sep 2023 17:14:49 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 57081400A0;
        Mon, 11 Sep 2023 17:14:49 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RjJGRIGSJDaQ; Mon, 11 Sep 2023 17:14:49 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 150F940032;
        Mon, 11 Sep 2023 17:14:49 -0500 (CDT)
Message-ID: <e0b46e9e-30ee-1ca7-b39c-89480de60009@foxvalley.net>
Date:   Mon, 11 Sep 2023 16:14:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
 <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
 <ZPEbacIuZv+116AE@smile.fi.intel.com>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <ZPEbacIuZv+116AE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

>>>> Implement a UART register tracing facility using the debugfs.  This can be
>>>> used as a "serial port sniffer" to monitor UART traffic and line settings
>>>> with timestamps at microsecond granularity.  This can be useful for general
>>>> serial port debugging or to debug the UART driver itself.
>>>
>>>>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
>>>
>>> My gosh. Why trace points and trace events can't be used for that?
>>
>> I don't understand your post.  Are you saying there is already a way to
>> trace UART register reads/writes without this patch? Can you elaborate?
> 
> Besides what Greg an I were telling you (another type of infrastructure),
> as a matter of fact you may trace any IO on some architectures (at least x86),
> it's called mmiotracer (I have used it like 5 years ago or so to trace UART).
> 
> Below is the excerpt from my old shell script
> 
> rebind() {
> 	local drvdir="/sys/bus/$1/drivers/$2"
> 	local devdir="/sys/bus/$1/devices/$3"
> 	[ -d "$drvdir" -a -d "$devdir" ] || return
> 	echo "$3" > "$drvdir/unbind"
> 	echo "$3" > "$drvdir/bind"
> }
> 
> mmiotrace() {
> 	echo mmiotrace > /sys/kernel/tracing/current_tracer
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	rebind platform 'dw-apb-uart'   '80860F0A:00'   # BYT ttyS1 (ACPI)
> 	rebind platform 'dw-apb-uart'   '8086228A:00'   # BSW ttyS1 (ACPI)
> 	rebind pci      '8250_mid'      '0000:00:04.2'  # Edison ttyS1
> 	rebind pci      'intel-lpss'    '0000:00:18.1'  # BXT LH ttyS1
> 	rebind pci      'intel-lpss'    '0000:00:1e.0'  # SKL ttyS1
> 	rebind pci      '8250_lpss'     '0000:00:1e.3'  # BSW ttyS1 (PCI)
> }

Correct me if I'm wrong but I don't think mmiotrace will work for me.  My
environment comprises an Intel Celeron M connected to an 852GM north bridge,
an ICH4 south bridge, and a SCH3114 Super I/O controller.  My UART device
is ttyS1 and it uses port I/O not memory-mapped I/O.

# find /sys/devices -name '*ttyS*'
/sys/devices/platform/serial8250/tty/ttyS2
/sys/devices/platform/serial8250/tty/ttyS3
/sys/devices/pnp0/00:03/tty/ttyS0
/sys/devices/pnp0/00:04/tty/ttyS1

# ls -l /sys/bus/pnp/drivers/serial
total 0
lrwxrwxrwx    1 root     root             0 Sep 11 14:19 00:03 -> ../../../../devices/pnp0/00:03
lrwxrwxrwx    1 root     root             0 Sep 11 14:19 00:04 -> ../../../../devices/pnp0/00:04
--w-------    1 root     root          4096 Sep 11 14:19 bind
--w-------    1 root     root          4096 Sep 11 14:19 uevent
--w-------    1 root     root          4096 Sep 11 14:19 unbind

# mount -t tracefs tracefs /sys/kernel/tracing
# echo mmiotrace > /sys/kernel/tracing/current_tracer
# echo 00:04 > /sys/bus/pnp/drivers/serial/unbind
# echo 00:04 > /sys/bus/pnp/drivers/serial/bind
# dmesg | tail -5
[   36.438305] random: crng init done
[   97.736362] mmiotrace: enabled.
[  113.964953] serial 00:04: disabled
[  117.469704] serial 00:04: activated
[  117.469986] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A

(perform UART transaction)

# cat /sys/kernel/tracing/trace
# tracer: mmiotrace
#
# entries-in-buffer/entries-written: 0/0   #P:1
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
