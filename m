From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] serdev: make synchronous write return bytes written
Date: Mon, 19 Nov 2018 09:15:37 -0600
Message-ID: <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
References: <20181114150904.19653-1-johan@kernel.org> <20181114150904.19653-3-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114150904.19653-3-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
>
> Make the synchronous serdev_device_write() helper behave analogous to
> the asynchronous serdev_device_write_buf() by returning the number of
> bytes written (or rather buffered) also on timeout.
>
> This will allow drivers to distinguish the case where data was partially
> written from the case where no data was written.
>
> Also update the only two users that checked the return value.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gnss/serial.c     |  2 +-
>  drivers/gnss/sirf.c       |  2 +-
>  drivers/tty/serdev/core.c | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index 31e891f00175..def64b36d994 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
>
>         /* write is only buffered synchronously */
>         ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
> -       if (ret < 0)
> +       if (ret < 0 || ret < count)

The 2nd condition covers the 1st condition. Though I guess this will
all change anyways when you address the FIXME below.

>                 return ret;
>
>         /* FIXME: determine if interrupted? */
