From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [trivial patch] fix missing space in printk
	drivers/serial/8250.c
Date: Sat, 24 Jan 2009 22:59:26 +0100
Message-ID: <1232834366.1569.13.camel@x41.thuisdomein>
References: <497B7C7F.80104@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758849AbZAXV7i@vger.kernel.org>
In-Reply-To: <497B7C7F.80104@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-serial@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, 2009-01-24 at 23:39 +0300, Michael Tokarev wrote:
> Again, I don't know where to push this trivia thing.
> 8250 marked as Orphan in MAINTAINERS, so I'm sending
> to linux-serial@ AND to linux-kernel@

This was fixed by commit f1fb9bb8594cecf4e81e7a8ab8f6268e0bace40b
("trivial: Add a space (and a comma) to a printk in 8250 driver"), which
is the result of a patch that I sent to both trivial@kernel.org and
linux-kernel@vger.kernel.org a few weeks ago.

Regards,


Paul Bolle
