Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B03E0091
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841909; cv=none; b=VM2DSHpgmK0aTaDP/3+SxUN+N0iWPfoW/43lv7oXE5o7I+l9iuNL6iFrMF5gdvtdxR521ORiDeSfefiZvWF5h6PzwflxdiUX8KOtwabji0C9/0QMNr0QMqwWKLy8hWzhXuOex/c9CZrWzOU0uikPlk9DpCF1dHyUfPTvA8CPQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841909; c=relaxed/simple;
	bh=S6nkK01lytWvVQ+/zYLLYNZ1AcxMPWxMPb+AKeIyr/M=;
	h=In-Reply-To:References:To:Mime-Version:Content-Type:Cc:Date:
	 Message-Id:From:Subject; b=ZWjPLbpy+cc+JK+4gYdJxm+OIK9rnDE0gybPnLn1F0E5Idq0KgeI58qhe0/l0/f6xlIbzV6Zq9rrZ4JfQNmFBQUwYVXjLgsWJ/6m5MkXSIvEkIsRDcRYnf0nugEdXlS6uYEJ429NMEf1KFg8WBGqfvVlrTk9dW+15hQ2FbumRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=j0k0R5Oa; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="j0k0R5Oa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782841896; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lt9+20jVqDmOQeLLgODKvfl7Zgu81qIHjCSFvTHJaEc=;
 b=j0k0R5Oa1a5T1illDII55bgULW1FSTvUlXMH4Wso2rYZraCaGJ7f6G6V1gVdGioV8LefAs
 DHz52HFPrPcCX1OFT7JXa0CrICRt4GwyGO5L0kwa79yxTNVp3P3WVkfhIX/UU07g4qwaiv
 GC1pt/cMU4rtPCjyQMPM6Xr7uFKXv7PDlIVvdRXZnKGZ7JzKH0tn4rnjEaLgCL8RpnD3PB
 1VE2vnJZTfJSUHq9bD/nG5MXCf/OQugj4S2JBkhfDGAOZ1zmhRM0CAS0X6judvUlstuQA+
 OjhiQ9ktMkV+iVDqv6KQj/fgwol+kNYBADyVxAd69OBNyDOHaP2KnJStGTnVLg==
In-Reply-To: <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Cc: <yang.yicong@picoheart.com>, 
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, 
	"linux-serial" <linux-serial@vger.kernel.org>, 
	"LKML" <linux-kernel@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, <geshijian@picoheart.com>, 
	<yangyang.8776@picoheart.com>, <yanligen@picoheart.com>
Date: Wed, 1 Jul 2026 01:51:32 +0800
Message-Id: <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com>
X-Lms-Return-Path: <lba+26a440227+efa05d+vger.kernel.org+yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Received: from [172.16.14.160] ([219.142.31.218]) by smtp.feishu.cn with ESMTPS; Wed, 01 Jul 2026 01:51:34 +0800

