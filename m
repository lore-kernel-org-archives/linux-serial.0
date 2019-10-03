From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] serial: sh-sci: Use platform_get_irq_optional() for optional interrupts
Date: Thu, 03 Oct 2019 09:10:16 -0700
Message-ID: <5d961d69.1c69fb81.43b1b.addf@mx.google.com>
References: <20191001180743.1041-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180743.1041-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-01 11:07:43)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, scary warnings may be printed for optional interrupts:
>=20
>     sh-sci e6550000.serial: IRQ index 1 not found
>     sh-sci e6550000.serial: IRQ index 2 not found
>     sh-sci e6550000.serial: IRQ index 3 not found
>     sh-sci e6550000.serial: IRQ index 4 not found
>     sh-sci e6550000.serial: IRQ index 5 not found
>=20
> Fix this by calling platform_get_irq_optional() instead for all but the
> first interrupts, which are optional.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
