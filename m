Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C63C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CAC20708
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBKOkI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:40:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46478 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKOkH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 09:40:07 -0500
Received: from [5.158.153.52] (helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1j1Whk-0002Rl-DC; Tue, 11 Feb 2020 15:40:00 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Vikram Pandita <vikram.pandita@ti.com>
Subject: Re: [PATCH v1] serial: 8250: Check UPF_IRQ_SHARED in advance
In-Reply-To: <20200211135559.85960-1-andriy.shevchenko@linux.intel.com>
References: <20200211135559.85960-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 11 Feb 2020 15:39:59 +0100
Message-ID: <878sl99ohs.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

On Tue Feb 11 2020, Andy Shevchenko wrote:
> The commit 54e53b2e8081
>   ("tty: serial: 8250: pass IRQ shared flag to UART ports")
> nicely explained the problem:
>
> ---8<---8<---
>
> On some systems IRQ lines between multiple UARTs might be shared. If so, the
> irqflags have to be configured accordingly. The reason is: The 8250 port startup
> code performs IRQ tests *before* the IRQ handler for that particular port is
> registered. This is performed in serial8250_do_startup(). This function checks
> whether IRQF_SHARED is configured and only then disables the IRQ line while
> testing.
>
> This test is performed upon each open() of the UART device. Imagine two UARTs
> share the same IRQ line: On is already opened and the IRQ is active. When the
> second UART is opened, the IRQ line has to be disabled while performing IRQ
> tests. Otherwise an IRQ might handler might be invoked, but the IRQ itself
> cannot be handled, because the corresponding handler isn't registered,
> yet. That's because the 8250 code uses a chain-handler and invokes the
> corresponding port's IRQ handling routines himself.
>
> Unfortunately this IRQF_SHARED flag isn't configured for UARTs probed via device
> tree even if the IRQs are shared. This way, the actual and shared IRQ line isn't
> disabled while performing tests and the kernel correctly detects a spurious
> IRQ. So, adding this flag to the DT probe solves the issue.
>
> Note: The UPF_SHARE_IRQ flag is configured unconditionally. Therefore, the
> IRQF_SHARED flag can be set unconditionally as well.
>
> Example stack trace by performing `echo 1 > /dev/ttyS2` on a non-patched system:
>
> |irq 85: nobody cared (try booting with the "irqpoll" option)
> | [...]
> |handlers:
> |[<ffff0000080fc628>] irq_default_primary_handler threaded [<ffff00000855fbb8>] serial8250_interrupt
> |Disabling IRQ #85
>
> ---8<---8<---
>
> But unfortunately didn't fix the root cause. Let's try again here by moving
> IRQ flag assignment from serial_link_irq_chain() to serial8250_do_startup().
>
> This should fix the similar issue reported for 8250_pnp case.
>
> Since this change we don't need to have custom solutions in 8250_aspeed_vuart
> and 8250_of drivers, thus, drop them.
>
> Fixes: 1c2f04937b3e ("serial: 8250: add IRQ trigger support")
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Cc: Kurt Kanzenbach <kurt@linutronix.de>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The code looks alright to me.

 Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl5CvL8ACgkQeSpbgcuY
8KbwABAAmzVJ8bGInMeGRC7MGJ/LN6yX85rFLfxvxcXxpMLN6bkLDCnq2xkKEy0p
q9Ayv/RHTZaOwvUe66CJu/4ASF4Y0LX/2RbwIzG3y9obtnD2ew+RRHqvNsWpmi54
8baCbH3FQIr29Na+N0D1gF26dUwxG7HriAluWqJrAgwRtPjtNqLQPS2n5U55gxfj
h7wmKdPQO5JxIAB7lzPi+eg9MQgBBYC1k6oUQuxMwc6Oi9pWKz9pZvjAy170+RQh
0xsTkX5M6GKHVkiFpL6rYuHSG0Ho7g9xzLqq7hbKgw5j+fTyFRTjm1KlBqEFlrIs
PDdtWAKE4fIuFOiUsZ11zF6p0Wp5y9MkF8oHI61Tsi4SylZxGu3PifjlR1RbBack
E3iRcOld86inqk2bfzwRo0cGmQ117/SYEzcolOySrIZfQHHeeB2biSXrVtpsw/Ar
tlhi3SD7sUIWqvcxLfR/b9YlrNreJGN7575d30DHexyLgEmnIxw87TDfiNAObhbs
MrXTBBwR0x4acrvPlF/v2KJ+ZE28W170fmulNApdojI4Wona/VRHbH9vhe4aOEQA
cFZ8FhaXtzcCxTXKC17XsScYGGG9xsxfcRvf3smty8DohG64vpfKcPru/0Oyxy+2
TJ0ePexGCiG9RbJ5UVz/nBF1I1MVjyfxAyNesDYx1GSgiMkRL2g=
=HfoN
-----END PGP SIGNATURE-----
--=-=-=--
