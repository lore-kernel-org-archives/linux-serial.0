Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6F7C77B7E
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEYK3C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEYK3B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 06:29:01 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 03:29:00 PDT
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B310B
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 03:28:59 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id ce3a9d81-fae6-11ed-a9de-005056bdf889;
        Thu, 25 May 2023 13:27:53 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 13:27:52 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and
 rs485 improvements
Message-ID: <ZG84KCeMIINFVTMh@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 12:03:13AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series mainly fixes a GPIO regression and improve RS485 flags and properties
> detection from DT.
> 
> It now also includes various small fixes and improvements that were previously
> sent as separate patches, but that made testing everything difficult.

> Patches 1 and 2 are simple comments fix/improvements.

Usually we put fixes at the beginning of the series, but these patches are
missing Fixed tag. Are they really fixes or can be simply moved to the end of
the series?

> Patch 3 fixes an issue when debugging IOcontrol register. After testing the GPIO
> regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> this patch is also necessary for having the correct IOcontrol register values.
> 
> Patch 4 introduces a delay after a reset operation to respect datasheet
> timing recommandations.
> 
> Patch 5 fixes an issue with init of first port during probing. This commit
> brings some questions and I appreciate if people from the serial subsystem could
> comment on my proposed solution.
> 
> Patch 6 fixes a bug with the output value when first setting the GPIO direction.
> 
> Patch 7, 8 and 9 fix a GPIO regression by (re)allowing to choose GPIO function for
> GPIO pins shared with modem status lines.
> 
> Patch 10 allows to read common rs485 device-tree flags and properties.
> 
> Patch 11 add a custom dump function as relying on regmal debugfs is not really
> practical for this driver.
> 
> I have tested the changes on a custom board with two SC16IS752 DUART using a
> Variscite IMX8MN NANO SOM.

Other comments are per individual emails.

-- 
With Best Regards,
Andy Shevchenko


