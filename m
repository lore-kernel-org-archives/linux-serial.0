From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 09/11] Bluetooth: add nokia driver
Date: Wed, 22 Mar 2017 16:26:28 -0500
Message-ID: <CAL_Jsq+UXxocmpSJwJ8dVY0ZSLn1Rk+GfTRKP7Wqvo-_cE4qPg@mail.gmail.com>
References: <20170321223216.11733-1-sre@kernel.org> <20170321223216.11733-10-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170321223216.11733-10-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> This adds a driver for the Nokia H4+ protocol, which is used
> at least on the Nokia N9, N900 & N950.
>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---

> +       btdev->wakeup_host = devm_gpiod_get(dev, "host-wakeup", GPIOD_IN);
> +       if (IS_ERR(btdev->wakeup_host)) {
> +               err = PTR_ERR(btdev->wakeup_host);
> +               dev_err(dev, "could not get host wakeup gpio: %d", err);
> +               return err;
> +       }
> +
> +       btdev->wake_irq = gpiod_to_irq(btdev->wakeup_host);

Missed this in the binding review, but generally, we make these
interrupts rather than gpios in the binding.

> +
> +       err = devm_request_threaded_irq(dev, btdev->wake_irq, NULL,
> +               wakeup_handler,
> +               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +               "wakeup", btdev);
> +       if (err) {
> +               dev_err(dev, "could request wakeup irq: %d", err);
> +               return err;
> +       }
