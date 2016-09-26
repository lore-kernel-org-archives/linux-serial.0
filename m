From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Fix DCD reading
Date: Mon, 26 Sep 2016 11:13:37 -0300
Message-ID: <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
References: <20160926135531.31888-1-s.hauer@pengutronix.de> <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 26, 2016 at 11:09 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hallo,
>
> On Mon, Sep 26, 2016 at 03:55:31PM +0200, Sascha Hauer wrote:
>> The USR2_DCDIN bit is tested for in register usr1. As the name
>> suggests the usr2 register should be used instead. This fixes
>> reading the Carrier detect status.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Fixes: 90ebc4838666 ("serial: imx: repair and complete handshaking")
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Great, so it affects 4.5+ kernels and should probably have:

Cc: <stable@vger.kernel.org> # 4.5+
