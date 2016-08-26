From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] serio: serport: add support for buffered write
 and receive
Date: Fri, 26 Aug 2016 16:27:35 -0500
Message-ID: <CAL_JsqLNeV9BDvRtRbDCKbrq-gO9jv8-kmGJNS9AKXUSmEvYOA@mail.gmail.com>
References: <20160824232437.9446-1-robh@kernel.org> <20160824232437.9446-6-robh@kernel.org>
 <20160826201202.GA27227@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160826201202.GA27227@amd>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 26, 2016 at 3:12 PM, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Hi!
>
>> @@ -133,26 +133,29 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
>>       if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>>               goto out;
>>
>> -     for (i = 0; i < count; i++) {
>> -             if (fp) {
>> -                     switch (fp[i]) {
>> -                     case TTY_FRAME:
>> -                             ch_flags = SERIO_FRAME;
>> -                             break;
>> -
>> -                     case TTY_PARITY:
>> -                             ch_flags = SERIO_PARITY;
>> -                             break;
>> -
>> -                     default:
>> -                             ch_flags = 0;
>> -                             break;
>> +     if (serio_buffered_mode_enabled(serport->serio)) {
>> +             serio_receive_buf(serport->serio, cp, count);
>
> Elsewhere:
> +       /* Use buffer receive if the driver provides a callback */
> +       if (drv->receive_buf)
> +               set_bit(SERIO_MODE_BUFFERED, &drv->flags);
>
> Could we use if (drv->receive_buf) above directly, and not require the
> bitfield?

I'm allowing for allowing drivers to provide both functions and be
able to switch between them. However, I didn't provide any mechanism
to do so yet.

Rob
