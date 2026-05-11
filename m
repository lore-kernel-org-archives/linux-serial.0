Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308925F7A9;
	Mon, 11 May 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493039; cv=none; b=W7vuxoRikeFSP6o7Wj34yHZ1anwDSfpKhqaC5lBKEB7t7otItqGeO4A9ax/P/UPQoztcfYYRsn2HHvxQyimGTxY8cWVXZzme3+Cm7lWf75dE36WlBcWRuAjnO9iMo3Hwg9kG02W1DHy8XlEwXgzPzFcReYskj3EroTVYYqjEeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493039; c=relaxed/simple;
	bh=Z4f8Be3tvf+DeFSTMlalpRJHUnyRF5MgEUMBJBp4awk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nYxqC3RhCx1jxoURpwCD5pY1vbvjZQuOVal0J58scB5YXZHxZH5UAsGUzLunFEYCZlriaY5uZKInDDFleMuCZdyaEi7GeX2R0jxrt49i5VLc9T4gUdRZvA3swXS8nacLEnF5ym9fYdxMc48sKW1qwbKHczU979PWqYLOBXOzrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=JyBmQRNU; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="JyBmQRNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=pXp0B+DtFOhFG5oHIfyHHz0VpIQInvWd4
	5+4nuEQISQ=; b=JyBmQRNUIT+K1L054Eo3UZdxiRCKj/KBl1ECoFwe1r/SAcQkv
	YA8o5O7hP0E4IjLCtrnv8C/CCMIw7LJ+vi+xOrxyjB0BLKuNBMhFYqpx3nW5lcsO
	PrVVsBv+h6U+XQh1A1im7lwVXbTrcbrw36calT93QWeti01RuohMxAKYzg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUJ3pgFqlwMEAA--.3534S2;
	Mon, 11 May 2026 17:50:48 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 4/4] serial: 8250_dw: Use a fixed CPR value for
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
In-Reply-To: <66f322a7-70c5-13f9-3e97-6d0b18193f91@linux.intel.com>
References: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com>
 <20260429-ultrarisc-serial-v7-4-e475cce9e274@ultrarisc.com>
 <66f322a7-70c5-13f9-3e97-6d0b18193f91@linux.intel.com>
Date: Mon, 11 May 2026 17:50:05 +0800
Message-Id: <177849300569.62727.6686772792675107792.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493005; l=2656;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=Z4f8Be3tvf+DeFSTMlalpRJHUnyRF5MgEUMBJBp4awk=;
 b=vfCokh6bFqZ+ax0cWnwoM+VdZGWYQ0/P0aQZlubUa1RX5FmYEMav3Og4jjfuFYnCCnyAf769m
 Xb64k1dcNjGCFNK6uczeyPiIjCLdoUqrvCldL/z2Ql8ovPdrWD0Lhef
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUJ3pgFqlwMEAA--.3534S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fJrWDtF1Uur43urW3Jrb_yoW5GrWfpF
	4UGFWYyF9agF13u3Z2v3WvyFZaqa129342kwsrK347tFn0kryDJFnakrWfC3Zruryjgw1a
	yF1j93y7Ca1UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAEEWoBUkIAAwAEso

On 2026-04-29 13:55 +0300, Ilpo Järvinen wrote:
> On Wed, 29 Apr 2026, Jia Wang wrote:
> 
> > The UltraRISC DP1000 UART does not provide the standard CPR register used
> > by 8250_dw to discover port capabilities.
> > 
> > Provide a fixed CPR value for the DP1000-specific compatible so the
> > driver can configure the port correctly.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index 480f82d89856..55e40c10f46a 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -959,6 +959,15 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
> >  	.quirks = DW_UART_QUIRK_IER_KICK,
> >  };
> >  
> > +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
> > +	.usr_reg = DW_UART_USR,
> > +	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> > +		     DW_UART_CPR_THRE_MODE |
> > +		     DW_UART_CPR_DMA_EXTRA |
> > +		     DW_UART_CPR_FIFO_MODE_FROM_SIZE(32),
> > +	.quirks = DW_UART_QUIRK_CPR_VALUE,
> 
> Thanks for all the effort you put to this series,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Unrelated to this patch, I suppose we wouldn't strictly need to have 
> DW_UART_QUIRK_CPR_VALUE in this driver as non-zero .cpr_value should be 
> enough to decide if the CPR quirk should be used or not (if the code is 
> adapted, obviously).
> 

Thanks for the review and the tag, Ilpo.

The idea of dropping the quirk flag sounds reasonable to me. I'll keep
it in mind for a future cleanup patch once this series is merged.

> > +};
> > +
> >  static const struct of_device_id dw8250_of_match[] = {
> >  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
> >  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> > @@ -966,6 +975,7 @@ static const struct of_device_id dw8250_of_match[] = {
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

Best Regards,
Jia Wang


