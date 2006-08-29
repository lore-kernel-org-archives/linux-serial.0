From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Make it possible to disable serial console suspend
Date: Tue, 29 Aug 2006 23:03:18 +0200
Message-ID: <20060829210318.GA21678@elf.ucw.cz>
References: <200608292152.43915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8583 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965323AbWH2VDa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 17:03:30 -0400
Content-Disposition: inline
In-Reply-To: <200608292152.43915.rjw@sisk.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Tue 2006-08-29 21:52:43, Rafael J. Wysocki wrote:
> Hack uart_suspend_port() and uart_resume_port() so that serial console ports
> are not suspended if CONFIG_DISABLE_CONSOLE_SUSPEND is set.
> 
> This makes it possible to debug the suspend and resume routines of all device
> drivers as well as the lowest-level swsusp code with the help of the serial
> console.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks good to me, ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
