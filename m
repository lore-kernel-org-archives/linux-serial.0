Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B351C54
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802595; cv=none; b=g3+1vCBoy+gS5dN/P6RyqHsSx2ZWCuSDaVL8WiN0t4XMc1rxcra9dQqXQv/uDtW3Tjpm//KEu5aVow0/9sxX7mPOCOt/df4RrC7QhmQqCZu0c0L9tt2TxjvnI02Gwr1wc6VS8aeYQjJ3KoFQdHIQPMcgTNRIeoQfgrYzXztgwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802595; c=relaxed/simple;
	bh=bqF8MEgaGwgFRwrgZWMsa/U+WjwHBEC7oM8iS4kd2hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxUXPNUQIdWFepR+x6wPzihI1zA4zVQJ5HRAQV9cgoa4/gT9j95kKkBReATrx4SVqmXsP168/ofXtvFHPXpKbmjzFx0vXEUMaYAZprLLX3oVtzy4VfkeTgbAwUN2t/I9RZoW7KugmXA8Wosv4FevIqv5Ltkb0gU2oyybsCByVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPVysM7E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTSiicPW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPVysM7E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTSiicPW"
Date: Thu, 7 Mar 2024 10:09:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709802591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fGy8TOV/fhJE5oAAJ3MAEukbtM1398/CRgKOFV6eys=;
	b=mPVysM7EoFM4MwBJX5dLlMREizUcVcXH68EeHfMf1pN8zuiLtxnnrEGRK1G/i5Fvj+vUeV
	KfPvxIXfsPJF8mLiDPWUElFUhIChRZBPSzhhFrhOhg5ViJb/gMtEBT9UnLi7UfYObl5HJE
	yru3dCz5QQ2qng+gZBj9DGvjOWnrrnwNvrf0OiqpkWIUni09VnqZh6lsoFiUMI9AS7EDj/
	YUr5pEcHNG2Zjw9wYua7RLYC0yFRGDzCYFRu8j4OPNhWNXVl/7xgVNBdymlcEpXzM8rRG3
	NAjdcV3qZKN1p7MNR2vLjNWMPGyk02KEqs64zAYLNkQrLsX7ow0cmok8MnEwRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709802591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fGy8TOV/fhJE5oAAJ3MAEukbtM1398/CRgKOFV6eys=;
	b=yTSiicPW+BxkoaA11akToXnzY5400u66BAX3bq30g8xtpnXF+EDylMIy/6mMBf/he1xFZq
	qko7K2HqfY55xHCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: sifive: Remove 0 from fu540-c000-uart0 binding.
Message-ID: <20240307090950.eLELkuyK@linutronix.de>
References: <20240304105947.SJcVAdr1@linutronix.de>
 <20240304-whomever-gladly-d43da7ad2fe6@spud>
 <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>

The driver is using "sifive,fu540-c000-uart0" as a binding. The device
tree and documentation states "sifive,fu540-c000-uart" instead. This
means the binding is not matched and not used.

This did not cause any problems because the alternative binding, used in
the device tree, "sifive,uart0" is not handling the hardware any
different.

Align the binding in the driver with the documentation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2024-03-06 18:48:13 [-0800], Paul Walmsley wrote:
> On Mon, 4 Mar 2024, Conor Dooley wrote:
> > I suspect that the driver is what's incorrect, given there's little
> > value in putting the IP version in the SoC-specific compatible as it's
> > a fixed implementation. I'd change the driver to match the bindings.
> 
> Agreed

I didn't add any stable/ fixes tags as I guess there is no point in
backporting this.

> - Paul

 drivers/tty/serial/sifive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 0670fd9f84967..cbfce65c9d221 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -761,7 +761,7 @@ static int __init early_sifive_serial_setup(struct earlycon_device *dev,
 }
 
 OF_EARLYCON_DECLARE(sifive, "sifive,uart0", early_sifive_serial_setup);
-OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
+OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart",
 		    early_sifive_serial_setup);
 #endif /* CONFIG_SERIAL_EARLYCON */
 
@@ -1032,7 +1032,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
 				sifive_serial_resume);
 
 static const struct of_device_id sifive_serial_of_match[] = {
-	{ .compatible = "sifive,fu540-c000-uart0" },
+	{ .compatible = "sifive,fu540-c000-uart" },
 	{ .compatible = "sifive,uart0" },
 	{},
 };
-- 
2.43.0

Sebastian
