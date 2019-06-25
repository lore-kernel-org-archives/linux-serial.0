From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2 v9] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Date: Tue, 25 Jun 2019 14:19:48 +0300
Message-ID: <20190625111948.GV9224@smile.fi.intel.com>
References: <20190620062420.11650-1-sr@denx.de>
 <CAMuHMdXMpS_pg9N0qSW=Li0QavAMRG79RJcS4s0w6NTCxv_zzg@mail.gmail.com>
 <24bfb52c-6f77-b7cd-7421-9e6e4b0aa7d3@denx.de>
 <CAMuHMdWeX6=SuSPVUB=WaYMsUbrmg5sraM=APeXsqr_Yv6u4AA@mail.gmail.com>
 <d8ae626b-e574-be33-f698-3cb992653683@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d8ae626b-e574-be33-f698-3cb992653683@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 25, 2019 at 07:27:33AM +0200, Stefan Roese wrote:
> On 24.06.19 17:35, Geert Uytterhoeven wrote:
> > On Mon, Jun 24, 2019 at 5:29 PM Stefan Roese <sr@denx.de> wrote:
> > > On 24.06.19 10:42, Geert Uytterhoeven wrote:

> > > Should both options be supported ("cts-gpio" vs "cts-gpios")?
> > > Documentation/devicetree/bindings/serial/serial.txt only mentions
> > > the "-gpios" variant.
> > 
> > Well, the "-gpio" variant is deprecated, but still supported by
> > devm_gpiod_get_index_optional(), and there are active users in upstream
> > DTS files.
> > 
> > My main objection is (trying to) replicate the matching logic inside
> > gpiolib.c, causing subtle semantic differences. And keeping it consistent,
> > of course.
> > 
> > It would be nice if this could be fixed inside acpi_find_gpio(), so
> > users don't need to be updated.  There may be other subsystems where
> > the difference between DT and ACPI may cause issues, unbeknownst.
> 
> Sure, I can fix this. I would prefer to do this in a follow-up patch
> though, if nobody objects.

In case if you are going to do this, use approach from GPIO library. Perhaps,
it may require to create something like for_each_gpio_suffix() helper.

-- 
With Best Regards,
Andy Shevchenko
