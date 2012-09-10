From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 10/14] tty/serial: Add kgdb_nmi driver
Date: Mon, 10 Sep 2012 12:11:05 +0100
Message-ID: <20120910121105.724f982f@pyramind.ukuu.org.uk>
References: <20120910040802.GA1261@lizard>
	<20120910041412.GJ29537@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51414 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab2IJLHG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Sep 2012 07:07:06 -0400
In-Reply-To: <20120910041412.GJ29537@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Sun, 9 Sep 2012 21:14:12 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> This special driver makes it possible to temporary use NMI debugger port
> as a normal console by issuing 'nmi_console' command (assuming that the
> port is attached to KGDB).

No ref counting, no tty port, no compliance with the tty behaviour.
Concept looks fine but it needs porting to reflect a kernel newer than
about 2.6.18 8)

I would take a quick look at the tty_port helpers and also check v -next
which makes the tty_port mandatory. That'll pretty much cover your needs
for locking, semantics and the like.

Alan
