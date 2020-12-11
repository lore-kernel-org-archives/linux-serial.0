Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A62C4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 06:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0BB23F2B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 06:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395463AbgLKGLX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:11:23 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:34642 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390863AbgLKGLH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 01:11:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 3D420123B16;
        Fri, 11 Dec 2020 07:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607667016;
        bh=6kS5gL6N73YvYSzIt+4DLpz4DbOxzlgqvdiiuCRDJys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=52hxKpCgXch9EL+X9cy06GynYK5wmNLbo4EMlaBsv6iE/4gW+D/WBme3PxCCqOWXB
         8TsNPThLJd8EmfekExTSnKggR2KN7qgmkFu6eWwSWJaOvtEsSN8+u53WtyI0tb7KZ8
         kP6gK2fCxfoKLvdFDq29CwlFPv3KHOsq5KbDBbpA2EE7bBW32fC0C1TVFr7iAM28Pd
         VGQvxzd7eIQ61irqIZFTf9Vrd+2eLfv/lspIcoY3DgRCMflC86yhQoIcWgwsy+GE55
         Il3ZIC3MT2ZZSDcWRgipakYdn001M8DblqAF8cH25iYO2kM+GzT5yINfym6q8dYufB
         kur0UtmOqJmGw==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HMmVd6l5MS9K; Fri, 11 Dec 2020 07:09:46 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id C262D123B08;
        Fri, 11 Dec 2020 07:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607666986;
        bh=6kS5gL6N73YvYSzIt+4DLpz4DbOxzlgqvdiiuCRDJys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQNZB+sKFfbKuGIzeuoMTSxf3vcGWrtLfNMRu7EYturDr3IhQSd+NY4Z9UX7FvQWB
         wGLAONj/86q2LVl8lnyl0i8KysE5lTf51S1RHi7xVTQFkzF+uL4qeyvUSqiq9BG1pI
         uBJRikugFxdGrBJdTgsZu65SQDCF7c7DO3lIseyR2qPIbiOmTKU5mhwsb2wuUuqk9E
         SwcZPNzwoIEpeWyUICYTjZOfBM2oxwJjvff37E9lKzR0oQUPNWVG8KACu0BwYLlMOD
         zeWfzsvsdFsCtc9F8i2mH2nE74J/PkqS7awh+U8b0soqgPwH9Eob6QaMQjY/UtajNJ
         bjE7tK03ZFVvQ==
Date:   Fri, 11 Dec 2020 06:09:43 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <20201211060943.GA1065@dincontrollerdev>
References: <20201210170443.GA17304@dincontrollerdev>
 <X9Jw+srprdT8tquZ@kroah.com>
 <20201210194625.GA17516@dincontrollerdev>
 <X9MIwqJBG69M5uHq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9MIwqJBG69M5uHq@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 06:50:58AM +0100, 'Greg Kroah-Hartman' wrote:
> On Thu, Dec 10, 2020 at 07:46:25PM +0000, József Horváth wrote:
> > On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> > > On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > > > This is a serial port driver for
> > > > Silicon Labs Si4455 Sub-GHz transciver.
> > > > +
> > > > +#define BASE_TTYIOC_PRIVATE		0xA0
> > > > +/* Set EZConfig.
> > > > + * After this ioctl call, the driver restarts the si4455,
> > > > + * then apply the new configuration and patch.
> > > > + */
> > > > +#define SI4455_IOC_SEZC		_IOW('T', \
> > > > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > > > +				     struct si4455_iocbuff)
> > > 
> > > Why does a serial driver have private ioctls?  Please no, don't do that.
> > 
> > I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
> > In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.
> 
> My point is, a serial driver should NOT have any custom ioctls.
> 
> > I can change it to BASE_TTYIOC or SI4455_IOC_BASE
> > 
> > > Implement the basic serial driver first, and then we can talk about
> > > "custom" configurations and the like, using the correct apis.
> > 
> > Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
> > The cofiguration for interface is provided by user for application.
> 
> That is what a device tree is for, to configure the device to have the
> correct system configuration, why can't that be the same here?
> 
> > It contains the base frequency, channel spacing, modulation, and a lot
> > of more stuff, and generated by Silicon Labs Wireless Development
> > Suite.
> > The generated configuration is in a non public(compressed,
> > encrypted...who knows) format, so without this the driver can't
> > provide configuration parameters to Si4455.
> 
> So we have to take a "custom" userspace blob and send it to the device
> to configure it properly?  Like Jiri said, sounds like firmware, so just
> use that interface instead.

I checked Jiri's suggestion, and it is a good solution to replace SI4455_IOC_SEZC(configuration) and SI4455_IOC_SEZP(firmware patch).
I can move SI4455_IOC_SSIZ(package size) to device tree property.

Maybe you have good suggestion for the following:
SI4455_IOC_STXC -> Radio transmit channel index. It is a real use case to control this parameter by user at runtime.
SI4455_IOC_SRXC -> Radio receive channel index. It is a real use case to control this parameter by user at runtime.
SI4455_IOC_GRSSI -> Last measured RSSI, when packet received. This is a useful information.
(Currently I'm the only one user, and I need this :) )

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth


