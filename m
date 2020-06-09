Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77399C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5816F2072F
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFIV1K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:27:10 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:56891 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725894AbgFIV1J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 17:27:09 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Tue, 9 Jun 2020 23:26:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 23:26:45 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        oneukum@suse.com, linux-serial-owner@vger.kernel.org
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
In-Reply-To: <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
 <20200609115712.GD819153@kroah.com>
 <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
 <20200609142219.GB831428@kroah.com>
 <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
Message-ID: <3ca5a08d5858cf7f170046122c04313c@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-06-09 17:01, Joakim Tjernlund wrote:
> On Tue, 2020-06-09 at 16:22 +0200, gregkh@linuxfoundation.org wrote:
>> 
>> On Tue, Jun 09, 2020 at 01:13:06PM +0000, Joakim Tjernlund wrote:
>> > On Tue, 2020-06-09 at 13:57 +0200, Greg KH wrote:
>> > > On Tue, Jun 09, 2020 at 11:38:49AM +0000, Joakim Tjernlund wrote:
>> > > > Hi List
>> > > >
>> > > > I was advised to come here with this problem(started on the USB list).
>> > > >
>> > > > We have a USB to RS232 bridge which presents itself as an ttyACM and the first connect after power on,
>> > > > we see some garbage chars transmitted back from USB host(PC) to out device which becomes input to
>> > > > the device.
>> > > >
>> > > > After much debugging I found that this are chars sent early in the boot process which then
>> > > > are buffered and the TTYs default to ECHO chars is the cause.
>> > >
>> > > So some program in the boot sequence is trying to send data out the
>> > > device?  Why not just not do that?
>> >
>> > This is the boot console. Both u-boot and Linux prints a lot there, then init prints while starting services
>> 
>> So the same device is used for boot console as well as a ttyACM device
>> later on?
> 
> Not quite, the USB to RS232 chip is integrated on the device and is
> connected the CPUs RS232,
> there is no other port.
> I think you could compare with an external USB to RS232 puck. Senario:
> - Connect the puck to both computer and your device with an RS232 port.
> - Power on the device with the RS232 port.
> - Device "boots" and prints stuff on its RS232 port,
> 
> some time passes
> 
> - Open ttyACM in PC using minicom/cu
> Now early history of the boot prints are echoed back from PC to device
> with RS232

It sounds like either the USB-RS232 device or the ttyACM driver are 
holding
the incoming data over RS232 even though there is no open connection 
over
USB. My first suspicion would be the USB-RS232 device.

Also, doesn't it help to open minicom with echo off?

Maarten

> 
> PS:
>     Oliver, please help me make this clear. You sent me here :)
> 
>> 
>> > > > When the TTY is opened, any chars in the this buffer is ECHOed back over USB to the device,
>> > > > before one has a chance to disable ECHO. The device then thinks these chars are regular input.
>> > >
>> > > Wait, you said something in the boot process did write to the device,
>> > > which would have caused the tty to be opened then, right?
>> >
>> > well, boot process of the device prints and it is enough for the USB cable to be attached but not opened by any app.
>> > The device just see an UART and prints when UART is initialized.
>> 
>> What tool does that?  Why not fix that?
>> 
>> > > > Seems to me that this behaviour is unwanted in general and and app. should get a chance to flush/discard
>> > > > any chars so this does not happen.
>> > >
>> > > Where are the characters coming from that would need to be flushed?
>> >
>> > Early output from boot, basically whatever prints just after connecting the USB cable.
>> 
>> Then don't have boot print to that device :)
>> 
>> > > When should characters be flushed exactly?
>> >
>> > Whatever is in the buffers before opening the tty.
>> 
>> But what is supposed to happen to the data that was sent to it while 
>> it
>> was "closed"?
>> 
>> > The terminal app(like cu) tries to flush any input when it starts, just to avoid any old chars in the
>> > queue but it is to late then.
>> 
>> I strongly just suggest having userspace not write to the device to
>> start with, that would solve this, right?
> 
> It is not user space, it is the serial driver in kernel writing this
> back automatically.
> 
>  Jocke
> 
>> 
>> thanks,
>> 
>> greg k-h

