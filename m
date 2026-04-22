Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACE347C6;
	Wed, 22 Apr 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819494; cv=none; b=FN4h4ZOupmyq/wDJ16+wiQwWlu0O+Kne47xxdNT8Z/fZYAsYO4aesHJDnFGYMKV+xCgoY6NRRWsOkLo/s+UJdOiHyqbFJYCbk0fEadS3FEHkXrKofKgBe56kJtdFmUZUxoUH484x/1EyINCI4f31cOyTjKQSrrNyma6IyNjbhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819494; c=relaxed/simple;
	bh=1aoGw4hRSopLZOnb3TSXhniy1nlSol3La00ikxVVXvA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=r/PHAuw4WiI8sgeriSmQsx5nJvKqB9m9uQTyZuRdRXnWf9rgReA3+cnls25MpxKrSo1JXHnQDxZf1gLGWSBCoWTx8kr9lS1kKBQ6dxV3uort/XLXsLDpfdtgfFHMkCKNg031hiOHURQW0kEIFJdyfkmlqfr6JtHldlAcw0EPt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=m7/EuJU+; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="m7/EuJU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=S4U/6B0kXWG1i5F0LEcN7JR2dSSEwKbXX
	HV9ZsqsWio=; b=m7/EuJU+M3sCokRyqMFpfs8gX2fMrP/qy6d+2k+veFeoLrcfV
	e1YsMO+ELUP7gArg/GzCDkZPmgwlBEW/rAcmTL6CJGlQaKq7MEMR3hq5BWjgrDIQ
	+5OXD/SglW8u/o7T88gPc+3JuQhtrgzRqmRzDqDaggE5OPnCf+Q44x5IUE=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkNBHehpN54CAA--.1540S2;
	Wed, 22 Apr 2026 08:58:41 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
From: Jia Wang <wangjia@ultrarisc.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-serial <linux-serial@vger.kernel.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
Date: Wed, 22 Apr 2026 08:57:56 +0800
Message-Id: <177681947637.2697678.10937675549830278979.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776819476; l=2777;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=1aoGw4hRSopLZOnb3TSXhniy1nlSol3La00ikxVVXvA=;
 b=0cTTzyq/y4od7hWsMQVcQTU/3Tri1Z7RnNNQbAlPwNv9mR1XzrHQgebDKhBqufMjzMv0DZLNw
 1wiDq1NAnvpCN1O3lbJBsLIiasxuFi8EWuTsBjqhLD2T+hhovdiLuxF
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkNBHehpN54CAA--.1540S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4Utw4UGr43tFW8WrykXwb_yoW5XryDpF
	1xGFZ0yF9Yqa13u3Z2va1qvFZYva1293y7AwsrK347trn0yr98AFn7Kr4Yy3ZxurWYqr12
	yF1j9rW7Za17Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQADEWnlor4ACwAQsY

On 2026-04-21 15:18 +0300, Ilpo Järvinen wrote:
> On Tue, 21 Apr 2026, Jia Wang wrote:
> 
> > The UltraRISC DP1000 UART does not provide the standard CPR register used
> > by 8250_dw to discover port capabilities.
> > 
> > Provide a fixed CPR value for the DP1000-specific compatible so the
> > driver can configure the port correctly.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index 94beadb4024d..ca6dbdf75918 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -962,6 +962,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
> >  	.quirks = DW_UART_QUIRK_IER_KICK,
> >  };
> >  
> > +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
> > +	.usr_reg = DW_UART_USR,
> > +	.cpr_value = 0x00022022,
> 
> Hi,
> 
> Please construct the cpr_value by ORing DW_UART_CPR_* defines together.
> For fields, FIELD_PREP_CONST() may be useful.
> 
> In order to be able to use the DW_UART_CPR_* defines, they need to be 
> moved into 8250_dwlib.h (I'd move all DW_UART register defines in a 
> preparatory patch).
> 
> I know the existing Renesas' .cpr_value doesn't follow this convention but 
> that could be converted as well (in another patch, or leave the Renesas 
> entry conversion to me if you don't want to do that).
>

Thanks for the review.

Just to confirm: since you mentioned that the preparatory patch moving
the DW_UART register defines is already in place, I don't need to move
them again, correct?

I will update my patch to use the DW_UART_CPR_* macros and
FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
the next revision to convert the Renesas .cpr_value as well.
 
> > +	.quirks = DW_UART_QUIRK_CPR_VALUE,
> > +};
> > +
> >  static const struct of_device_id dw8250_of_match[] = {
> >  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
> >  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> > @@ -969,6 +975,7 @@ static const struct of_device_id dw8250_of_match[] = {
> >  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> >  	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
> >  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> > +	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
> >  	{ /* Sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> > 
> > 
> 
> -- 
>  i.
> 
> 

Regards,
Jia


