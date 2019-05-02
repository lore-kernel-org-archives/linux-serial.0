From: Fabio Estevam <festevam@gmail.com>
Subject: Re: cpu power up timing changes causes UART rx character loss on
 imx6ull
Date: Thu, 2 May 2019 08:31:54 -0300
Message-ID: <CAOMZO5DmeaxZTvOLeJrvb8_YbzTuYQVUZhLU1z2s-tm98gPf1A@mail.gmail.com>
References: <kcis.DC82F67FDB724ECD9A98DE07DACAC907@DHPLMX01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <kcis.DC82F67FDB724ECD9A98DE07DACAC907@DHPLMX01>
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

On Thu, May 2, 2019 at 6:40 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> I have tested the patch with kernel version 5.1-rc7 and I could not reproduce the loss of characters any more.

Excellent. I have just sent a formal patch.

> Couldn't it perhaps be better to name the define SW2ISO_IMX6SX instead of SW2ISO_IMX6X?

Yes, I have changed it in the forma patch. Please reply with your
Tested-by when you have a chance.

Thanks
