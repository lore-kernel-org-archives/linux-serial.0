From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/9] arm: add call to CPU idle quirks handler
Date: Fri, 26 Jun 2015 09:40:10 +0200
Message-ID: <2139691.3OPR29uKdT@wuerfel>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <alpine.LFD.2.11.1506251237000.2617@knanqh.ubzr> <alpine.LNX.2.00.1506260715300.499@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1506260715300.499@localhost.localdomain>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan Lynch <nathan_lynch@mentor.com>
List-Id: linux-serial@vger.kernel.org

On Friday 26 June 2015 07:30:49 Paul Osmialowski wrote:
> ENDPROC(cpu_kinetis_do_idle)
> 
> But... what about the rest of this hypothetical proc_kinetis.S file?
> 
> It would be a lot of code duplication with proc-v7m.S I think.
> 

I doubt that the Kinetis has a custom version of the CPU core. Are you
sure that not all Cortex-M4 need this?

As long as the idle implementation depends only on the CPU core type,
it's easy to just define multiple .proc.info.init entries in the
same file, like we do in proc-v7.S.

	Arnd
