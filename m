From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [RFC v2 3/6] serdev: add multiplexer support
Date: Wed, 16 Aug 2017 15:23:37 +0200
Message-ID: <CAO3366xyGjrkC_JYCk9kpS=ENDZTW3uBnFThFo4PjcpyBKpgjw@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1500305076-15570-4-git-send-email-ulrich.hecht+renesas@gmail.com> <CAL_JsqJ5M18+cSr0GaMHs5N5quJxLaU-fE2vDPYE1+X5pSFmuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ5M18+cSr0GaMHs5N5quJxLaU-fE2vDPYE1+X5pSFmuQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 19, 2017 at 1:06 AM, Rob Herring <robh@kernel.org> wrote:
>>  static inline struct serdev_controller *to_serdev_controller(struct device *d)
>> @@ -172,7 +180,7 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
>>  {
>>         struct serdev_device *serdev = ctrl->serdev;
>>
>> -       if (!serdev || !serdev->ops->write_wakeup)
>> +       if (!serdev || !serdev->ops || !serdev->ops->write_wakeup)
>
> When is ops ever NULL? Should be a separate change AFIACT.

I dumped it; IIRC that happened once during development due to a bug elsewhere.

CU
Uli
