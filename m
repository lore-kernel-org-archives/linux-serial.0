Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B15C001DF
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 15:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGaPOU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGaPOT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 11:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC110E3;
        Mon, 31 Jul 2023 08:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8913961199;
        Mon, 31 Jul 2023 15:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66798C433C7;
        Mon, 31 Jul 2023 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690816457;
        bh=605GW2aMkhzlVNmIzbk6AaScUygEfZfjwao24uZgIYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoG8K1WVKPcyrUiHhZM7uwHu45VgRZFKfXtDx6DqttMU+LxUrCPU7pOr0imgCv2FS
         TVd0PBOKW6Cmo1CmH34at4/nUrxUV/XZO7ll5v0iXhR1n1ozjpITT037ERKVS/J38k
         DiLpuwtIjj1T9cWJqZZxnIzNSPCfds2NQAT6q9eY=
Date:   Mon, 31 Jul 2023 17:14:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <2023073158-ungraded-carefully-6af3@gregkh>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
 <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 25, 2023 at 12:07:04PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> > We are missing the serial core controller id for the serial core port
> > name. Let's fix the issue for sane sysfs output, and to avoid issues
> > addressing serial ports later on.
> > 
> > And as we're now showing the controller id, the "ctrl" and "port" prefix
> > for the DEVNAME become useless, we can just drop them. Let's standardize on
> > DEVNAME:0 for controller name, where 0 is the controller id. And
> > DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> > 
> > This makes the sysfs output nicer, on qemu for example:
> > 
> > $ ls /sys/bus/serial-base/devices
> > 00:04:0         serial8250:0    serial8250:0.2
> > 00:04:0.0       serial8250:0.1  serial8250:0.3
> 
> Hmm... Why 0.0 is absent for serial8250?
> Btw, what was before this patch there?
> And maybe ls -l will look more informative?
> 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Andy, I kept your Reviewed-by although I updated the device naming and
> > description, does the patch still look OK to you?
> 
> Looks okay, but I have a question above.

Can I get an ack for this if you are ok with these fixes?

thanks,

greg k-h
