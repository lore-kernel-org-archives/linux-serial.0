From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Fri, 15 Apr 2016 16:01:04 -0600
Message-ID: <20160415160104.6aed0770@lwn.net>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
	<1460624891-8389-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460624891-8389-5-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 14 Apr 2016 11:08:11 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> As mutex_lock() must not be called with interrupts disabled,
> .break_ctl() may sleep.

So I've applied the first three to the docs tree, but this one stopped
me.  The changelog doesn't really say why the patch is correct; what we
really need to know is that break_ctl() won't be called in atomic
context.  I'm assuming that's the case, but if it truly is, can I get a
version with a changelog saying that?

Thanks,

jon
