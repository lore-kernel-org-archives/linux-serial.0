From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 00/23] LPUART fixes and improvements
Date: Wed, 31 Jul 2019 14:59:59 -0300
Message-ID: <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, NXP Linux Team <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Andrey,

On Wed, Jul 31, 2019 at 2:53 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Everyone:
>
> This series contains fixes/improvements to LPUART dirver I came up
> with recently as well as fixes picked up from Toradex and NXP Vybrid
> repos.
>
> Feedback is welcome!
>
> Changes since [v1]:

Greg has already applied some of these patches:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing

Please rebase on his tree and send the remaining ones.

Thanks
