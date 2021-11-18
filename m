Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B143FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 01:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9E561B64
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 01:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhKRBP6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbhKRBP6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 20:15:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEEC061570
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 17:12:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np3so3755160pjb.4
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 17:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SjyIycdw6npApI5zItaLRCEPx3V5C7NN2Rzwwn/XbZM=;
        b=y5Vh1/ZJcwpdFheWH3s2m2mAgg3JLTvVTVJucfgFzi4/kirUErj73fMpfekgBmPSNe
         a+8/Mz7cKHlNUBr27J4RZnFpJDESOavJi3/B+Jh+e5NlsJfPaQCkutljAIfnoc1ezjwa
         3xsj4UolBqS0NGSX/41pnWFUfwTPOaUhO9+d52mj7F1YrHosDW2oIk8O9NxXgsr58xLo
         MiZ73OtFpNWfZO59GtKwYL4NxgHnlg6G5O3gTj18rLDnK+HzS8nuv37ZA6ur5zQK4TeZ
         qeklFPBogV69FUPJQkoko5cySF36tHF9CoipVZYXHNSR1OlFV725T0OnNY//QmwDRtdG
         Wayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjyIycdw6npApI5zItaLRCEPx3V5C7NN2Rzwwn/XbZM=;
        b=7pvlseT1q0o/1bWEn719r93+BXztQI0Dk4hJjfHIt80qM90q+6l++X6Wd+pn/RNk2P
         7nj1tUWJGgm9b61pQ6WY4TFkGrulNojHAc7r41PDH2fuzR1TmzcIm39r41EhezSykD+s
         injApBLfsQmDwmJtDwgNa5T5ASHy0l9a7geibwkEbd488xlRwdmkh6u0xeA3zwofiGLc
         fv2rfCm4f8qyWXmAKU6JaJJdxmOKVuWGYOjPwOceoOxVRnPUkQ5TENjoblocXXbpiJcI
         6IAZVOlaOweLHJAOMSeSjdgFzs07M0TXhrjTLMiHgGaInkIfqbntLdxgZhIVh4KtyuTF
         ORog==
X-Gm-Message-State: AOAM531zsp9r4r/7I+1hClgjj/UeVtbrBbdEhqIAFOolBF90Wro4uARE
        KKJQ6wpGNQMCu1FsLkVVDk+AvVfNAJDV
X-Google-Smtp-Source: ABdhPJwcHhhANEzTLry0tyj9+TN/gY3JaVVN5QVTuZiCqxf4/bdF7lkAP5nxjUfCxVE2CgPUutazEQ==
X-Received: by 2002:a17:90b:1bca:: with SMTP id oa10mr5639688pjb.20.1637197978390;
        Wed, 17 Nov 2021 17:12:58 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id c1sm909070pfv.54.2021.11.17.17.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 17:12:58 -0800 (PST)
