From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] serdev: ttyport: enforce tty-driver open() requirement
Date: Fri, 20 Oct 2017 16:43:41 -0500
Message-ID: <CAL_JsqLxtT7Rh1_w==_3=m+nOAyzopS7rfZ4RZZT3dThpu6Dag@mail.gmail.com>
References: <20171016130620.5404-1-johan@kernel.org> <CAL_JsqKhCue-vMzM2ip3NoGTKb9T_EexG3G2-SekfVZOTKdHOA@mail.gmail.com>
 <20171020122144.GA30326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020122144.GA30326@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 20, 2017 at 7:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 17, 2017 at 11:07:20AM -0500, Rob Herring wrote:
>> On Mon, Oct 16, 2017 at 8:06 AM, Johan Hovold <johan@kernel.org> wrote:
>> > The tty-driver open routine is mandatory, but the serdev
>> > tty-port-controller implementation did not treat it as such and would
>> > instead fall back to calling tty_port_open() directly.
>>
>> The idea was to eventually get rid of the tty_struct dependency and
>> only depend on tty_port. That's very invasive though and needs various
>> pieces of tty_struct to move into tty_port.
>>
>> Of course, tty_port_open itself would have to change as well, so this
>> change doesn't really matter.
>
> So are you acking these patches?

Yeah, I guess. I was mainly trying to give some background on why it
was done the way it was.

For both:

Acked-by: Rob Herring <robh@kernel.org>

Rob
