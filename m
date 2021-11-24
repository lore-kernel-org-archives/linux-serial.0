Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F5C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 11:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhKXLvO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:51:14 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:54398 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241424AbhKXLvJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 06:51:09 -0500
Received: from [141.19.158.31] (account willenberg@hs-mannheim.de [141.19.158.31] verified)
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55732170; Wed, 24 Nov 2021 12:47:57 +0100
Message-ID: <fabc3767-c524-1a88-4bec-d1b03d57bf4a@hs-mannheim.de>
Date:   Wed, 24 Nov 2021 12:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com
References: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
 <YZ4PKesu+YzXcfxS@kroah.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <YZ4PKesu+YzXcfxS@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 24.11.2021 um 11:08 schrieb Greg KH:
> On Tue, Nov 23, 2021 at 12:14:46AM +0100, Ruediger Willenberg wrote:
>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>> the device tree port-number property is outside that range. This
>> happens when there are other UART types in the system because the
>> Xilinx device tree generator numbers all UARTs consecutively;
>> as a result, not as many Uartlites as specified by the
>> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
> 
> Ick.  Please just remove that build option entirely, this should just
> dynamically allocate new devices based on what is in the system.
> 
> The driver should not care at build time about this.
> 

Fully agree removing SERIAL_UARTLITE_NR_UARTS and making allocation 
dynamic is best.
Please briefly advise on how to best handle the following resulting issue:

In  serial_core.c  the following check occurs:

int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
{
...
	if (uport->line >= drv->nr)
		return -EINVAL;
		

To not let this fail on registering a legit uartlite port, should we

* Set  ulite_uart_driver.nr = INT_MAX  before registering the driver
* Adjust  ulite_uart_driver.nr  when adding or removing a port (surely 
with lock, but still smells)
* do something blindingly obvious I'm missing?

Thank you,
Ruediger
