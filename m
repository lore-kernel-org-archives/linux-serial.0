Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8199EC4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 08:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21643225AC
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 08:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437688AbgLNIFB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:05:01 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41544 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391285AbgLNIFB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 03:05:01 -0500
Received: by mail-ed1-f41.google.com with SMTP id i24so16133819edj.8;
        Mon, 14 Dec 2020 00:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6HcxwkmtsxMwHNGWU966enZlE/AZzmVp1n8HvKsbko=;
        b=cj8Dh+hglaFJQZXxjRMR71YygwrHHG3B2kuLXIlNUV+sv642DNjFEKrbIUgTV0RGgA
         x4fmrgGmPg6yZ+CLJoowGM15lcb3gimyAEBXcx+50r6UfhOKo18lE1oNkdF6CK9j5Rg9
         lmv+jrefyPcaU0XnC2wIDXugcNLWJN5bl4MFKJ29dNR6gJAOoEVbCHYE9UiZp2CQkVpJ
         Dfj2Dq33qEucczBVT5R/yyo55SQt+HQWD2GA9GxtT0bz7QG6Cq1khkrb7QUZj9j19q7l
         qAwrBoBY09wsAvsbm0DkR1riNS5Zvzq6nb4H7oJ/d41QTlh7kO9+xt8thwcqhx7mdSWL
         wFxQ==
X-Gm-Message-State: AOAM533+LyeFGyHsI+jACj91U1pwIeuBkVVjKiiUVx5EgN8vgO+txVMC
        K0ZuxddmC8hVZJG/eCZH5wEM5cd14WThNA==
X-Google-Smtp-Source: ABdhPJz9zNAgDkZ/GdcuRXVCfhFJUu5fuvCJQdpnRukMmyv4gSsvijwiEdhtzU0GoxzNJ30m4VFxYA==
X-Received: by 2002:a50:b944:: with SMTP id m62mr9340381ede.182.1607933055800;
        Mon, 14 Dec 2020 00:04:15 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y17sm13269745ejj.84.2020.12.14.00.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 00:04:14 -0800 (PST)
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
To:     =?UTF-8?Q?J=c3=b3zsef_Horv=c3=a1th?= <info@ministro.hu>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201212070944.GA13909@dincontrollerdev>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <2855efaf-79a5-f43b-ff8c-9c01a3f14df7@kernel.org>
Date:   Mon, 14 Dec 2020 09:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201212070944.GA13909@dincontrollerdev>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 12. 20, 8:09, József Horváth wrote:
> This is a serial port driver for
>   Silicon Labs Si4455 Sub-GHz transciver.
> 
> The goal of this driver is to removing wires
>   between central(linux) device and remote serial devices/sensors,
>   but keeping the original user software.
>   It represents regular serial interface for the user space.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf

A description of changes between v1..v4 here, please.

