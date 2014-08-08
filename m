From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v3 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Fri, 08 Aug 2014 17:55:09 +0530
Message-ID: <53E4C1A5.7000400@gmail.com>
References: <1407497524-26535-1-git-send-email-matthias.bgg@gmail.com> <1407497524-26535-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1407497524-26535-2-git-send-email-matthias.bgg@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, alan@linux.intel.com, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 08/08/2014 05:02 PM, Matthias Brugger wrote:
> This patch adds support for the UART block found on Mediatek SoCs.
> The device has a highspeed register which influences the calcualtion of the
> divisor. The chip lacks support for some baudrates. When requested, we set the
> divisor to the next smaller baudrate and adjust the c_cflag accordingly.

(...)

> +static struct platform_driver mtk8250_platform_driver = {
> +	.driver = {
> +		.name		= "mt6577-uart",
> +		.owner		= THIS_MODULE,

We can remove this field. Its updated by module_platform_driver()

Thanks.

-- 
Regards,
Varka Bhadram.

