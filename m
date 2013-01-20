From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: Re: close /dev/console casue 30seconds' hang
Date: Sun, 20 Jan 2013 13:00:25 +0100
Message-ID: <20130120130025.7bba6cdf@x60.lan>
References: <5857088.8tFJrCsqj8@ll-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:55710 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751962Ab3ATOnR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 09:43:17 -0500
Received: from mail637.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 9DA9CFF88F7
	for <linux-serial@vger.kernel.org>; Sun, 20 Jan 2013 13:14:07 +0100 (CET)
In-Reply-To: <5857088.8tFJrCsqj8@ll-pc>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yi Qingliang <niqingliang2003@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sun, 20 Jan 2013 19:28:42 +0800
Yi Qingliang <niqingliang2003@gmail.com> wrote:

> I'm running 3.6.9 kernel on my s3c2442 board.
> the sysvinit freeze 30seconds after print out "INIT:",
> and then freeze 30seconds after print out "version 2.88 booting".
> I checked it's code, the 'close(fd)' should be responsible for that.
I had the exact same problem while trying to boot a recent
mainline kernel on the GTA02.

I tried to bisect it many times but I failed because the problem was in
a reagion that I had to skip...

Denis.
