Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C9C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 10:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhLTKmq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:42:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39410 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhLTKmq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 05:42:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7A860F7D
        for <linux-serial@vger.kernel.org>; Mon, 20 Dec 2021 10:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77578C36AE7;
        Mon, 20 Dec 2021 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639996965;
        bh=ModzByBE4K+e6fnzbXHUKm5QJtVbtiyM0AQZ7InN+So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdeGgAY325RTrWvGVv2pHWQJXjUQNct6OQjqFbmSlWLNa/hzjnfthydCV9a6jqv7B
         HCpTIKqNojE/P9vFmGW9zEhyd3J/aIBRYcpKKh3PpgVmo/+C26f45Jobv5YcWTsdbe
         Lzu/PlRu9AihzlxoSbbGREXIxFsiKxLwj63JTthQ=
Date:   Mon, 20 Dec 2021 11:42:37 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jun Miao <jun.miao@intel.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [BUG report]: serial8250 unbind/bind failture
Message-ID: <YcBeHUTb8TnQBphS@kroah.com>
References: <DM6PR11MB47391ECD2402AB4F521DAC869A7B9@DM6PR11MB4739.namprd11.prod.outlook.com>
 <YcBThJYwRk1i9emo@kroah.com>
 <3f82cdd9-c1d9-2dfb-45b0-55d0a419c96a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f82cdd9-c1d9-2dfb-45b0-55d0a419c96a@intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 20, 2021 at 09:08:19PM +0800, Jun Miao wrote:
> 
> On 2021/12/20 17:57, gregkh@linuxfoundation.org wrote:
> > On Mon, Dec 20, 2021 at 09:54:41AM +0000, Miao, Jun wrote:
> > > [Hardware]
> > > Intel Corporation Alder Lake Client Platform/AlderLake-M LP5 RVP, BIOS ADLPFWI1.R00.2265.A01.2107010436 07/01/2021
> > > About x86 old UART, not the PNP device.
> > > 
> > > [how to reproduce]
> > > root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > unbind
> > > root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > bind
> > After you unbound, this device is gone, so how does this path still
> > work?
> > 
> > > [What`s my Confusion]
> > > After the unbind and bind the serial8250_probe cannot register ttyS0.
> > Then do not do that :)
> 
> Hi maintainer,
> 
> Thanks your reply so quickly.
> 
> You mean, this operation is useless and should don`t do that.

Why do you think it is useful?

> But , if this is a PNP device,  it can probe successfully after unbind/bind.

Is that possible?  If so, how?  Has it ever worked before?  Who requires
this to work?  Does this bus and hardware support this type of
functionality for this hardware device?

> > > And there is not dmesg like this: "serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A".
> > > 
> > > Any one have some advice about 8250 serial ?  It is a common operation if we believe that the old UART which don`t support like this unbind. Or we ignore about this really bug before?
> > What are you trying to do here exactly?  Why are you wanting to unbind
> > the driver from this device?  Why do you then want to bind it again?
> > What problem are you trying to solve by doing this?
> > 
> > thanks,
> > 
> > greg k-h
> 
> There is a testcase to test UART by unbind/bind.   i want to support it on
> old uart  of serial8250 .

Who created this test case and what were they expecting to have happen?
What are they thinking this test case should be doing?  Is this a new
functionality that they need Linux to support?  If so, then new code
probably has to be written :)

bind/unbind is a "best effort" type of thing, not all busses and
hardware types support this at all.

thanks,

greg k-h
