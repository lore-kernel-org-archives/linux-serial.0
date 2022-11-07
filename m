Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F9C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 12:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKGMks (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKGMkr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 07:40:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3879718B35
        for <linux-serial@vger.kernel.org>; Mon,  7 Nov 2022 04:40:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso7050619wmp.5
        for <linux-serial@vger.kernel.org>; Mon, 07 Nov 2022 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4S6YSkl7sVMb8IS7+ULFAdYZf1+uuCOaIqxVataExk=;
        b=Hz/yqiVNAKvMsmfaBX151DXkzkvB+KIYvN6NYA2Wb0W0MbU6giR8jjjJYDeJpZrdG8
         saK+CDy6AdbSMT1AGU16SnFR7bICngAzJ6/dbGm4lti8VrEGs00zP0uhmHVHnsNTLnE4
         daSUEGOqfd3JuwqTbia11oPfuJoI+bUFfbgTo8LsevCCqo8f0k5n36IF9ID0+EvkcecN
         wOiHLIdcO0ahtcJnGOFNt8wPhyFOcIVexCISTzdYBu+aXM8gPmtHlKv5cTag/n67Q+z9
         0xNVCGX7BN51hoDEurFnM2kVhHPJ+B2tDaTyelARdRKNryX2BLqm65t2dphioD5aI5Np
         4P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4S6YSkl7sVMb8IS7+ULFAdYZf1+uuCOaIqxVataExk=;
        b=lW9+M6La1rOnaNsNcRpO3UmWbsG9bLQ+5/Riqcrc/ub6DhL7uxz7dOWMKX665vMm+y
         3dtLf+nPl4/z63NnxXjHTw9zieZx9GsJ64J6+VqP4jukfxCkop74Zj3fX/Z7y2uJ4+OU
         qPs9pGensG4zMhPULsXPqLqWSIgRxdTtG2uPjPFOq/erUV1a5oDn4qPxw665RNHNlCn4
         yaLdKdGIhy6bYI+jeDSd2n03Pj8tUA7LNVzX+lydoB+L1TrniLuMnx6ryaKkVX9BlrdD
         Yfk8ekKwgrKMkI9ndNmamyvkEDX1vLi0P8KccrQCX8746vWzWMuYu9bSzkLuSM5KeeaP
         JWmg==
X-Gm-Message-State: ACrzQf2sL1l7q3wPDozBUMTgbWf1YIRDobGn+LGFpMyjVyySkSXZ4qEc
        PDK+aWDAXChSjQ1qNT1adRc=
X-Google-Smtp-Source: AMsMyM4BolUPwuB33BIS0T8/hjO+QBmXyU+2NT6jUbnqj+wuQQ0in477p+gHos4bjBg+fT5gACRJ0w==
X-Received: by 2002:a05:600c:4ed2:b0:3cf:a33b:f735 with SMTP id g18-20020a05600c4ed200b003cfa33bf735mr7024525wmq.95.1667824844465;
        Mon, 07 Nov 2022 04:40:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm14502056wmo.27.2022.11.07.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:40:44 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:40:41 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [tty:tty-next 10/67] drivers/tty/serial/8250/8250_omap.c:825
 omap8250_rs485_config() warn: bitwise AND condition is false here
Message-ID: <202211070440.8hWunFUN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   15730dc45dc7432713c7af9ee5abad76872f6405
commit: 801954d1210a89b767176e1e34cf5976f41ca6d3 [10/67] serial: 8250: 8250_omap: Support native RS485
config: nios2-randconfig-m041-20221106
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/tty/serial/8250/8250_omap.c:825 omap8250_rs485_config() warn: bitwise AND condition is false here

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +825 drivers/tty/serial/8250/8250_omap.c

801954d1210a89 Lukas Wunner              2022-10-16  805  static int omap8250_rs485_config(struct uart_port *port,
801954d1210a89 Lukas Wunner              2022-10-16  806  				 struct ktermios *termios,
801954d1210a89 Lukas Wunner              2022-10-16  807  				 struct serial_rs485 *rs485)
801954d1210a89 Lukas Wunner              2022-10-16  808  {
801954d1210a89 Lukas Wunner              2022-10-16  809  	struct omap8250_priv *priv = port->private_data;
801954d1210a89 Lukas Wunner              2022-10-16  810  	struct uart_8250_port *up = up_to_u8250p(port);
801954d1210a89 Lukas Wunner              2022-10-16  811  	u32 fixed_delay_rts_before_send = 0;
801954d1210a89 Lukas Wunner              2022-10-16  812  	u32 fixed_delay_rts_after_send = 0;
801954d1210a89 Lukas Wunner              2022-10-16  813  	unsigned int baud;
801954d1210a89 Lukas Wunner              2022-10-16  814  
801954d1210a89 Lukas Wunner              2022-10-16  815  	/*
801954d1210a89 Lukas Wunner              2022-10-16  816  	 * There is a fixed delay of 3 bit clock cycles after the TX shift
801954d1210a89 Lukas Wunner              2022-10-16  817  	 * register is going empty to allow time for the stop bit to transition
801954d1210a89 Lukas Wunner              2022-10-16  818  	 * through the transceiver before direction is changed to receive.
801954d1210a89 Lukas Wunner              2022-10-16  819  	 *
801954d1210a89 Lukas Wunner              2022-10-16  820  	 * Additionally there appears to be a 1 bit clock delay between writing
801954d1210a89 Lukas Wunner              2022-10-16  821  	 * to the THR register and transmission of the start bit, per page 8783
801954d1210a89 Lukas Wunner              2022-10-16  822  	 * of the AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
801954d1210a89 Lukas Wunner              2022-10-16  823  	 */
801954d1210a89 Lukas Wunner              2022-10-16  824  	if (priv->quot) {
801954d1210a89 Lukas Wunner              2022-10-16 @825  		if (priv->mdr1 & UART_OMAP_MDR1_16X_MODE)

This should be:

	if (priv->mdr1 == UART_OMAP_MDR1_16X_MODE)

801954d1210a89 Lukas Wunner              2022-10-16  826  			baud = port->uartclk / (16 * priv->quot);
801954d1210a89 Lukas Wunner              2022-10-16  827  		else
801954d1210a89 Lukas Wunner              2022-10-16  828  			baud = port->uartclk / (13 * priv->quot);
801954d1210a89 Lukas Wunner              2022-10-16  829  
801954d1210a89 Lukas Wunner              2022-10-16  830  		fixed_delay_rts_after_send  = 3 * MSEC_PER_SEC / baud;
801954d1210a89 Lukas Wunner              2022-10-16  831  		fixed_delay_rts_before_send = 1 * MSEC_PER_SEC / baud;
801954d1210a89 Lukas Wunner              2022-10-16  832  	}
801954d1210a89 Lukas Wunner              2022-10-16  833  
801954d1210a89 Lukas Wunner              2022-10-16  834  	/*
801954d1210a89 Lukas Wunner              2022-10-16  835  	 * Fall back to RS485 software emulation if the UART is missing
801954d1210a89 Lukas Wunner              2022-10-16  836  	 * hardware support, if the device tree specifies an mctrl_gpio
801954d1210a89 Lukas Wunner              2022-10-16  837  	 * (indicates that RTS is unavailable due to a pinmux conflict)
801954d1210a89 Lukas Wunner              2022-10-16  838  	 * or if the requested delays exceed the fixed hardware delays.
801954d1210a89 Lukas Wunner              2022-10-16  839  	 */
801954d1210a89 Lukas Wunner              2022-10-16  840  	if (!(priv->habit & UART_HAS_NATIVE_RS485) ||
801954d1210a89 Lukas Wunner              2022-10-16  841  	    mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) ||
801954d1210a89 Lukas Wunner              2022-10-16  842  	    rs485->delay_rts_after_send  > fixed_delay_rts_after_send ||
801954d1210a89 Lukas Wunner              2022-10-16  843  	    rs485->delay_rts_before_send > fixed_delay_rts_before_send) {
801954d1210a89 Lukas Wunner              2022-10-16  844  		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_EN;
801954d1210a89 Lukas Wunner              2022-10-16  845  		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
801954d1210a89 Lukas Wunner              2022-10-16  846  
801954d1210a89 Lukas Wunner              2022-10-16  847  		port->rs485_config = serial8250_em485_config;
801954d1210a89 Lukas Wunner              2022-10-16  848  		return serial8250_em485_config(port, termios, rs485);
801954d1210a89 Lukas Wunner              2022-10-16  849  	}
801954d1210a89 Lukas Wunner              2022-10-16  850  
801954d1210a89 Lukas Wunner              2022-10-16  851  	rs485->delay_rts_after_send  = fixed_delay_rts_after_send;
801954d1210a89 Lukas Wunner              2022-10-16  852  	rs485->delay_rts_before_send = fixed_delay_rts_before_send;
801954d1210a89 Lukas Wunner              2022-10-16  853  
801954d1210a89 Lukas Wunner              2022-10-16  854  	if (rs485->flags & SER_RS485_ENABLED)
801954d1210a89 Lukas Wunner              2022-10-16  855  		priv->mdr3 |= UART_OMAP_MDR3_DIR_EN;
801954d1210a89 Lukas Wunner              2022-10-16  856  	else
801954d1210a89 Lukas Wunner              2022-10-16  857  		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_EN;
801954d1210a89 Lukas Wunner              2022-10-16  858  
801954d1210a89 Lukas Wunner              2022-10-16  859  	/*
801954d1210a89 Lukas Wunner              2022-10-16  860  	 * Retain same polarity semantics as RS485 software emulation,
801954d1210a89 Lukas Wunner              2022-10-16  861  	 * i.e. SER_RS485_RTS_ON_SEND means driving RTS low on send.
801954d1210a89 Lukas Wunner              2022-10-16  862  	 */
801954d1210a89 Lukas Wunner              2022-10-16  863  	if (rs485->flags & SER_RS485_RTS_ON_SEND)
801954d1210a89 Lukas Wunner              2022-10-16  864  		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_POL;
801954d1210a89 Lukas Wunner              2022-10-16  865  	else
801954d1210a89 Lukas Wunner              2022-10-16  866  		priv->mdr3 |= UART_OMAP_MDR3_DIR_POL;
801954d1210a89 Lukas Wunner              2022-10-16  867  
801954d1210a89 Lukas Wunner              2022-10-16  868  	serial_out(up, UART_OMAP_MDR3, priv->mdr3);
801954d1210a89 Lukas Wunner              2022-10-16  869  
801954d1210a89 Lukas Wunner              2022-10-16  870  	return 0;
801954d1210a89 Lukas Wunner              2022-10-16  871  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

