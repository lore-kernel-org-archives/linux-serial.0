Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534DC0015E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jul 2023 08:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjGZItn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGZItT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jul 2023 04:49:19 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FF35B1
        for <linux-serial@vger.kernel.org>; Wed, 26 Jul 2023 01:42:29 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 587334d6-2b90-11ee-b3cf-005056bd6ce9;
        Wed, 26 Jul 2023 11:42:25 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 26 Jul 2023 11:42:25 +0300
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH 0/3] 8250_men_mcb: Make UART port autoconfigurable
Message-ID: <ZMDccXK4N4ZEwsPn@surfacebook>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Wed, Jul 05, 2023 at 01:14:51PM +0000, Rodríguez Barbarin, José Javier kirjoitti:
> Make configuration be handled by the 8250 UART subsystem

Actually this is not the best idea. 

> to avoid weird behaviours 

The opposite.

8250 detection is full of quirks and was developed to handle tons of different
UARTs when the driver was in a single file. Since you have a separate 8250_*.c
module for your UART and you _know_ the type beforehand, why on earth you need
to rely on the old and maybe not very suitable code? Have you thought about
corner cases with IRQ detection, for example?

> and for better maintainability.

The opposite.

I don't know if it affects your hardware to the date, but it may be different
for the future models, or models that you hadn't tested.

That said, I highly recommend to reconsider.

-- 
With Best Regards,
Andy Shevchenko


