From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] cdc-acm: do not drop data from fast devices
Date: Mon, 05 Mar 2018 17:04:31 +0100
Message-ID: <1520265871.6256.15.camel@suse.com>
References: <20180305095539.13698-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305095539.13698-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, johan@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-03-05 at 10:55 +0100, Romain Izard wrote:

> The TTY buffer is 4096 bytes large, throttling when there are only 128
> free bytes left, and unthrottling when there are only 128 bytes available.
> But the TTY buffer is filled from an intermediate flip buffer that
> contains up to 64 KiB of data, and each time unthrottle() is called 16
> URBs are scheduled by the driver, sending up to 16 KiB to the flip buffer.
> As the result of tty_insert_flip_string() is not checked in the URB
> reception callback, data can be lost when the flip buffer is filled faster
> than the TTY is emptied.

It seems to me that the problem is in the concept here. If you cannot
take all data, you should tell the lower layer how much data you can
take.

> Moreover, as the URB callbacks are called from a tasklet context, whereas
> throttling is called from the system workqueue, it is possible for the
> throttling to be delayed by high traffic in the tasklet. As a result,
> completed URBs can be resubmitted even if the flip buffer is full, and we
> request more data from the device only to drop it immediately.

That points to a deficiency with how we throttle. Maybe we should poison
URBs upon throttle() being called?

> To prevent this problem, the URBs whose data did not reach the flip buffer
> are placed in a waiting list, which is only processed when the serial port
> is unthrottled.

So we introduce yet another buffer? That does look like we are papering
over a design problem.


> This is working when using the normal line discipline on ttyACM. But
> there is a big hole in this: other line disciplines do not use throttling
> and thus unthrottle is never called. The URBs will never get resubmitted,

Now that is a real problem. This introduces a regression.

> and the port is dead. Unfortunately, there is no notification when the
> flip buffer is ready to receive new data, so the only alternative would
> be to schedule a timer polling the flip buffer. But with an additional
> asynchronous process in the mix, the code starts to be very brittle.

Well, no. This tells us something is broken in the tty layer.

> I believe this issue is not limited to ttyACM. As the TTY layer is not
> performance-oriented, it can be easy to overwhelm devices with a low
> available processing power. In my case, a modem sending a sustained 2 MB/s
> on a debug port (exported as a CDC-ACM port) was enough to trigger the
> issue. The code handling the CDC-ACM class and the generic USB serial port
> is very similar when it comes to URB handling, so all drivers that rely on
> that code have the same issue.
> 
> But in general, it seems to me that there is no code in the kernel that
> checks the return value of tty_insert_flip_string(). This means that we
> are working with the assumption that the kernel will consume the data
> faster than the source can send it, or that the upper layer will be
> able or willing to throttle it fast enough to avoid losing data.

Yes. And if the assumption is false, you need to go for the tty layer.
I am sorry, but NACK.

	Regards
		Oliver
