From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] Revert "serial: imx: remove unbalanced clk_prepare"
Date: Thu, 20 Aug 2015 08:13:30 -0300
Message-ID: <CAOMZO5Czxr5TTtsrbRyD6N1a89AkeVSyam9Wo5tFxWkyE2iMfQ@mail.gmail.com>
References: <1439912592-14779-1-git-send-email-fabio.estevam@freescale.com>
 <20150818233356.GA4494@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150818233356.GA4494@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 18, 2015 at 8:33 PM, Eduardo Valentin <edubezval@gmail.com> wrote:

> hmmm.. I really did not see this one. Looking at the code looks like we
> could be atomic in some of the uart console callbacks.
>
> For this one:
>
> Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
>
> Did you try the runtime pm patch on your end?

I have only tested linux-next.
