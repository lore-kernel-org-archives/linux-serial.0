From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [rtc-linux] [PATCH 8/8] ARM: vt8500: gpio: Devicetree support for arch-vt8500
Date: Wed, 8 Aug 2012 16:28:24 +0200
Message-ID: <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A@mail.gmail.com>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
	<1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
	<CACRpkdbYxpN9RCu8j8KMBgrb=-DsYZHq7hx-ifmHhJ0ZZcRYjw@mail.gmail.com>
	<201208080919.52592.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201208080919.52592.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Eric Andersson <eric.andersson-TStm8jYLEPpl57MIdRCFDg@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 8, 2012 at 11:19 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

>> What on earth are all those magic numbers?
>>
>> I *guess* they're enabling some default GPIO settings etc.
>
> No, they are the register offsets you quoted above, per bank.

Aha I was fooled by this:

+struct vt8500_gpio_bank_regs {
+       int     en;
+       int     dir;
+       int     data_out;
+       int     data_in;
+       int     ngpio;
+};

This needs to be named something intuitive like "vt8500_gpio_bank_regoffsets"

Some kerneldoc intsead of the opaque comment above will also improve
readability a lot:

/**
  * struct vt8500_gpio_bank_regoffsets
  * @en: offset to enable register in the bank
  * ...

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
