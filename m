Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5ECC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8DF20812
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591703844;
	bh=U5cRHD9oynGB8W5eaa6106YhosgjR13Vgd3Md26JLAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V2CLyNRtJBGlhBnBqcQnPvzBl7xg/Nvgtc+foIraTFR+NKRTaYNabzufrcSos+O1T
	 rCADrAj+EVkzFe9WAgiQqp/GaepscY9NUqtA9ogIXeGdO9sO3rmYqYt4FnWJ2bIUCL
	 yTp9RE8JcRYymKUd11VuyrqF0zocvY4oqMWbuDYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgFIL5X (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFIL5P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 07:57:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9892078D;
        Tue,  9 Jun 2020 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591703834;
        bh=U5cRHD9oynGB8W5eaa6106YhosgjR13Vgd3Md26JLAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sv54t4tkC1B1bGWfQAQwB+zObaK9nfy1W2FM8WZQgJIeA9nRX5RvcsuzMhWjnN9/7
         H6EggVhqfY8PgnoZMqIfcZJO2Ci4ve2GT/pyje9Pdi/HxjSkZnl0iX/CozjBxbiHNM
         FikUcItHezb+15LZWPUDZq5czCrj7i67tJhsHUts=
Date:   Tue, 9 Jun 2020 13:57:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Message-ID: <20200609115712.GD819153@kroah.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 09, 2020 at 11:38:49AM +0000, Joakim Tjernlund wrote:
> Hi List
> 
> I was advised to come here with this problem(started on the USB list).
> 
> We have a USB to RS232 bridge which presents itself as an ttyACM and the first connect after power on,
> we see some garbage chars transmitted back from USB host(PC) to out device which becomes input to
> the device.
> 
> After much debugging I found that this are chars sent early in the boot process which then
> are buffered and the TTYs default to ECHO chars is the cause.

So some program in the boot sequence is trying to send data out the
device?  Why not just not do that?

> When the TTY is opened, any chars in the this buffer is ECHOed back over USB to the device,
> before one has a chance to disable ECHO. The device then thinks these chars are regular input.

Wait, you said something in the boot process did write to the device,
which would have caused the tty to be opened then, right?

> Seems to me that this behaviour is unwanted in general and and app. should get a chance to flush/discard
> any chars so this does not happen.

Where are the characters coming from that would need to be flushed?
When should characters be flushed exactly?

thanks,

greg k-h
