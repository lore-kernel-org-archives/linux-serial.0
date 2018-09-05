From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2 1/2] tty: serial: imx: add lock for registers
 save/restore
Date: Wed, 5 Sep 2018 07:54:27 +0200
Message-ID: <20180905055427.q67larwwfbttdoof@pengutronix.de>
References: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

Hello,

On Wed, Sep 05, 2018 at 09:24:26AM +0800, Anson Huang wrote:
> In noirq suspend/resume stage with no_console_suspend enabled,
> imx_uart_console_write() may be called to print out log_buf
> message by printk(), so there will be race condition between
> imx_uart_console_write() and imx_uart_save/restore_context(),
> need to add lock to protect the registers save/restore operations.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 239c0fa..c15332d 100644

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
