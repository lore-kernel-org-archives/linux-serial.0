Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D6C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459D82083E
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591712546;
	bh=jBRNwa5V6o/6Z4aLrhzGyB42k11bBR4PkaxVf8OBhyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ftZzqPBp9i9IGsfQnwIuvvkkV9HpyCnAdDRFO2exwZlv3MUO/so+4lj3ibP82tPFA
	 PvUWbsViuYrUNz3Oc//9iWocebXtql6XCDyV7DyHU6L/tEwlWRUZ5L8jbPHnSeocNw
	 AGl+tqiQP95TQyOasQm+MVnln61qauwXidjbvAXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFIOWZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbgFIOWW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 10:22:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030A920774;
        Tue,  9 Jun 2020 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591712541;
        bh=jBRNwa5V6o/6Z4aLrhzGyB42k11bBR4PkaxVf8OBhyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8JXmT63rNPnPgS7yWKjEfD6pycVTILQVCA4fLju0pdWfIu5JiIPaOUMPwP1jqUuS
         fQNHTG6E/fvtvuzFNwgtVyPOgAfYhtG+dpWesJ+PUDdhH+7ynK1DzgHqepkXgxqWG8
         HwnwmvLqOV9oQApDio/KBJGG8eyLhEGx+ngH/MC8=
Date:   Tue, 9 Jun 2020 16:22:19 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Message-ID: <20200609142219.GB831428@kroah.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
 <20200609115712.GD819153@kroah.com>
 <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 09, 2020 at 01:13:06PM +0000, Joakim Tjernlund wrote:
> On Tue, 2020-06-09 at 13:57 +0200, Greg KH wrote:
> > 
> > On Tue, Jun 09, 2020 at 11:38:49AM +0000, Joakim Tjernlund wrote:
> > > Hi List
> > > 
> > > I was advised to come here with this problem(started on the USB list).
> > > 
> > > We have a USB to RS232 bridge which presents itself as an ttyACM and the first connect after power on,
> > > we see some garbage chars transmitted back from USB host(PC) to out device which becomes input to
> > > the device.
> > > 
> > > After much debugging I found that this are chars sent early in the boot process which then
> > > are buffered and the TTYs default to ECHO chars is the cause.
> > 
> > So some program in the boot sequence is trying to send data out the
> > device?  Why not just not do that?
> 
> This is the boot console. Both u-boot and Linux prints a lot there, then init prints while starting services

So the same device is used for boot console as well as a ttyACM device
later on?

> > > When the TTY is opened, any chars in the this buffer is ECHOed back over USB to the device,
> > > before one has a chance to disable ECHO. The device then thinks these chars are regular input.
> > 
> > Wait, you said something in the boot process did write to the device,
> > which would have caused the tty to be opened then, right?
> 
> well, boot process of the device prints and it is enough for the USB cable to be attached but not opened by any app.
> The device just see an UART and prints when UART is initialized.

What tool does that?  Why not fix that?

> > > Seems to me that this behaviour is unwanted in general and and app. should get a chance to flush/discard
> > > any chars so this does not happen.
> > 
> > Where are the characters coming from that would need to be flushed?
> 
> Early output from boot, basically whatever prints just after connecting the USB cable.

Then don't have boot print to that device :)

> > When should characters be flushed exactly?
> 
> Whatever is in the buffers before opening the tty.

But what is supposed to happen to the data that was sent to it while it
was "closed"?

> The terminal app(like cu) tries to flush any input when it starts, just to avoid any old chars in the
> queue but it is to late then.

I strongly just suggest having userspace not write to the device to
start with, that would solve this, right?

thanks,

greg k-h
