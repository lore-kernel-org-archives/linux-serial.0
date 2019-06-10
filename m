From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
Date: Mon, 10 Jun 2019 12:39:11 -0700
Message-ID: <CAF6AEGt9=xND3TyJy5HDg3RbXB=dxzj6oqBxKX9MaC5O2=JYVQ@mail.gmail.com>
References: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
 <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com> <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org, David Brown <david.brown@linaro.org>, jslaby@suse.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khasim.mohammed@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 12:11 PM Jorge Ramirez
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> On 6/10/19 19:53, Rob Clark wrote:
> > On Mon, Jun 10, 2019 at 10:23 AM Jorge Ramirez-Ortiz
> > <jorge.ramirez-ortiz@linaro.org> wrote:
> >> The function msm_wait_for_xmitr can be taken with interrupts
> >> disabled. In order to avoid a potential system lockup - demonstrated
> >> under stress testing conditions on SoC QCS404/5 - make sure we wait
> >> for a bounded amount of time.
> >>
> >> Tested on SoC QCS404.
> >>
> >> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >
> > I had observed that heavy UART traffic would lockup the system (on
> > sdm845, but I guess same serial driver)?
> >
> > But a comment from the peanut gallary:  wouldn't this fix lead to TX
> > corruption, ie. writing more into TX fifo before hw is ready?  I
> > haven't looked closely at the driver, but a way to wait without irqs
> > disabled would seem nicer..
> >
> > BR,
> > -R
> >
>
> I think sdm845 uses a different driver (qcom_geni_serial.c) but yes in
> any case we need to determine the sequence leading to the lockup. In our
> internal releases we are adding additional debug information to try to
> capture this info.

ahh, ok.. perhaps qcom_geni_serial has a similar issue.. fwiw where I
tend to hit it is debugging mesa, bugs that can trigger GPU lockups
can tricker a lot of them, and a lot of dmesg spew.  Which in turn
seems to freeze usb (? I think.. I'm using a usb-c ethernet adapter)
making it hard to ctrl-c the thing that  is causing the GPU lockups in
the first place.

> But also I dont think this means that the safety net should not be used

yeah, probably not worse than the current state.. although a proper
solution would be nice

> btw, do you think that perhaps we should add a WARN_ONCE() on timeout?.

not sure if backtrace adds much value here.. but perhaps a (very)
ratelimited warning msg?  You don't want to make the underlying
problem too much worse with too much debug msg but some hint about
what is happening could be useful.

BR,
-R
