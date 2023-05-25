Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172B5C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 11:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEYLL1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjEYLL0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 07:11:26 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787D191
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 04:11:25 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id e1f6056f-faec-11ed-a9de-005056bdf889;
        Thu, 25 May 2023 14:11:23 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 14:11:22 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 07/11] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <ZG9CWhiTbLBKjPC9@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-8-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 12:03:21AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Some variants in this series of uart controllers have GPIO pins that

UART

> are shared between GPIO and modem control lines.
> 
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
> 
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.

I'm wondering if we can convert this to YAML first and then add a new property.

-- 
With Best Regards,
Andy Shevchenko


