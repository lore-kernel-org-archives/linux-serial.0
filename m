From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] NULL pointer dereference in uart_write_room().
Date: Mon, 5 May 2008 11:30:55 +0100
Message-ID: <20080505113055.5284052e@core>
References: <261636618@web.de>
	<200805022300.GIB30385.FJOVHQSMFtOOFL@I-love.SAKURA.ne.jp>
	<200805041716.DDG43279.JOSMHVFOFFQLOt@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34519 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbYEEKjt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 May 2008 06:39:49 -0400
In-Reply-To: <200805041716.DDG43279.JOSMHVFOFFQLOt@I-love.SAKURA.ne.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rmk@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> (5) uart_remove_one_port() is called by serial8250_register_port()
>     since ttyS0 is already in use but it is requested to be once removed.

That means 8250_pnp is taking over and then trying to delete the console,
so its breakage in the serial layer glue. Perhaps Russell has some ideas
as its hard to tell what he intended to happen originally.

Alan
