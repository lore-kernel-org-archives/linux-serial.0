From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: mctrl_gpio: Drop support for out1-gpios and
 out2-gpios
Date: Fri, 22 Apr 2016 11:32:34 -0700
Message-ID: <571A6E42.9030207@hurleysoftware.com>
References: <1461337814-29058-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461337814-29058-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/22/2016 08:10 AM, Geert Uytterhoeven wrote:
> The OUT1 and OUT2 pins present on some legacy UARTs are basically GPIOs.
> It doesn't make much sense to emulate GPIOs using other GPIOs, hence
> drop support for that.

Thanks Geert.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
