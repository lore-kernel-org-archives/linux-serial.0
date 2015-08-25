From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v3 1/4] serial: sh-sci: Stop TX and RX on shutdown
Date: Tue, 25 Aug 2015 15:01:17 +0200
Message-ID: <CAMuHMdUez4SK+-PDVw_DCqQeq8o6SL22jfSdpGg7=9cq2QZtQw@mail.gmail.com>
References: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
	<1440181546-7334-2-git-send-email-geert+renesas@glider.be>
	<1780221.Xost2UeeDz@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1780221.Xost2UeeDz@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent, Matsuoka-san,

On Sat, Aug 22, 2015 at 1:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 21 August 2015 20:25:43 Geert Uytterhoeven wrote:
>> Make sure the transmitter and receiver are stopped when shutting down
>> the port, to avoid new RX DMA requests to arrive.
>>
>> Inspired by a patch in the BSP by Koji Matsuoka
>> <koji.matsuoka.xm@renesas.com>.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index d8b73e791a554823..0622cafaf1c71cab 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -1820,12 +1820,16 @@ static void sci_shutdown(struct uart_port *port)
>>  {
>>       struct sci_port *s = to_sci_port(port);
>>       unsigned long flags;
>> +     u16 scscr;
>>
>>       dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
>>
>>       spin_lock_irqsave(&port->lock, flags);
>>       sci_stop_rx(port);
>>       sci_stop_tx(port);
>> +     scscr = serial_port_in(port, SCSCR);
>> +     scscr &= ~(SCSCR_TE | SCSCR_RE);
>> +     serial_port_out(port, SCSCR, scscr);
>
> Given that the register contains lots of interrupt enable bits, would it make
> sense to just write it to 0 to disable everything ? I don't think we need to
> keep any of the SCSCR bits across shutdown/startup.

I don't  know.

Actually this patch causes a problem on e.g. armadillo and kzm9g, where
serial console output suddenly stops on halt/reboot:

| # halt
|
| Broadcast message from root@armadillo (ttySC1) (Tue Aug 25 14:52:35 2015):
| The system is going down for system halt NOW!
| INIT: Switching to runlevel: 0
| INIT: Sending process

After reverting, it continues again with:

| es the TERM signal
| [info] Using makefile-style concurrent boot in runlevel 0.
| [ ok ] Asking all remaining processes to terminate...done.
| [ ok ] All processes ended within 1 seconds...done.
| [ ok ] Stopping enhanced syslogd: rsyslogd.
| [ ok ] Stopping NFS common utilities: idmapd statd.
| rpcbind: rpcbind terminating on signal. Restart with "rpcbind -w"
| [ ok ] Stopping rpcbind daemon....
| [....] not deconfiguring network interfaces: network file systems
still mounted.[war (warning).
| [info] Saving the system clock.
| [info] Hardware Clock updated to Tue Aug 25 14:56:18 CEST 2015.
| [ ok ] Deactivating swap...done.
| [info] Will now halt.
| reboot: System halted

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
