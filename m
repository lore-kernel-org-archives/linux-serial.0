From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix an uninitialised variable warning in the 8250
 driver
Date: Fri, 14 Nov 2008 16:34:28 +0000
Message-ID: <20081114163428.7b676742@lxorguk.ukuu.org.uk>
References: <20081114162038.23016.20581.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47048 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751037AbYKNQfG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2008 11:35:06 -0500
In-Reply-To: <20081114162038.23016.20581.stgit@warthog.procyon.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, dhowells@redhat.com, linux-kernel@vger.kernel.org

On Fri, 14 Nov 2008 16:20:38 +0000
David Howells <dhowells@redhat.com> wrote:

> Fix an uninitialised variable warning in the 8250 driver:
> 
>   CC      drivers/serial/8250.o
> drivers/serial/8250.c: In function 'serial8250_shutdown':
> drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in this function

Current versions of gcc that I've tested get this all correct just fine
for x86 at least.

Do check that the BUG_ON() helper for whatever platform you are using
needs to correctly indicate that its BUG spewing path may not return
(__attibute((__noreturn__)). I seem to remember some of the architectures
are broken on that.

Alan
