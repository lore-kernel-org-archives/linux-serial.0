From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an
 standard TTY port
Date: Wed, 13 Jun 2018 08:35:53 +0200
Message-ID: <CAPybu_1rgnAGa813pdNyhem5q3t_gGwAVtCO933bb24KB+sghQ@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-19-ricardo.ribalda@gmail.com> <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Rob,
On Wed, Jun 13, 2018 at 3:20 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 11, 2018 at 5:52 AM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> > serdev driver can only be used by serdev controllers that are compatible
> > with ttyport.
>
> I'm hesitant to expose a tty device on top of serdev to userspace that
> we then have to support forever unless that's the only way tty devices
> (for serial ports) are created.

My concern is that, with the current implementation, serdev does have
a tiny collection of usecases:

-It cannot be used for board bring up
-It cannot be used as a replacement of hciattach and friends

It can only be used on embedded devices or platforms where the
developer has control of the ACPI table.

This hack, allows its use in almost any scenario and I have been
happily using it for two weeks with no issue.
It is also a very simple solution that does not have the issues of
cdev/serdev coexistence that you mention.

I am not very convinced about all the ttydev being serdevs. Adding 1K
lines of code to people that do not plan to use serdev seems like a
high expense. If in the future we can get rid of all the hciattach
programs then we can redesign the port probing.

>
> I did a similar patch which just registered both serdev and a tty
> allowing them to coexist. It suffered from warnings about open counts
> though and felt hacky.
>
> Rob



-- 
Ricardo Ribalda
