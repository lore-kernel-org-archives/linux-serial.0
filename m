Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA65C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2C761545
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhKQK4M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:56:12 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:43090 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231591AbhKQK4L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 05:56:11 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2021 05:56:10 EST
Received: from [176.199.209.39] (account willenberg@hs-mannheim.de HELO [192.168.0.240])
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55606295; Wed, 17 Nov 2021 10:53:10 +0100
Message-ID: <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
Date:   Wed, 17 Nov 2021 10:53:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-serial@vger.kernel.org
Cc:     kernel.development@povil.us, michals@xilinx.com, git@xilinx.com,
        gregkh@linuxfoundation.org, Michal Simek <michal.simek@xilinx.com>
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
> "The uartlite is used by FPGAs that support a basically unlimited number
> of uarts so limiting it at 16 dosn't make sense as users might need more
> than that."
> the commit also said that number should be unlimited. However it set the
> default to 1 instead of 16.The original 16 written in driver should be
>   quite reasonable default to cover most of the cases.
> 
> So change the default number of uarts back to 16.

Respectfully, this is an inadequate fix to a decade-old underlying issue
in the Xilinx device tree generator. The DTG assigns consecutive
"port-number" properties to UARTs handled by separate drivers (uartps,
uartlite, uartns), which are then used in drivers/tty/serial/uartlite.c
to index the struct uart_port[] array and set uart_port->line.
The DTG should number devices for each driver separately from 0;
serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
consequence, when a Zynq system has both a PS-UART and a Uartlite,
setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
probing the uartlite fails, which is confusing to the unsuspecting
KConfig user. Setting the default to 16 just kicks the can down the
road because it will fail for more than 15 Uartlites (or less, if there
are more PS-UARTs or AXI 16550A UARTs).
I've submitted a patch for the DTG numbering scheme to git@xilinx.com
just yesterday. Will post a PATCH to this list later today or tomorrow
to handle the issue from the other end (uartlite.c).

Cheers,
Ruediger
