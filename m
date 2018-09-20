From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Date: Thu, 20 Sep 2018 20:04:38 +0800
Message-ID: <1884583f-5eec-7499-b987-b2e53b15b30e@huawei.com>
References: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
 <3b23675a-f537-868f-2432-b7f8a0c8c466@suse.cz>
 <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
 <VI1PR0402MB3600A7368D538E3B6D044C5FFF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR0402MB3600A7368D538E3B6D044C5FFF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Duan <fugang.duan@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "jslaby@suse.cz" <jslaby@suse.cz>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "A.s. Dong" <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, Bough Chen <haibo.chen@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Han Xu <han.xu@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>, Leo Zhang <leo.zhang@nxp.com>, Peng Fan <peng.fan@nxp.com>, Peter Chen <peter.chen@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Robert Chiras <robert.chiras@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Zening Wang <zening.wang@nxp.com>, gregkh@linuxfound
List-Id: linux-serial@vger.kernel.org

On 2018/9/20 17:41, Andy Duan wrote:
> From: Leonard Crestez Sent: 2018年9月20日 16:51
>> On Thu, 2018-09-20 at 08:45 +0200, Jiri Slaby wrote:
>>> On 09/20/2018, 03:58 AM, YueHaibing wrote:
>>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>>
>>>> drivers/tty/serial/imx.c: In function 'imx_uart_probe':
>>>> drivers/tty/serial/imx.c:2198:20: warning:
>>>>  variable 'rtsirq' set but not used [-Wunused-but-set-variable]
>>>>
>>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c @@
>>>> -2220,7 +2220,6 @@ static int imx_uart_probe(struct
>> platform_device
>>>> *pdev)
>>>>
>>>>  	rxirq = platform_get_irq(pdev, 0);
>>>>  	txirq = platform_get_irq(pdev, 1);
>>>> -	rtsirq = platform_get_irq(pdev, 2);
>>>
>>> I am not sure this is correct. platform_get_irq has side effects (like
>>> enabling the IRQ). Are you sure this won't change the behaviour (this
>>> is question mostly to IMX fellows)?
>>
>> As far as I can tell there was a request_irq call for rtsirq which was
>> removed by mistake in commit afe9cbb1a6ad ("serial: imx: drop support
>> for IRDA"):
>>
>> -               /* do not use RTS IRQ on IrDA */
>> -               if (!USE_IRDA(sport)) {
>> -                       ret = devm_request_irq(&pdev->dev, rtsirq,
>> -                                              imx_rtsint, 0,
>> -
>> dev_name(&pdev->dev), sport);
>> -                       if (ret)
>> -                               return ret;
>> -               }
>>
>> This should have just removed the IRDA check and request rtsirq
>> unconditionally. Nobody noticed this by testing RTS on imx1, this is an old
>> chip and later variants have a single combined irq.
>>
>> The correct fix for the warning would be to restore that request_irq.
>>
>> --
>> Regards,
>> Leonard
> 
> Yes, your explain is very correct! Thanks for your comment.
> We should restore rtsirq request that for i.MX1.

Ok, I will post a new fix patch as Leonard and suggested.

> 
> Regards,
> Andy Duan
> 