> Signed-off-by: József Horváth <info@ministro.hu>
...
> --- /dev/null
> +++ b/drivers/tty/serial/si4455.c
> @@ -0,0 +1,1328 @@
...
> +struct si4455_one {

What is this si4455_one good for? I mean, why not just inline these two 
in si4455_port?

> +	struct uart_port port;
> +	struct work_struct tx_work;
> +};
> +
> +struct si4455_port {
> +	struct mutex mutex; /* For syncing access to device */
> +	int power_count;
> +	bool connected;

If you put this int and bool after u32s below, the structure won't 
contain holes AFAICS.

> +	struct gpio_desc *shdn_gpio;
> +	struct si4455_part_info part_info;
> +	struct si4455_modem_status modem_status;
> +	u32 tx_channel;
> +	u32 rx_channel;
> +	u32 package_size;
> +	bool configured;
> +	bool tx_pending;
> +	bool rx_pending;
> +	u32 current_rssi;
> +	struct si4455_one one;
> +};
...
> +static int si4455_get_response(struct uart_port *port, int length, u8 *data)
> +{
> +	int ret;
> +	u8 data_out[] = { SI4455_CMD_ID_READ_CMD_BUFF };
> +	u8 *data_in = NULL;

A useless initialization.

> +	struct spi_transfer xfer[2];
> +	int timeout = 10000;
> +
> +	if (length > 0 && !data)
> +		return -EINVAL;
> +
> +	data_in = kzalloc(1 + length, GFP_KERNEL);
> +	if (!data_in)
> +		return -ENOMEM;
> +
> +	memset(&xfer, 0x00, sizeof(xfer));
> +	xfer[0].tx_buf = data_out;
> +	xfer[0].len = sizeof(data_out);
> +	xfer[1].rx_buf = data_in;
> +	xfer[1].len = 1 + length;
> +
> +	while (--timeout > 0) {
> +		data_out[0] = SI4455_CMD_ID_READ_CMD_BUFF;
> +		ret = spi_sync_transfer(to_spi_device(port->dev), xfer,
> +					ARRAY_SIZE(xfer));
> +		if (ret) {
> +			dev_err(port->dev, "%s: spi_sync_transfer error(%i)", __func__, ret);

Missing \n. And a space before (.

> +			break;
> +		}
> +
> +		if (data_in[0] == 0xFF) {
> +			if (length > 0 && data)
> +				memcpy(data, &data_in[1], length);
> +
> +			break;
> +		}
> +		usleep_range(100, 200);
> +	}
> +	if (timeout == 0) {
> +		dev_err(port->dev, "%s:timeout==%i", __func__, timeout);
> +		ret = -EIO;
> +	}
> +	kfree(data_in);
> +	return ret;
> +}
...
> +static int si4455_send_command(struct uart_port *port, int length, u8 *data)
> +{
> +	int ret;
> +
> +	ret = si4455_poll_cts(port);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: si4455_poll_cts error(%i)", __func__, ret);
> +		return ret;
> +	}

Put a newline here.

> +	ret = spi_write(to_spi_device(port->dev), data, length);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: spi_write error(%i)", __func__, ret);
> +	}

And here.

> +	return ret;
> +}
> +
> +static int si4455_send_command_get_response(struct uart_port *port,
> +					    int out_length, u8 *data_out,
> +					    int in_length, u8 *data_in)
> +{
> +	int ret;
> +
> +	ret = si4455_send_command(port, out_length, data_out);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: si4455_send_command error(%i)", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = si4455_get_response(port, in_length, data_in);
> +
> +	return ret;

Simplify by return si4455_get_response() directly.

> +}
> +
> +static int si4455_read_data(struct uart_port *port, u8 command, int poll,
> +			    int length, u8 *data)
> +{
> +	int ret = 0;
> +	u8 data_out[] = { command };
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = data_out,
> +			.len = sizeof(data_out),
> +		}, {
> +			.rx_buf = data,
> +			.len = length,
> +		}
> +	};
> +
> +	if (poll) {
> +		ret = si4455_poll_cts(port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = spi_sync_transfer(to_spi_device(port->dev),
> +				xfer,
> +				ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: spi_sync_transfer error(%i)", __func__, ret);

\n here. And in all the other dev_errs all around.

> +	}

A newline here.

> +	return ret;
> +}
...
> +static int si4455_get_int_status(struct uart_port *port, u8 ph_clear,
> +				 u8 modem_clear, u8 chip_clear,
> +				 struct si4455_int_status *result)
> +{
> +	int ret;
> +	u8 data_out[] = {
> +		SI4455_CMD_ID_GET_INT_STATUS,
> +		ph_clear,
> +		modem_clear,
> +		chip_clear
> +	};
> +	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_INT_STATUS];
> +
> +	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
> +					       sizeof(data_in), data_in);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: si4455_send_command_get_response error(%i)",
> +			__func__, ret);

return ret; here. And no else there:

