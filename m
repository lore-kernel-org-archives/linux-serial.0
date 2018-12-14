From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] tty: serial: qcom_geni_serial: Remove interrupt storm
Date: Thu, 13 Dec 2018 16:59:09 -0800
Message-ID: <CAD=FV=XoZKLppEzh+MSK7wMTCNvzE174aLYTtjvbgY00dDTLCQ@mail.gmail.com>
References: <20181213194321.240148-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213194321.240148-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Thu, Dec 13, 2018 at 11:43 AM Ryan Case <ryandcase@chromium.org> wrote:
>
> Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
> transaction so we don't continue to receive a flurry of free space
> interrupts while waiting for the M_CMD_DONE notification. Re-enable the
> watermark when establishing the next transaction.
>
> Also clear the watermark interrupt after filling the FIFO so we do not
> receive notification again prior to actually having free space.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v2:
> Addressed Doug's comments
>  - Avoid M_TX_WATERMARK_EN writes when values already match
>  - Added note about M_TX_WATERMARK_EN triggering and latching
>
>  drivers/tty/serial/qcom_geni_serial.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If I echo something out the serial port I now see 2 interrupts fire.
That seems about right compared to before where we'd get boatloads.
Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
