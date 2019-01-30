From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3Y0?= =?utf-8?Q?=5D?= tty: fix
 race between flush_to_ldisc and tty_open
Date: Wed, 30 Jan 2019 14:16:41 +0100
Message-ID: <20190130131641.GA10795@kroah.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
 <20190130101914.GA30587@kroah.com>
 <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "jslaby@suse.com" <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gkohli@codeaurora.org" <gkohli@codeaurora.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 30, 2019 at 12:48:42PM +0000, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] 代表 Greg KH
> > 发送时间: 2019年1月30日 18:19
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: jslaby@suse.com; linux-kernel@vger.kernel.org; gkohli@codeaurora.org
> > 主题: Re: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
> > 
> > On Fri, Jan 18, 2019 at 05:27:17PM +0800, Li RongQing wrote:
> > > There still is a race window after the commit b027e2298bd588
> > > ("tty: fix data race between tty_init_dev and flush of buf"), and we
> > > encountered this crash issue if receive_buf call comes before tty
> > > initialization completes in n_tty_open and
> > > tty->driver_data may be NULL.
> > >
> > > CPU0                                    CPU1
> > > ----                                    ----
> > >                                  n_tty_open
> > >                                    tty_init_dev
> > >                                      tty_ldisc_unlock
> > >                                        schedule flush_to_ldisc
> > > receive_buf
> > >   tty_port_default_receive_buf
> > >    tty_ldisc_receive_buf
> > >     n_tty_receive_buf_common
> > >       __receive_buf
> > >        uart_flush_chars
> > >         uart_start
> > >         /*tty->driver_data is NULL*/
> > >                                    tty->ops->open
> > >                                    /*init tty->driver_data*/
> > >
> > > it can be fixed by extending ldisc semaphore lock in tty_init_dev to
> > > driver_data initialized completely after tty->ops->open(), but this
> > > will lead to put lock on one function and unlock in some other
> > > function, and hard to maintain, so fix this race only by checking
> > > tty->driver_data when receiving, and return if tty->driver_data
> > > is NULL
> > >
> > > Signed-off-by: Wang Li <wangli39@baidu.com>
> > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > V4: add version information
> > > V3: not used ldisc semaphore lock, only checking tty->driver_data with
> > > NULL
> > > V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> > > V1: extend ldisc lock to protect that tty->driver_data is inited
> > >
> > > drivers/tty/tty_port.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c index
> > > 044c3cbdcfa4..86d0bec38322 100644
> > > --- a/drivers/tty/tty_port.c
> > > +++ b/drivers/tty/tty_port.c
> > > @@ -31,6 +31,9 @@ static int tty_port_default_receive_buf(struct tty_port
> > *port,
> > >  	if (!tty)
> > >  		return 0;
> > >
> > > +	if (!tty->driver_data)
> > > +		return 0;
> > > +
> > 
> > How is this working?  What is setting driver_data to NULL to "stop" this race?
> > 
> 
> 
> if tty->driver_data is NULL and return,  tty_port_default_receive_buf will not step to
> uart_start which access tty->driver_data and trigger panic before tty_open, so it can
> fix the system panic
> 
> > There's no requirement that a tty driver set this field to NULL when it is "done"
> > with the tty device, so I think you are just getting lucky in that your specific
> > driver happens to be doing this.
> > 
> 
> when tty_open is running, tty is allocated by kzalloc in tty_init_dev which called
> by tty_open_by_driver, tty is inited to 0
> 
> > What driver are you testing this against?
> > 
> 
> 8250

Ok, as this is specific to the uart core, how about this patch instead:

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5c01bb6d1c24..b56a6250df3f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -130,6 +130,9 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
+	if (!state)
+		return;
+
 	port = uart_port_lock(state, flags);
 	__uart_start(tty);
 	uart_port_unlock(port, flags);
