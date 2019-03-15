From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: serial driver cleanups v2
Date: Fri, 15 Mar 2019 19:41:14 +0100
Message-ID: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
 <20190315181118.GF9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315181118.GF9224@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com
List-Id: linux-serial@vger.kernel.org

On 15.03.19 19:11, Andy Shevchenko wrote:

>> The actual goal is generalizing the whole iomem handling, so individual
>> usually just need to call some helpers that do most of the things.
>> Finally, I also wanted to have all io region information consolidated
>> in struct resource.
> 
> That's should be a selling point, not just conversion per se.

hmm, I never was good at selling :o

but I'll try anyways: it shall make the code smaller and easier to
read/understand.

does that count ?

> You have to explain that in each commit message, that the change does bring a
> possible new error message printed.

Ok, I wasn't aware of that. Yes, I missed to read the code of that
function carefully and didn't expect that it does more than just a dumb
wrapper around dev_ioremap() that picks out the params from struct
resource.

OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

> The performance side of the deal, you are lucky here, is not significant
> because it's slow path.

okay :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
