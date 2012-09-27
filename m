From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH-v3] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Thu, 27 Sep 2012 14:15:22 +0100
Message-ID: <20120927141522.7d3e26de@pyramind.ukuu.org.uk>
References: <20120925154707.33aa2fa4@pyramind.ukuu.org.uk>
	<1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 27 Sep 2012 13:58:21 +0200
Ivo Sieben <meltedpianoman@gmail.com> wrote:

> When low_latency flag is set the TTY receive flip buffer is copied to the
> line discipline directly instead of using a work queue in the background.
> Therefor only in case a workqueue is actually used for copying data to the
> line discipline we'll have to flush the workqueue.
> 
> This prevents unnecessary spin lock/unlock on the workqueue spin lock that
> can cause additional scheduling overhead on a PREEMPT_RT system. On a 200
> MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
> overhead on the TTY read call.
> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

(but for 3.8 not 3.7 ...)
