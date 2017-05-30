From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 9/9] serial: exar: Add support for IOT2040 device
Date: Tue, 30 May 2017 21:38:02 +0300
Message-ID: <CAHp75VeUp_Ucg81BEL45P=dQVst_TMV2azcESB6-zFWm3oARPg@mail.gmail.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com> <86bb088c2f8530930f68cc236f16569ac7be160b.1496127684.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86bb088c2f8530930f68cc236f16569ac7be160b.1496127684.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> This implements the setup of RS232 and the switch-over to RS485 or RS422
> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
> to switch between the different modes. The external logic is controlled
> via MPIO pins of the EXAR controller.
>
> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
> an LED.
>
> As the XR17V352 used on the IOT2040 is not equipped with an external
> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
> subdevice IDs. Thus, we have to check via DMI for the target platform.

Take into consideration comments per patch 2.
Otherwise looks good to me.

-- 
With Best Regards,
Andy Shevchenko
