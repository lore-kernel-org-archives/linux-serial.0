Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419053081B7
	for <linux-serial@vger.kernel.org>; Wed, 15 Oct 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556928; cv=none; b=WO7bMMD0GYwxi8WmBhCM/rkcrYl3PTupD1+x5DWfFglzyM7krlTEQ/CqtYsnvpxM39/+xYt41Cg4ieJdSf9IA/4SAkW8KopJJ8enll3ci+S7Dd2sHMfTLmjFetXDzUrbsAbujaxrMcKf8FFvc1D49xGhu35qooB282l+O2yaeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556928; c=relaxed/simple;
	bh=9MbXsUNCntZdddV7entbvcM1K2yDmgBB8O25hAxYvWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEn97W1XRJ+F4hL5v76mEgGMPSfKcPvBMShjBZcT1BWQBHl+dpsmUSppE5v7B0/lbkKHBdIJDEPtp8LPyZ3IGBNQuJKuC2BmETB0HNZakvOIqSTQA94AnAdhUOgPRoBmhwFpHY9GyjIF1DkG59tKXX28w5v5Wj6oCH4w6Kga71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=xQn7sIVa; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xQn7sIVa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bUnd1pwCyhkX/cxjtG1Zi0wDRIn1CUyXHrFYYPbHQ64=; b=xQn7sIVaaGAU62aaaRfNV+72Ts
	0m0uH68FEnGDMv/4VOfcRA2qS7tsjdggJ0UlOWazBCWzz1U8T71G6DyK3K6M3V2yYedl+eCV7ntfm
	Pm/HeCddOH5PEiYYKxn6zabZe6lNIr/sxoCVYYw6X2FLv6gr0+JwqPjWAaCVgMmH06UU=;
Received: from [93.82.65.102] (helo=[10.0.0.160])
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v96bi-000000002M8-0QXh;
	Wed, 15 Oct 2025 20:52:18 +0200
Message-ID: <204ce0ec-6e8e-41b4-afea-7f4890cb3ea2@engleder-embedded.com>
Date: Wed, 15 Oct 2025 20:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250: add driver for KEBA UART
To: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Gerhard Engleder <eg@keba.com>,
 Daniel Gierlinger <gida@keba.com>
References: <20251014191515.75888-1-gerhard@engleder-embedded.com>
 <20251014191515.75888-3-gerhard@engleder-embedded.com>
 <01ea9c8b-08cb-40d0-b550-12eb60e515ab@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <01ea9c8b-08cb-40d0-b550-12eb60e515ab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 15.10.25 08:14, Jiri Slaby wrote:
> On 14. 10. 25, 21:15, Gerhard Engleder wrote:
>> +/* flags */
>> +#define KUART_RS485        0x00000001
>> +#define KUART_USE_CAPABILITY    0x00000002
> 
> use BIT()
> 
>> +/* registers */
>> +#define KUART_VERSION        0x0000
>> +#define KUART_REVISION        0x0001
>> +#define KUART_CAPABILITY    0x0002
>> +#define KUART_CONTROL        0x0004
>> +#define KUART_BASE        0x000C
>> +#define KUART_REGSHIFT        2
>> +#define KUART_CLK        1843200
>> +
>> +/* mode flags */
>> +#define KUART_MODE_NONE        0
>> +#define KUART_MODE_RS485    1
>> +#define KUART_MODE_RS422    2
>> +#define KUART_MODE_RS232    3
> 
> Use enum.
> 
>> +/* capability flags */
>> +#define KUART_CAPABILITY_NONE    (1<<KUART_MODE_NONE)
>> +#define KUART_CAPABILITY_RS485    (1<<KUART_MODE_RS485)
>> +#define KUART_CAPABILITY_RS422    (1<<KUART_MODE_RS422)
>> +#define KUART_CAPABILITY_RS232    (1<<KUART_MODE_RS232)
> 
> use BIT()
> 
>> +#define KUART_CAPABILITY_MASK    0x0000000f
> 
> Use GENMASK().
> 
>> +/* Additional Control Register DTR line configuration */
>> +#define UART_ACR_DTRLC_MASK        0x18
>> +#define UART_ACR_DTRLC_COMPAT        0x00
>> +#define UART_ACR_DTRLC_ENABLE_LOW    0x10
>> +
>> +struct kuart {
>> +    struct keba_uart_auxdev *auxdev;
>> +    void __iomem *base;
>> +    int line;
> 
> unsigned
> 
>> +
>> +    unsigned long flags;
> 
> I would say unsigned int would be enough.
> 
>> +    u8 capability;
>> +    int mode;
> 
> Use the new enum as a type.
> 
>> +};
>> +
>> +static void kuart_set_phy_mode(struct kuart *kuart, int mode)
> 
> enum too.
> 
>> +{
>> +    iowrite8(mode, kuart->base + KUART_CONTROL);
>> +}
> ...
>> +static int kuart_rs485_config(struct uart_port *port, struct ktermios 
>> *termios,
>> +                  struct serial_rs485 *rs485)
>> +{
>> +    struct uart_8250_port *up = up_to_u8250p(port);
>> +    struct kuart *kuart = port->private_data;
>> +    int mode;
> 
> enum
> 
> ...
>> +    return 0;
>> +}

I will improve the code as suggested.

Thank you for your review!

Gerhard

