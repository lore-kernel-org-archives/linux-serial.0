From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Wed, 24 May 2017 10:52:34 -0300
Message-ID: <CAOMZO5CYaZZES6VSUE2JpCvHSH+fvr13ECZ=oKKoKRpmQUXDaA@mail.gmail.com>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
 <CAOMZO5CT5MS1WGm_rCJ61Ambh+rMapsQWD84RXtagtt3HhmZwg@mail.gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D75E@SW-EX-MBX02.diasemi.com>
 <CAOMZO5D=_L9Dd3gOgQssKBN5TouGqOx+zJnwr+-1HQrVT_yLRQ@mail.gmail.com> <6ED8E3B22081A4459DAC7699F3695FB7018CD8D7CD@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D7CD@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-serial@vger.kernel.org

Hi Steve,

On Wed, May 24, 2017 at 9:49 AM, Steve Twiss
<stwiss.opensource@diasemi.com> wrote:

> I used this tag: jb4.3_1.1.1-ga
> http://git.freescale.com/git/cgit.cgi/imx/uboot-imx.git/commit/?id=jb4.3_1.1.1-ga
>
> This repo is slightly modified for a project I am working on, but it only queries
> the  I2C for devices before printing out some messages, so minor changes I
> think. Here's the output from the console:

I am not able to reproduce it using this same U-Boot version on my
mx6sabresd board:

https://pastebin.com/ppnrnidr

Had to select dtb append in the kernel menu config.
