From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: (unknown)
Date: Sun,  4 Mar 2012 18:59:11 +0100
Message-ID: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40835 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab2CDR7i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 12:59:38 -0500
Received: by wgbds11 with SMTP id ds11so750320wgb.1
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 09:59:37 -0800 (PST)
Subject: 
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

Subject: [RFC] tty : make receive_room internal to N_TTY line discipline
In-Reply-To:

This patch try to solve issue exposed on https://lkml.org/lkml/2011/6/7/700

On Tue, Jun 07, 2011 at 07:44:48PM -0700, Linus Torvalds wrote
> I'd love to get rid of receive_room entirely - and just letting the
> tty line discipline handler say how much it actually received. in
> other words, having receive_buf() just tell us how much it used, and
> not looking at receive_room in the caller is absolutely the right
> thing.


