From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH RFC v1 0/7] serial: imx: fix RTS and RTS/CTS handling
Date: Wed, 26 Jun 2019 14:19:05 +0300
Message-ID: <87ef3gr3va.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
 <20190626100041.a7hyyhubun6y2r2z@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190626100041.a7hyyhubun6y2r2z@pengutronix.de> (Sascha Hauer's
 message of "Wed, 26 Jun 2019 12:00:41 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Sasha,

Sascha Hauer <s.hauer@pengutronix.de> writes:
> Hi Sergey,
>
> On Thu, Jun 20, 2019 at 05:47:46PM +0300, Sergey Organov wrote:
>> The patches are not tested yet, so the RFC in the header. I'll re-roll
>> without RFC once Sasha Hauer tests them.
>> 
>> Sasha, in addition to already discussed fixes, I've also reordered 2
>> patches so that the sequence makes sense.
>> 
>
> I reviewed and tested this series, so when resending you can add my:
>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thank you so much!

Have a nice day,

-- Sergey
