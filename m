From: Fabio Estevam <festevam@gmail.com>
Subject: Re: cpu power up timing changes causes UART rx character loss on
 imx6ull
Date: Tue, 30 Apr 2019 12:35:21 -0300
Message-ID: <CAOMZO5C=E461yvHJ1PS7JE_ivS1cn82SKT2vvFDOjHqUnZUqaQ@mail.gmail.com>
References: <kcis.E7DDD7DFA27C49D7987A7EAB797CB891@DHPLMX01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <kcis.E7DDD7DFA27C49D7987A7EAB797CB891@DHPLMX01>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Christoph,

On Tue, Apr 30, 2019 at 11:10 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> Hello,
>
> I have found out that the commit 1e434b703248 ("ARM: imx: update the cpu power up timing setting on i.mx6sx") causes UART rx character loss on imx6ull.
> The commit is designed for imx6sx, but it also changes the cpu power up timing of the imx6ull, because function imx6sx_cpuidle_init() is also used for imx6ull.
>
> After receiving of 32 characters correctly, the following characters 33-36 gets lost if there is no delay in the transmission.
> I connect the imx6ull with a native PC COM port.
>
> If I revert the commit I will receive all characters correctly.

Thanks for the report.

It seems we need to change sw2iso only for mx6sx and not for imx6ul.

Could you please test the following patch?
http://code.bulix.org/crpbf9-684699

Thanks
