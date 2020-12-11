Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E5C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E9222D2A
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgLKMJj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 07:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389342AbgLKMJF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 07:09:05 -0500
Date:   Fri, 11 Dec 2020 13:09:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607688503;
        bh=41rS8U52qZEUqZ7Xg2L67KOIODeUL5vsHKWqEJrq3PY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHNI8D5uOwfHjKS+cWBLwZ0CjZq9PhyzDYeD/RKhSB8O2yaSz6s7CWRprq6HDrIpW
         Y/LGtZrskpkFmtyZmHNjERogoKuUR0fTZvICbxeWa297qH/ZHEZW32TNbugsC76gTP
         IEoWW4J62N7D8fqqEANDZScrAj6PO1FhFTvaLvyU=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <X9NhfyEuPTxezHt9@kroah.com>
References: <X9Jw+srprdT8tquZ@kroah.com>
 <20201210194625.GA17516@dincontrollerdev>
 <X9MIwqJBG69M5uHq@kroah.com>
 <20201211060943.GA1065@dincontrollerdev>
 <X9MPuX1x4MezwkEj@kroah.com>
 <20201211063752.GB1065@dincontrollerdev>
 <X9MgvZ7bWX7HMNir@kroah.com>
 <20201211081634.GC1065@dincontrollerdev>
 <X9MxM+aEKIAHqd4G@kroah.com>
 <20201211091823.GD1065@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201211091823.GD1065@dincontrollerdev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 09:18:24AM +0000, József Horváth wrote:
> On Fri, Dec 11, 2020 at 09:43:31AM +0100, 'Greg Kroah-Hartman' wrote:
> > On Fri, Dec 11, 2020 at 08:16:34AM +0000, József Horváth wrote:
> > > On Fri, Dec 11, 2020 at 08:33:17AM +0100, 'Greg Kroah-Hartman' wrote:
> > > > On Fri, Dec 11, 2020 at 06:37:52AM +0000, József Horváth wrote:
> > > > > On Fri, Dec 11, 2020 at 07:20:41AM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > > On Fri, Dec 11, 2020 at 06:09:43AM +0000, József Horváth wrote:
> > > > > > > On Fri, Dec 11, 2020 at 06:50:58AM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > > > > On Thu, Dec 10, 2020 at 07:46:25PM +0000, József Horváth wrote:
> > > > > > > > > On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > > > > > > On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > > > > > > > > > > This is a serial port driver for
> > > > > > > > > > > Silicon Labs Si4455 Sub-GHz transciver.
> > > > > > > > > > > +
> > > > > > > > > > > +#define BASE_TTYIOC_PRIVATE		0xA0
> > > > > > > > > > > +/* Set EZConfig.
> > > > > > > > > > > + * After this ioctl call, the driver restarts the si4455,
> > > > > > > > > > > + * then apply the new configuration and patch.
> > > > > > > > > > > + */
> > > > > > > > > > > +#define SI4455_IOC_SEZC		_IOW('T', \
> > > > > > > > > > > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > > > > > > > > > > +				     struct si4455_iocbuff)
> > > > > > > > > > 
> > > > > > > > > > Why does a serial driver have private ioctls?  Please no, don't do that.
> > > > > > > > > 
> > > > > > > > > I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
> > > > > > > > > In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.
> > > > > > > > 
> > > > > > > > My point is, a serial driver should NOT have any custom ioctls.
> > > > > > > > 
> > > > > > > > > I can change it to BASE_TTYIOC or SI4455_IOC_BASE
> > > > > > > > > 
> > > > > > > > > > Implement the basic serial driver first, and then we can talk about
> > > > > > > > > > "custom" configurations and the like, using the correct apis.
> > > > > > > > > 
> > > > > > > > > Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
> > > > > > > > > The cofiguration for interface is provided by user for application.
> > > > > > > > 
> > > > > > > > That is what a device tree is for, to configure the device to have the
> > > > > > > > correct system configuration, why can't that be the same here?
> > > > > > > > 
> > > > > > > > > It contains the base frequency, channel spacing, modulation, and a lot
> > > > > > > > > of more stuff, and generated by Silicon Labs Wireless Development
> > > > > > > > > Suite.
> > > > > > > > > The generated configuration is in a non public(compressed,
> > > > > > > > > encrypted...who knows) format, so without this the driver can't
> > > > > > > > > provide configuration parameters to Si4455.
> > > > > > > > 
> > > > > > > > So we have to take a "custom" userspace blob and send it to the device
> > > > > > > > to configure it properly?  Like Jiri said, sounds like firmware, so just
> > > > > > > > use that interface instead.
> > > > > > > 
> > > > > > > I checked Jiri's suggestion, and it is a good solution to replace SI4455_IOC_SEZC(configuration) and SI4455_IOC_SEZP(firmware patch).
> > > > > > > I can move SI4455_IOC_SSIZ(package size) to device tree property.
> > > > > > > 
> > > > > > > Maybe you have good suggestion for the following:
> > > > > > > SI4455_IOC_STXC -> Radio transmit channel index. It is a real use case to control this parameter by user at runtime.
> > > > > > > SI4455_IOC_SRXC -> Radio receive channel index. It is a real use case to control this parameter by user at runtime.
> > > > > > 
> > > > > > These are not serial port things, why would a serial port care about
> > > > > > these?
> > > > > 
> > > > > You are right, these are not regular serial port things, but this device is not a regular uart, it is a sub-GHz transciever, digital radio.
> > > > > This driver tries to represent it as a serial port to user.
> > > > 
> > > > Is that the correct representation to be using here?  Why not act like a
> > > > proper radio device instead?  That way you get to use the normal kernel
> > > > apis for radio devices.
> > > 
> > > In my mind it is absolute a serial device by the application.
> > 
> > What is the application?  Traditionally serial ports don't need radio signals :)
> 
> The application is connecting newly developed sensors(with only rf interface) and legacy sensors(with regular serial communication over rs-485 with modbus) keeping the legacy user software.
> 
> User sw [Java]
> 	<-> /dev/ttyXXX
> 		<-> si4455[driver]
> 			<-> si4455[hardware]
> 				<---air---> new device[si4455+ARM Cortex-M0] 1
> 					+-> new device[si4455+ARM Cortex-M0] 2
> 					+-> new device[si4455+ARM Cortex-M0] n
> 					+-> gateway[si4455+ARM Cortex-M0]<---RS485--> Legacy device 1
> 										  +-> Legacy device 2
> 										  +-> Legacy device n

If these are "sensors", why are you using a tty interface at all, and
not just using the correct iio interface for them?

thanks,

greg k-h
