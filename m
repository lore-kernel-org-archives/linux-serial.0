From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
Date: Tue, 29 May 2018 23:23:51 +0200
Message-ID: <CAPybu_3tZ2z7sk5tSwgXdqNyiTm_31UwdUsWNL1_eNHBDQyCiw@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-8-ricardo.ribalda@gmail.com> <CAHp75Ve_=euX83qVfArU+ZbcU2Z_PnBdtQGi7XbA7AVfM1XO-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve_=euX83qVfArU+ZbcU2Z_PnBdtQGi7XbA7AVfM1XO-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Tue, May 29, 2018 at 10:35 PM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > Allow creating and deleting devices via sysfs. Devices created will be
> > matched to serdev drivers via modalias (the string provided by the user)
> > and deleted via their name.

> > +       int err;
> > +       char *nline;

> Better to read in reversed order.

> > +       nline = strchr(buf, '\n');
> > +       if (nline)
> > +               *nline = '\0';

> strim() / strstrip() ?

> > +       nline = strchr(buf, '\n');
> > +       if (nline)
> > +               *nline = '\0';

> Ditto.

> > +static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
> > +                                 delete_device_store);

> Perhaps leave it on one line?

> --
> With Best Regards,
> Andy Shevchenko

Thanks for your review. I am working on v2 at
https://github.com/ribalda/linux/tree/serdev2 it fixes your comments except
the line cut for DEVICE_ATTR, I want also to make checkpatch happy ;)

Will send v2  to the list after I got more feedback, you can of course ping
me if there is something in my tree that it is not fixed properly.

Cheers


-- 
Ricardo Ribalda
