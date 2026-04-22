Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B63C9426;
	Wed, 22 Apr 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851130; cv=none; b=VohRGJv5RfN0N6Ctble7xTNTn/BdIIVZ0UcjjHNgzqppGAc/55K4+qqN4MX1IQ/mqMSU+7KjwNN7CLX8fUNBzzMiPywQhPH/kEaIioEFF2rV8PJ6cj4uuifRJBOwmxkk5whHv05eNg15AblZ64XKQui7RVQ4K/j1TxeLNzslM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851130; c=relaxed/simple;
	bh=4zqVy+XtKgRxGiMzoPFgfg5vI+4TZ59byA4yAXHOmTM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NOmYGtXPY1Z+D50eUheIZecsPZ3qvvTOS0Cc20k4gfm8izZ75lzFNjVT0ssGp8nDLoIPxmkiBiIC3gn2R3u+XjluUGmuMQiDpdDUyckuqfPtffVSBY2xvqwIxSWt7+/vB2tMhcppp9bsoR/gwUX5cyMBrVHx8LtdGSEFxCDpv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=B1q/Kexw; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="B1q/Kexw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=fBKH/HXbWWaP59wt4kSlVA4e+/kt2/yz9
	4apwAHGDm0=; b=B1q/KexwszubstnoHstLH0GK8YTQm4QwUwxUXAj5wbjA+ebIA
	SWrQ8fVgljQSrRGDPYu0COi5YDesyrAQTx+zmNxJSlce7INJlZVNbvONdxFW9pvV
	zKjk8OHFW+ikoKCze/SRKORHSbzHizZas6BTvFjRnnFY6bidDXoPyUc/7s=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkPPmOhpoqQCAA--.1549S2;
	Wed, 22 Apr 2026 17:45:51 +0800 (CST)
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
In-Reply-To: <446bf928-002a-456a-ae50-28220883dade@linux.intel.com>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
 <446bf928-002a-456a-ae50-28220883dade@linux.intel.com>
Date: Wed, 22 Apr 2026 17:45:06 +0800
Message-Id: <177685110619.768471.8296280075168950467.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776851106; l=3618;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=4zqVy+XtKgRxGiMzoPFgfg5vI+4TZ59byA4yAXHOmTM=;
 b=7WEztEAuFIW0/XSHLTXmt/ddsyy0WGDukxrE0QppuC1YDZ9+09jLnCh5V9qz3qf57fcW+qKpr
 UDLYse7EWnHCpDi17F+vRWpjBGpaiagkHmlX81otL3/LhVDZ1Du+TQE
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkPPmOhpoqQCAA--.1549S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UCrW8AFyUAryrCry3Arb_yoW5tr43pF
	48GFWYkryktwsaywn2va1jvFsaya1Sg3yUWrnrW342yFn0yr1SyFy8trWY9a4DZrWFkr1j
	vF4Yvay7uw4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAFEWnoRb4ACQAPsp

On 2026-04-22 12:01 +0300, Ilpo Järvinen wrote:
> On Wed, 22 Apr 2026, Jia Wang wrote:
> 
> > On 2026-04-21 15:18 +0300, Ilpo Järvinen wrote:
> > > On Tue, 21 Apr 2026, Jia Wang wrote:
> > > 
> > > > The UltraRISC DP1000 UART does not provide the standard CPR register used
> > > > by 8250_dw to discover port capabilities.
> > > > 
> > > > Provide a fixed CPR value for the DP1000-specific compatible so the
> > > > driver can configure the port correctly.
> > > > 
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_dw.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > > > index 94beadb4024d..ca6dbdf75918 100644
> > > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > > @@ -962,6 +962,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
> > > >  	.quirks = DW_UART_QUIRK_IER_KICK,
> > > >  };
> > > >  
> > > > +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
> > > > +	.usr_reg = DW_UART_USR,
> > > > +	.cpr_value = 0x00022022,
> > > 
> > > Hi,
> > > 
> > > Please construct the cpr_value by ORing DW_UART_CPR_* defines together.
> > > For fields, FIELD_PREP_CONST() may be useful.
> > > 
> > > In order to be able to use the DW_UART_CPR_* defines, they need to be 
> > > moved into 8250_dwlib.h (I'd move all DW_UART register defines in a 
> > > preparatory patch).
> > > 
> > > I know the existing Renesas' .cpr_value doesn't follow this convention but 
> > > that could be converted as well (in another patch, or leave the Renesas 
> > > entry conversion to me if you don't want to do that).
> > >
> > 
> > Thanks for the review.
> > 
> > Just to confirm: since you mentioned that the preparatory patch moving
> > the DW_UART register defines is already in place, I don't need to move
> > them again, correct?
> 
> I'm not sure where that preparatory patch is. Those defines still appear 
> in 8250_dwlib.c AFAICT.
> 
> To be clear, DW_UART_CPR_* defines are in 8250_dwlib.c but you're 
> modifying 8250_dw.c file here so you cannot use those pre-existing defines 
> as is in 8250_dw.c. To solve that, please add a preparatory patch into 
> your series which relocates all those defines from 8250_dwlib.c to 
> 8250_dwlib.h. If there's a patch which does that already, it has missed my 
> radar.
> 
> And my suggestion is to move not just DW_UART_CPR_* defines into 
> 8250_dwlib.h but all DW UART specific register defines to keep them in 
> the same place.
> 
> Hopefully this clears up any misunderstanding.
> 
> 
> My main point all along is that do not do the define move in the same 
> patch where you're adding UltraRISC DP1000 UART (which is a common pitfall 
> to many submitters so I try to give pro-active instructions while 
> reviewing to avoid extra versions because of them).
>

Thanks.

Understood. I will add a preparatory patch to move all DW_UART register
defines into 8250_dwlib.h, and update the UltraRISC DP1000 support accordingly.

I will also follow the ordering suggested during review and resend the
series as v4.
 
> > I will update my patch to use the DW_UART_CPR_* macros and
> > FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> > the next revision to convert the Renesas .cpr_value as well.
> 
> Great, thanks.
> 
> > > > +	.quirks = DW_UART_QUIRK_CPR_VALUE,
> > > > +};
> 
> -- 
>  i.

Regards,
Jia Wang

