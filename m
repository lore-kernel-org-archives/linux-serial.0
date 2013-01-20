From: Yi Qingliang <niqingliang2003@gmail.com>
Subject: Re: close /dev/console casue 30seconds' hang
Date: Sun, 20 Jan 2013 20:53:38 +0800
Message-ID: <6093467.AFuYjWa6KM@ll-pc>
References: <5857088.8tFJrCsqj8@ll-pc> <20130120130025.7bba6cdf@x60.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:39092 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3ATMxn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 07:53:43 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so2310193dad.41
        for <linux-serial@vger.kernel.org>; Sun, 20 Jan 2013 04:53:43 -0800 (PST)
In-Reply-To: <20130120130025.7bba6cdf@x60.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: linux-serial@vger.kernel.org


n Sunday, January 20, 2013 01:00:25 PM Denis 'GNUtoo' Carikli wrote:
> On Sun, 20 Jan 2013 19:28:42 +0800
> 
> Yi Qingliang <niqingliang2003@gmail.com> wrote:
> > I'm running 3.6.9 kernel on my s3c2442 board.
> > the sysvinit freeze 30seconds after print out "INIT:",
> > and then freeze 30seconds after print out "version 2.88 booting".
> > I checked it's code, the 'close(fd)' should be responsible for that.
> 
> I had the exact same problem while trying to boot a recent
> mainline kernel on the GTA02.
> 
> I tried to bisect it many times but I failed because the problem was in
> a reagion that I had to skip...
I also tried to open INITDEBUG and DEBUG in sysvinit's init.h, can solve this 
problem.

the INITDEBUG will fork a process, and then the close(fd) will not call 
release in tty driver.

I have checked the state of uart fifo, if the pclk is 00, it looks like the fifo 
works abnormally.
> 
> Denis.
