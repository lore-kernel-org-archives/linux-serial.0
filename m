From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] TTY: serial, remove dead code from 68328
Date: Wed, 31 Aug 2011 21:51:04 +0200
Message-ID: <CAMuHMdUBYarp4V_k_8Skr8T-Ow2fc69EpJGi3wm-M_UZNxDLeA@mail.gmail.com>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
	<1314818699-10873-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45060 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab1HaTvF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Aug 2011 15:51:05 -0400
In-Reply-To: <1314818699-10873-2-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>, linux-m68k@lists.linux-m68k.org

On Wed, Aug 31, 2011 at 21:24, Jiri Slaby <jslaby@suse.cz> wrote:
> The code is dead at least since 2002. So remove it to not distort git
> grep output (about port.tty usage).
>
> Remove the whole do_softirq tasklet as it's noop now.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alan Cox <alan@linux.intel.com>
> ---
> Cc: linux-m68k@lists.linux-m68k.org

This is a uClinux driver.

> =C2=A0drivers/tty/serial/68328serial.c | =C2=A0 35 ------------------=
-----------------
> =C2=A0drivers/tty/serial/68328serial.h | =C2=A0 =C2=A01 -
> =C2=A02 files changed, 0 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68=
328serial.c
> index e0a7754..f549231 100644
> --- a/drivers/tty/serial/68328serial.c
> +++ b/drivers/tty/serial/68328serial.c
> @@ -235,22 +235,6 @@ static void batten_down_hatches(void)
>
> =C2=A0static void status_handle(struct m68k_serial *info, unsigned sh=
ort status)
> =C2=A0{
> -#if 0
> - =C2=A0 =C2=A0 =C2=A0 if(status & DCD) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if((info->port.tty=
->termios->c_cflag & CRTSCTS) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((inf=
o->curregs[3] & AUTO_ENAB)=3D=3D0)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 info->curregs[3] |=3D AUTO_ENAB;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 info->pendregs[3] |=3D AUTO_ENAB;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 write_zsreg(info->m68k_channel, 3, info->curregs[3]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if((info->curregs[=
3] & AUTO_ENAB)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 info->curregs[3] &=3D ~AUTO_ENAB;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 info->pendregs[3] &=3D ~AUTO_ENAB;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 write_zsreg(info->m68k_channel, 3, info->curregs[3]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 }
> -#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If this is console input and this is a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 'break asserted' status change interrup=
t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * see if we can drop into the debugger
> @@ -340,9 +324,6 @@ static void transmit_chars(struct m68k_serial *in=
fo)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->xmit_tail =3D info->xmit_tail & (SER=
IAL_XMIT_SIZE-1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->xmit_cnt--;
>
> - =C2=A0 =C2=A0 =C2=A0 if (info->xmit_cnt < WAKEUP_CHARS)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&inf=
o->tqueue);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(info->xmit_cnt <=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* All done fo=
r now... TX ints off */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart->ustcnt &=
=3D ~USTCNT_TX_INTR_MASK;
> @@ -378,21 +359,6 @@ irqreturn_t rs_interrupt(int irq, void *dev_id)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
>
> -static void do_softint(struct work_struct *work)
> -{
> - =C2=A0 =C2=A0 =C2=A0 struct m68k_serial =C2=A0 =C2=A0 =C2=A0*info =3D=
 container_of(work, struct m68k_serial, tqueue);
> - =C2=A0 =C2=A0 =C2=A0 struct tty_struct =C2=A0 =C2=A0 =C2=A0 *tty;
> -
> - =C2=A0 =C2=A0 =C2=A0 tty =3D info->tty;
> - =C2=A0 =C2=A0 =C2=A0 if (!tty)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -#if 0
> - =C2=A0 =C2=A0 =C2=A0 if (clear_bit(RS_EVENT_WRITE_WAKEUP, &info->ev=
ent)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_wakeup(tty);
> - =C2=A0 =C2=A0 =C2=A0 }
> -#endif
> -}
> -
> =C2=A0static int startup(struct m68k_serial * info)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0m68328_uart *uart =3D &uart_addr[info->lin=
e];
> @@ -1324,7 +1290,6 @@ rs68328_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->event =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->count =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->blocked_open =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&info->tqueue, do_soft=
int);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&info->o=
pen_wait);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&info->c=
lose_wait);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->line =3D i;
> diff --git a/drivers/tty/serial/68328serial.h b/drivers/tty/serial/68=
328serial.h
> index 8c9c3c0..3d2faab 100644
> --- a/drivers/tty/serial/68328serial.h
> +++ b/drivers/tty/serial/68328serial.h
> @@ -158,7 +158,6 @@ struct m68k_serial {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_head;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_tail;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_cnt;
> - =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0tqueue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 ope=
n_wait;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 clo=
se_wait;
> =C2=A0};
> --
> 1.7.6.1

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