Subject: Re: [PATCH v1 1/2] serial: 8250_pci: Split out Pericom driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <20211117145750.43911-2-andriy.shevchenko@linux.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <36a3c24a-59c1-2537-14ef-c750aaa55ea9@accesio.com>
Date:   Wed, 17 Nov 2021 17:12:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117145750.43911-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> Pericom along with Acces I/O support consumes a lot of LOCs in 8250_pci.c.
> For the sake of easier maintenance, split it to a separate driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c     | 405 +------------------------
>   drivers/tty/serial/8250/8250_pericom.c | 217 +++++++++++++
>   drivers/tty/serial/8250/Kconfig        |   8 +
>   drivers/tty/serial/8250/Makefile       |   1 +
>   4 files changed, 231 insertions(+), 400 deletions(-)
>   create mode 100644 drivers/tty/serial/8250/8250_pericom.c
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 8b29a9381c74..f8d68db73db8 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1318,89 +1318,6 @@ static int pci_default_setup(struct serial_private *priv,
>   
>   	return setup_port(priv, port, bar, offset, board->reg_shift);
>   }
> -static void
> -pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
> -			       unsigned int quot, unsigned int quot_frac)
> -{
> -	int scr;
> -	int lcr;
> -
> -	for (scr = 16; scr > 4; scr--) {
> -		unsigned int maxrate = port->uartclk / scr;
> -		unsigned int divisor = maxrate / baud;
> -		int delta = maxrate / divisor - baud;
> -
> -		if (baud > maxrate + baud / 50)
> -			continue;
> -
> -		if (divisor == 0 || delta > baud / 50)
> -			divisor++;
> -
> -		if (divisor > 0xffff)
> -			continue;
> -
> -		/* Update delta due to possible divisor change */
> -		delta = maxrate / divisor - baud;
> -		if (abs(delta) < baud / 50) {
> -			lcr = serial_port_in(port, UART_LCR);
> -			serial_port_out(port, UART_LCR, lcr | 0x80);
> -			serial_port_out(port, UART_DLL, divisor & 0xff);
> -			serial_port_out(port, UART_DLM, divisor >> 8 & 0xff);
> -			serial_port_out(port, 2, 16 - scr);
> -			serial_port_out(port, UART_LCR, lcr);
> -			return;
> -		}
> -	}
> -}
> -static int pci_pericom_setup(struct serial_private *priv,
> -		  const struct pciserial_board *board,
> -		  struct uart_8250_port *port, int idx)
> -{
> -	unsigned int bar, offset = board->first_offset, maxnr;
> -
> -	bar = FL_GET_BASE(board->flags);
> -	if (board->flags & FL_BASE_BARS)
> -		bar += idx;
> -	else
> -		offset += idx * board->uart_offset;
> -
> -
> -	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
> -		(board->reg_shift + 3);
> -
> -	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
> -		return 1;
> -
> -	port->port.set_divisor = pericom_do_set_divisor;
> -
> -	return setup_port(priv, port, bar, offset, board->reg_shift);
> -}
> -
> -static int pci_pericom_setup_four_at_eight(struct serial_private *priv,
> -		  const struct pciserial_board *board,
> -		  struct uart_8250_port *port, int idx)
> -{
> -	unsigned int bar, offset = board->first_offset, maxnr;
> -
> -	bar = FL_GET_BASE(board->flags);
> -	if (board->flags & FL_BASE_BARS)
> -		bar += idx;
> -	else
> -		offset += idx * board->uart_offset;
> -
> -	if (idx==3)
> -		offset = 0x38;
> -
> -	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
> -		(board->reg_shift + 3);
> -
> -	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
> -		return 1;
> -
> -	port->port.set_divisor = pericom_do_set_divisor;
> -
> -	return setup_port(priv, port, bar, offset, board->reg_shift);
> -}
>   
>   static int
>   ce4100_serial_setup(struct serial_private *priv,
> @@ -1886,42 +1803,6 @@ pci_moxa_setup(struct serial_private *priv,
>   #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
>   #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
>   
> -#define PCI_VENDOR_ID_ACCESIO			0x494f
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SDB	0x1051
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2S	0x1053
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB	0x105C
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S	0x105E
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM232_2DB	0x1091
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_2	0x1093
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB	0x1099
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4	0x109B
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SMDB	0x10D1
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2SM	0x10D3
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB	0x10DA
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM	0x10DC
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_1	0x1108
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_2	0x1110
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_2	0x1111
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4	0x1118
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4	0x1119
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2S	0x1152
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S	0x115A
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_2	0x1190
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_2	0x1191
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4	0x1198
> -#define PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4	0x1199
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2SM	0x11D0
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4	0x105A
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4	0x105B
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM422_8	0x106A
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM485_8	0x106B
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4	0x1098
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM232_8	0x10A9
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM	0x10D9
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_COM_8SM	0x10E9
> -#define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM	0x11D8
> -
> -
>   #define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
>   #define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
>   #define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
> @@ -2198,16 +2079,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
>   		.setup		= pci_default_setup,
>   		.exit		= pci_plx9050_exit,
>   	},
> -	/*
> -	 * Pericom (Only 7954 - It have a offset jump for port 4)
> -	 */
> -	{
> -		.vendor		= PCI_VENDOR_ID_PERICOM,
> -		.device		= PCI_DEVICE_ID_PERICOM_PI7C9X7954,
> -		.subvendor	= PCI_ANY_ID,
> -		.subdevice	= PCI_ANY_ID,
> -		.setup		= pci_pericom_setup_four_at_eight,
> -	},
>   	/*
>   	 * PLX
>   	 */
> @@ -2238,125 +2109,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
>   		.setup		= pci_default_setup,
>   		.exit		= pci_plx9050_exit,
>   	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup_four_at_eight,
> -	},
> -	{
> -		.vendor     = PCI_VENDOR_ID_ACCESIO,
> -		.device     = PCI_ANY_ID,
> -		.subvendor  = PCI_ANY_ID,
> -		.subdevice  = PCI_ANY_ID,
> -		.setup      = pci_pericom_setup,
> -	},	/*
> +	/*
>   	 * SBS Technologies, Inc., PMC-OCTALPRO 232
>   	 */
>   	{
> @@ -2948,10 +2701,6 @@ enum pci_board_num_t {
>   	pbn_wch382_2,
>   	pbn_wch384_4,
>   	pbn_wch384_8,
> -	pbn_pericom_PI7C9X7951,
> -	pbn_pericom_PI7C9X7952,
> -	pbn_pericom_PI7C9X7954,
> -	pbn_pericom_PI7C9X7958,
>   	pbn_sunix_pci_1s,
>   	pbn_sunix_pci_2s,
>   	pbn_sunix_pci_4s,
> @@ -3696,33 +3445,6 @@ static struct pciserial_board pci_boards[] = {
>   		.uart_offset    = 8,
>   		.first_offset   = 0x00,
>   	},
> -	/*
> -	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
> -	 */
> -	[pbn_pericom_PI7C9X7951] = {
> -		.flags          = FL_BASE0,
> -		.num_ports      = 1,
> -		.base_baud      = 921600,
> -		.uart_offset	= 0x8,
> -	},
> -	[pbn_pericom_PI7C9X7952] = {
> -		.flags          = FL_BASE0,
> -		.num_ports      = 2,
> -		.base_baud      = 921600,
> -		.uart_offset	= 0x8,
> -	},
> -	[pbn_pericom_PI7C9X7954] = {
> -		.flags          = FL_BASE0,
> -		.num_ports      = 4,
> -		.base_baud      = 921600,
> -		.uart_offset	= 0x8,
> -	},
> -	[pbn_pericom_PI7C9X7958] = {
> -		.flags          = FL_BASE0,
> -		.num_ports      = 8,
> -		.base_baud      = 921600,
> -		.uart_offset	= 0x8,
> -	},
>   	[pbn_sunix_pci_1s] = {
>   		.num_ports	= 1,
>   		.base_baud      = 921600,
> @@ -3834,6 +3556,10 @@ static const struct pci_device_id blacklist[] = {
>   	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), },
>   	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
>   
> +	/* Pericom devices */
> +	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), },
> +
>   	/* End of the black list */
>   	{ }
>   };
> @@ -5027,127 +4753,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
>   	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
>   		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>   		pbn_b3_8_115200 },
> -	/*
> -	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
> -	 */
> -	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0,
> -		0, pbn_pericom_PI7C9X7951 },
> -	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0,
> -		0, pbn_pericom_PI7C9X7952 },
> -	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0,
> -		0, pbn_pericom_PI7C9X7954 },
> -	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0,
> -		0, pbn_pericom_PI7C9X7958 },
> -	/*
> -	 * ACCES I/O Products quad
> -	 */
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SDB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2S,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_2DB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_2,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SMDB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_1,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7951 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_2,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_2,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2S,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_2,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_2,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7952 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM422_8,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7958 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM485_8,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7958 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_8,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7958 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_8SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7958 },
> -	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_pericom_PI7C9X7954 },
>   	/*
>   	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
>   	 */
> diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
> new file mode 100644
> index 000000000000..322c3b743a38
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pericom.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Driver for Pericom UART */
> +
> +#include <linux/bits.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/pci.h>
> +
> +#include "8250.h"
> +
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SDB	0x1051
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2S	0x1053
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_4	0x105a
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_4	0x105b
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SDB	0x105c
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4S	0x105e
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_8	0x106a
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_8	0x106b
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_2DB	0x1091
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_2	0x1093
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4	0x1098
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4DB	0x1099
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_4	0x109b
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_8	0x10a9
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SMDB	0x10d1
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2SM	0x10d3
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SM	0x10d9
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SMDB	0x10da
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4SM	0x10dc
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_COM_8SM	0x10e9
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_1	0x1108
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_2	0x1110
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_2	0x1111
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_4	0x1118
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_4	0x1119
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2S	0x1152
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4S	0x115a
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_2	0x1190
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_2	0x1191
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_4	0x1198
> +#define PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_4	0x1199
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2SM	0x11d0
> +#define PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4SM	0x11d8
> +
> +struct pericom8250 {
> +	void __iomem *virt;
> +	unsigned int nr;
> +	int line[];
> +};
> +
> +#define PERICOM8250_DEFAUL_BAUD_RATE		921600
> +
> +static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
> +				   unsigned int quot, unsigned int quot_frac)
> +{
> +	int scr;
> +
> +	for (scr = 16 ; scr > 4 ; scr--) {
> +		int maxrate = port->uartclk / scr;
> +		int divisor = maxrate / baud;
> +		int delta = maxrate / divisor - baud;
> +
> +		if (baud > maxrate + baud / 50)
> +			continue;
> +
> +		if (divisor == 0 || delta > baud / 50)
> +			divisor++;
> +
> +		if (divisor > 0xffff)
> +			continue;
> +
> +		/* Update delta due to possible divisor change */
> +		delta = maxrate / divisor - baud;
> +		if (abs(delta) < baud / 50) {
> +			int lcr = serial_port_in(port, UART_LCR);
> +
> +			serial_port_out(port, UART_LCR, lcr | 0x80);
> +			serial_port_out(port, UART_DLL, divisor & 0xff);
> +			serial_port_out(port, UART_DLM, (divisor >> 8) & 0xff);
> +			serial_port_out(port, 2, 16 - scr);
> +			serial_port_out(port, UART_LCR, lcr);
> +			return;
> +		}
> +	}
> +}
> +
> +static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	unsigned int nr, i, bar = 0, maxnr;
> +	struct pericom8250 *pericom;
> +	struct uart_8250_port uart;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	maxnr = pci_resource_len(pdev, bar) >> 3;
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_PERICOM)
> +		nr = pdev->device & 0x0f;
> +	else if (pdev->vendor == PCI_VENDOR_ID_ACCESSIO)
> +		nr = BIT(((pdev->device & 0x38) >> 3) - 1);
> +	else
> +		nr = 1;
> +
> +	pericom = devm_kzalloc(&pdev->dev, struct_size(pericom, line, nr), GFP_KERNEL);
> +	if (!pericom)
> +		return -ENOMEM;
> +
> +	pericom->virt = pcim_iomap(pdev, bar, 0);
> +	if (!pericom->virt)
> +		return -ENOMEM;
> +
> +	memset(&uart, 0, sizeof(uart));
> +
> +	uart.port.dev = &pdev->dev;
> +	uart.port.irq = pdev->irq;
> +	uart.port.private_data = pericom;
> +	uart.port.iotype = UPIO_MEM;
> +	uart.port.uartclk = PERICOM8250_DEFAUL_BAUD_RATE * 16;
> +	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +	uart.port.set_divisor = pericom_do_set_divisor;
> +	for (i = 0; i < nr && i < maxnr; i++) {
> +		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
I'm told this works for PCIe ACCES PIDS, but the PCI PIDs don't have the 
fourth port at the wrong address. I didn't know this until just now. 
I've never had reason to try and tell if a pci_dev is PCI or PCIe. Can 
we query capabilities? It may also be possible to tell by the size of 
one of the BARs. I've requested a four port PCI card and should have it 
tomorrow.
I'm currently building the previous patch set for testing.
> +
> +		uart.port.mapbase = pci_resource_start(pdev, bar) + offset;
> +		uart.port.membase = pericom->virt + offset;
> +
> +		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
> +			uart.port.iobase, uart.port.irq, uart.port.iotype);
> +
> +		pericom->line[i] = serial8250_register_8250_port(&uart);
> +		if (pericom->line[i] < 0) {
> +			dev_err(&pdev->dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, pericom->line[i]);
> +			break;
> +		}
> +	}
> +	pericom->nr = i;
> +
> +	pci_set_drvdata(pdev, pericom);
> +	return 0;
> +}
> +
> +static void pericom8250_remove(struct pci_dev *pdev)
> +{
> +	struct pericom8250 *pericom = pci_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i = 0; i < pericom->nr; i++)
> +		serial8250_unregister_port(pericom->line[i]);
> +}
> +
> +static const struct pci_device_id pericom8250_pci_ids[] = {
> +	/*
> +	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
> +	 * (Only 7954 has an offset jump for port 4)
> +	 */
> +	{ PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951) },
> +	{ PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952) },
> +	{ PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954) },
> +	{ PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958) },
> +
> +	/*
> +	 * ACCES I/O Products quad
> +	 * (Only 7954 has an offset jump for port 4)
> +	 */
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SDB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2S) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SDB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4S) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_8) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_8) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_2DB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_2) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4DB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_8) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SMDB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2SM) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SM) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SMDB) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4SM) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_8SM) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_1) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_2) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_2) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2S) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4S) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_2) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_2) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_4) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2SM) },
> +	{ PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4SM) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, pericom8250_pci_ids);
> +
> +static struct pci_driver pericom8250_pci_driver = {
> +	.name           = "8250_pericom",
> +	.id_table       = pericom8250_pci_ids,
> +	.probe          = pericom8250_probe,
> +	.remove         = pericom8250_remove,
> +};
> +module_pci_driver(pericom8250_pci_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Pericom UART driver");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 8cd11aa63ed5..9d415a38cc71 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -498,6 +498,14 @@ config SERIAL_8250_MID
>   	  present on the UART found on Intel Medfield SOC and various other
>   	  Intel platforms.
>   
> +config SERIAL_8250_PERICOM
> +	tristate "Support for Pericom and Acces I/O serial ports"
> +	default SERIAL_8250
> +	depends on SERIAL_8250 && PCI
> +	help
> +	  Selecting this option will enable handling of the extra features
> +	  present on the Pericom and Acces I/O UARTs.
> +
>   config SERIAL_8250_PXA
>   	tristate "PXA serial port support"
>   	depends on SERIAL_8250
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index b9bcd73c8997..4e4913e0e4d2 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
>   obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
>   obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
>   obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
> +obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
>   obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
>   obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
>   obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
> 

-- 
Jay Dolan
ACCES I/O Products, Inc.
Senior Linux Kernel Dev
jay.dolan@accesio.com
