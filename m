From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Sat, 16 Apr 2016 10:47:49 -0600
Message-ID: <20160416104749.49c74c20@lwn.net>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
	<1460624891-8389-5-git-send-email-geert+renesas@glider.be>
	<20160415160104.6aed0770@lwn.net>
	<57116BC2.5070102@hurleysoftware.com>
	<20160415164150.1666b58c@lwn.net>
	<5711743B.3030207@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5711743B.3030207@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 15 Apr 2016 16:07:39 -0700
Peter Hurley <peter@hurleysoftware.com> wrote:

> > I'm missing something here.  
> 
> Yes.
> 
> The analysis above is required to show that the API contract asserted by
> the proposed change to the documentation is currently true in the code,
> which is what I care about.

Yes, but the analysis says nothing about what uart_break_ctl() itself
might do, so by itself, it provides no guarantee for break_ctl().  That
was my sticking point since somebody clearly put that line in there for a
reason.

Looking at the code, it's pretty obvious that uart_break_ctl() isn't
acquiring any spinlocks.  The documentation line in question has been
there, unchanged, since the beginning of the Git era.  The patch is
obviously fine, and I've applied it, but I did tweak the changelog some.

Thanks,

jon
