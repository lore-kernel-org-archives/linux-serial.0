From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: Correct tty buffer flushing.
Date: Thu, 29 Nov 2012 21:28:09 +0000
Message-ID: <20121129212809.5bc12088@bob.linux.org.uk>
References: <50B55A93.4090900@ilyx.ru>
	<50B6A652.9000107@ilyx.ru>
	<20121129135418.4237e7f8@pyramind.ukuu.org.uk>
	<50B76D96.20809@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34139 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab2K2VZm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Nov 2012 16:25:42 -0500
In-Reply-To: <50B76D96.20809@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Xiaobing Tu <xiaobing.tu@intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> Sorry, In you reply not all patch.
> Main idea here -  we never flash last (struct tty_buffer) in the
> active buffer. Only data for ldisc. (tty->buf.head->read =
> tty->buf.head->commit). At that moment driver can collect(write) data
> in buffer without conflict.

Ah.. now I understand. Yes that makes sense.  I will think about that
carefully. This is why a good explanation with a patch is important.

