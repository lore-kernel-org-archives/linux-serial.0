From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date: Wed, 28 Oct 2009 15:34:17 -0700
Message-ID: <20091028223417.GC2921@linux-mips.org>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com> <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com> <20091028122430.f7670ae2.akpm@linux-foundation.org> <f861ec6f0910281227t455a6f5cw9e492a9a1fc1b07e@mail.gmail.com> <20091028125203.c513883e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:41411 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZJ1WdG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Oct 2009 18:33:06 -0400
Received: from localhost.localdomain ([127.0.0.1]:42893 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493439AbZJ1WdI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Oct 2009 23:33:08 +0100
Content-Disposition: inline
In-Reply-To: <20091028125203.c513883e.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

On Wed, Oct 28, 2009 at 12:52:03PM -0700, Andrew Morton wrote:

> >  I know, that's why I added "The mips parts apply on top of Ralf's
> > mips-queue tree" below
> > the patch description.
> 
> If that's the case then Ralf's mips-queue tree isn't in linux-next :(

I just respun my tree for linux-next, just in case.

> > If it makes it easier to apply, I could split this one in a mips and in a
> > 8250 patch?
> 
> That's a hard call without knowing what's going on in mipsworld.  If

My tree for linux-next is at

  http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary

  Ralf
