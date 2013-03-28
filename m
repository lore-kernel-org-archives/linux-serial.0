From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: Make SERIAL8250_CONFIG_RUNTIME_UARTS work
 correctly
Date: Thu, 28 Mar 2013 15:15:34 -0700
Message-ID: <20130328221534.GA23191@kroah.com>
References: <1364502043-13018-1-git-send-email-karthik.manamcheri@ni.com>
 <20130328212254.GA20051@kroah.com>
 <OFCAF9F7AE.C68748CA-ON86257B3C.00771424-86257B3C.00798499@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:38268 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3C1WPg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Mar 2013 18:15:36 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so5090dae.37
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2013 15:15:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <OFCAF9F7AE.C68748CA-ON86257B3C.00771424-86257B3C.00798499@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karthik Manamcheri <karthik.manamcheri@ni.com>
Cc: Karthik Manamcheri <karthik.manamcheri@gmail.com>, linux-serial@vger.kernel.org

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Thu, Mar 28, 2013 at 05:07:18PM -0500, Karthik Manamcheri wrote:
> The config option should have been SERIAL_8250_RUNTIME_UARTS. I mis-typed the
> name of the config option.
> 
> Consider a situation where I have an ARM based system and therefore no legacy
> ports. Say, I have two memory-mapped ports. I use device tree to describe the
> ports. What would be the config options I set so that I get only the two ports
> in my system? I do not want legacy ports being created automatically and I want
> it to be flexible enough that it creates the devices based only on the device
> tree. I expected setting SERIAL_8250_RUNTIME_UARTS = 0 to work because the
> description said, "Set this to the maximum number of serial ports you want the
> kernel to register at boot time." Unfortunately, even though
> SERIAL_8250_NR_UARTS was set to a default value of 4, I did not get any device
> nodes (because SERIAL_8250_RUNTIME_UARTS was 0). This is what this patch is
> trying to address.
> 
> SERIAL_8250_NR_UARTS controls the maximum number of ports you can support.
> SERIAL_8250_RUNTIME_UARTS specifies the number of ports you want to create
> automatically for legacy ports at boot time. All other ports will be created
> when serial8250_register_port is called (and if does not exceed the total
> number of supported ports as specified by SERIAL_8250_NR_UARTS).

Great, care to put all of that into the changelog section of the patch
and resend it after fixing the config option as well?

thanks,

greg "I have to drag it out of people" k-h
