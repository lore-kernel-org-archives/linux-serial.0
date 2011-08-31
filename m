From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] TTY: serial, remove dead code from 68328
Date: Wed, 31 Aug 2011 21:51:52 +0200
Message-ID: <CAMuHMdXQCXj_y+JzP-opYq+EioR6mp1bPF903GWOAtEjYqr4Dw@mail.gmail.com>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
	<1314818699-10873-2-git-send-email-jslaby@suse.cz>
	<CAMuHMdUBYarp4V_k_8Skr8T-Ow2fc69EpJGi3wm-M_UZNxDLeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53653 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab1HaTvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Aug 2011 15:51:53 -0400
In-Reply-To: <CAMuHMdUBYarp4V_k_8Skr8T-Ow2fc69EpJGi3wm-M_UZNxDLeA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>, linux-m68k@lists.linux-m68k.org, uClinux development list <uclinux-dev@uclinux.org>

On Wed, Aug 31, 2011 at 21:51, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> On Wed, Aug 31, 2011 at 21:24, Jiri Slaby <jslaby@suse.cz> wrote:
>> The code is dead at least since 2002. So remove it to not distort gi=
t
>> grep output (about port.tty usage).
>>
>> Remove the whole do_softirq tasklet as it's noop now.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Alan Cox <alan@linux.intel.com>
>> ---
>> Cc: linux-m68k@lists.linux-m68k.org
>
> This is a uClinux driver.

So I really wanted to cc the uClinux list...

>> =C2=A0drivers/tty/serial/68328serial.c | =C2=A0 35 -----------------=
------------------
>> =C2=A0drivers/tty/serial/68328serial.h | =C2=A0 =C2=A01 -
>> =C2=A02 files changed, 0 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6=
8328serial.c
>> index e0a7754..f549231 100644
>> --- a/drivers/tty/serial/68328serial.c
>> +++ b/drivers/tty/serial/68328serial.c
>> @@ -235,22 +235,6 @@ static void batten_down_hatches(void)
>>
>> =C2=A0static void status_handle(struct m68k_serial *info, unsigned s=
hort status)
>> =C2=A0{
>> -#if 0
>> - =C2=A0 =C2=A0 =C2=A0 if(status & DCD) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if((info->port.tt=
y->termios->c_cflag & CRTSCTS) &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((in=
fo->curregs[3] & AUTO_ENAB)=3D=3D0)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 info->curregs[3] |=3D AUTO_ENAB;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 info->pendregs[3] |=3D AUTO_ENAB;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_zsreg(info->m68k_channel, 3, info->curregs[3]);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if((info->curregs=
[3] & AUTO_ENAB)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 info->curregs[3] &=3D ~AUTO_ENAB;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 info->pendregs[3] &=3D ~AUTO_ENAB;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_zsreg(info->m68k_channel, 3, info->curregs[3]);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If this is console input and this is a
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 'break asserted' status change interru=
pt
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * see if we can drop into the debugger
>> @@ -340,9 +324,6 @@ static void transmit_chars(struct m68k_serial *i=
nfo)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->xmit_tail =3D info->xmit_tail & (SE=
RIAL_XMIT_SIZE-1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->xmit_cnt--;
>>
>> - =C2=A0 =C2=A0 =C2=A0 if (info->xmit_cnt < WAKEUP_CHARS)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&in=
fo->tqueue);
>> -
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(info->xmit_cnt <=3D 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* All done f=
or now... TX ints off */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart->ustcnt =
&=3D ~USTCNT_TX_INTR_MASK;
>> @@ -378,21 +359,6 @@ irqreturn_t rs_interrupt(int irq, void *dev_id)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
>> =C2=A0}
>>
>> -static void do_softint(struct work_struct *work)
>> -{
>> - =C2=A0 =C2=A0 =C2=A0 struct m68k_serial =C2=A0 =C2=A0 =C2=A0*info =
=3D container_of(work, struct m68k_serial, tqueue);
>> - =C2=A0 =C2=A0 =C2=A0 struct tty_struct =C2=A0 =C2=A0 =C2=A0 *tty;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 tty =3D info->tty;
>> - =C2=A0 =C2=A0 =C2=A0 if (!tty)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> -#if 0
>> - =C2=A0 =C2=A0 =C2=A0 if (clear_bit(RS_EVENT_WRITE_WAKEUP, &info->e=
vent)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_wakeup(tty);
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -#endif
>> -}
>> -
>> =C2=A0static int startup(struct m68k_serial * info)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0m68328_uart *uart =3D &uart_addr[info->li=
ne];
>> @@ -1324,7 +1290,6 @@ rs68328_init(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->event =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->count =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->blocked_open =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&info->tqueue, do_sof=
tint);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&info->=
open_wait);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&info->=
close_wait);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info->line =3D i;
>> diff --git a/drivers/tty/serial/68328serial.h b/drivers/tty/serial/6=
8328serial.h
>> index 8c9c3c0..3d2faab 100644
>> --- a/drivers/tty/serial/68328serial.h
>> +++ b/drivers/tty/serial/68328serial.h
>> @@ -158,7 +158,6 @@ struct m68k_serial {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_head;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_tail;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xmit_cnt;
>> - =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0tqueue=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 op=
en_wait;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 cl=
ose_wait;
>> =C2=A0};
>> --
>> 1.7.6.1

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
