From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 7/9] serdev: Introduce new bus for serial attached devices
Date: Wed, 18 Jan 2017 15:26:03 -0600
Message-ID: <CAL_JsqJCg9wXA8hvo1TDPtyRN+ydMs1_S7yzwggvZAnq1aRgag@mail.gmail.com>
References: <20170116225436.17505-1-robh@kernel.org> <20170116225436.17505-8-robh@kernel.org>
 <09cdab76-ee1a-45da-699f-a66bf7148579@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <09cdab76-ee1a-45da-699f-a66bf7148579-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 18, 2017 at 5:53 AM, Frédéric Danis
<frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
>
> Le 16/01/2017 à 23:54, Rob Herring a écrit :
>>
>> ---
>> v2:
>> - Add modalias sysfs attr and uevent hook
>
> ...
>>
>> +static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
>> +{
>> +       /* TODO: ACPI and platform modalias */
>> +       return of_device_uevent_modalias(dev, env);
>> +}
>
> ...
>>
>> +static ssize_t modalias_show(struct device *dev,
>> +                            struct device_attribute *attr, char *buf)
>> +{
>> +       ssize_t len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
>> +       buf[len] = '\n';
>> +       buf[len+1] = 0;
>> +       return len+1;
>> +}
>
>
> This prevents from building serdev as a module with following errors:
>   ERROR: "of_device_uevent_modalias" [drivers/tty/serdev/serdev.ko]
> undefined!
>   ERROR: "of_device_get_modalias" [drivers/tty/serdev/serdev.ko] undefined!

Turns out, there's a fix already[1] that should be going in via Greg's tree.

Rob

[1] https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1299121.html
