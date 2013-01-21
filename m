From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/7] tty: of_serial: Add pinctrl support
Date: Mon, 21 Jan 2013 23:13:55 +0100
Message-ID: <CACRpkdYNOTcTVNMqD-q8sJ50nuwoXZLUJZpMXWa=mrZGnGY9+g@mail.gmail.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
	<1358544639-14761-7-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358544639-14761-7-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Stefan Roese <sr@denx.de>, Alejandro Mery <amery@geeks.cl>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 18, 2013 at 10:30 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Use pinctrl to configure the SoCs pins directly from the driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

You can poke Greg about this which is fun because it does become
superfluous with the patch titled
"[PATCH v4] drivers/pinctrl: grab default handles from device core"
http://marc.info/?l=linux-kernel&m=135879594515932&w=2

Which will auto-grab the default state on any device.

Greg, can I have your ACK on that device core grab patch
so you don't have to merge this patch but can point out that
it solves the boilerplate problem?

Yours,
Linus Walleij
