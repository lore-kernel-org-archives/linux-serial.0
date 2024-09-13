Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239D1D6C6E;
	Fri, 13 Sep 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221791; cv=none; b=L03OVaVwomuoVee6kU7cRT4Yj+srQG7XcWbMDCDHwqGr1Mgzg1QGpguzjwnF12cZn1C7reB9xLqiq0626W0KxeQYtbeU1ErFKrJLA9asI9cgcH9MfMQEQzX5QMZQmlAKY82ikJ54QT12TxD5pHEyVDGg7QxVBlzcA/m3orUrStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221791; c=relaxed/simple;
	bh=v77vG3R2aQwdctrT7b5cLJzwQds5ti5P3NnSbJlI2b8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FbQR/TlbtoUyKrHyeUkvtd9K+y2ukQ6mzkp6OQqDFjo5dLhSfu5IZvZ98Xw3ukToeN1XyJUIVAorX4QJA/Gogh/mWMGNxqgV95nkRqczhvPjKFnIaeY6ibaNGGeGDm+xOmgg/GL4Nu6KopSBbs2ZPnGflezTFUznSFa3h/4c5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0IryVpN4; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0IryVpN4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rlPvbEnZ5WQngyesq81myBzkHs5Lcelfd34b25m5ANQ=; b=0IryVpN4MTLdCo88llTCADA7Vx
	RY2gmXVOOIupVG6SYex0ZlRMeQjiZkJxTu0WzU2/zcf0zWvVB88FY8MUJiAHN9nTFWHwgJl65EWvg
	JZDD/tFkt8f6SgQ10z1FnwMP+c/v5tMLt6ZGakcSxQjllNzfFKLVv/spzS3rywxp5C/ZT+KVYgLIU
	6jCTPsx/nUM0bAj+6HXmOkyJ9652ShqGf1FAuNHlTd8jQZaTkQ9VmEOqB7v+K0mfGxlepXw/I4GJ+
	UBUpfiZmgkT7l16YnDq55gK0764gmm95gmLqZFgfbv1tcidEd2+NL7JIDo3dc6U9zo1x0E+OE5FV2
	ZlGz7F8Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp38l-0001ta-BP; Fri, 13 Sep 2024 12:02:59 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp38k-0009i8-05;
	Fri, 13 Sep 2024 12:02:58 +0200
From: Esben Haabendal <esben@geanix.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,  John Ogness
 <john.ogness@linuxtronix.de>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org,
  imx@lists.linux.dev
Subject: Re: [PATCH 2/2] serial: imx: Add more comments on port lock status
In-Reply-To: <2200890.irdbgypaU6@steina-w> (Alexander Stein's message of "Fri,
	13 Sep 2024 11:17:04 +0200")
References: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
	<20240913-serial-imx-lockfix-v1-2-4d102746c89d@geanix.com>
	<2200890.irdbgypaU6@steina-w>
Date: Fri, 13 Sep 2024 12:02:57 +0200
Message-ID: <87v7yz50ry.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

Alexander Stein <alexander.stein@ew.tq-group.com> writes:

> Hi,
>
> Am Freitag, 13. September 2024, 10:39:50 CEST schrieb Esben Haabendal:
>> Comments regarding status of port.lock on internal functions is useful when
>> reviewing correct handling of registers that must be protected by this
>> lock.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/tty/serial/imx.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index efa3eb3a2c57..bea4510743ef 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -370,6 +370,7 @@ static void imx_uart_soft_reset(struct imx_port *sport)
>>  	sport->idle_counter = 0;
>>  }
>>  
>> +/* called with port.lock taken and irqs off */
>>  static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
>>  {
>>  	unsigned int uts;
>
> I think you are referring to sport.lock.

Yes.

> On the other hand, instead of just adding comments, wouldn't it be
> better to make it explicit?
> Adding
>> lockdep_assert_held(&sport->port->lock);
> and/or sparse annoations
>> __must_hold(&sport->port->lock)
>
> seems more reasonable to me than adding non-enforcing comments.

I fear that due to the way that legacy console works, assertations might
trigger in special situations, such as printk during panic.

Converting comments to assertations could definitely be a good idea, but
I think it might be better to wait with that until the driver has been
converted to NBCON (in progress, see
https://lore.kernel.org/all/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/),
as that will change the code paths this code will be used in.

/Esben
