Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31272C77B73
	for <linux-serial@archiver.kernel.org>; Fri, 26 May 2023 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbjEZSkW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 May 2023 14:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbjEZSj7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 May 2023 14:39:59 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9881B7
        for <linux-serial@vger.kernel.org>; Fri, 26 May 2023 11:39:34 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 728c0da8-fbf4-11ed-b972-005056bdfda7;
        Fri, 26 May 2023 21:38:03 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 26 May 2023 21:38:02 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/11] serial: sc16is7xx: add dump registers function
Message-ID: <ZHD8iufgUQH8Ssyz@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-12-hugo@hugovil.com>
 <ZG9F8xsPqs2ZWfED@surfacebook>
 <20230525154946.98829ff5bda64d7c723ed6ff@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525154946.98829ff5bda64d7c723ed6ff@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 03:49:46PM -0400, Hugo Villeneuve kirjoitti:
> On Thu, 25 May 2023 14:26:43 +0300
> andy.shevchenko@gmail.com wrote:
> > Thu, May 25, 2023 at 12:03:25AM -0400, Hugo Villeneuve kirjoitti:

...

> > Not sure about this. Can we rather create an abstract mapping on regmap?
> > (Something like gpio-pca953x.c has)
> 
> maybe we can, but more like they do in the driver max310x.c (single, dual and
> quad UART versions).
> 
> I will look into it, but it will probably be a patch that affects a lot of
> the code, and that I would like to submit separately after this serie, and so
> I will probably simply drop this current patch (11/11) since it will not be
> needed anymore.

Whatever, I commented on this solely because Greg KH is usually against new
module parameters. If you sell your point to him, fine to me.

-- 
With Best Regards,
Andy Shevchenko


