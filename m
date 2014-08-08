From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v3 2/2] DTS: serial: Add bindings documention for the
 Mediatek UARTs
Date: Fri, 08 Aug 2014 17:04:52 +0530
Message-ID: <53E4B5DC.2080807@gmail.com>
References: <1407497524-26535-1-git-send-email-matthias.bgg@gmail.com> <1407497524-26535-3-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:42601 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbaHHLgZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Aug 2014 07:36:25 -0400
In-Reply-To: <1407497524-26535-3-git-send-email-matthias.bgg@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, alan@linux.intel.com, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org

On 08/08/2014 05:02 PM, Matthias Brugger wrote:
> This patch adds the devicetree documentation for the Mediatek UART.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   .../devicetree/bindings/serial/mtk-uart.txt        |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> new file mode 100644
> index 0000000..2bf571e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -0,0 +1,19 @@
> +* Mediatek Universal Asynchronous Receiver/Transmitter (UART)
> +

Missing Required Properties:....?



-- 
Regards,
Varka Bhadram.

