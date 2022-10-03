Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B66CC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  3 Oct 2022 15:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJCPLR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJCPLQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Oct 2022 11:11:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD66315
        for <linux-serial@vger.kernel.org>; Mon,  3 Oct 2022 08:11:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 293FB0J8034065;
        Mon, 3 Oct 2022 10:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664809860;
        bh=SnqQPNlfnlLM6XF91h5NCDgNQ/YtIhKbuvhQ1X4IGLs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ukjUpRP3DOhPwTdCB2yBQ7sR9XdQ0dlbnWmhgxkBd7c72zaPQ5XiIRS+VTNJBq6D7
         zfoG6yKwK9+Rf1Aj5/yVZwEg+Mb2/tP8ZW0svFxU+3D6YMvmNLG2GlPeyFPB4AoWak
         KpjcInUavo0Mm2Iglbxov/4/oAQogK2N+T4PRuKI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 293FB0a2020280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Oct 2022 10:11:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 3 Oct
 2022 10:11:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 3 Oct 2022 10:11:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 293FB0Dv058901;
        Mon, 3 Oct 2022 10:11:00 -0500
Date:   Mon, 3 Oct 2022 10:10:59 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
Message-ID: <20221003151059.mypganj25awuxc2d@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lukas,

Thanks for enabling this feature.

On Tue, Sep 27, 2022 at 02:10:01PM +0200, Lukas Wunner wrote:
> Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> automatically assert RTS when data is transmitted, obviating the need
> to emulate this functionality in software.
> 
> The feature is controlled through new DIR_EN and DIR_POL bits in the
> Mode Definition Register 3.  For details see page 8783 and 8890 of the
> AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Su Bao Cheng <baocheng.su@siemens.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> Matthias tested this patch on the AM64 board TQMa6442L + MBaX4XxL:
> He says both sending and receiving continue to work.
> He's verified via /dev/mem that DIR_EN and DIR_POL bits are set
> on an RS485-enabled UART and are not set on other UARTs.
> Also RTS polarity is correct and not changed by the patch.
> 
>  drivers/tty/serial/8250/8250_omap.c | 67 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 68f5a16..e734efe8 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -44,6 +44,7 @@
>  #define	UART_HAS_EFR2			BIT(4)
>  #define UART_HAS_RHR_IT_DIS		BIT(5)
>  #define UART_RX_TIMEOUT_QUIRK		BIT(6)
> +#define UART_HAS_NATIVE_RS485		BIT(7)
>  
>  #define OMAP_UART_FCR_RX_TRIG		6
>  #define OMAP_UART_FCR_TX_TRIG		4
> @@ -101,6 +102,11 @@
>  #define UART_OMAP_IER2			0x1B
>  #define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
>  
> +/* Mode Definition Register 3 */
> +#define UART_OMAP_MDR3			0x20
> +#define UART_OMAP_MDR3_DIR_POL		BIT(3)
> +#define UART_OMAP_MDR3_DIR_EN		BIT(4)
> +
>  /* Enhanced features register 2 */
>  #define UART_OMAP_EFR2			0x23
>  #define UART_OMAP_EFR2_TIMEOUT_BEHAVE	BIT(6)
> @@ -112,6 +118,7 @@ struct omap8250_priv {
>  	int line;
>  	u8 habit;
>  	u8 mdr1;
> +	u8 mdr3;
>  	u8 efr;
>  	u8 scr;
>  	u8 wer;
> @@ -345,7 +352,9 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
>  
>  	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
>  
> -	if (up->port.rs485.flags & SER_RS485_ENABLED)
> +	if (priv->habit & UART_HAS_NATIVE_RS485)
> +		serial_out(up, UART_OMAP_MDR3, priv->mdr3);

This makes the NATIVE_RS485 always used if the SoC supports it, but

> +	else if (up->port.rs485.flags & SER_RS485_ENABLED)
>  		serial8250_em485_stop_tx(up);

there are cases em485 should be used even if SoC supports NATIVE_RS485.
For example:
- the design has pinmux conflict and the RTS pin has to be used for
  something else. Then a GPIO pin would be used for RS485 DE control;
- the design requires customized delay_rts_before_send or
  delay_rts_after_send which NATIVE_RS485 doesn't support;

So we might need an option for such usecases. A device tree flag?

-Bin.
