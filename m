From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 00/32] ldisc patchset
Date: Tue, 5 Mar 2013 22:18:27 +0100
Message-ID: <20130305211827.GB5771@linutronix.de>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
 <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39311 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab3CEVSd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 16:18:33 -0500
Content-Disposition: inline
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>

* Peter Hurley | 2013-02-20 15:02:47 [-0500]:

>Sebastian, please re-test your g_nokia+dummy_hcd testcase with
>this series.

I tested this on top ov v3.9-rc1. Without this series I see often a
warning in drivers/tty/tty_buffer.c:428 / flush_to_ldisc(). With this
things seem to work fine.

Sebastian
