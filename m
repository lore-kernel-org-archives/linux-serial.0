Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6398DC77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 11:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjEYLKn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbjEYLKm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 07:10:42 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA91B9
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 04:10:30 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id c0ee11ec-faec-11ed-b3cf-005056bd6ce9;
        Thu, 25 May 2023 14:10:28 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 14:10:27 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 06/11] serial: sc16is7xx: fix bug when first setting
 GPIO direction
Message-ID: <ZG9CIww5WbgJ3TUf@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-7-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-7-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 12:03:20AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> When we want to configure a pin as an output pin with a value of logic
> 0, we end up as having a value of logic 1 on the output pin. Setting a
> logic 0 a second time (or more) after that will correctly output a
> logic 0 on the output pin.
> 
> By default, all GPIO pins are configured as inputs. When we enter
> c16is7xx_gpio_direction_output() for the first time, we first set the

Missing 's'.

> desired value in IOSTATE, and then we configure the pin as an output.
> The datasheet states that writing to IOSTATE register will trigger a
> transfer of the value to the I/O pin configured as output, so if the
> pin is configured as an input, nothing will be transferred.
> 
> Therefore, set the direction first in IODIR, and then set the desired
> value in IOSTATE.
> 
> This is what is done in NXP application note AN10587.

-- 
With Best Regards,
Andy Shevchenko


