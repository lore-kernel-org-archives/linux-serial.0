From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH] PM / core: Propagate dev->power.wakeup_path when no
 callbacks
Date: Wed, 10 Apr 2019 17:28:06 +0200
Message-ID: <c0e5e074-b0e4-c554-ab50-b04b046a487e@st.com>
References: <20190410095516.6170-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410095516.6170-1-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Loic Pallardy <loic.pallardy@st.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulf

On 4/10/19 11:55 AM, Ulf Hansson wrote:
> The dev->power.direct_complete flag may become set in device_prepare() in
> case the device don't have any PM callbacks (dev->power.no_pm_callbacks is
> set). This leads to a broken behaviour, when there is child having wakeup
> enabled and relies on its parent to be used in the wakeup path.
> 
> More precisely, when the direct complete path becomes selected for the
> child in __device_suspend(), the propagation of the dev->power.wakeup_path
> becomes skipped as well.
> 
> Let's address this problem, by checking if the device is a part the wakeup
> path or has wakeup enabled, then prevent the direct complete path from
> being used.
> 
> Reported-by: Loic Pallardy <loic.pallardy@st.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 

Thanks Ulf for this patch. It'll avoid to have dirty hack in serial 
suspend callback (at least for stm32). I just tested it on stm32 kernel 
v4.19 (which embeds all our genpd based power features). Replacing
device_may_wakeup(dev) by
device_may_wakeup(dev) || dev->power.wakeup_path) then dirty hack to 
test ttydev wakeup flag in stm32 usart driver is no more needed.

So you can add my Tested-by

Regards
Alex


> More background:
> 
> This problem was reported by Loic Pallardy, offlist, while he was working
> on enabling wakeup for a tty serial console driver.
> 
> When I looked more closely, I noticed that uart_suspend_port() calls
> device_may_wakeup() for the tty child devices, and then also the used serial
> driver check its device (parent) for device_may_wakeup(). To me this looks like
> workarounds to fix a behaviour that really should be dealt with from the PM
> core, no matter of whether the child have PM callbacks assigned or not.
> 
> In other words, it seems like the serial driver(s) should be checking the
> wakeup_path flag for the parent, solely, instead.
> 
> I haven't digested further behaviours for other subsystem, but recently
> reviewed a patch for a gpio driver [1], that seems to be suffering from the
> similar problems.
> 
> Kind regards
> Ulf Hansson
> 
> [1]
> https://lkml.org/lkml/2019/4/4/1283
> 
> ---
>   drivers/base/power/main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 41eba82ee7b9..f9cfdeee8288 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1747,6 +1747,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>   	if (dev->power.syscore)
>   		goto Complete;
>   
> +	/* Avoid direct_complete, to let wakeup_path being propagated. */
> +	if (device_may_wakeup(dev) || dev->power.wakeup_path)
> +		dev->power.direct_complete = false;
> +
>   	if (dev->power.direct_complete) {
>   		if (pm_runtime_status_suspended(dev)) {
>   			pm_runtime_disable(dev);
> 
