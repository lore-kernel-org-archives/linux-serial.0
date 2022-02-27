Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE4C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 27 Feb 2022 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiB0XHj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Feb 2022 18:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB0XHi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Feb 2022 18:07:38 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B86AB55493;
        Sun, 27 Feb 2022 15:07:00 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8918892009C; Mon, 28 Feb 2022 00:06:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7BAA292009B;
        Sun, 27 Feb 2022 23:06:58 +0000 (GMT)
Date:   Sun, 27 Feb 2022 23:06:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
In-Reply-To: <alpine.DEB.2.21.2202251753530.25061@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202271516420.39915@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202121646020.34636@angie.orcam.me.uk> <alpine.DEB.2.21.2202121706060.34636@angie.orcam.me.uk> <Yhiixm/iRlnF18B7@kroah.com> <alpine.DEB.2.21.2202251753530.25061@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 26 Feb 2022, Maciej W. Rozycki wrote:

> On Fri, 25 Feb 2022, Greg Kroah-Hartman wrote:
> 
> > We don't do this for any other driver subsystem, so why is it really
> > needed?  What is so special about this driver that distros can't
> > just enable all of the drivers and all is good?  What is keeping those
> > drivers fromb eing enabled?
> 
>  My justification is we have a supposedly generic PCI 8250 UART driver, 
> except it explicitly and silently refuses to handle a handful of devices 
> chosen by their PCI IDs based on that they may have extra features, even 
> though they are otherwise fully compatible with a generic 8250.

 Actually as it happens we do have a precedent too, as here's what I have 
just spotted on my laptop by chance when hibernating:

psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.

(with a distribution kernel, so clearly whoever packaged that has not 
enabled what might be needed).  Someone else wanted to be helpful too as 
it seems.

  Maciej
