From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/4] tty: serial: 8250: add optional spinlock arg to
 serial8250_rx_chars
Date: Fri, 22 Jan 2016 08:18:53 -0800
Message-ID: <56A2566D.6010408@hurleysoftware.com>
References: <877fj1rjs0.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877fj1rjs0.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi John,

On 01/22/2016 02:27 AM, John Ogness wrote:
> serial8250_rx_chars() must be called from interrupt context and with
> the port lock held. The port lock is released temporarily within that
> function to call tty_flip_buffer_push(). However, there may be other
> drivers that need to synchronize the tty_flip_buffer_push() call within
> serial8250_rx_chars() with other contexts. Since the port lock cannot
> be used for this synchronization, an optional spinlock argument is added.
> If non-NULL, this will be locked during the tty_flip_buffer_push() call.

I removed the port lock drop-claim in serial8250_rx_chars in patch
"serial: 8250: Remove low_latency workaround" (Greg has this patch in his
inbox but not in next because of the merge window).

IOW, you can drop this patch.

Regards,
Peter Hurley
