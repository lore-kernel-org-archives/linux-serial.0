From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 16:29:56 +0000
Message-ID: <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ricardo.ribalda@gmail.com
Cc: adurbin@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, marc_gonzalez@sigmadesigns.com, Doug Anderson <dianders@chromium.org>, matt.redfearn@mips.com, Jeffy <jeffy.chen@rock-chips.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
ricardo.ribalda@gmail.com> wrote:

> Hi Daniel


> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
wrote:
> >
> > AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> > input clock.
> >
> > Allow these platforms to set up this clock by specifying a kernel
command
> > line like:
> > earlycon=amdcz,mmio32,0xfedc6000,115200


> If the port and the mode (mmio32) is always fixed, couldn't we just
> add those two into
> early_amdcz_setup?

There are multiple memory mapped UARTs on at least the one chip I am aware
of, specifying the address here chooses which port to use as the early
console.

In fact, the recommended way is to have firmware specify an ACPI SPCR table
with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/) to
configure proper access and address.  With an SPCR table in place,  the
kernel command line just becomes "earlycon", with no parameters.

-Dan
