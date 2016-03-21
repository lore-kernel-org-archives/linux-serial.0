From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
Date: Mon, 21 Mar 2016 15:39:50 -0500
Message-ID: <56F05C16.1030805@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, andre.przywara@arm.com, linux@arm.linux.org.uk, graeme.gregory@linaro.org, peter@hurleysoftware.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org
Cc: jason.liu@linaro.org
List-Id: linux-serial@vger.kernel.org

Jun Nie wrote:
> @@ -2570,9 +2608,17 @@ static int pl011_uart_plat_probe(struct platform_device *pdev)
>   	if (!uap)
>   		return -ENOMEM;
>
> +	uap->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(uap->clk))
> +		return PTR_ERR(uap->clk);
> +

I don't this is supposed to be part of your patch, and it breaks my ACPI 
platform anyway.  Where did it come from?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
