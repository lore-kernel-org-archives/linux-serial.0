From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: of_serial: remove NULL pointer check for clk_disable_unprepare
Date: Sun, 21 May 2017 04:04:50 +0900
Message-ID: <CAK7LNASoHTNeNWOX63S74bE6PrTsOce_rxtSiLkNypTPcSDJFA@mail.gmail.com>
References: <1495302286-1503-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495302286-1503-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, Sekhar Nori <nsekhar@ti.com>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Lechner <david@lechnology.com>, Thor Thayer <tthayer@opensource.altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

2017-05-21 2:44 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> After long term efforts of fixing non-common clock implementations,
> clk_disable() is a no-op for a NULL pointer input, and this is now
> tree-wide consistent.
>
> All clock consumers can safely call clk_disable(_unprepare) without
> NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Sorry, I retract this patch.

Krzysztof pointed out
cleanups only for clk_disable_unprepare() will lose the code symmetry.

NULL pointer checks for clk_prepare_enable() should be
removed to keep the code symmetrical.

This is possible for common-clock framework because
clk_prepare_enable() is also a no-op for a NULL clk input.
But it is not necessarily true for non-common clock implementations.


-- 
Best Regards
Masahiro Yamada
