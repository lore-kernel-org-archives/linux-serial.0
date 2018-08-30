From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
Date: Thu, 30 Aug 2018 09:19:29 -0500
Message-ID: <CAL_Jsq+UDvL9+3RT8wKXyobXJx14MmcS4X0B1hVghQHXttGAmQ@mail.gmail.com>
References: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>, kurt@linutronix.de, Masahiro Yamada <yamada.masahiro@socionext.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 30, 2018 at 4:10 AM John Garry <john.garry@huawei.com> wrote:
>
> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
> check was added for the UART driver being probed prior to the parent IRQ
> controller.
>
> Unfortunately this breaks certain boards which have no interrupt support,
> like Huawei D03.
>
> Indeed, the 8250 DT bindings state that interrupts should be supported -
> not must.
>
> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
> does relay whether the IRQ host controller domain is not ready, i.e.
> defer probe, instead of assuming it.

Good, one less user of irq_of_parse_and_map().

Reviewed-by: Rob Herring <robh@kernel.org>
