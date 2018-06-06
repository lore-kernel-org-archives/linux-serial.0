From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
Date: Wed, 6 Jun 2018 12:55:42 +0300
Message-ID: <CAHp75VfZBKTu5XHt5_0eQp6m0Tdyi0H3vNz00c3ok+jgx2By7A@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-19-ricardo.ribalda@gmail.com> <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
 <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com> <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 6, 2018 at 10:47 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Hi Andy,
> On Wed, Jun 6, 2018 at 8:58 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:

> I have defaulted the module to n as you suggested. You can take a look
> to the patches that I plan to submit tomorrow at:
>
> https://github.com/ribalda/linux/tree/serdev2

n _is_ default. So, just remove a line.

-- 
With Best Regards,
Andy Shevchenko
