From: <Grzegorz.Sygieda@tieto.com>
Subject: RE: [PATCH] pl011: added clock management feature
Date: Wed, 10 Nov 2010 09:54:18 +0200
Message-ID: <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D88A@EXMB01.eu.tieto.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
 <20101109224012.GA21992@kroah.com>
 <20101110000152.GA8993@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ebb06.tieto.com ([131.207.168.38]:44744 "EHLO ebb06.tieto.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab0KJHyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 02:54:37 -0500
In-Reply-To: <20101110000152.GA8993@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@arm.linux.org.uk, greg@kroah.com
Cc: linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com, gregkh@suse.de, Lukasz.Rymanowski@tieto.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>On Tue, Nov 09, 2010 at 02:40:12PM -0800, Greg KH wrote:
>> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
>> > From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
>> > 
>> > This patch allows to control the pl011 clock using set_termios 
>> > callback. Any positive baudrate passed enables clock, otherwise 
>> > disables. This saves a lot of power on submicron designs since we 
>> > can clock off and disable unused UARTs.
>> 
>> That's nice, but it seems like an overload of what people 
>> traditionally think of when it comes to baud rates.  Why not just 
>> power down ports that are not open instead?
>
>We already do.  My question to Linus (in a previous message) is why this isn't sufficient.

The main goal was to disable/enable clock while port open. This is usefull for scenario, where some higher level driver wants to control the power consumption (using set_termios). In the same time a user-space app (eg. hciattach) is still bounded to the specific /dev/tty* device associated with particular uart. From user POV device is always open, and app does not have to respawn, and we can save power.

I hope it's clear explanation. 