From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 2/6] serdev: add method to set parity
Date: Tue, 18 Jul 2017 18:08:53 -0500
Message-ID: <CAL_JsqKAXLWxLNfT=pRjcFCe2kKU6pbwYSbgZ9Yu3S_fpW55tA@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 17, 2017 at 10:24 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds serdev_device_set_parity() and an implementation for ttyport.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/tty/serdev/core.c           | 12 ++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 17 +++++++++++++++++
>  include/linux/serdev.h              |  4 ++++
>  3 files changed, 33 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
