From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an
 standard TTY port
Date: Tue, 12 Jun 2018 19:20:03 -0600
Message-ID: <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-19-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-19-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 5:52 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> serdev driver can only be used by serdev controllers that are compatible
> with ttyport.

I'm hesitant to expose a tty device on top of serdev to userspace that
we then have to support forever unless that's the only way tty devices
(for serial ports) are created.

I did a similar patch which just registered both serdev and a tty
allowing them to coexist. It suffered from warnings about open counts
though and felt hacky.

Rob
