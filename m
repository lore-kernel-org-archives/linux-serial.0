From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 4/7] serial: 8250_fintek: Rearrange function
Date: Thu, 1 Sep 2016 13:17:29 +0200
Message-ID: <CAPybu_09HrXc2p+KzqRwcJKGDFCgNv5gMtNYK5Fx4SoJ2gMC3Q@mail.gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com> <1472701196-14795-5-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-5-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On one previous patch you almost rewrote theset_irq_mode function and
added the prototype. It might be a good moment to move the whole
function up.

On Thu, Sep 1, 2016 at 5:39 AM, Ji-Ze Hong (Peter Hong)
<hpeter@gmail.com> wrote:
> We change the position of fintek_8250_set_irq_mode() above the
> find_base_port() to eliminate the prototype define.
>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 5625203..921f742 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -56,9 +56,6 @@ struct fintek_8250 {
>         u8 key;
>  };
>
> -static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata,
> -                                    bool level_mode);
> -
>  static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
>  {
>         outb(reg, pdata->base_port + ADDR_PORT);
> @@ -179,6 +176,14 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
>         }
>  }
>
> +static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
> +{
> +       sio_write_reg(pdata, LDN, pdata->index);
> +       sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
> +       sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
> +                          is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
> +}
> +
>  static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
>                           unsigned int irq)
>  {
> @@ -230,14 +235,6 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
>         return -ENODEV;
>  }
>
> -static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
> -{
> -       sio_write_reg(pdata, LDN, pdata->index);
> -       sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
> -       sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
> -                          is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
> -}
> -
>  int fintek_8250_probe(struct uart_8250_port *uart)
>  {
>         struct fintek_8250 *pdata;
> --
> 1.9.1
>



-- 
Ricardo Ribalda
