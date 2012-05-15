From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 16:53:39 +0100
Message-ID: <20120515165339.6b142cd2@pyramind.ukuu.org.uk>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45402 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2EOPuu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 11:50:50 -0400
In-Reply-To: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corbin Atkinson <corbinat@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

On Fri,  4 May 2012 12:35:10 -0500
Corbin Atkinson <corbinat@gmail.com> wrote:

> Currently, serial drivers don't report buffer overruns. When a buffer overrun
> occurs, tty_insert_flip_char returns 0, and no attempt is made to insert that
> same character again (i.e. it is lost). This patch reports buffer overruns via
> the buf_overrun field in the port's icount structure.

I think this is mostly a misunderstanding - it's always been interpreted
as logging hardware reported overrruns. The case of the software layer
losing bytes is a "doesn't happen in normal circumstances" situation. At
least it should be.

Alan
