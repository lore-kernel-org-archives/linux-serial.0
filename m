Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53BC49EA5
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 00:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294F8613B9
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 00:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYARn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:17:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:33103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhFYARm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 20:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624580116;
        bh=Dk/xnFQD/pCMBlbWxyk+SIVEEtZV15dB6a0OvtJAc3E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gw34a4ltD7yjpe9+7hRH8Txp3fqHnKkVg5mgF76OoHXky36yRfJjgyT0iqkWTUEOY
         mFB83dfO1MywWRBAtURlPgIfHdH50xMeGIJQ2+slvhCAz0/6PuAWUM3dEYEASnfm7h
         uFJCyTQPR+3Ku1JmYLqfLzlABPFCj7t3pHlURQLU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([149.172.234.120]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1luOhn3pE0-006fON; Fri, 25
 Jun 2021 02:15:15 +0200
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
 <YNSA1H0cFKiPUn6N@kroah.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
Date:   Fri, 25 Jun 2021 02:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNSA1H0cFKiPUn6N@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9FnTjOIomPTa98q+ugEDAo7F5w87ZpdPys/4PdghkTw1lEQ1/P4
 MJlt7oFr+QCZqsxG0+2UxmcVPqVRAdVGpEiwjpg5zKEdI4bv/s5axATMTWa6zKKE18uzJkS
 GknsC1csZeIKxVp0uYrM9klTIOGb36rmHUIec2s0gCG6jdUm+av5O/zlmN4ZVAn2h6tvPca
 M4WKAMuY7odu0/+hW574Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lk9pEEESwSo=:VPqO6H5qblnkk9e2BHZEjt
 /vo+x9dwfQHoqEGkR00vze230Aw6PYUz5v3P4C5SD5/cxVi4N06wzwLgsGfuE7tiYTh3av/zY
 J8NUpeYjfqRdcu0vU1W9M4cQzRf49uwndHi06OPB6mB1TnLIP1MAqdzxSe3G29NJqGs3YwNg4
 HjMSflmES0TSSJ+kciqFvzUHgr9iJGQz7FRFT53asGEINBFOWXxPVTThVLRlmPUmcdBIXGCGO
 JmUoCxfjy2gDInTURH87WleBsLW91dw84yCkYlA1T8HX3eX772oTM1nziESx3bnY2MpUdIqwc
 A+HRpRZOtqL4M5ERoBfSFIYwn80nzhqqiMl9ZNwXus+185Qlc4i7iuO3+ELLTn99YtYliUILr
 SRVk/djEUGYd+IrR3Ycc9S/glqjsBlD7OhIxDb5kkHIBcfdZVBN87/0/CQD/+94/SIZ+QqQSF
 gOhrgyJA9lRJlGhP/jVcS0LFCQjWnv8ta4287NUnYJ5IWndbnrMVuG06pDQzlVrVWUD8EVoqp
 OuOsGlyC53r3aiaF/AF8BJ1cgJjK33ti3UpDoZEr3vZzKI/yEGW5SKtjASy2KazGfmDqd3tiF
 MWLPQBTLeXOgvmKawcA8FRAkWIqLd0+Sp2o8m8WrZFb0p01BV6n4cdoD8DufNV3O9Pw7K2aqz
 YJkxyJrjJ3XTr2lhGfbjdXDJhvXMGE38EkpF2jcjbvebcx6sHFSZpwcEcPV6OXkx5FLrvV1te
 Jf4esD9ZBoZdmweml7OTqTqv7HZ9KQb+TyPUaZU5YZ1qfEj5W4g5XGRwI78CWkZDx1wXtixlJ
 M65oUthQ8ERs1FF1ltviHu+4asPAe/i+a+iqvTmDpMH8VORsCJ2oC0cX9FsTMjBfBNgNBPpjy
 NU2sM9HztZuDWwXchQ1iXwPCPe6HJ7QNBRxNMud6wT69liUtJarUGi/YM5sxVZ3uj0Q6mHaVg
 X8B9A0jSbkYwuRb8yiEQ4/y/yXfRDAPde45APLc7vhVBpFJNhGov2a//kTxt7kAxvhEoGiloN
 GDNXUnRUn7oXsmmrWmLgJ0rt+dSBjM0wSuP0k2qbAoFVbLqcnc6hcmqVaZQ8xXbEcrxw9Ny0B
 xGDuVc7X22rbLZxIfl5tCwtYaFJKRPpiew7
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Hi,

On 24.06.21 at 14:55, Greg KH wrote:
>>
>> +static int pl011_rs485_tx_stop(struct uart_amba_port *uap)
>> +{
>> +	struct uart_port *port =3D &uap->port;
>> +	u32 cr;
>> +
>> +	/* Wait until hardware tx queue is empty */
>> +	while (!pl011_tx_empty(port))
>> +		udelay(uap->rs485_tx_drain_interval);
>
> No way out if the hardware doesn't ever empty?  Shouldn't you have an
> "upper bound" on this loop somehow?

Yes, indeed. I will fix this.

>
>> +
>> +	if (port->rs485.delay_rts_after_send)
>> +		mdelay(port->rs485.delay_rts_after_send);
>> +
>> +	cr =3D pl011_read(uap, REG_CR);
>> +
>> +	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>> +		cr &=3D ~UART011_CR_RTS;
>> +	else
>> +		cr |=3D UART011_CR_RTS;
>
> Blank line here please.

Ok.

>
>> +	/* Disable the transmitter and reenable the transceiver */
>> +	cr &=3D ~UART011_CR_TXE;
>> +	cr |=3D UART011_CR_RXE;
>> +	pl011_write(cr, uap, REG_CR);
>> +
>> +	uap->rs485_tx_started =3D false;
>> +
>> +	return 0;
>
> Why does this function return a value if it can not fail and you do not
> check the return value of it?

>> +}
>> +
>>  static void pl011_stop_tx(struct uart_port *port)
>>  {
>>  	struct uart_amba_port *uap =3D
>> @@ -1290,6 +1322,9 @@ static void pl011_stop_tx(struct uart_port *port)
>>  	uap->im &=3D ~UART011_TXIM;
>>  	pl011_write(uap->im, uap, REG_IMSC);
>>  	pl011_dma_tx_stop(uap);
>> +
>> +	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
>> +		pl011_rs485_tx_stop(uap);
>
> So, no check :(
>

Ah, right. The return value is a leftover from an earlier version of the f=
unction. I will
correct this in the next patch version.

>
>>  }
>>
>>  static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>> @@ -1380,6 +1415,31 @@ static bool pl011_tx_char(struct uart_amba_port =
*uap, unsigned char c,
>>  	return true;
>>  }
>>
>> +static void pl011_rs485_tx_start(struct uart_amba_port *uap)
>> +{
>> +	struct uart_port *port =3D &uap->port;
>> +	u32 cr;
>> +
>> +	/* Enable transmitter */
>> +	cr =3D pl011_read(uap, REG_CR);
>> +	cr |=3D UART011_CR_TXE;
>
> Blank line please.
>

Ok.

>> +
>>  	spin_lock_irqsave(&port->lock, flags);
>>
>>  	/*
>>  	 * Update the per-port timeout.
>>  	 */
>>  	uart_update_timeout(port, termios->c_cflag, baud);
>
> Blank line
>

Ok.

>>
>> +static int pl011_rs485_config(struct uart_port *port,
>> +			      struct serial_rs485 *rs485)
>> +{
>> +	struct uart_amba_port *uap =3D
>> +		container_of(port, struct uart_amba_port, port);
>> +
>> +	/* pick sane settings if the user hasn't */
>> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
>
> Why the !! in an if statement?
>
>> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>
> Same here, why?
>

This was copied from serial8250_em485_config(). But I think we can simply =
use

	if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
		rs485->flags &=3D ~SER_RS485_RTS_ON_SEND;
	else
		rs485->flags |=3D SER_RS485_RTS_ON_SEND;

instead. I will adjust the code accordingly.

>> +
>> +	if (port->rs485.flags & SER_RS485_ENABLED)
>> +		pl011_rs485_tx_stop(uap);
>> +
>> +	/* Set new configuration */
>> +	port->rs485 =3D *rs485;
>
> Blank line please.
>

Ok.

>
> thanks,
>
> greg k-h
>

Thank you for the review!

Regards,
Lino
