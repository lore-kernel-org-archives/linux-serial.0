From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Fri, 6 Oct 2017 07:33:41 -0500
Message-ID: <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com> <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 4, 2017 at 3:51 AM, Frédéric Danis
<frederic.danis.oss@gmail.com> wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
>
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
>
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 94 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
