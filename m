Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585CC77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 11:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbjEYL0s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbjEYL0r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 07:26:47 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01A10B
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 04:26:46 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 07139230-faef-11ed-a9de-005056bdf889;
        Thu, 25 May 2023 14:26:44 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 14:26:43 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/11] serial: sc16is7xx: add dump registers function
Message-ID: <ZG9F8xsPqs2ZWfED@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-12-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-12-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 12:03:25AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> With this driver, it is very hard to debug the registers using
> the /sys/kernel/debug/regmap interface.
> 
> The main reason is that bits 0 and 1 of the register address
> correspond to the channels bits, so the register address itself starts
> at bit 2, so we must 'mentally' shift each register address by 2 bits
> to get its offset.
> 
> Also, only channels 0 and 1 are supported, so combinations of bits
> 0 and 1 being 10b and 11b are invalid, and the display of these
> registers is useless.
> 
> For example:
> 
> cat /sys/kernel/debug/regmap/spi0.0/registers
> 04: 10 -> Port 0, register offset 1
> 05: 10 -> Port 1, register offset 1
> 06: 00 -> Port 2, register offset 1 -> invalid
> 07: 00 -> port 3, register offset 1 -> invalid
> ...
> 
> Add a debug module parameter to call a custom dump function for each
> port registers after the probe phase to help debug.

Not sure about this. Can we rather create an abstract mapping on regmap?
(Something like gpio-pca953x.c has)

-- 
With Best Regards,
Andy Shevchenko


