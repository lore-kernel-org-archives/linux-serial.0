From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty:serial:imx: use spin_lock instead of
 spin_lock_irqsave in isr
Date: Mon, 1 Oct 2018 10:52:12 +0200
Message-ID: <20181001085212.wu7eba4eh7koy5jx@pengutronix.de>
References: <20180827144904.17226-1-hangdianqj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827144904.17226-1-hangdianqj@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jun qian <hangdianqj@163.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Barry song <21cnbao@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Mon, Aug 27, 2018 at 07:49:04AM -0700, jun qian wrote:
> Before the program enters the uart ISR, the local interrupt has been
> disabled by the system, so it's not appropriate to use spin_lock_irqsave
> interface in the ISR.

"not appropriate" is a bit strong. It's not as optimal as it could be
though, yes.

The change is fine,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
