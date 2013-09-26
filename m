From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Date: Thu, 26 Sep 2013 12:18:47 +0200
Message-ID: <52440A07.4050101@linaro.org>
References: <52410F86.4040301@renesas.com> <20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp> <20130924044236.GC3619@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130924044236.GC3619@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, takasi-y@ops.dti.ne.jp
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On 09/24/2013 06:42 AM, Simon Horman wrote:
> [ CCed Daniel Lezcano and Thomas Gleixner, the clocksource maintainer=
s ]
>
> On Tue, Sep 24, 2013 at 01:09:24PM +0900, takasi-y@ops.dti.ne.jp wrot=
e:
>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
>> migrate to the common clock framework.
>>
>> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com=
>

I am not a clk framework expert but at the first glance sounds correct.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>> ---
>>   drivers/clocksource/em_sti.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_s=
ti.c
>> index 3a5909c..9d17083 100644
>> --- a/drivers/clocksource/em_sti.c
>> +++ b/drivers/clocksource/em_sti.c
>> @@ -78,7 +78,7 @@ static int em_sti_enable(struct em_sti_priv *p)
>>   	int ret;
>>
>>   	/* enable clock */
>> -	ret =3D clk_enable(p->clk);
>> +	ret =3D clk_prepare_enable(p->clk);
>>   	if (ret) {
>>   		dev_err(&p->pdev->dev, "cannot enable clock\n");
>>   		return ret;
>> @@ -107,7 +107,7 @@ static void em_sti_disable(struct em_sti_priv *p=
)
>>   	em_sti_write(p, STI_INTENCLR, 3);
>>
>>   	/* stop clock */
>> -	clk_disable(p->clk);
>> +	clk_disable_unprepare(p->clk);
>>   }
>>
>>   static cycle_t em_sti_count(struct em_sti_priv *p)
>> --
>> 1.8.1.5
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

