Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B30C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 10:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhKXKL4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 05:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhKXKLz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 05:11:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2845F60F43;
        Wed, 24 Nov 2021 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637748526;
        bh=LHP843bA+kZvwtvvEKKOhBAIwXxDHs6fiT+30wG+QO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7wMBVxS/i/Afh4l/4mGL+QvneQg2I7WdwGmM1QPZiNh+j1d1oHOEP0Wl7i59JdPv
         zesLfd46+WV7lOYxEKRy99VWm+qDw//ByE/85maX4ig8aacqko2hmXHquGiej0LegL
         4yExvzHWa2PKfoRpQODFXS4CjewSeXWkoQBXt5t4=
Date:   Wed, 24 Nov 2021 11:08:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com
Subject: Re: [PATCH v3] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Message-ID: <YZ4PKesu+YzXcfxS@kroah.com>
References: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 12:14:46AM +0100, Ruediger Willenberg wrote:
> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
> the device tree port-number property is outside that range. This
> happens when there are other UART types in the system because the
> Xilinx device tree generator numbers all UARTs consecutively;
> as a result, not as many Uartlites as specified by the
> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.

Ick.  Please just remove that build option entirely, this should just
dynamically allocate new devices based on what is in the system.

The driver should not care at build time about this.

thanks,

greg k-h