> +	} else {
> +		result->int_pend       = data_in[0];
> +		result->int_status     = data_in[1];
> +		result->ph_pend        = data_in[2];
> +		result->ph_status      = data_in[3];
> +		result->modem_pend     = data_in[4];
> +		result->modem_status   = data_in[5];
> +		result->chip_pend      = data_in[6];
> +		result->chip_status    = data_in[7];
> +	}
> +	return ret;
> +}
> +
> +static int si4455_get_modem_status(struct uart_port *port, u8 modem_clear,
> +				   struct si4455_modem_status *result)
> +{
> +	int ret;
> +	u8 data_out[] = {
> +		SI4455_CMD_ID_GET_MODEM_STATUS,
> +		modem_clear,
> +	};
> +	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS];
> +
> +	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
> +					       sizeof(data_in), data_in);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: si4455_send_command_get_response error(%i)",
> +			__func__, ret);

The same here and the other functions below.

> +	} else {
> +		result->modem_pend      = data_in[0];
> +		result->modem_status    = data_in[1];
> +		result->curr_rssi       = data_in[2];
> +		result->latch_rssi      = data_in[3];
> +		result->ant1_rssi       = data_in[4];
> +		result->ant2_rssi       = data_in[5];
> +		memcpy(&result->afc_freq_offset,
> +		       &data_in[6], sizeof(result->afc_freq_offset));
> +	}
> +	return ret;
> +}
...
> +static int si4455_configure(struct uart_port *port, const u8 *configuration_data)
> +{
> +	int ret = 0;
> +	u8 col;
> +	u8 response;
> +	u8 count;
> +	struct si4455_int_status int_status = { 0 };
> +	u8 radio_cmd[16u];

Any reason for 16 specifically _unsigned_?

> +
> +	/* While cycle as far as the pointer points to a command */
> +	while (*configuration_data != 0x00) {
> +		/* Commands structure in the array:
> +		 * --------------------------------
> +		 * LEN | <LEN length of data>

Multiline comments should look like this:
/*
  * comment 1
  * comment 2
  */

> +		 */
> +		count = *configuration_data++;
> +		dev_dbg(port->dev, "%s: count(%u)",
> +			__func__, count);
> +		if (count > 16u) {

And here?

> +			/* Initial configuration of Si4x55 */
> +			if (SI4455_CMD_ID_WRITE_TX_FIFO
> +				 == *configuration_data) {
> +				if (count > 128u) {

And here?

BTW too many nestings here. Could you switch the 
SI4455_CMD_ID_WRITE_TX_FIFO if condition and break here. No need for 
else branch then and the code would go one indentation level left.

> +					/* Number of command bytes exceeds
> +					 * maximal allowable length
> +					 */
> +					dev_err(port->dev, "%s: command length error(%i)",
> +						__func__, count);
> +					ret = -EINVAL;
> +					break;
> +				}
> +
> +				/* Load array to the device */
> +				configuration_data++;
> +				ret = si4455_write_data(port,
> +							SI4455_CMD_ID_WRITE_TX_FIFO,
> +							1,
> +							count - 1,
> +							configuration_data);
> +				if (ret) {
> +					dev_err(port->dev, "%s: si4455_write_data error(%i)",
> +						__func__, ret);
> +					break;
> +				}
> +
> +				/* Point to the next command */
> +				configuration_data += count - 1;
> +
> +				/* Continue command interpreter */
> +				continue;
> +			} else {
> +				/* Number of command bytes exceeds
> +				 * maximal allowable length
> +				 */
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +
> +		for (col = 0u; col < count; col++) {
> +			radio_cmd[col] = *configuration_data;
> +			configuration_data++;
> +		}
> +
> +		dev_dbg(port->dev, "%s: radio_cmd[0](%u)", __func__, radio_cmd[0]);
> +		ret = si4455_send_command_get_response(port, count, radio_cmd,
> +						       1, &response);
> +		if (ret) {
> +			dev_err(port->dev,
> +				"%s: si4455_send_command_get_response error(%i)",
> +				__func__, ret);
> +			break;
> +		}
> +
> +		/* Check response byte of EZCONFIG_CHECK command */
> +		if (radio_cmd[0] == SI4455_CMD_ID_EZCONFIG_CHECK) {
> +			if (response) {
> +				/* Number of command bytes exceeds
> +				 * maximal allowable length
> +				 */
> +				ret = -EIO;
> +				dev_err(port->dev, "%s: EZConfig check error(%i)",
> +					__func__, radio_cmd[0]);
> +				break;
> +			}
> +		}
> +
> +		/* Get and clear all interrupts.  An error has occurred... */
> +		si4455_get_int_status(port, 0, 0, 0, &int_status);
> +		if (int_status.chip_pend
> +		    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK) {
> +			ret = -EIO;
> +			dev_err(port->dev, "%s: chip error(%i)",
> +				__func__, int_status.chip_pend);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
...
> +static int si4455_do_work(struct uart_port *port)
> +{
> +	int ret = 0;
> +	struct si4455_port *s = dev_get_drvdata(port->dev);
> +	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned int tx_pending = 0;
> +	unsigned int tx_to_end = 0;
> +	u8 *data = NULL;
> +
> +	mutex_lock(&s->mutex);
> +	dev_dbg(port->dev, "%s(connected=%i, configured=%i, power_count=%i)",
> +		__func__, s->connected, s->configured, s->power_count);
> +	if (s->connected && s->configured && s->power_count > 0) {
> +		if (!(uart_circ_empty(xmit) || uart_tx_stopped(port) || s->tx_pending)) {
> +			tx_pending = uart_circ_chars_pending(xmit);
> +			if (s->package_size > 0) {
> +				if (tx_pending >= s->package_size) {
> +					tx_pending = s->package_size;
> +					data = kzalloc(s->package_size, GFP_KERNEL);
> +					tx_to_end = CIRC_CNT_TO_END(xmit->head,
> +								    xmit->tail,
> +								    UART_XMIT_SIZE);
> +					if (tx_to_end < tx_pending) {


Again, too much spaghetti here.

> +						memcpy(data,
> +						       xmit->buf + xmit->tail,
> +						       tx_to_end);
> +						memcpy(data,
> +						       xmit->buf,
> +						       tx_pending - tx_to_end);
> +					} else {
> +						memcpy(data,
> +						       xmit->buf + xmit->tail,
> +						       tx_pending);
> +					}
> +					if (si4455_begin_tx(port, s->tx_channel,
> +							    tx_pending, data) == 0) {
> +						s->tx_pending = true;
> +					}
> +					kfree(data);
> +				}
> +			} else {
> +				//TODO: variable packet length
> +			}
> +		}
> +		if (!s->tx_pending) {
> +			if (s->package_size > 0) {
> +				ret = si4455_begin_rx(port, s->rx_channel,
> +						      s->package_size);
> +			} else {
> +				//TODO: variable packet length
> +			}
> +		}
> +	}
> +	mutex_unlock(&s->mutex);
> +	return ret;
> +}
...
> +static irqreturn_t si4455_port_irq(struct si4455_port *s)
> +{
> +	struct uart_port *port = &s->one.port;
> +	irqreturn_t ret = IRQ_NONE;

You never return IRQ_NONE, right?

> +	struct si4455_int_status int_status = { 0 };
> +	struct si4455_fifo_info fifo_info = { 0 };
> +
> +	mutex_lock(&s->mutex);
> +	if (s->connected && s->configured && s->power_count > 0) {
> +		if (!si4455_get_int_status(port, 0, 0, 0, &int_status)) {
> +			si4455_get_modem_status(port, 0, &s->modem_status);
> +			if (int_status.chip_pend
> +			    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT) {
> +				dev_err(port->dev,
> +					"%s: chip_status:CMD_ERROR_PEND",
> +					__func__);
> +			} else if (int_status.ph_pend
> +				   & SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT) {
> +				dev_dbg(port->dev,
> +					"%s: ph_status:PACKET_SENT_PEND",
> +					__func__);
> +				si4455_handle_tx_pend(s);
> +			} else if (int_status.ph_pend
> +				   & SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT) {
> +				dev_dbg(port->dev,
> +					"%s: ph_status:PACKET_RX_PEND",
> +					__func__);
> +				s->current_rssi = s->modem_status.curr_rssi;
> +				si4455_fifo_info(port, 0, &fifo_info);
> +				si4455_handle_rx_pend(s);
> +			} else if (int_status.ph_pend
> +				   & SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT) {
> +				dev_dbg(port->dev,
> +					"%s: ph_status:CRC_ERROR_PEND",
> +					__func__);
> +			}
> +			ret = IRQ_HANDLED;
> +		}
> +	} else {
> +		ret = IRQ_HANDLED;

How can this be IRQ_HANDLED when the device is off?

> +	}
> +	mutex_unlock(&s->mutex);
> +	si4455_do_work(port);
> +	return ret;
> +}
> +
> +static irqreturn_t si4455_ist(int irq, void *dev_id)

Why is this wrapper needed?

> +{
> +	struct si4455_port *s = (struct si4455_port *)dev_id;
> +	bool handled = false;
> +
> +	if (si4455_port_irq(s) == IRQ_HANDLED)
> +		handled = true;
> +
> +	return IRQ_RETVAL(handled);

A weird way of just doing:
return si4455_port_irq(s);

> +}
...
> +static unsigned int si4455_tx_empty(struct uart_port *port)
> +{
> +	return TIOCSER_TEMT;

Always free to send?

> +}
> +
> +static unsigned int si4455_get_mctrl(struct uart_port *port)
> +{
> +	dev_dbg(port->dev, "%s", __func__);
> +	return TIOCM_DSR | TIOCM_CAR;

And always carrier?

> +}
...
> +static void si4455_start_tx(struct uart_port *port)
> +{
> +	struct si4455_one *one = container_of(port,
> +					      struct si4455_one,
> +					      port);
> +
> +	dev_dbg(port->dev, "%s", __func__);
> +
> +	if (!work_pending(&one->tx_work))

This if is pointless.

> +		schedule_work(&one->tx_work);
> +}
...
> +static int __maybe_unused si4455_suspend(struct device *dev)
> +{
> +	struct si4455_port *s = dev_get_drvdata(dev);
> +
> +	uart_suspend_port(&si4455_uart, &s->one.port);

Newline here.

> +	return 0;
> +}
...
> +static int si4455_probe(struct device *dev,
> +			int irq)
> +{
> +	int ret;
> +	struct si4455_port *s;
> +	const void *of_ptr;
> +	char ez_fw_name[255] = { 0 };
> +	const struct firmware *ez_fw = NULL;
> +
> +	/* Alloc port structure */
> +	dev_dbg(dev, "%s\n", __func__);
> +	s = devm_kzalloc(dev, sizeof(*s), GFP_KERNEL);
> +	if (!s) {
> +		dev_err(dev, "Error allocating port structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, s);
> +	mutex_init(&s->mutex);
> +
> +	s->shdn_gpio = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
> +	if (IS_ERR(s->shdn_gpio)) {
> +		dev_err(dev, "Unable to reguest shdn gpio\n");
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +
> +	of_ptr = of_get_property(dev->of_node, "silabs,package-size", NULL);
> +	if (IS_ERR_OR_NULL(of_ptr)) {
> +		dev_err(dev, "dt silabs,package-size property not present\n");
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +	s->package_size = be32_to_cpup(of_ptr);
> +	if (s->package_size > SI4455_FIFO_SIZE) {
> +		dev_err(dev, "dt silabs,package-size property maximum is %i\n", SI4455_FIFO_SIZE);
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +
> +	of_ptr = of_get_property(dev->of_node, "silabs,tx-channel", NULL);
> +	if (IS_ERR_OR_NULL(of_ptr)) {
> +		dev_err(dev, "dt silabs,tx-channel property not present\n");
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +	s->tx_channel = be32_to_cpup(of_ptr);
> +
> +	of_ptr = of_get_property(dev->of_node, "silabs,rx-channel", NULL);
> +	if (IS_ERR_OR_NULL(of_ptr)) {
> +		dev_err(dev, "dt silabs,rx-channel property not present\n");
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +	s->rx_channel = be32_to_cpup(of_ptr);
> +
> +	of_ptr = of_get_property(dev->of_node, "silabs,ez-config", NULL);
> +	if (IS_ERR_OR_NULL(of_ptr)) {
> +		dev_err(dev, "dt silabs,ez-config property not present\n");
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +	strncpy(ez_fw_name, of_ptr, sizeof(ez_fw_name) - 1);
> +
> +	/* Initialize port data */
> +	s->one.port.dev	= dev;
> +	s->one.port.line = 0;
> +	s->one.port.irq	= irq;
> +	s->one.port.type	= PORT_SI4455;
> +	s->one.port.fifosize	= SI4455_FIFO_SIZE;
> +	s->one.port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> +	s->one.port.iotype	= UPIO_PORT;
> +	s->one.port.iobase	= 0x00;
> +	s->one.port.membase	= (void __iomem *)~0;

This is a cast of int to a pointer, isn't it?

> +	s->one.port.rs485_config = NULL;
> +	s->one.port.ops	= &si4455_ops;
> +
> +	si4455_s_power(dev, 1);
> +
> +	//detect
> +	ret = si4455_get_part_info(&s->one.port, &s->part_info);
> +	dev_dbg(dev, "si4455_get_part_info()==%i", ret);
> +	if (ret == 0) {
> +		dev_dbg(dev, "partInfo.chip_rev= %u", s->part_info.chip_rev);
> +		dev_dbg(dev, "partInfo.part= %u", s->part_info.part);
> +		dev_dbg(dev, "partInfo.pbuild= %u", s->part_info.pbuild);
> +		dev_dbg(dev, "partInfo.id= %u", s->part_info.id);
> +		dev_dbg(dev, "partInfo.customer= %u", s->part_info.customer);
> +		dev_dbg(dev, "partInfo.rom_id= %u", s->part_info.rom_id);
> +		dev_dbg(dev, "partInfo.bond= %u", s->part_info.bond);
> +		if (s->part_info.part != 0x5544) {
> +			dev_err(dev, "part(%u) error", s->part_info.part);
> +			ret = -ENODEV;
> +		}
> +	}
> +
> +	if (ret)
> +		goto out_generic;
> +
> +	ret = request_firmware(&ez_fw, ez_fw_name, dev);
> +	if (ret) {
> +		dev_err(dev, "firmware(%s) request error(%i)\n", ez_fw_name, ret);
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +
> +	ret = si4455_re_configure(&s->one.port, ez_fw);
> +	release_firmware(ez_fw);
> +	if (ret) {
> +		dev_err(dev, "device configuration error(%i)\n", ret);
> +		ret = -EINVAL;
> +		goto out_generic;
> +	}
> +
> +	/* Initialize queue for start TX */
> +	INIT_WORK(&s->one.tx_work, si4455_tx_proc);

Isn't this too late? It might not be right now. But I would do it right 
after allocation, along with others above.

> +
> +	/* Register port */
> +	ret = uart_add_one_port(&si4455_uart, &s->one.port);
> +	if (ret) {
> +		s->one.port.dev = NULL;
> +		goto out_uart;
> +	}
> +
> +	ret = sysfs_create_group(&dev->kobj, &si4455_attr_group);
> +	if (ret) {
> +		dev_err(dev, "sysfs_create_group error(%i)\n", ret);
> +		goto out_uart;
> +	}
> +	/* Setup interrupt */
> +	ret = devm_request_threaded_irq(dev, irq, NULL, si4455_ist,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					dev_name(dev), s);
> +
> +	if (!ret)
> +		return 0;
> +
> +	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
> +	sysfs_remove_group(&dev->kobj, &si4455_attr_group);
> +
> +out_uart:
> +	uart_remove_one_port(&si4455_uart, &s->one.port);
> +out_generic:
> +	mutex_destroy(&s->mutex);
> +	si4455_s_power(dev, 0);
> +
> +	return ret;
> +}
...
> +static int __init si4455_uart_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&si4455_uart);
> +	if (ret)
> +		return ret;
> +	spi_register_driver(&si4455_spi_driver);

spi_register_driver can fail too.

> +
> +	return 0;
> +}

regards,
-- 
js
