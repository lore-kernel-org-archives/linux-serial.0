From: Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v1 7/8] Bluetooth: hci_serdev: remove the
 HCI_UART_INIT_PENDING check
Date: Sun, 19 Nov 2017 22:43:25 +0200
Message-ID: <20171119204325.GA24345@x1c.home>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-8-martin.blumenstingl@googlemail.com>
 <56889A64-AFB2-454C-9889-FAA4C051168A@holtmann.org>
 <CAFBinCC_G845v4cZW9hvwYEDQhTCLW1iG_JWzAz9Gu42rM4_Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFBinCC_G845v4cZW9hvwYEDQhTCLW1iG_JWzAz9Gu42rM4_Zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Martin,

On Sun, Nov 19, 2017, Martin Blumenstingl wrote:
> >> @@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
> >>       else
> >>               hdev->dev_type = HCI_PRIMARY;
> >>
> >> -     if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
> >> -             return 0;
> >> -
> >
> > then lets also remove the flag definition itself. Or if that is
> > still needed for some legacy operation, then describe this. For
> > example I also see it used in hci_serdev.c and main question would
> > be if it is used there as well or some legacy cruft.
> 
> this flag is still used in hci_ldisc.c (if that's what you mean
> instead of hci_serdev.c):
> as far as I understand the code it's used to postpone the
> hci_register_dev() call until the sync response is received
> 
> Johan Hedberg added this code in 9f2aee848fe6 ("Bluetooth: Add delayed
> init sequence support for UART controllers") - it would be great if he
> could comment on this (he is CC'ed on this mail)

That patch is over five years old, so don't count on me remembering the
details ;)  That said, your analysis of its use sounds correct. It's
possible however that we've since then given HCI drivers other
capabilities that would make the INIT_PENDING flag redundant. E.g. the
setup callback didn't exist at the time that I wrote the patch.

Johan
