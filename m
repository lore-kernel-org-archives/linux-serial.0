From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
Date: Mon, 11 Feb 2019 16:03:26 -0800
Message-ID: <20190212000326.GS117604@google.com>
References: <20190119002305.16639-1-mka@chromium.org>
 <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: msavaliy@codeaurora.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Balakrishna Godavarthi <bgodavar@codeaurora.org>, linux-kernel-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Sorry for the late reply, your message got buried in my inbox :(

On Mon, Jan 21, 2019 at 08:05:10PM +0530, msavaliy@codeaurora.org wrote:
> On 2019-01-19 05:53, Matthias Kaehlcke wrote:
> > The geni set/get_mctrl() functions currently do nothing unless
> > hardware flow control is enabled. Remove this arbitrary limitation.
> > 
> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for
> > flow control")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c
> > b/drivers/tty/serial/qcom_geni_serial.c
> > index a72d6d9fb9834..38016609c7fa9 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -225,7 +225,7 @@ static unsigned int
> > qcom_geni_serial_get_mctrl(struct uart_port *uport)
> >  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
> >  	u32 geni_ios;
> > 
> > -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> > +	if (uart_console(uport)) {
> >  		mctrl |= TIOCM_CTS;
> >  	} else {
> >  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> > @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct
> > uart_port *uport,
> >  {
> >  	u32 uart_manual_rfr = 0;
> > 
> > -	if (uart_console(uport) || !uart_cts_enabled(uport))
> > +	if (uart_console(uport))
> >  		return;
> > 
> >  	if (!(mctrl & TIOCM_RTS))
> 
> Though late but wanted to check on why flow control is disabled in a BT case
> ?

Flow control is generally enabled, but for the QCA WNC3990 (and
potentially others) it needs to be temporarily disabled during
baudrate switches:

  Bluetooth: hci_qca: Deassert RTS while baudrate change command
 
  This patch will help to stop frame reassembly errors while changing
  the baudrate. This is because host send a change baudrate request
  command to the chip with 115200 bps, Whereas chip will change their
  UART clocks to the enable for new baudrate and sends the response
  for the change request command with newer baudrate, On host side
  we are still operating in 115200 bps which results of reading garbage
  data. Here we are pulling RTS line, so that chip we will wait to send data
  to host until host change its baudrate.
 
  Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

https://lore.kernel.org/patchwork/patch/1038502/

> If i understand, CRTSCTS at serial core is what makes flow as enabled with
> UPSTAT_CTS_ENABLE set and that in turn returned by uart_cts_enabled(uport).
> So is there any settings or configuration missing to enable flow
> control ?

To my knowledge there is no problem with enabling flow control (for
the non-console case). The problem was that RTS was not cleared when
flow control was disabled (done here: https://elixir.bootlin.com/linux/v4.20.7/source/drivers/bluetooth/hci_ldisc.c#L325)

> There could be a case to have 2 wire UART without flow control enablement,
> In that case we may need check for uart_cts_enabled() right ?
> Please add/correct if i missed something.

I'm no serial expert, but IIUC a UART driver doesn't know if the flow
control signals are wired up and is not supposed to do any specific
handling if flow control is enabled on a port without CTS/RTS
wires. Folks with more serial expertise please correct me if I'm
wrong.

Thanks

Matthias
