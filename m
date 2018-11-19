From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
Date: Mon, 19 Nov 2018 09:21:24 -0600
Message-ID: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com> <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sugaya.taichi@socionext.com
Cc: linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Nov 18, 2018 at 7:00 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add Milbeaut M10V earlyprintk.

Do you really need earlyprintk? earlycon is preferred instead. It's
not quite as early, but doesn't require rebuilding the kernel and
supports more than 1 fixed device. If you crash before earlycon is
enabled, that pretty much means either a bad dtb memory node or just
flaky memory.

Rob
