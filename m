Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A3DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C770264EDC
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhBYImp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Feb 2021 03:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhBYImo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Feb 2021 03:42:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 433EE64EDB;
        Thu, 25 Feb 2021 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614242522;
        bh=QBi0B0RUXEm0tnf/vuL2s9mtVapBPFsksrkFZovRl2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FR/B9mFzRMSj6WTidFhV5qRUTJrBSR8ohnVl0fqHKIHfod5sdJR8juKrMYh6a5cm6
         1v/AWJJaOndrUqfrm9k+RQWa01RjbsWhsWFU78Rjwvnjb5EyipF9cWcDfZOcsFgRiC
         /Lbidmj3aAAL2OFsHiJirT6wSEpYPYRv5pqDTh3Cg3doaPI/yczjl9rZO5XiIB8GG3
         VFVMWXdf6ObbveTXg1KKMakUvOoDgrZ8cs0d0Z8pNxc3CPSSwLhYc5uu8q1G0FJ0Lh
         QO78rnQ2evadvWWhPv7EuhmULDeu4S++14kPdzxBoZsK0WEr8NAtpcjvNjR9A9fcSm
         3o5T8U6O7mqew==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lFCE0-00082Q-CI; Thu, 25 Feb 2021 09:42:21 +0100
Date:   Thu, 25 Feb 2021 09:42:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDdi7NcnzgQDMzZH@hovoldconsulting.com>
References: <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
 <YDaHEtQCGkiM/pad@hovoldconsulting.com>
 <2162ce18-32e9-e54c-f266-47febdea11f1@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2162ce18-32e9-e54c-f266-47febdea11f1@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 24, 2021 at 01:13:39PM -0500, Michael G. Katzmann wrote:
> On 2/24/21 12:04 PM, Johan Hovold wrote:
> > Perhaps you can even figure out how to poll for an empty TX FIFO from
> > it, unless Charles is able to provide some details on that separate
> > matter?
> 
> I presume from the code below, that when the device is closed, all
> data waiting to send is clobbered (if so, so the problem is the driver
> and not the device)
> 
> I would have thought that the driver should drain the buffers. I can
> see that this might be a problem if there is flow control (it may
> never drain) but the current method seems pretty brutal.

We do; the code below isn't called until after we've waited for the
buffers to drain (driver buffers + device FIFO).

I'll provide a patch so that you can extend the timeout for draining the
driver buffers (defaults to 30 s), but the main problem is that we don't
know how to query the PL2303 FIFO fill level.

> 119 void usb_serial_generic_close(struct usb_serial_port *port)
> 120 {
> 121         unsigned long flags;
> 122         int i;
> 123
> 124         if (port->bulk_out_size) {
> 125                 for (i = 0; i < ARRAY_SIZE(port->write_urbs); ++i)
> 126                         usb_kill_urb(port->write_urbs[i]);
> 127
> 128                 spin_lock_irqsave(&port->lock, flags);
> 129                 kfifo_reset_out(&port->write_fifo);
> 130                 spin_unlock_irqrestore(&port->lock, flags);
> 131         }
> 132         if (port->bulk_in_size) {
> 133                 for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i)
> 134                         usb_kill_urb(port->read_urbs[i]);
> 135         }
> 136 }

Johan
