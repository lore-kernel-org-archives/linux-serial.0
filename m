From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date: Wed, 28 Nov 2018 08:32:34 -0800
Message-ID: <154342275484.88331.11625853632580952641@swboyd.mtv.corp.google.com>
References: <20181127022536.104663-1-ryandcase@chromium.org>
 <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
 <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
 <154337068886.88331.5708018437286125025@swboyd.mtv.corp.google.com>
 <CACjz--nbtoHA3ejeF+es4q5qsyYeoLRbUsd+a0r2RYfkuVVwPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACjz--nbtoHA3ejeF+es4q5qsyYeoLRbUsd+a0r2RYfkuVVwPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Quoting Ryan Case (2018-11-27 18:37:15)
> On Tue, Nov 27, 2018 at 6:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Ryan Case (2018-11-27 17:24:44)
> >
> > > I hope underflow is impossible as well. However, if the hardware did
> > > wind up in a strange state I wanted to err on the side of not throwing
> > > away data and being able to resume later if things recovered. I can
> > > remove the defensive checks if that's the custom, otherwise I'll
> > > update the comparison logic accordingly.
> >
> > Well it looks like impossible code because an unsigned value can't be
> > less than zero. So it's not about customs, more about dead code removal.
> =

> Agreed on the current dead code aspect which is why I offered the
> option of updating the comparison logic, but I can just delete it if
> you want.

Ok, got it.
