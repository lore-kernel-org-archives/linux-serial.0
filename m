Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142327E1B1;
	Fri, 11 Jul 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227429; cv=none; b=dXZAQs4VEKuBZTYNnk2qa6yLUxN0yA7XTWxLv0CsXx6+1Ac0Q5NoXZ28zxgRdzij5aFf4lAXUk3xWikGCTb+Ws6VmhZeHRsOOBo/cibK69hucuW4VviKgxYDwyJ9tnU2aMHnaZAllBXnzk0dtZdOR0x6v6jrULUg3+sT3D57Oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227429; c=relaxed/simple;
	bh=dtspvvL/DutC0GPC7MJ47Cq6Dcw0cHiqIGuGdORQV8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzjHlw48FGreUHn4zgpusRMhHD/3BNVjmEpSY6/uZRP0OAqZCEMGlPutQXrhC/hDAoj70jpQwTnSC8h8RZQwPzAznQMDyIwt+3BVfHn5jEUf0KR/W8dm8hWAeYHSR8Jjldntfy+vWGZfB+IrUCmZk1KcirRjzN0jhAJyghEPjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BB216F2;
	Fri, 11 Jul 2025 02:50:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26EC3F6A8;
	Fri, 11 Jul 2025 02:50:25 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:50:23 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com,
	bwicaksono@nvidia.com, rmk+kernel@armlinux.org.uk,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250711095023.GB1093654@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
 <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
 <20250710133557.GA1093654@e132581.arm.com>
 <jlhgtwkeezoca34wbqipvsgr4muxov5wmgrswleo2k7zqitzfr@4ngriyb2udra>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jlhgtwkeezoca34wbqipvsgr4muxov5wmgrswleo2k7zqitzfr@4ngriyb2udra>

Hi Breno,

On Thu, Jul 10, 2025 at 10:30:45AM -0700, Breno Leitao wrote:

[...]

> > The atomic path is introduced recently by the commit:
> > 
> >   2eb2608618ce ("serial: amba-pl011: Implement nbcon console")
> > 
> > My conclusion is that changing the initcall will not disable the atomic
> > path, changing to console_initcall() will cause AMBA device init
> > failure, and as a result, the clock operations will not be invoked.
> > Thus, I am curious if you have ruled out the issue is caused by the UART
> > clock (as I mentioned in another reply).
> > 
> > BTW, since the atomic path is enabled in the commit 2eb2608618ce, what
> > is the result after reverting the commit?
> 
> I've reverted commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> console"), and I don't see the CSD locks anymoer. The serial speed is
> the same and continue to be slow, but, the CSD lock is not there. Here
> is the time spent on the serial flush when reverting the commit above
> 
> 	[    0.309561] printk: legacy console [ttyAMA0] enabled
> 	[    8.657938] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])

From this result, we can know both the atomic path and the thread path
take a long time polling.

Since both paths configure the UART clock, I'm curious about the
behaviour if the UART clock is untouched. The relevant code is shown
below.

I may seem a bit stubborn in suspecting a clock issue :) But if you
have confirmed that a standard pl011 UART IP is being used, then the
only external factor I am aware of is the clock.

Thanks,
Leo

---8<---

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 71482d639a6d..b04773ba2602 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -64,6 +64,8 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
 {
 	int ret;
 
+	return 0;
+
 	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
 	if (IS_ERR(pcdev->pclk))
 		return PTR_ERR(pcdev->pclk);
@@ -77,8 +79,8 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
 
 static void amba_put_disable_pclk(struct amba_device *pcdev)
 {
-	clk_disable_unprepare(pcdev->pclk);
-	clk_put(pcdev->pclk);
+	//clk_disable_unprepare(pcdev->pclk);
+	//clk_put(pcdev->pclk);
 }
 
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..9ba24afb6e4f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1777,7 +1777,7 @@ static int pl011_hwinit(struct uart_port *port)
 	/*
 	 * Try to enable the clock producer.
 	 */
-	retval = clk_prepare_enable(uap->clk);
+	retval = clk_prepare(uap->clk);
 	if (retval)
 		return retval;
 
@@ -1934,7 +1934,7 @@ static int pl011_startup(struct uart_port *port)
 	return 0;
 
  clk_dis:
-	clk_disable_unprepare(uap->clk);
+	//clk_disable_unprepare(uap->clk);
 	return retval;
 }
 
@@ -2025,7 +2025,7 @@ static void pl011_shutdown(struct uart_port *port)
 	/*
 	 * Shut down the clock producer
 	 */
-	clk_disable_unprepare(uap->clk);
+	//clk_disable_unprepare(uap->clk);
 	/* Optionally let pins go into sleep states */
 	pinctrl_pm_select_sleep_state(port->dev);
 
@@ -2524,7 +2524,7 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
+	//clk_enable(uap->clk);
 
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
@@ -2542,7 +2542,7 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
+	//clk_disable(uap->clk);
 
 	nbcon_exit_unsafe(wctxt);
 }
@@ -2556,7 +2556,7 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
+	//clk_enable(uap->clk);
 
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
@@ -2586,7 +2586,7 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
+	//clk_disable(uap->clk);
 
 	nbcon_exit_unsafe(wctxt);
 }
