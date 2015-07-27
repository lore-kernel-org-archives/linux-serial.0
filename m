From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: etraxfs-uart: use mctrl_gpio helpers for handling
 modem signals
Date: Mon, 27 Jul 2015 16:09:06 +0200
Message-ID: <CACRpkdYE8R5nqtZJV+Ko7o-Fkyd6SA4ew69VNYLb113+pNRSzA@mail.gmail.com>
References: <1437782566-11528-1-git-send-email-nks@flawful.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437782566-11528-1-git-send-email-nks@flawful.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <nks@flawful.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jul 25, 2015 at 2:02 AM, Niklas Cassel <nks@flawful.org> wrote:

> In order to use the mctrl_gpio helpers, we change the DT bindings:
> ri-gpios renamed to rng-gpios. cd-gpios renamed to dcd-gpios.
> However, no in-tree dts/dtsi specifies these, so no worries.
>
> Signed-off-by: Niklas Cassel <nks@flawful.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
