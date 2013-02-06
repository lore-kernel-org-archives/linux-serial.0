From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 6 Feb 2013 11:52:19 +0000
Message-ID: <20130206115219.GE17833@n2100.arm.linux.org.uk>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36553 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3BFL6Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 06:58:16 -0500
Content-Disposition: inline
In-Reply-To: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: jslaby@suse.cz, linus.walleij@linaro.org, anton.vorontsov@linaro.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, patches@linaro.org

On Wed, Feb 06, 2013 at 07:47:14PM +0800, Haojian Zhuang wrote:
> If uart driver is probed defer, console_setup will be called later
> after __init && __initdata sections destroyed. And amba_console isn't
> defined in __init or __initdata section. So we needn't define
> pl011_console_setup() && pl011_console_get_options() in __init section.

It sounds like there's a deeper problem here - if this driver being
deferred, why isn't it being retried after the pinctrl stuff gets
its driver registered?

We've had bugs in this deferred probing before, I wouldn't be surprised
if there's more... and we should not be "fixing" drivers because of bugs
elsewhere.
