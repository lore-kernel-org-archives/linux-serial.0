From: =?utf-8?Q?Christoph_Niedermaier?= <cniedermaier@dh-electronics.com>
Subject: cpu power up timing changes causes UART rx character loss on imx6ull
Date: Tue, 30 Apr 2019 13:45:19 +0000
Message-ID: <kcis.E7DDD7DFA27C49D7987A7EAB797CB891@DHPLMX01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?Q?linux-arm-kernel=40lists=2Einfradead=2Eorg?= <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?linux-imx=40nxp=2Eco?= =?utf-8?Q?m?= <linux-imx@nxp.com>, =?utf-8?Q?linux-serial=40vger=2Ekernel?= =?utf-8?Q?=2Eorg?= <linux-serial@vger.kernel.org>
Cc: =?utf-8?Q?Sascha_Hauer?= <s.hauer@pengutronix.de>, =?utf-8?Q?Anson_Huang?= <anson.huang@nxp.com>, =?utf-8?Q?kernel=40pengutronix=2Ede?= <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hello,

I have found out that the commit 1e434b703248 ("ARM: imx: update the cpu power up timing setting on i.mx6sx") causes UART rx character loss on imx6ull.
The commit is designed for imx6sx, but it also changes the cpu power up timing of the imx6ull, because function imx6sx_cpuidle_init() is also used for imx6ull.

After receiving of 32 characters correctly, the following characters 33-36 gets lost if there is no delay in the transmission.
I connect the imx6ull with a native PC COM port.

If I revert the commit I will receive all characters correctly.

Has anyone discovered this behavior as well?

Thank you,
Christoph
