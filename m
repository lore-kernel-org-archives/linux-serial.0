From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Tue, 12 Jun 2012 20:54:17 +0200
Message-ID: <CACRpkdahoqUEc74eEcf=KcYRoUMEYQ456nZ85qGViLGBxUpdbw@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46160 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2FLSyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Jun 2012 14:54:18 -0400
Received: by qcro28 with SMTP id o28so1283225qcr.19
        for <linux-serial@vger.kernel.org>; Tue, 12 Jun 2012 11:54:18 -0700 (PDT)
In-Reply-To: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Wed, May 23, 2012 at 9:18 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> We had a boot regression in Ux500 in the merge window because
> two orthogonal pin control schemes for the PL011 were merged
> at the same time:
>
> - One using the .init() and .exit() hooks into the platform
> =A0for Ux500 putting the pins into default vs sleep state
> =A0respectively as the port was started/stopped.
> =A0commit a09806607fd20bed2f8c41fe22793386790a14aa
> =A0"ARM: ux500: switch to using pinctrl for uart0"
>
> - One hogging the default setting at PL011 probe()
> =A0commit 258e055111d3cde2607e0d04eb91da2f7a59b591
> =A0"serial: amba-pl011: adopt pinctrl support"
>
> To get a solution that works for both let's scrap the stuff
> in the platform callbacks, instead have the driver itself
> select default and sleep states when the port is
> started/stopped. Hopefully this works for all clients.
> Platform callbacks are bad for device tree migration anyway,
> so this rids us of another problem in Ux500.
>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

A friendly poke at Greg to push this for the -rc series whenever
time permits (if OK) as it's regressing Ux500 for the moment.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
