Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C400C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198B220760
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591773882;
	bh=sEYiNe+25VZ/lesuUmLPL1RJyNlc2x6zDAXECZaQ+6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jh/4Wf8swyBb5vgBHzZQ7gfM2QAuDxI3TxSWRNllazYL83JoKEG4QpiYsKSzZPc/i
	 Cv2KgejTVz4znczvOVOEZV6ENwJ3MfkNa+BG84BP9sA8m81B/61Rg6Nxc6PxSgdqVO
	 n2HmKyq/MeEP8cYhTd0eYB0kPBtvfrMdCDcXsZyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFJHYl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJHYl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 03:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEFB2064C;
        Wed, 10 Jun 2020 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591773880;
        bh=sEYiNe+25VZ/lesuUmLPL1RJyNlc2x6zDAXECZaQ+6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/0nShjyqvKyK+gJjeo8BKz1Vb9raBdh1V+cRj0CzN0dPG1ger04cdSMRUr1YYs/X
         tU5LiHm8ZCaqC66W1pwKNJKterI7/1y7WeRHyY65OweYO7A9Tis/lUIseYSneg08hn
         7e84b/DByRWq5jpTorC+4QC2aczd9d+4qK7r0wyo=
Date:   Wed, 10 Jun 2020 09:24:38 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Message-ID: <20200610072438.GG1923109@kroah.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
 <20200609115712.GD819153@kroah.com>
 <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
 <20200609142219.GB831428@kroah.com>
 <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 09, 2020 at 03:01:14PM +0000, Joakim Tjernlund wrote:
> On Tue, 2020-06-09 at 16:22 +0200, gregkh@linuxfoundation.org wrote:
> > 
> > On Tue, Jun 09, 2020 at 01:13:06PM +0000, Joakim Tjernlund wrote:
> > > On Tue, 2020-06-09 at 13:57 +0200, Greg KH wrote:
> > > > On Tue, Jun 09, 2020 at 11:38:49AM +0000, Joakim Tjernlund wrote:
> > > > > Hi List
> > > > > 
> > > > > I was advised to come here with this problem(started on the USB list).
> > > > > 
> > > > > We have a USB to RS232 bridge which presents itself as an ttyACM and the first connect after power on,
> > > > > we see some garbage chars transmitted back from USB host(PC) to out device which becomes input to
> > > > > the device.
> > > > > 
> > > > > After much debugging I found that this are chars sent early in the boot process which then
> > > > > are buffered and the TTYs default to ECHO chars is the cause.
> > > > 
> > > > So some program in the boot sequence is trying to send data out the
> > > > device?  Why not just not do that?
> > > 
> > > This is the boot console. Both u-boot and Linux prints a lot there, then init prints while starting services
> > 
> > So the same device is used for boot console as well as a ttyACM device
> > later on?
> 
> Not quite, the USB to RS232 chip is integrated on the device and is connected the CPUs RS232,
> there is no other port.
> I think you could compare with an external USB to RS232 puck. Senario:
> - Connect the puck to both computer and your device with an RS232 port.
> - Power on the device with the RS232 port.
> - Device "boots" and prints stuff on its RS232 port,
> 
> some time passes
> 
> - Open ttyACM in PC using minicom/cu
> Now early history of the boot prints are echoed back from PC to device with RS232

Ah, ok, so, are you sure that data isn't just "stuck" in the USB-serial
chip's buffers?  That's often the case with many devices as they are
tiny and dumb and try to do the right thing most of the time (like not
drop data that was sent to it.)

thanks,

greg k-h
