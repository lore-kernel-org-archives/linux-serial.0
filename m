Return-Path: <SRS0=xhGe=3J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE1C32771
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D12073D
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 06:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL9ZWFcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATGGX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:06:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32932 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGGX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jan 2020 01:06:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so32572778lji.0;
        Sun, 19 Jan 2020 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=W1JIXHfXLk3MBN8q4UB67xLKe5M2gcb3jjoZNOy3eF0=;
        b=qL9ZWFcf+4HeLzNH7LM35cH3xyLKfqouiP0N7ADEgLutGwj/F6KgEPYH0qxNILY4e9
         u8oUU+gmeU8UrHuv0mdsVczsqjGHpAjuwHGwvxuMWUpw9M6XjAYKTUSkMR477Wkzldio
         /egzxQq5zQtt3T8qlGCm9bWX5mPW01QOWMfKERZCk8aVaVpdzpl7bOEqh7xskuplJGig
         kNMluUCW6WOc1jntYPZK5TsuprW0c+xDDIRa6b2uw5pKkTnc4RcdR8Ib0bRc++9xAJa4
         pGUM1Xl0mFvqXvKE9iwC9cSQ6vlxiJGsLsRcM6XKG6Iamc0TVmgNBqjRO6+FN0q8FjDA
         8QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=W1JIXHfXLk3MBN8q4UB67xLKe5M2gcb3jjoZNOy3eF0=;
        b=SIIaRwGSL0eTEtnbFeaZvA2Lt1G/jD63XTM7mgMIbeC70myIZgHLfvBbwzMw2Z1QxV
         cfEq+nZF6cd95AvJpE8bvWMlVo8cvmJTTVos3KHmBw8sCm7Bea5UhE7RGI8HB7o3Lh87
         I3tkqhHS2GIlCJcuxFwyZ/d6umFx8msow3HMIWrEId1FNR5ejJ49WFhGq2TpC14rdsre
         D6SOVOjNOgNnjbn3L3a0n8zFKd792YJ9JITFfBTfweTSTYnVSHa3vGOiRE2Fzpom9nyk
         8DyTpzdHaw4Ri3YpLKEN8WPcr8U+0w+f0heZqddzsoQFHHeG+3bzJwWWgThnXEjujjqL
         miwg==
X-Gm-Message-State: APjAAAWVow6gI/O84rbGehpurjHMkbqFCSSj4b9Yux8v5UWP7esmvhmV
        z8SXaBGznJpHabG9wkea5AGDSIrL
X-Google-Smtp-Source: APXvYqzb7u+VwESHZIjk53+KBPWZ4kZVTJDCITTX6FCnpS8abU6CP4IJMxROoyBdDTL1aZEQHvCn5Q==
X-Received: by 2002:a2e:918c:: with SMTP id f12mr12845605ljg.66.1579500380449;
        Sun, 19 Jan 2020 22:06:20 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t1sm16092908lji.98.2020.01.19.22.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:06:19 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: serial: fix Tx stall after buffer overflow
References: <87pnfi8xc2.fsf@osv.gnss.ru> <20200117203414.GA11783@qmqm.qmqm.pl>
Date:   Mon, 20 Jan 2020 09:06:18 +0300
In-Reply-To: <20200117203414.GA11783@qmqm.qmqm.pl> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_Miros=C5=82aw=22's?=
        message of "Fri, 17 Jan 2020 21:34:14 +0100")
Message-ID: <87sgkak6g5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:

> On Fri, Jan 17, 2020 at 08:29:33AM +0300, Sergey Organov wrote:
> [...]
>> NOTE: current version of the driver leaks data from one connection to
>> another through its internal circular buffer. It might be a good idea
>> to clear the buffer on open/close/connect/disconnect, in which case
>> the problem this patch solves would have been fixed in a different
>> manner. However, not only that's a more dramatic change, but to do it
>> right TTY-layer buffers are to be considered as well.
>
> This is normal for serial devices, as they don't have any means to
> signal connection and will usually transmit anyway when not connected.
> In case of a console on the USB gadget-emulated serial port, it might
> actually be convenient that the data is kept until connection.

Yeah, just wanted to make sure I did select the right way of fixing the
issue.

>
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -563,6 +563,8 @@ static int gs_start_io(struct gs_port *port)
>>  
>>         /* unblock any pending writes into our circular buffer */
>>         if (started) {
>> +               pr_debug("gs_start_tx: ttyGS%d\n", port->port_num);
>> +               gs_start_tx(port);
>>                 tty_wakeup(port->port.tty);
>
> The tty_wakeup() will be called from gs_start_tx(), so should be removed
> from here.

Not exactly. tty_wakeup() will be called from gs_start_tx() only when
there has been something actually transferred from the buffer. I didn't
want to change behavior when the buffer is empty, so I kept the explicit
tty_wakeup() call in place, intentionally. Please let me know if you
still think it should be removed.

> The pr_debug() in other callers of gs_start_tx() say:
> "caller: start ttyGS%d".

???

$ git co gregkh/tty-next && grep -r 'caller: start tty' .
HEAD is now at 7788f54... serial_core: Remove unused member in uart_port
$ 

-- Sergey
