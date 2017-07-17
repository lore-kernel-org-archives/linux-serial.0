From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [Customers.Eckelmann] [PATCH] serial: imx: disable DMA for RS-485
 on i.MX6 SMP
Date: Mon, 17 Jul 2017 08:34:56 -0300
Message-ID: <CAOMZO5BttM23SqDerppk_9EPP_TBnHm2T6ikn1RufaUHLbwc_A@mail.gmail.com>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com> <D415CD2EC4182C4EAB90A76B7D9F16DC022038EACC@EX-DAG02.eckelmann.group>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D415CD2EC4182C4EAB90A76B7D9F16DC022038EACC@EX-DAG02.eckelmann.group>
Sender: linux-kernel-owner@vger.kernel.org
To: "Schenk, Gavin" <G.Schenk@eckelmann.de>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Ian Jamison <ian.dev@arkver.com>
List-Id: linux-serial@vger.kernel.org

Hi Gavin,

On Fri, Jun 23, 2017 at 6:26 AM, Schenk, Gavin <G.Schenk@eckelmann.de> wrot=
e:

> Uwe Kleine-K=C3=B6nig had the idea to disable DMA on the i.MX6dl based pl=
atform via dts and this is our current workaround.

Please test Ian's patch:
http://marc.info/?l=3Dlinux-serial&m=3D150005865213531&w=3D2

It should fix this DMA problem with RS485.
