From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
Date: Mon, 04 Jun 2018 14:44:28 +0300
Message-ID: <7bdb658727b364e275c121a3bdd351f183d56cb9.camel@linux.intel.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
         <65c26f5db1275e958cfe6390e9336568b0158dea.camel@linux.intel.com>
         <CAJs94EZEEBNZRU3ixkdG9w44xsQDi7MUYAya2dzkAErT=xwqVA@mail.gmail.com>
         <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-06-04 at 12:42 +0200, Giulio Benetti wrote:

> > > I don't see in Cc list author of rs485 code, who might be
> > > interested in
> > > this.
> > > 
> > > So, added him here.
> 
> Thanks Andy for adding in Cc an reviewing.
> Dumb question: how did you find him?

I'm just following mailing lists somehow.
Though you always can do `git annotate` to see who lately did change
what.

> I thought he was between people on get_maintainer.pl output.

Hmm... probably. Never checked myself for this particular case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
