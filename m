Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79EC77B7A
	for <linux-serial@archiver.kernel.org>; Mon, 29 May 2023 22:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjE2WkY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 May 2023 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjE2WkY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 May 2023 18:40:24 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF924CD
        for <linux-serial@vger.kernel.org>; Mon, 29 May 2023 15:40:21 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id ca0df54f-fe71-11ed-b972-005056bdfda7;
        Tue, 30 May 2023 01:40:19 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 01:40:19 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
Message-ID: <ZHUp0wcleB06s-N5@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Mon, May 29, 2023 at 10:07:02AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series mainly fixes a GPIO regression and improve RS485 flags and
> properties detection from DT.
> 
> It now also includes various small fixes and improvements that were previously
> sent as separate patches, but that made testing everything difficult.
> 
> Patch 1 fixes an issue when debugging IOcontrol register. After testing the GPIO
> regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> this patch is also necessary for having the correct IOcontrol register values.
> 
> Patch 2 introduces a delay after a reset operation to respect datasheet
> timing recommandations.
> 
> Patch 3 fixes an issue with init of first port during probing.
> 
> Patch 4 fixes a bug with the output value when first setting the GPIO direction.
> 
> Patch 5 is a refactor of GPIO registration code.
> 
> Patches 6 and 7 fix a GPIO regression by (re)allowing to choose GPIO function
> for GPIO pins shared with modem status lines.
> 
> Patch 8 allows to read common rs485 device-tree flags and properties.
> 
> Patch 9 improves comments about chip variants.
> 
> I have tested the changes on a custom board with two SC16IS752 DUART using a
> Variscite IMX8MN NANO SOM.

In general looks good to me, just some minor things and patch ordering issues.
Thank you for doing this!

-- 
With Best Regards,
Andy Shevchenko


