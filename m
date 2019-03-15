From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: serial driver cleanups v2
Date: Fri, 15 Mar 2019 20:45:45 +0200
Message-ID: <CAHp75VdCy0vtk0wYKrCKFKzdGQXaXQkgL_zWfCZGKas5JO9HtA@mail.gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net> <20190315181118.GF9224@smile.fi.intel.com>
 <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@g
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 8:44 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 15.03.19 19:11, Andy Shevchenko wrote:


> OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
> it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

Compare  iomap vs. ioREmap.

-- 
With Best Regards,
Andy Shevchenko
