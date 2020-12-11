Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70507C4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E58223770
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405495AbgLKISh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:18:37 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:60882 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389785AbgLKISH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 03:18:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 67677123B1E;
        Fri, 11 Dec 2020 09:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607674636;
        bh=fw0CRLnop7lta5hIRJuAVT1kvoifNFSGv0Kp1RHA8xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnTWsh/hWR+rS7K39XfGwPiS4x8NbX2qJuF2GnSKNgG7QSUlDxOVGzkp3pcNJL3wS
         cqwGdAw9f7fnndZL/12DuIzzjAg+qb/OVjN9ap5DhKTJC/lJ3KTr6+1P95hYmfDx29
         UensW3OLzCFQiYIMfZsqeAHOoxq2Ne4+ia4XIypi0/5IEPtyAkbEz+0VpLf1t98rH3
         kiIT40dZ3YgxQvtBtJRfWLMz2AMlA6pfvf39wdg3mVG3zl8hFGDWtjz2IYAnsNJC38
         ZO0rhiyGkTkNWrHTk/UadyV7Rn5BG12ae7DHxreoLKEGjN/VEcW02BFmovf1FdtNcl
         obD4nRmAzJTmw==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4mm9n5moSepJ; Fri, 11 Dec 2020 09:16:37 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 581F5123B1C;
        Fri, 11 Dec 2020 09:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607674597;
        bh=fw0CRLnop7lta5hIRJuAVT1kvoifNFSGv0Kp1RHA8xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPpIrHP9S3zFJ/pkw45eE18pYcr8epaZc+GOlxCDQ2AVNI8L6zQiiDkIunRJcwwu8
         PYBKaP5K6dvhDttJFWezlr/EMqlytxF3Y0JKvncl4rjvOPIto/xYFW7Pe+pvykhbe7
         4CwQAa9GlsDMUNgK1KxcIiwK01A8+IMEGnMqf1GO9w2IO+ReJFbulfwnYtzTLXr16r
         yTk9mHSzr8NDipDsYYluYdevgSuK7QrxoHa6DyXqmjD98M5llRTtrjWjXlLBJE8W60
         QfyJaVZRS2Yt9oZtYBkJaZ/4TRXro+yA25QJqyhzjXebnaRpOIGw6LEI4VEttEc6o8
         CmB+4NElOG5+A==
Date:   Fri, 11 Dec 2020 08:16:34 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <20201211081634.GC1065@dincontrollerdev>
References: <20201210170443.GA17304@dincontrollerdev>
 <X9Jw+srprdT8tquZ@kroah.com>
 <20201210194625.GA17516@dincontrollerdev>
 <X9MIwqJBG69M5uHq@kroah.com>
 <20201211060943.GA1065@dincontrollerdev>
 <X9MPuX1x4MezwkEj@kroah.com>
 <20201211063752.GB1065@dincontrollerdev>
 <X9MgvZ7bWX7HMNir@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9MgvZ7bWX7HMNir@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 08:33:17AM +0100, 'Greg Kroah-Hartman' wrote:
> On Fri, Dec 11, 2020 at 06:37:52AM +0000, József Horváth wrote:
> > On Fri, Dec 11, 2020 at 07:20:41AM +0100, 'Greg Kroah-Hartman' wrote:
> > > On Fri, Dec 11, 2020 at 06:09:43AM +0000, József Horváth wrote:
> > > > On Fri, Dec 11, 2020 at 06:50:58AM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > On Thu, Dec 10, 2020 at 07:46:25PM +0000, József Horváth wrote:
> > > > > > On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > > > On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > > > > > > > This is a serial port driver for
> > > > > > > > Silicon Labs Si4455 Sub-GHz transciver.
> > > > > > > > +
> > > > > > > > +#define BASE_TTYIOC_PRIVATE		0xA0
> > > > > > > > +/* Set EZConfig.
> > > > > > > > + * After this ioctl call, the driver restarts the si4455,
> > > > > > > > + * then apply the new configuration and patch.
> > > > > > > > + */
> > > > > > > > +#define SI4455_IOC_SEZC		_IOW('T', \
> > > > > > > > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > > > > > > > +				     struct si4455_iocbuff)
> > > > > > > 
> > > > > > > Why does a serial driver have private ioctls?  Please no, don't do that.
> > > > > > 
> > > > > > I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
> > > > > > In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.
> > > > > 
> > > > > My point is, a serial driver should NOT have any custom ioctls.
> > > > > 
> > > > > > I can change it to BASE_TTYIOC or SI4455_IOC_BASE
> > > > > > 
> > > > > > > Implement the basic serial driver first, and then we can talk about
> > > > > > > "custom" configurations and the like, using the correct apis.
> > > > > > 
> > > > > > Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
> > > > > > The cofiguration for interface is provided by user for application.
> > > > > 
> > > > > That is what a device tree is for, to configure the device to have the
> > > > > correct system configuration, why can't that be the same here?
> > > > > 
> > > > > > It contains the base frequency, channel spacing, modulation, and a lot
> > > > > > of more stuff, and generated by Silicon Labs Wireless Development
> > > > > > Suite.
> > > > > > The generated configuration is in a non public(compressed,
> > > > > > encrypted...who knows) format, so without this the driver can't
> > > > > > provide configuration parameters to Si4455.
> > > > > 
> > > > > So we have to take a "custom" userspace blob and send it to the device
> > > > > to configure it properly?  Like Jiri said, sounds like firmware, so just
> > > > > use that interface instead.
> > > > 
> > > > I checked Jiri's suggestion, and it is a good solution to replace SI4455_IOC_SEZC(configuration) and SI4455_IOC_SEZP(firmware patch).
> > > > I can move SI4455_IOC_SSIZ(package size) to device tree property.
> > > > 
> > > > Maybe you have good suggestion for the following:
> > > > SI4455_IOC_STXC -> Radio transmit channel index. It is a real use case to control this parameter by user at runtime.
> > > > SI4455_IOC_SRXC -> Radio receive channel index. It is a real use case to control this parameter by user at runtime.
> > > 
> > > These are not serial port things, why would a serial port care about
> > > these?
> > 
> > You are right, these are not regular serial port things, but this device is not a regular uart, it is a sub-GHz transciever, digital radio.
> > This driver tries to represent it as a serial port to user.
> 
> Is that the correct representation to be using here?  Why not act like a
> proper radio device instead?  That way you get to use the normal kernel
> apis for radio devices.

In my mind it is absolute a serial device by the application.

> 
> > > > SI4455_IOC_GRSSI -> Last measured RSSI, when packet received. This is a useful information.
> > > > (Currently I'm the only one user, and I need this :) )
> > > 
> > > What is "RSSI"?
> > > 
> > > And why not debugfs if it's only debugging stuff?
> > 
> > Received signal strength indication, and not only debugging. It is an information for the end user.
> 
> How do other radio devices (like wifi controllers) export this
> information to userspace?  Don't create custom apis for only a single
> device when the goal of a kernel is to make hardware interfaces all work
> the same as far as userspace is concerned.

I move the package size, tx/rx channel properties to dt as device parameter, and the user could control these properties in sysfs and get rssi too. Finally I can remove all custom ioctl commands.
What do you think?

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth

