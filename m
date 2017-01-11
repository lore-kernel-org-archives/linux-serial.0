From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Wed, 11 Jan 2017 09:51:29 -0200
Message-ID: <CAOMZO5CGoq6FKSE6n9CyQycdtuJ6dAjSL7vJU4ZtXjAPWvdAug@mail.gmail.com>
References: <20170107134557.GA12299@archie.localdomain> <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain> <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain> <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
 <20170107230624.GA21729@archie.localdomain> <CAOMZO5DedNURGV_k5Y=nt1O98SojsvrOd69PEPEzi8F7N3dJuw@mail.gmail.com>
 <20170108180609.GB24155@archie.localdomain> <CAOMZO5AYha+SwS4761XxOnUtT1DYhHH69UpXmQzcmEdfC++JKQ@mail.gmail.com>
 <20170111003319.GA25265@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111003319.GA25265@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, Tim Harvey <tharvey@gateworks.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Tue, Jan 10, 2017 at 10:33 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> Hi Fabio,
>
> On Sun, Jan 08, 2017 at 07:46:29PM -0200, Fabio Estevam wrote:
>> > What's the revision of the i.MX6Q on your board? Mine is 1.5 (TO 1.3)
>>
>> Mine is a mx6solo rev1.1.
>
> Could it be dependent upon SMP? Do you have an i.MX6Q board around to
> try?

Unfortunately the only hardware I can test RS485 is based on mx6solo.

Adding Tim Harvey, who could probably test RS485 on MX6Q.

Regards,

Fabio Estevam
