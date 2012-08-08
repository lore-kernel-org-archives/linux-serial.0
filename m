From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: RE: [rtc-linux] [PATCH 8/8] ARM: vt8500: gpio: Devicetree support
 for arch-vt8500
Date: Wed, 8 Aug 2012 19:46:54 +0000
Message-ID: <76F764B079F92A4E843589C893D0A022D1DCA8E3@SERVER.prisktech.co.nz>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
 <CACRpkdbYxpN9RCu8j8KMBgrb=-DsYZHq7hx-ifmHhJ0ZZcRYjw@mail.gmail.com>
 <201208080919.52592.arnd@arndb.de>,
 <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Eric Andersson <eric.andersson-TStm8jYLEPpl57MIdRCFDg@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>L
List-Id: linux-serial@vger.kernel.org

>This needs to be named something intuitive like "vt8500_gpio_bank_regoffsets"

>Some kerneldoc intsead of the opaque comment above will also improve
>readability a lot:

>/**
>  * struct vt8500_gpio_bank_regoffsets
>  * @en: offset to enable register in the bank
>  * ...

Changes made as requested.


>My feeling however is that the "vt8500_chip->regoff" is wrong, which
>would mean only the first bank works. The code adds the same offsets
>per bank once more that it sets in this bank table.

>        Arnd

Oh.. Thanks for picking that up Arnd. You are absolutely correct. I have removed
the references for ->regoff. Left over from old code.

Regards

Tony Prisk
