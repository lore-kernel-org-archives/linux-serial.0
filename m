Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D980C1B0D9
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 06:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E4823EB2
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 06:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbgLKGjO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:39:14 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:40666 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbgLKGjG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 01:39:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 44C51123B18;
        Fri, 11 Dec 2020 07:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607668704;
        bh=ugkcwpsp8hU79DcK5AY9md1R6//9xinfQewzn4Q8jzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6hZeKgX2tuj5Ea4LNct2Mmy9dnCcG4FF0HAHspcVrp+tRX6xLvRIqamJTljQZg7T
         X30Kdu9ObP6Jlr+F61Cxe1lJX2jt0AenXZ5ubJq9UDoaLUgPCXP4CS3pZ5oofXsNbD
         fYv21Y0X0qNijCF6gIZSEjXlNQeVai3y3Az6qJnadNimCRqiq/EEC4R4RAJrdWd1NH
         SHcu1Y+1G2PbE4xnFEck26qLx5dRl4zlnzrlm92o3OqPXcjsEwm3lIhoSlZBnTbei9
         sROqoQyRkQpub1jcb+QEQTYjx1AOrfSLZ5t01FmrkupJ/+ffUkh/8xKSQSfIhUcyot
         S3OuNQ0/FWgIQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y3PUCZX0RggV; Fri, 11 Dec 2020 07:37:55 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id D890C123B16;
        Fri, 11 Dec 2020 07:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607668675;
        bh=ugkcwpsp8hU79DcK5AY9md1R6//9xinfQewzn4Q8jzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6BS2qVvBohPiHfw6I3DUYpNU+2rFywI7q4EyfuEleJoA5BNxC5nO1IVx29veILe3
         s5igpTUYgQkl6TM7EczT0o+vQ1FFOYrWGm0Gstcg3l8HRN3y2Y/91/Bq58SGUaib7A
         invJv1mZ8LDDshjyUGR9Vtp4Qysg2WU3O9h86bNbOYvrZeBw2uwnULiajVoH4eiMpB
         I7M8Or/jb0VQYhaCKZSpW1BANkJ6XfZD2ADTWjgndd1UsQV/CbOKDD1U4nHOWR6f+d
         sUUWWU8Al78/HQjt51EQKMqnN1XIbgckX7IPh1aqJmLIZHc+aaYCFf6j1MBDgAZ7Jv
         3h4uZvGEKf5CA==
Date:   Fri, 11 Dec 2020 06:37:52 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <20201211063752.GB1065@dincontrollerdev>
References: <20201210170443.GA17304@dincontrollerdev>
 <X9Jw+srprdT8tquZ@kroah.com>
 <20201210194625.GA17516@dincontrollerdev>
 <X9MIwqJBG69M5uHq@kroah.com>
 <20201211060943.GA1065@dincontrollerdev>
 <X9MPuX1x4MezwkEj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9MPuX1x4MezwkEj@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 07:20:41AM +0100, 'Greg Kroah-Hartman' wrote:
> On Fri, Dec 11, 2020 at 06:09:43AM +0000, József Horváth wrote:
> > On Fri, Dec 11, 2020 at 06:50:58AM +0100, 'Greg Kroah-Hartman' wrote:
> > > On Thu, Dec 10, 2020 at 07:46:25PM +0000, József Horváth wrote:
> > > > On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> > > > > On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > > > > > This is a serial port driver for
> > > > > > Silicon Labs Si4455 Sub-GHz transciver.
> > > > > > +
> > > > > > +#define BASE_TTYIOC_PRIVATE		0xA0
> > > > > > +/* Set EZConfig.
> > > > > > + * After this ioctl call, the driver restarts the si4455,
> > > > > > + * then apply the new configuration and patch.
> > > > > > + */
> > > > > > +#define SI4455_IOC_SEZC		_IOW('T', \
> > > > > > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > > > > > +				     struct si4455_iocbuff)
> > > > > 
> > > > > Why does a serial driver have private ioctls?  Please no, don't do that.
> > > > 
> > > > I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
> > > > In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.
> > > 
> > > My point is, a serial driver should NOT have any custom ioctls.
> > > 
> > > > I can change it to BASE_TTYIOC or SI4455_IOC_BASE
> > > > 
> > > > > Implement the basic serial driver first, and then we can talk about
> > > > > "custom" configurations and the like, using the correct apis.
> > > > 
> > > > Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
> > > > The cofiguration for interface is provided by user for application.
> > > 
> > > That is what a device tree is for, to configure the device to have the
> > > correct system configuration, why can't that be the same here?
> > > 
> > > > It contains the base frequency, channel spacing, modulation, and a lot
> > > > of more stuff, and generated by Silicon Labs Wireless Development
> > > > Suite.
> > > > The generated configuration is in a non public(compressed,
> > > > encrypted...who knows) format, so without this the driver can't
> > > > provide configuration parameters to Si4455.
> > > 
> > > So we have to take a "custom" userspace blob and send it to the device
> > > to configure it properly?  Like Jiri said, sounds like firmware, so just
> > > use that interface instead.
> > 
> > I checked Jiri's suggestion, and it is a good solution to replace SI4455_IOC_SEZC(configuration) and SI4455_IOC_SEZP(firmware patch).
> > I can move SI4455_IOC_SSIZ(package size) to device tree property.
> > 
> > Maybe you have good suggestion for the following:
> > SI4455_IOC_STXC -> Radio transmit channel index. It is a real use case to control this parameter by user at runtime.
> > SI4455_IOC_SRXC -> Radio receive channel index. It is a real use case to control this parameter by user at runtime.
> 
> These are not serial port things, why would a serial port care about
> these?

You are right, these are not regular serial port things, but this device is not a regular uart, it is a sub-GHz transciever, digital radio.
This driver tries to represent it as a serial port to user.

> 
> > SI4455_IOC_GRSSI -> Last measured RSSI, when packet received. This is a useful information.
> > (Currently I'm the only one user, and I need this :) )
> 
> What is "RSSI"?
> 
> And why not debugfs if it's only debugging stuff?

Received signal strength indication, and not only debugging. It is an information for the end user.

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth


