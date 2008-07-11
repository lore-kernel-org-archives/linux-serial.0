From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial8250: Sanity check nr_uarts on all paths.
Date: Fri, 11 Jul 2008 21:05:16 +0100
Message-ID: <20080711210516.02a04245@lxorguk.ukuu.org.uk>
References: <m1wsjsdxr1.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45466 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760169AbYGKUX3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2008 16:23:29 -0400
In-Reply-To: <m1wsjsdxr1.fsf@frodo.ebiederm.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>, linux-serial@vger.kernel.org, Bryan Wu <cooloney@kernel.org>

On Fri, 11 Jul 2008 12:30:42 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> 
> I had 8250.nr_uarts=16 in the boot line of a test kernel and I had a
> weird mysterious crash in sysfs.  After an taking in depth look I realized
> that CONFIG_SERIAL_8250_NR_UARTS was set to 4 and I was walking off
> the end of the serial8250_ports array.
> 
> Ouch!!!
> 
> Don't let this happen to someone else.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Alan Cox <alan@redhat.com>

Added to ttydev tree but please fire straight at Linus in case he fancies
it for 2.6.26
