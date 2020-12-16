Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FFDC2BBCF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0030E23123
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgLPI0c (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:26:32 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:37069 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgLPI0c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Dec 2020 03:26:32 -0500
Received: by mail-ej1-f46.google.com with SMTP id ga15so31451656ejb.4;
        Wed, 16 Dec 2020 00:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkZOg5dGVuAiTfWa+P23apkjAkDfeZHgeEgsN2Bozjo=;
        b=bjPBhVeKoEohtdPESangqyKb14UNmhy0qjmDV6G7k9+uO9N7Qojo9GKxs7y/5K1FZh
         VzAQAnIjXYMeXiPVfsMIZ/P4OHDD0mxWwLKeYphcS3PO6bvD1VGjqYznzSNh2WvUQfwk
         3ZQa170U1pHYAszF+YAEa4WxKV/FwuB0elNckV+t8x6911MEQZFynig9Woc/s5uhYX5d
         dqerAZ+5Wtqh0dVMABMRq8ZmfkermoYGLuEhZuMYxxom10BbW34xyINB1w+ad0rq/hx/
         Tv1+nTt7g2LKuSZfKKF0H1dtxB8m3oig507rAI2ClpFWQ3aCLODKy1rmSkjDmD2PsGVM
         tYYA==
X-Gm-Message-State: AOAM531/jbgtX20+czH5g8Wpmv1YTsJmu9bolLeBLo+Zvaotsc1jvZce
        VJ9epEhBILcN9mUNzIf+nCEwR6eiWaC4hw==
X-Google-Smtp-Source: ABdhPJwO0nwC5J/YIjrpa9PIWO1mPzwt4a69ZXRY6OlmgMrVAhdfro5xYlokNMIoR7LgWCOe0I5eUg==
X-Received: by 2002:a17:906:b096:: with SMTP id x22mr8732064ejy.471.1608107149932;
        Wed, 16 Dec 2020 00:25:49 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id w20sm20872984edi.12.2020.12.16.00.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 00:25:49 -0800 (PST)
Subject: Re: [PATCH v6] Serial: silabs si4455 serial driver
To:     =?UTF-8?Q?J=c3=b3zsef_Horv=c3=a1th?= <info@ministro.hu>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201215181506.GA20057@dev>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <fcbd72c2-e3a1-241e-a34b-7aecc41c8964@kernel.org>
Date:   Wed, 16 Dec 2020 09:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201215181506.GA20057@dev>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15. 12. 20, 19:15, József Horváth wrote:
> --- /dev/null
> +++ b/drivers/tty/serial/si4455.c
> @@ -0,0 +1,1372 @@
...
> +static int si4455_write_data(struct uart_port *port, u8 command, int poll,
> +			     int length, const u8 *data)
> +{
> +	int ret = 0;
> +	u8 *data_out;
> +
> +	if (poll) {
> +		ret = si4455_poll_cts(port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data_out = kzalloc(1 + length, GFP_KERNEL);
> +	if (!data_out)
> +		return -ENOMEM;
> +
> +	data_out[0] = command;
> +	memcpy(&data_out[1], data, length);
> +	ret = spi_write(to_spi_device(port->dev), data_out, 1 + length);
> +	if (ret) {
> +		dev_err(port->dev,
> +			"%s: spi_write error (%i)\n", __func__, ret);
> +	}
> +
> +	kfree(data_out);
> +
> +	return ret;
> +}
> +
> +static void si4455_set_power(struct si4455_port *priv, int on)

"on" can be bool here. And "poll" in earlier functions. And "on" in 
later ones.

> +{
> +	if (!priv->shdn_gpio)
> +		return;
> +	if (on) {
> +		gpiod_direction_output(priv->shdn_gpio, 0);
> +		usleep_range(4000, 5000);
> +		gpiod_set_value(priv->shdn_gpio, 1);
> +		usleep_range(4000, 5000);
> +	} else {
> +		gpiod_direction_output(priv->shdn_gpio, 0);
> +	}

The above can be simpler:

gpiod_direction_output(priv->shdn_gpio, 0);

if (on) {
	usleep_range(4000, 5000);
	gpiod_set_value(priv->shdn_gpio, 1);
	usleep_range(4000, 5000);
}

> +static void si4455_handle_rx_pend(struct si4455_port *s)
> +{
> +	struct uart_port *port = &s->port;
> +	u8 *data = NULL;

Unused initialization.

> +	int sret = 0;
> +	int i = 0;
> +
> +	if (s->package_size == 0) {
> +		//TODO: variable packet length
> +		dev_err(port->dev, "%s: variable packet length is not supported by the driver\n",
> +			__func__);
> +		return;
> +	}
> +
> +	data = kzalloc(s->package_size, GFP_KERNEL);

Missing check of data.

> +	sret = si4455_end_rx(port, s->package_size, data);
> +	if (sret) {
> +		dev_err(port->dev, "%s: si4455_end_rx error (%i)\n",
> +			__func__, sret);
> +	} else {
> +		for (i = 0; i < s->package_size; i++) {
> +			uart_insert_char(port, 0, 0, data[i], TTY_NORMAL);
> +			port->icount.rx++;
> +		}
> +		tty_flip_buffer_push(&port->state->port);
> +	}
> +	kfree(data);
> +}
...
thanks,
-- 
js
suse labs
