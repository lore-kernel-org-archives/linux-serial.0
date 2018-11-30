From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3] tty: serial: qcom_geni_serial: Fix softlock
Date: Thu, 29 Nov 2018 18:22:41 -0800
Message-ID: <CAD=FV=WX5Dcs4a1puEf3_DO0x6di48T67buVGoacMneeJG2obw@mail.gmail.com>
References: <20181130021840.75861-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130021840.75861-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ryandcase@chromium.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Thu, Nov 29, 2018 at 6:19 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
>
> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Reworded comment for clarity
> - Fixed mips compiler warning
>
> Changes in v2:
> - Addressed nits raised by Stephen
>
>  drivers/tty/serial/qcom_geni_serial.c | 56 +++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 17 deletions(-)

Looks happy to me now.  Thanks and sorry for misunderstanding how
"active" worked on v2.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
