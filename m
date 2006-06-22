From: Alan Cox <alan@redhat.com>
Subject: Re: [Q] New tty flip interface doubt.
Date: Thu, 22 Jun 2006 08:56:52 -0400
Message-ID: <20060622125652.GA23090@devserv.devel.redhat.com>
References: <87hd2epuu6.fsf@javad.com> <20060621134208.GA12884@devserv.devel.redhat.com> <87irmt63wk.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:64141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751786AbWFVM4y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jun 2006 08:56:54 -0400
Content-Disposition: inline
In-Reply-To: <87irmt63wk.fsf@javad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Organov <osv@javad.com>
Cc: Alan Cox <alan@redhat.com>, linux-serial@vger.kernel.org

On Thu, Jun 22, 2006 at 11:33:15AM +0400, Sergei Organov wrote:
> One more question, if I get memory for N bytes with
> tty_prepare_flip_string() then store M (M <= N) bytes into the buffer,
> how do I tell tty layer that only M bytes are in fact stored?

You don't.

> [I'm thinking about eliminating buffers allocation for urbs as well as
> data copy when transferring data from USB subsystem to flip buffers of
> the tty subsystem. Currently the flow is:

The tty buffers may not be DMAable

> and it seems that using tty buffers directly is a better idea:
> 
> - allocate N-bytes data buffer from tty and use it for urb
> - submit the urb to USB subsystem
> - flip M-bytes of data (M <= N) in USB receive callback.

Its doable in theory but is it worth it ?

