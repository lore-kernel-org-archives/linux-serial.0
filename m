From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Curious about tty_port_operations drop() callback.
Date: Wed, 23 Jan 2013 14:38:15 +0000
Message-ID: <20130123143815.0cecd29a@www.etchedpixels.co.uk>
References: <kdmfat$dt9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35908 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab3AWOiY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 09:38:24 -0500
In-Reply-To: <kdmfat$dt9$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, 22 Jan 2013 16:38:54 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> While testing/debugging the tty driver I've changed to use the
> tty_port_* helper functions, I noticed there are two
> tty_port_operation fields that I'm not providing: destruct() and
> drop(). There's an example of destruct() usage in the hvc driver and a
> comment in tty.h explaining when it's called, so that's fairly
> obvious.
> 
> I haven't been able to figure out the purpose of the drop() callback.
> It's not used anywhere and there is no comment in tty.h hinting at its
> purpose.

It may well no longer be needed. If so then I'm all for its removal.

Alan
