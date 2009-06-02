From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/11] Blackfin SPORT UART: fix overrun errors
Date: Tue, 2 Jun 2009 10:00:18 +0100
Message-ID: <20090602100018.415b1dfc@lxorguk.ukuu.org.uk>
References: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
	<1243926700-30485-4-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760193AbZFBJF2@vger.kernel.org>
In-Reply-To: <1243926700-30485-4-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue,  2 Jun 2009 03:11:33 -0400
Mike Frysinger <vapier@gentoo.org> wrote:

> From: Cliff Cai <cliff.cai@analog.com>
> 
> Push the ty_flip_buffer_push() call from the IRQ handler to a timer so as
> to improve performance and decrease likelihood of overruns.

This should have no effect on a modern kernel. There is 64K of queueing
between you and the ldisc nowdays. Furthermore unless you set
tty->low_latency the kernel already basically does this aggregation for
you as the buffer push queues stuff for the ldisc to wake up and process.
