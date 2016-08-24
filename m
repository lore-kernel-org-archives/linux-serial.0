From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Wed, 24 Aug 2016 10:29:58 -0400
Message-ID: <A8AA3046-E635-4697-BA01-86FFFBB5B2E0@holtmann.org>
References: <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com> <20160822180254.5c95af7c@lxorguk.ukuu.org.uk> <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com> <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk> <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org> <20160822223223.398ee72d@lxorguk.ukuu.org.uk> <20160822220017.GA10689@amd> <20160822235414.4b2f8712@lxorguk.ukuu.org.uk> <20160822235758.gh33xupgyroye5wa@earth> <20160823011521.0ed94283@lxorguk.ukuu.org.uk> <20160823005749.io6x4oi7muttkhfx@earth> <20160824145714.02bbebb3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824145714.02bbebb3-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

>> So you mean if I do "hciconfig hci0 down", then the uart-bus should
>> "down" the tty and only on "hciconfig hci0 up" it should "up" the
>> tty? I would expect a uart-bus slave-device takes control of the
>> device ("up" it) on probe. It's hardwired anyway.
> 
> Today you can switch stacks at runtime, you can switch between the kernel
> stack and debug tools at runtime. Breaking that is a regression.

actually that is not true. We have HCI User Channel since a long time that gives you raw access to the devices. And also kernel interfaces to do all vendor / debug tasks.

Regards

Marcel
