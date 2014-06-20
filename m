From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 16/20] mfd: sun6i-prcm: Add support for
 Allwinner A23 PRCM
Date: Fri, 20 Jun 2014 15:38:38 +0800
Message-ID: <CAGb2v67M1FV8UPrg8bK9HDz6v72pL8-G97b-PHtOtCFurPjyrw@mail.gmail.com>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-17-git-send-email-wens@csie.org> <20140618082953.GO21030@lee--X1>
 <20140618122438.GR19730@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBFGKR6OQKGQEE62ELDA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140618122438.GR19730@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 18, 2014 at 8:24 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Wed, Jun 18, 2014 at 09:29:53AM +0100, Lee Jones wrote:
>> > The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
>> > The differences are the AR100 clock can no longer be modified,
>> > the APB0 clock has different divisors, and some clock gates are
>> > gone.
>> >
>> > This patch adds a compatible with a modified subdevice list for
>> > the A23.
>> >
>> > Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> > ---
>> >  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
>> >  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
>> >  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> The patch looks fine to me, but I'm concerned about the size of the
>> patch set and the amount of subsystems it touches.
>>
>> I am guessing that this patch can just be taken independently though.
>> Please correct me if I'm wrong.
>
> I have a bit of the same concern. We have several comments on the
> previous patches, so I'm not even sure this patch can go as is.
>
> It would be much easier if you (ChenYu) could introduce first a very
> basic with just the UART support, and then, as separate series,
> clocks, PRCM, MMC, and so on.

OK. I will do that. I'll also try to send some of the independent
fixes separately.


ChenYu
