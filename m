From: Aaron Durbin <adurbin@chromium.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Mon, 9 Apr 2018 10:00:13 -0600
Message-ID: <CAE2855vVXr24bOjXvU7pVcDs_X-6G-xndsUf=9jtyXVJS5G6bA@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
 <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
 <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
 <20180326192428.71c23abf@alans-desktop> <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
 <20180329143400.6d9256a5@alans-desktop> <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
 <20180406144713.30d1ca00@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406144713.30d1ca00@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Aaron Durbin <adurbin@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Doug Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 6, 2018 at 7:47 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> But we don't have the full ACPI interpreter up in the early part of
>> the kernel. All these 'early' devices have their own setup/config
>> which is the source of the issue. Or maybe I am wrong about the full
>> interpreter and the early drivers are just not taking advantage of the
>> ACPI device binding?
>
> In very early boot with serial console you just have to pray. No change
> there. Once ACPI comes up you however have the information to populate
> everything and configure correctly.
>
> So it should work fine except for kernel hackers trying to do early boot
> debug, which is a small (but important) cornercase ?

Yes, I think we're on the same page. This patch series is trying to
get the early console working correctly given the current code
assumptions.

-Aaron
