From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 0/6] serdev multiplexing support
Date: Tue, 18 Jul 2017 18:14:50 -0500
Message-ID: <CAL_JsqKpQk+gNvUegNvSAXwwSt6xNRWzS_tpwZFgfDxSJSwz_Q@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 17, 2017 at 10:24 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Hi!
>
> This is a new attempt to add multiplexer support to serdev. It is now based
> on the mux subsystem, making it more generic than the previous iteration
> ("[RFC 0/4] serdev GPIO-based multiplexing support").
>
> Thanks to reviewers for their comments. This revision incorporates the
> changes suggested as far as they are still applicable, which mostly applies
> to those concerning the MAX9260 i2c adapter driver.
>
> New patches have been added that fix a small issue in the mux include files
> ("mux: include compiler.h from mux/consumer.h"), and implement deferred
> probing of serdev controllers ("serial: core: support deferring serdev
> controller registration"), hopefully correctly.
>
> This series depends on the "pinctrl: sh-pfc: r8a7792: Add SCIF1 pin groups"
> patch as well as v15 of the mux subsystem series ("[PATCH v15 00/13] mux
> controller abstraction and iio/i2c muxes").

Please also document how muxed devices are represented in DT in
serial/slave-device.txt.

Rob
