From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] tty: serial: meson: allow baud-rates higher than 115200
Date: Wed, 18 Jan 2017 13:44:42 -0800
Message-ID: <m2o9z4yred.fsf@baylibre.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
        <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170115223255.10350-2-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
        (Martin Blumenstingl's message of "Sun, 15 Jan 2017 23:32:52 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:

> The vendor driver allows setting baud-rates higher than 115200 baud.
> There is a check in the vendor driver which prevents using more than
> 115200 baud during startup, however it does not have such a check in
> .set_termios.
> Higher baud-rates are often used by the bluetooth modules embedded into
> the SDIO wifi chips (Amlogic devices use brcmfmac based wifi chips quite
> often, 2000000 baud seems to be a common value for the UART baud-rate in
> Amlogic's "libbt").
>
> I have tested this on a Meson GXL device with uart_A (to which the
> bluetooth module is connected, where initialization times out with
> 115200 baud) and uart_AO (which I manually set to 2000000 baud  and then
> connected with my USB UART adapter to that).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Acked-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
