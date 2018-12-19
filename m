From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX
 buffer
Date: Wed, 19 Dec 2018 11:04:25 -0800
Message-ID: <20181219190425.GC109358@google.com>
References: <20181219181747.118278-1-mka@chromium.org>
 <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, msavaliy@codeaurora.org, ryandcase@chromium.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 19, 2018 at 10:49:26AM -0800, Evan Green wrote:
> On Wed, Dec 19, 2018 at 10:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
> > softlock") the size of TX transfers was limited to the TX FIFO size,
> > and wrap arounds of the UART circular buffer were split into two
> > transfers. With the commit wrap around are allowed within a transfer.
> > The TX FIFO of the geni serial port uses a word size of 4 bytes. In
> > case of a circular buffer wrap within a transfer the driver currently
> > may write an incomplete word to the FIFO, with some bytes containing
> > data from the circular buffer and others being zero. Since the
> > transfer isn't completed yet the zero bytes are sent as if they were
> > actual data.
> >
> > Handle wrap arounds of the TX buffer properly and ensure that words
> > written to the TX FIFO always contain valid data (unless the transfer
> > is completed).
> >
> > Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Oh nice, so this did end up being your problem with corrupt
> characters?

Yes

> Strange though, I still would have expected this bug to
> result in inserted serial characters, rather than edited ones.

You are right here, initially I interpreted that some bytes changed,
but actually we observed inserted bytes, and later missing ones at the
end of the transfer.

> Either way, this looks good to me.
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks!