On 6/29/26 11:56 PM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 Jun 2026, Yicong Yang wrote:
>=20
>> The DW uart could get into the cases where a bogus RX timeout
>> interrupt is asserted but no available data. This could be
>> workaround by doing a bogus read.
>>
>> Currently the driver's using the standard RBR (receive buffer
>> register) for this bogus read. However the reading of RBR
>> in this case is allowed to raise a hardware error if vendor
>> choose to implement in this way (our platform). It's also
>> allowed to do the bogus read using SRBR (shadow RBR) for
>> workaround which won't raise the hardware error. So change
>> to use the SRBR to workaround the issue if it's available.
>>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
>>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
>>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250=
/8250_dw.c
>> index 84ffba045ffa..fea7dfa30e78 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *p)
>>  	if (!up->dma && rx_timeout) {
>>  		status =3D serial_lsr_in(up);
>> =20
>> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> -			serial_port_in(p, UART_RX);
>> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
>> +			/*
>> +			 * Do the bogus read from Shadow RBR (SRBR) if provided.
>> +			 * Both RBR and SRBR are supported ways to workaround
>=20
> Hi,
>=20
> I've not come across this being mentioned anywhere else than in kernel=20
> related context, but you seem to imply there something that tells about=
=20
> "supported ways"?
>=20

in fact we got this workaround method that's documented in the synopsys
dw_uart issue report, so comment "supported" here. quote the related part
of the workaround below:

  [read USR[3] for the rx fifo status]
  If the read value is '0' (indicating the RX FIFO is empty), do a dummy
  read of the RBR or shadow RBR (SRBR) register without processing the
  invalid read data.

  ...Note: Reading the RBR results in a PSLVERR immediately if
  REG_TIMEOUT_WIDTH parameter is set to '0'. Whereas, reading SRBR does
  not result in PSLVERR.

> If there's no such thing, I'm bit hesitant to declare presence of SRBR=20
> guarantees reading it universally solves this issue.
>=20
> BUT, I suppose it does on your HW since you must have hit this code path,=
=20
> and thus PSLVERR, yourself to actually discover this issue so I assume=20
> you've then also confirmed that this patch solves the issue in your case=
=20
> which isn't entirely without merit either.
>=20

actually it's hard to reproduce, only once at boot time in our several
hundreds reboot test. we locate the code line here by the backtrace of
the system error. the issue hasn't reproduced yet on the patched kernel
(hundred reboots so far, but still going on), and I suppose it's correct
as provided by the IP designer.

>> +			 * this problem. But read RBR can cause hardware error
>> +			 * (PSLVERR) if hardware choose to implement in this way
>> +			 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
>> +			 */
>> +			if (d->data.shadow_support)
>> +				serial_port_in(p, DW_UART_SRBR_0);
>> +			else
>> +				serial_port_in(p, UART_RX);
>=20
> How about:
> 			serial_port_in(p, d->data.shadow_support ? DW_UART_SRBR_0
> 								 : UART_RX);
>=20

will do. it also looks fine to me.

thanks.

> --
>  i.
>=20
>> +		}
>>  	}
>> =20
>>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8=
250/8250_dwlib.c
>> index 8859e66d2d71..19d997a59541 100644
>> --- a/drivers/tty/serial/8250/8250_dwlib.c
>> +++ b/drivers/tty/serial/8250/8250_dwlib.c
>> @@ -247,5 +247,8 @@ void dw8250_setup_port(struct uart_port *p)
>> =20
>>  	if (reg & DW_UART_CPR_SIR_MODE)
>>  		up->capabilities |=3D UART_CAP_IRDA;
>> +
>> +	if (reg & DW_UART_CPR_SHADOW)
>> +		pd->shadow_support =3D true;
>>  }
>>  EXPORT_SYMBOL_GPL(dw8250_setup_port);
>> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8=
250/8250_dwlib.h
>> index 1fe52332e774..3ad412d984ed 100644
>> --- a/drivers/tty/serial/8250/8250_dwlib.h
>> +++ b/drivers/tty/serial/8250/8250_dwlib.h
>> @@ -13,6 +13,7 @@
>>  #include "8250.h"
>> =20
>>  /* Offsets for the DesignWare specific registers */
>> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
>>  #define DW_UART_USR	0x1f /* UART Status Register */
>=20
> It seems USR and now SRBR_0 are without regshift whereas the reset of=20
> the register defines are with it.
>=20
> Somewhat unrelated to this patch, I really hate this=20
> dw8250_readl/writel_ext() mess even more now... Why are those needed=20
> anyway, should the .serial_in/out callbacks handle those byte-order, etc.=
=20
> variations just fine?
>=20
> Are those _ext calls only required for some early things during probe?
> I guess 8250_lpss hasn't setup the callbacks yet before calling=20
> dw8250_setup_port() (I'm not even sure where it gets set with it after=20
> looking for it for a few minutes)?
>
