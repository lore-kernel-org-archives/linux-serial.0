Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23CCC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Feb 2022 12:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbiBKMDM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:03:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349882AbiBKMDH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Feb 2022 07:03:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF44BE4
        for <linux-serial@vger.kernel.org>; Fri, 11 Feb 2022 04:03:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3810BB8294F
        for <linux-serial@vger.kernel.org>; Fri, 11 Feb 2022 12:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA3C340E9;
        Fri, 11 Feb 2022 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644580946;
        bh=B7S6Nht4YEJD3EkKnDtdsz/IZN5Eo6mSDt0NHhWEu/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5Vce3Fiq102FxU8LAJD466axNPztwNpfaX1+GarOyeyPE/jHDH4UZonv78OtHSoP
         5wMuQODbI+NkQTBFUJuj3qIy3nXIlMoXj1XI8gK4zrjcEk8fYjU55mjXu31/AyySyC
         eLLNBlAxCQ0vBOBYqxHQIy0YJQXHIpgvZ9S6pd/w=
Date:   Fri, 11 Feb 2022 13:02:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     Richard.Petrie@microchip.com, linux-serial@vger.kernel.org,
        Sundararaman.H@microchip.com, Ronnie.Kunin@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com, Annirudh.D@microchip.com,
        Pragash.Mangalapandian@microchip.com
Subject: Re: Reg: Serial port driver for microchip's new PCIe UART device
Message-ID: <YgZQT9SFWQcXm9C7@kroah.com>
References: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YgOl6SFsKnZxkbFy@kroah.com>
 <CH0PR11MB5380EE38DD9B8BF9EE5F1796E92F9@CH0PR11MB5380.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB5380EE38DD9B8BF9EE5F1796E92F9@CH0PR11MB5380.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 10, 2022 at 10:38:39AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > > We are working on a PCIe based multi-instance UART device.
> > > Based on the Linux community feedback few months back, we had written
> > it as a custom driver inside drivers/tty/serial/8250.
> > > Now this custom driver is requiring a DWORD FIFO access for both Tx and
> > Rx, and I am in the process of changing my driver code.
> > 
> > Why does the hardware not follow the normal standard here?
> We are building a PCIe 8250 based UART.  We can absolutely support the normal 8250 framework and standard drivers. 
> However, the challenges we see are the round-trip delays introduced by PCIe reads and writes having an impact on throughput, particularly if you are downstream of a PCIe tree with multiple hops.
> The sizes of the payloads are limited to 32-bit by the processor PIO, however, even going from 8-bit payloads to 32-bit payloads improves throughput dramatically.

What specific reads are you having problems with?

Why not just use DMA like other PCIe serial port cards do, which we have
supported for decades now.

> > And are you sure it will still not fit into the 8250 format?
> As mentioned our hardware can support this, however, we see that it is less efficient due to the requirement for single byte reads and writes.

Again, which reads/writes are taking a long time?  And again, why not
use DMA for the data instead?

> > > Can I model my custom driver on serial drivers present in drivers/tty/serial/
> > directory?
> > 
> > You could, but it would be much smaller and easier to use the 8250
> > framework given that you probably do have an 8250-like device, right?
> Adding DWORD reads/writes to the hardware is a necessary enhancement for improved performance over PCIe.
> But 8250 framework looks very closely tied with reading character by character from the FIFO and I was not able to find a place in that framework where I could hook my own DWORD based Rx and Tx logic.
> Is there any DWORD based UART FIFO driver example with 8250 framework available?

All of the code is there for you to read :)

thanks,

greg k-h
