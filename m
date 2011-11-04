From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
Date: Fri, 04 Nov 2011 11:18:44 +0100
Message-ID: <4EB3BC04.1090203@atmel.com>
References: <samsung_rs485>
	<1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Boojin Kim <boojin.kim@samsung.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 10/22/2011 05:46 AM, Paul Schilling :
> Add RS485 tranmit/recieve control line capabilities
> This RS485 driver uses two methodes to determine if the transmit
> should be disabled.

[..]

> This patch adds an additional variable to the serial RS-485 struct so
> that a program can change the terminate token value via the IOCTL.

[..]

> diff --git a/include/linux/serial.h b/include/linux/serial.h
> index ef91406..826b1c0 100644
> --- a/include/linux/serial.h
> +++ b/include/linux/serial.h
> @@ -211,9 +211,12 @@ struct serial_rs485 {
>  #define SER_RS485_RTS_ON_SEND		(1 << 1)
>  #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
>  #define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
> +#define SER_RS485_ALWAYS_LISTEN		(1 << 4)

This value is already in another patch (now in Linus' tree).

> +#define SER_RS485_TOGGLE_ON_TOKEN	(1 << 5)
>  	__u32	delay_rts_before_send;	/* Milliseconds */
>  	__u32	delay_rts_after_send;	/* Milliseconds */
> -	__u32	padding[5];		/* Memory is cheap, new structs
> +	__u32	toggle_token;			/* Token used to toggle to receive */

Do not forget to add this new value in the RS485 device tree bindings
[1] that appeared during this merge window. Once converted to device
tree, your platform may need to retrieve this value from it.

[1]: Documentation/devicetree/bindings/serial/rs485.txt

Best regards,
-- 
Nicolas Ferre
