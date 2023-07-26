Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF8CC0015E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jul 2023 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjGZKcg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jul 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjGZKcb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jul 2023 06:32:31 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EEE26A5
        for <linux-serial@vger.kernel.org>; Wed, 26 Jul 2023 03:32:26 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id b562e7a9-2b9f-11ee-abf4-005056bdd08f;
        Wed, 26 Jul 2023 13:32:24 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 26 Jul 2023 13:32:23 +0300
To:     andy.shevchenko@gmail.com
Cc:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH 3/3] 8250_men_mcb: Make UART config auto configurable
Message-ID: <ZMD2N3qNIhsuwMIr@surfacebook>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
 <20230705131423.30552-4-josejavier.rodriguez@duagon.com>
 <ZMDc_krXXhoT2jwn@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMDc_krXXhoT2jwn@surfacebook>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Wed, Jul 26, 2023 at 11:44:46AM +0300, andy.shevchenko@gmail.com kirjoitti:
> Wed, Jul 05, 2023 at 01:15:14PM +0000, Rodríguez Barbarin, José Javier kirjoitti:
> > The UART ports created by this driver were not usable out of
> > the box, so let the configuration be handled by the 8250 UART
> > subsystem. This makes the implementation simpler and the UART
> > port more usable.
> > 
> > The 8250 UART subsystem will take care of requesting the memory
> > resources, but the driver needs to first read the register where
> > the num ports is set, so a request of the resource is needed
> > before registering the UART port.
> 
> I see this is already pending to the next cylce, but
> formally I would like to NAK this change as explained
> in reply to cover letter why.

Okay, after a bit of digging it seems not so bad as I was thinking initially.
The IRQ test requires specific flag which seems is not set in this case.
This removes my main worries.

-- 
With Best Regards,
Andy Shevchenko


