From: Fabio Estevam <festevam@gmail.com>
Subject: Re: earlycon: no match?
Date: Tue, 5 May 2015 14:06:52 -0300
Message-ID: <CAOMZO5A4=Pc8Q6-RGo-Ub7zKmhH0P3bfRsNXB-1DYd7Zzdf-NQ@mail.gmail.com>
References: <20150503211054.GR15254@pengutronix.de>
	<55477BC1.6000805@hurleysoftware.com>
	<20150504194229.GR15254@pengutronix.de>
	<5547D4DB.8060300@hurleysoftware.com>
	<20150504205241.GT15254@pengutronix.de>
	<5547E447.9020604@hurleysoftware.com>
	<20150504215832.GW15254@pengutronix.de>
	<5547F350.7030405@hurleysoftware.com>
	<20150505045139.GY15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505045139.GY15254@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, May 5, 2015 at 1:51 AM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:

> In that case, the system should come up, console comes out of the serial
> line and earlycon is available. Then I should not get a diagnostic
> message, becasue I did everything right.

On imx6q-wandboard when building multi_v7_defconfig, we get [1]:
[    0.000000] earlycon: no match for ttymxc0,115200


[1] http://arm-soc.lixom.net/bootlogs/next/next-20150505/wandboard-arm-multi_v7_defconfig.html

Actually this 'no match' warning appears in all arm configs:
http://arm-soc.lixom.net/bootlogs/next/next-20150505/
