From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev
 api
Date: Fri, 17 Feb 2012 20:39:16 +0300
Message-ID: <4F3E90C4.8010904@mvista.com>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-8-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64935 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab2BQQjz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Feb 2012 11:39:55 -0500
Received: by bkcjm19 with SMTP id jm19so3200326bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 17 Feb 2012 08:39:54 -0800 (PST)
In-Reply-To: <1329474800-20979-8-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Hello.

On 02/17/2012 01:33 PM, John Crispin wrote:

> Update from old pmu_{dis,en}able() to ckldev api.

    The comment doesn't match the essence of patch.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-serial@vger.kernel.org
> ---
> This patch should go via MIPS with the rest of the series.

>   drivers/tty/serial/lantiq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 96c1cac..136dae8 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
>   	if (lqasc_port[pdev->id] != NULL)
>   		return -EBUSY;
>
> -	clk = clk_get(&pdev->dev, "fpi");
> +	clk = clk_get_sys("fpi", NULL);

    Why not just clk_get(&pdev->dev, NULL)?

WBR, Sergei
