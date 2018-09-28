From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] tty: Convert to using %pOFn instead of device_node.name
Date: Fri, 28 Sep 2018 17:32:37 -0500
Message-ID: <CAL_JsqK4UGPoqE=K0hdx1=3XnzB5DVY=mCO8jPe=iZrsf9vk2Q@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-46-robh@kernel.org>
 <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 28, 2018 at 5:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/tty/ehv_bytechan.c                  | 12 ++++++------
> >  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 ++++----
> >  drivers/tty/serial/pmac_zilog.c             |  4 ++--
> >  3 files changed, 12 insertions(+), 12 deletions(-)
>
> Hey Greg, Is this still in your queue? Maybe you've just been extra
> busy lately. ;)

NM. I see it's applied now. Sorry for the noise.

Rob
