From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Fix DCD reading
Date: Mon, 26 Sep 2016 11:28:31 -0300
Message-ID: <CAOMZO5B0Dkx8NTJPrNwR4WE1JJQEY1vczV=d1OtROzzDOGfQAQ@mail.gmail.com>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
 <20160926140938.ikjatvprk3t4lsed@pengutronix.de> <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
 <20160926142506.ix53ekhykp2svodu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160926142506.ix53ekhykp2svodu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Mon, Sep 26, 2016 at 11:25 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

>> Great, so it affects 4.5+ kernels and should probably have:
>>
>> Cc: <stable@vger.kernel.org> # 4.5+
>
> This is usually not necessary if there is a Fixes: line.

I thought Greg prefers the explicit Cc: stable line as documented in
Documentation/stable_kernel_rules.txt.

Greg?
