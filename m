Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3418E34A;
	Thu, 16 Jan 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016953; cv=none; b=QOMyBDz/ClPGvi4TgT/afYxho5u/cdi6mvlwkPDYhABYTnIiRi/qHRPtL2qaEdXzXUkakHctr6BIL/rv/sMpo7iMUhl8gyeCt7YeAJX50LTC5cYFib59AYFxpWXZ4QGipKGUYpbsS4hqCTrYSH0MGbLnM/J1Kra56HbRiH/2d6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016953; c=relaxed/simple;
	bh=jpy1gvJ/71eJXN4NHHKgSQ+1qRQlwa4Fpb/y0/Muo9M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S47RzlL/o1KkOwxUKKD3rQqbWbMEIm4hurCowyxzocMf5Cp62ckpJEHQIkzF1n1/i5p0q0lSppXXCPWUcfpMR5/jayCugIavO8/WJyGnWIRY/zrnUEK5RgU2F7DUQj436MxpuFvxBVK0S4rPzOkl8pWmeVEiNWUs3zMfRID1uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=RHpCq7Pr; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="RHpCq7Pr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9C113941A5C2;
	Thu, 16 Jan 2025 09:42:28 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 68r6MG7kUYZq; Thu, 16 Jan 2025 09:42:28 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7516B941A5C4;
	Thu, 16 Jan 2025 09:42:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 7516B941A5C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737016948; bh=XxFbNSlamFw1Er3F2668QNTDDNRY18Y1SSIPKD43TQU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RHpCq7PrUuggmKNzLU2K9RWeB+DNS6pWhTY11bxWJ4jq9QWVK/7nrbiafHcybjWwe
	 DUC9V7ChIvMHGPAYQK3g3xib8IkMRPlwk1ZvlyMjDriYsTGR7SFIoWgGK2JVghM4yc
	 a/rf3zzM9OdoBpO90UCqVIznWT9k1+8VCfCWUg0CJHW/K83D7pdkI6TGePBulL/tVe
	 CX1UXU8tyYXgb1VHI6XyfGB4GqcUS4uDGP7FjzMQJXFyjiHv2VXCl6EX607tKWQaPQ
	 53zFQEjF6VQxffYMu4qV7CwVdqWoXfhRnM7sN2oxxjM9pKUP8nYhii4PRR9bFkB0G3
	 6+iiiMVUI64MQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id viwgHERnJYEX; Thu, 16 Jan 2025 09:42:28 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 1AB0A941A5C2;
	Thu, 16 Jan 2025 09:42:28 +0100 (CET)
Date: Thu, 16 Jan 2025 09:42:27 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Andre Werner <andre.werner@systec-electronic.com>
cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
    andy@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7] serial: sc16is7xx: Add polling mode if no IRQ pin is
 available
In-Reply-To: <20250116083447.453615-1-andre.werner@systec-electronic.com>
Message-ID: <58638faa-ddc2-bc64-5467-d62ea6a222cd@systec-electronic.com>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com> <20250116083447.453615-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-1558811587-1737016948=:445428"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-1558811587-1737016948=:445428
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dear Andy,

I hope this is what you expected and is what I have understood so far.
I performed the rebase to
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch. This is a commit that has been created due to the rebase. The
commit message title is the same as from the previous commit already in
linux-next and the commit message body differs, because there was a typo
in the message and the description was still including the "interrupts"
property from dt to use to select polling mode that is not directly used
anymore in the latest version of the patch.

Sorry if I still did something wrong, but this is what I thought I had
to do.

Best regards,
Andr=E9


On Thu, 16 Jan 2025, Andre Werner wrote:

> Fall back to polling mode if no interrupt is configured because there
> is no possibility to connect the interrupt pin.
>
> If no interrupt pin is available the driver uses a delayed worker to
> poll the state of interrupt status registers (IIR).
>
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner@s=
ystec-electronic.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> V2:
> - Change warning for polling mode to debug log entry
> - Correct typo: Resuse -> Reuse
> - Format define with missing tabs for SC16IS7XX_POLL_PERIOD
> - Format struct declaration sc16is7xx_one_config with missing tabs for =
polling and shutdown
> - Adapt dtbinding with new polling feature
> V3:
> - Use suffix with units and drop a comment SC16IS7XX_POLL_PERIOD_MS. So=
rry for that miss.
> - Make Kernel lowercase.
> V4:
> - Reword commit messages for better understanding.
> - Remove 'shutdown' property for canceling delayed worker.
> - Rename worker function: sc16is7xx_transmission_poll -> sc16is7xx_poll=
_proc
> - Unify argument for worker functions: kthread_work *work -> kthread_wo=
rk *ws
> V5:
> - Replace of_property check with IRQ number check to set polling
>   property. This will add support for usage without device tree
>   definitions. Thanks for that advice.
> - Add blank line es requested.
> V6:
> - Use polling mode for IRQ numbers <=3D 0 which encounter no valid IRQ
>   were found/defined.
> V7:
> - Try to improve and unify comments as requested.
> - Fix typo in commit message: pull -> poll
> ---
>  drivers/tty/serial/sc16is7xx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> index 7b51cdc274fd..348ddc3103cd 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -868,10 +868,12 @@ static void sc16is7xx_poll_proc(struct kthread_wo=
rk *ws)
>  {
>  	struct sc16is7xx_port *s =3D container_of(ws, struct sc16is7xx_port, =
poll_work.work);
>
> -	/* Reuse standard IRQ handler. Interrupt ID is unused in this context=
. */
> +	/*
> +	 * Reuse standard IRQ handler. Interrupt ID is unused in this
> +	 * context and set to zero.
> +	 */
>  	sc16is7xx_irq(0, s);
>
> -	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
>  	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
>  				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
>  }
> @@ -1561,7 +1563,7 @@ int sc16is7xx_probe(struct device *dev, const str=
uct sc16is7xx_devtype *devtype,
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);
>
> -	s->polling =3D !!irq;
> +	s->polling =3D (irq <=3D 0);
>  	if (s->polling)
>  		dev_dbg(dev,
>  			"No interrupt pin definition, falling back to polling mode\n");
> @@ -1694,7 +1696,7 @@ int sc16is7xx_probe(struct device *dev, const str=
uct sc16is7xx_devtype *devtype,
>  #endif
>
>  	if (s->polling) {
> -		/* Initialize kernel thread for polling */
> +		/* Initialize a kthread work struct that is dedicated to polling */
>  		kthread_init_delayed_work(&s->poll_work, sc16is7xx_poll_proc);
>  		return 0;
>  	}
> --
> 2.48.0
>
>
---1463794929-1558811587-1737016948=:445428--
