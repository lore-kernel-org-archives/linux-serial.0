From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Thu, 29 Mar 2018 14:34:00 +0100
Message-ID: <20180329143400.6d9256a5@alans-desktop>
References: <20180314003655.12141-1-djkurtz@chromium.org>
        <20180314003655.12141-2-djkurtz@chromium.org>
        <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
        <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
        <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
        <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
        <20180326192428.71c23abf@alans-desktop>
        <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Durbin <adurbin@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Doug Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 26 Mar 2018 20:56:45 -0600
Aaron Durbin <adurbin@chromium.org> wrote:

> On Mon, Mar 26, 2018 at 12:24 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> Sadly, this situation
> >> is not unique to this hardware. There is hardware all over that does
> >> not meet the current assumptions being made in the early uart drivers
> >> within the kernel.  
> >
> > Is there any fundamental reason you can't just embed dt entries in the
> > ACPI table to describe the other features you need. I appreciate it
> > doesn't solve the generic PC case but it ought to help for anything where
> > the firmware cares about Linux ?  
> 
> What's the method for doing that? Using _DSD methods? Or have a
> pointer to examples? Sorry, I haven't spelunked into the current state
> of bridging ACPI and devicetree in a while.

ACPI 5.1 adds an _DSD method UUID for device properties.

The kernel device_property_* interface will pick them up just as if they
came from DT tables etc.

Alan
