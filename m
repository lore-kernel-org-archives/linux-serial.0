Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CCAC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64FA22288
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbhAEKNp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:13:45 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:52358 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbhAEKNo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 05:13:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 3BD7911F84F;
        Tue,  5 Jan 2021 11:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609841582;
        bh=/+byBqZvoSDCctSRWxIZMu5f2V01FrVLCGvDFaB5oyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6P3/1QG5ZMdlDSACP2F7uiEmV1WPh9QlHt1nBruIyBGuR5paI+k7pVxO8kdtgnKE
         Ew91igGozNcFtY90rNwaBPmNg2+gYfcX5bjEhXjYpd4kf4Xbo54l3jRYyjj6VbEzSp
         +L9BhjYEQmcfNYhyeMOzAcdjsa4vz9SmwOcNHdirBu/ml5Ytz/bhy3kp5LjeVC/Max
         0kQvSKf0q7yLdhbzSCi3xdsO4AvSgw0XtgAFJnH/6NgeHQUtYPy+3qNmM6pMOg9UUP
         ziGWcC/vwMcFumy/hKtFj0inccXUDtLpnb3gYwUfiCAA5O6CtFyM5mxU12MkYrNGZm
         yxOX4nY5SrFxg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hl2DmTyJirux; Tue,  5 Jan 2021 11:12:15 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 14A4511F84E;
        Tue,  5 Jan 2021 11:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609841535;
        bh=/+byBqZvoSDCctSRWxIZMu5f2V01FrVLCGvDFaB5oyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np15jG1nY4XPYIykOytyXzFUJpSrHgCTYIDhLGbwMEFqXpRYtw7bJEG87dXdcADRC
         KSFwKZW/Y4rqxHpkL9NZkk2s2dAPxgvViedIV2VzdM8ZIBbtaRBpXvGA30h0A4Uap6
         1mj5ibdvVU56XUPht8himYKPj62hf62wNFw7W756kyCu/pG6LsunlAmWoGgQbl8AyL
         gWnUc8wu22pFv1P3xwLW/wsdFTogVAxS9nXjTDhofx/eoKhap2oysKcWv460t4M+IV
         SqSmVBWRsLBPdaYjTtrYJiHIbFgRYDY+j/81BtTgkg30stEM5K83964WNSoGmE77cB
         7YG5IezbNNcTQ==
Date:   Tue, 5 Jan 2021 10:12:11 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Serial: silabs si4455 serial driver
Message-ID: <20210105101211.GA9717@dev>
References: <20201215181506.GA20057@dev>
 <fcbd72c2-e3a1-241e-a34b-7aecc41c8964@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcbd72c2-e3a1-241e-a34b-7aecc41c8964@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 16, 2020 at 09:25:47AM +0100, Jiri Slaby wrote:
> On 15. 12. 20, 19:15, József Horváth wrote:
> > --- /dev/null
> > +++ b/drivers/tty/serial/si4455.c
> > @@ -0,0 +1,1372 @@
> ...
> > +static int si4455_write_data(struct uart_port *port, u8 command, int poll,
> > +			     int length, const u8 *data)
> > +{
> > +	int ret = 0;
> > +	u8 *data_out;
> > +
> > +	if (poll) {
> > +		ret = si4455_poll_cts(port);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	data_out = kzalloc(1 + length, GFP_KERNEL);
> > +	if (!data_out)
> > +		return -ENOMEM;
> > +
> > +	data_out[0] = command;
> > +	memcpy(&data_out[1], data, length);
> > +	ret = spi_write(to_spi_device(port->dev), data_out, 1 + length);
> > +	if (ret) {
> > +		dev_err(port->dev,
> > +			"%s: spi_write error (%i)\n", __func__, ret);
> > +	}
> > +
> > +	kfree(data_out);
> > +
> > +	return ret;
> > +}
> > +
> > +static void si4455_set_power(struct si4455_port *priv, int on)
> 
> "on" can be bool here. And "poll" in earlier functions. And "on" in later
> ones.
> 
> > +{
> > +	if (!priv->shdn_gpio)
> > +		return;
> > +	if (on) {
> > +		gpiod_direction_output(priv->shdn_gpio, 0);
> > +		usleep_range(4000, 5000);
> > +		gpiod_set_value(priv->shdn_gpio, 1);
> > +		usleep_range(4000, 5000);
> > +	} else {
> > +		gpiod_direction_output(priv->shdn_gpio, 0);
> > +	}
> 
> The above can be simpler:
> 
> gpiod_direction_output(priv->shdn_gpio, 0);
> 
> if (on) {
> 	usleep_range(4000, 5000);
> 	gpiod_set_value(priv->shdn_gpio, 1);
> 	usleep_range(4000, 5000);
> }
> 
> > +static void si4455_handle_rx_pend(struct si4455_port *s)
> > +{
> > +	struct uart_port *port = &s->port;
> > +	u8 *data = NULL;
> 
> Unused initialization.
> 
> > +	int sret = 0;
> > +	int i = 0;
> > +
> > +	if (s->package_size == 0) {
> > +		//TODO: variable packet length
> > +		dev_err(port->dev, "%s: variable packet length is not supported by the driver\n",
> > +			__func__);
> > +		return;
> > +	}
> > +
> > +	data = kzalloc(s->package_size, GFP_KERNEL);
> 
> Missing check of data.
> 
> > +	sret = si4455_end_rx(port, s->package_size, data);
> > +	if (sret) {
> > +		dev_err(port->dev, "%s: si4455_end_rx error (%i)\n",
> > +			__func__, sret);
> > +	} else {
> > +		for (i = 0; i < s->package_size; i++) {
> > +			uart_insert_char(port, 0, 0, data[i], TTY_NORMAL);
> > +			port->icount.rx++;
> > +		}
> > +		tty_flip_buffer_push(&port->state->port);
> > +	}
> > +	kfree(data);
> > +}
> ...
> thanks,
> -- 
> js
> suse labs

Thank you for suggestions.

Üdvözlettel / Best regards:
József Horváth

