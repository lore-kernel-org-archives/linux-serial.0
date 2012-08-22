From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [rtc-linux] [PATCHv3 8/9] arm: vt8500: gpio: Devicetree support
 for arch-vt8500
Date: Wed, 22 Aug 2012 11:21:32 +0200
Message-ID: <CACRpkdZnQyLSRQ6cRpFBurAv2cv44einGAsT86FLCqsj1euDMA@mail.gmail.com>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
	<1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38686 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810Ab2HVJVd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Aug 2012 05:21:33 -0400
Received: by vcbfk26 with SMTP id fk26so812420vcb.19
        for <linux-serial@vger.kernel.org>; Wed, 22 Aug 2012 02:21:32 -0700 (PDT)
In-Reply-To: <1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: vt8500-wm8505-linux-kernel@googlegroup.com, Russell King <linux@arm.linux.org.uk>, Alessandro Zummo <a.zummo@towertech.it>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@stericsson.com>, Mike Turquette <mturquette@ti.com>, Stephen Warren <swarren@nvidia.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Tue, Aug 21, 2012 at 10:47 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Converted the existing arch-vt8500 gpio to a platform_device.
> Added support for WM8505 and WM8650 GPIO controllers.
(...)
> +       unsigned val;

I asked about the datatype for this "val", it sure isn't "unsigned".

I suspected the registers were only 8bit and so it should be u8.
But atleast use u32 if you must use all these bits.

(...)
> +       val = readl(vt8500_chip->base + vt8500_chip->regs->en);
> +       val |= BIT(offset);
> +       writel(val, vt8500_chip->base + vt8500_chip->regs->en);

BTW: have you considered [readl|writel]_relaxed?

Yours,
Linus Walleij
