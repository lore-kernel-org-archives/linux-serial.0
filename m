Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F33C41513
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jul 2023 08:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGZIvE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGZIum (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jul 2023 04:50:42 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFA4C27
        for <linux-serial@vger.kernel.org>; Wed, 26 Jul 2023 01:44:49 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id acc1db47-2b90-11ee-abf4-005056bdd08f;
        Wed, 26 Jul 2023 11:44:47 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 26 Jul 2023 11:44:46 +0300
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
Subject: Re: [PATCH 3/3] 8250_men_mcb: Make UART config auto configurable
Message-ID: <ZMDc_krXXhoT2jwn@surfacebook>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
 <20230705131423.30552-4-josejavier.rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705131423.30552-4-josejavier.rodriguez@duagon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Wed, Jul 05, 2023 at 01:15:14PM +0000, Rodríguez Barbarin, José Javier kirjoitti:
> The UART ports created by this driver were not usable out of
> the box, so let the configuration be handled by the 8250 UART
> subsystem. This makes the implementation simpler and the UART
> port more usable.
> 
> The 8250 UART subsystem will take care of requesting the memory
> resources, but the driver needs to first read the register where
> the num ports is set, so a request of the resource is needed
> before registering the UART port.

I see this is already pending to the next cylce, but
formally I would like to NAK this change as explained
in reply to cover letter why.

...

Side note:

>  		uart.port.mapbase = (unsigned long) mem->start
>  					    + data->offset[i];

Weird indentation and strange casting.

-- 
With Best Regards,
Andy Shevchenko


