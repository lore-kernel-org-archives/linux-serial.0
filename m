Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A833CEB89
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840482; cv=none; b=jQOo1L5Uizp930grJvfXDLnpfODPXEBajBcxGAU1Kv5i3hWtRCtANmsD5dchG1o6bWvsAPr8c9v5rNc5RyVLL7DoVNW7lZObj9VXxYQCZDD7PkZ/urtJkSe9sr5xSsTIWmsgcr0BOWxdwci2Qj+OoLdZmWeTDWQC77VG06nFWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840482; c=relaxed/simple;
	bh=EsfVrBZrJsQs/Tx4mfI8R8eRm6q5uajg1tGl9pwd0JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsU8Buyk0Bx8jloYjeeMWkQOVAAt0DECIxPYFw8h9b+mEuvZl7lfgYJkIH1Hoyow7Y785e0Fh44JTv1eYE6wsYPtC95DJbawtRxpEj8rFqsBkrNVSvNmJf7YbydKc/GWzfe5j8MaiYqBDIbPXE7NscQopSv7hR9iSbx3kOpJ/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8SRfXK/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8SRfXK/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so78225955e9.3
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778840479; x=1779445279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkvhJ/9wP8zr+IJruUAJhSjjyH2HxiZyy6n7D1GMZRw=;
        b=W8SRfXK/Kgq8GrQxYKwInjZCMRtWX3qIIyuOU/TIduZrBVlynZkhp5ZU+blJ/qI02T
         z3PGRwTdWZKlwo79lWPPPJ3Ydm5O+MIexA/CBKOs5qm+GUDR+2YiyULKXdVDlIXvEqcI
         Ku+zyVGq5V8hViIboN3xLKPhkYIProkyGwcnH0rvPeSsS1HHoIztaCdT3W9h5i2SMs6B
         fqE3zI5CYj6QlipmoMqxuQQ5C6m8cDOg1W0wZleZsDikm/p6naXhM4+UJxbCCvcMul3O
         GWKEi9EWeIAUgFrbZyuDnT++yIt0N1NNHf8xY7AiWLy1XmXmnSH/E7MKziF92edtNcDV
         OQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840479; x=1779445279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkvhJ/9wP8zr+IJruUAJhSjjyH2HxiZyy6n7D1GMZRw=;
        b=q0OScTe51jaDDajnGSGHbfekvY51CHac7iLyFGGcNKRzcxShrfI/Diq23qdPjIsDPB
         z7KXtgQocC90gME7hDWVF8aeL4SNRoCDxqTf4Fuu3pwRB+tsj+sdE2AwpzUa/bzRoc6u
         yGRzhjPh4Y7dR52rlrxj4ROcDzp7Jf8vGWodKnPWm4fpwZXsupE0dlhBocFhekhCNsAP
         q8dQtPZUK4b5vciQXvherkdLgXh+neU7UAcHDFgsIWI3ACWsGSPIdE6wfTuATAc1OQtS
         wUgiAcet72FrT7Vz5fsKBtIzdeAcIOnQIXwKljVAbbBSHCC6g2bgv/filWfNCKSRc9da
         vgRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PFETwQzju+RambVVFiyS7ZIZTrFBQGT/ez7IUOyox+/tizFebiyaZcBvExVfZMS4uHtSMUQnNma7Ya5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywob2hb7bmKmWk/DItbm89ghrkovH3bXRuQkdMHgONn81OQrIY9
	42+MQsr33gf9wpr4mcNgU0Mlf4jBtWHGGi6A/bN230BMlGCECTQ43E2gYCIxO7idtIw=
X-Gm-Gg: Acq92OG1HctCIxuWn/deKMVpUhsfAhS0JESrXU8PjEf7XXHEO4b8tEkx0tPyll5hFD5
	B+gduDhyzIgGbN2DPn0MO9kE7WcPQ4q4qC4XQn3dOHmaVfiMp+N/wrkMg46IId+RcMlwTKqzH7g
	+nvrMr8z0U6n9axSaghSU47R8JxpGQuNvRDVXlcu5kaVAFDhzg4GkyIREjC8OkXUtz/PMFg8p7r
	OwTyn2njEMtetlA5UxwSO3+HvHU+1EDbL4CpZTdYbJaofsiIY+nz7UQkak1JOvZQD3kkT1FOpsT
	pU22A0r73TYrVsRFpRMRdMPvuaSv5psHDXu/lk/QnlAOBfKK6dbUzgZCDoWRk1cmiI7qlObQvfJ
	xIZWSjRFsAFs80dmH81zUbyG+KQ7vlb18tn6m5SDVGJfxCQGLySUXJTTGbNLZ6JtNG/4wtetmcO
	IYdh5zXf1to7p9OEwDD+8F6n83eB3S5wIx
X-Received: by 2002:a05:600c:46cf:b0:48e:8974:c377 with SMTP id 5b1f17b1804b1-48fe6626ba1mr44036975e9.29.1778840479456;
        Fri, 15 May 2026 03:21:19 -0700 (PDT)
Received: from [10.11.12.109] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm52284855e9.3.2026.05.15.03.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:21:19 -0700 (PDT)
Message-ID: <ae8fdfa0-d910-432c-b5fc-f11b997a4bce@linaro.org>
Date: Fri, 15 May 2026 13:21:15 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>, Juan Yescas <jyescas@google.com>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
 <87lddvy2dl.fsf@jogness.linutronix.de>
 <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
 <87wlx56rcc.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87wlx56rcc.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 10:53 AM, John Ogness wrote:
> On 2026-05-13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> (This email is particularly directed at the Samsung folks.)
>>>
>>> Responding to Sashiko:
>>>
>>> https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de
>>>
>>> On 2026-05-06, Sashiko wrote:
>>>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>>>> index e27806bf2cf3e..2f94fc798cffb 100644
>>>>> --- a/drivers/tty/serial/samsung_tty.c
>>>>> +++ b/drivers/tty/serial/samsung_tty.c
>>>>> @@ -319,7 +319,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>>>>>  	ourport->tx_enabled = 0;
>>>>>  	ourport->tx_in_progress = 0;
>>>>>  
>>>>> -	if (port->flags & UPF_CONS_FLOW)
>>>>> +	if (uart_cons_flow_enabled(port))
>>>>>  		s3c24xx_serial_rx_enable(port);
>>>>
>>>> This isn't a new bug introduced by this patch, but does this code
>>>> result in a recursive spinlock acquisition and deadlock when console
>>>> flow control is enabled?
>>>>
>>>> The serial core framework calls port->ops->stop_tx() with the
>>>> port->lock spinlock already held. When uart_cons_flow_enabled(port)
>>>> evaluates to true, s3c24xx_serial_stop_tx() invokes
>>>> s3c24xx_serial_rx_enable().
>>>>
>>>> Looking at s3c24xx_serial_rx_enable(), it unconditionally attempts to
>>>> acquire the exact same lock again:
>>>>
>>>> static void s3c24xx_serial_rx_enable(struct uart_port *port)
>>>> {
>>>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>>>> 	unsigned long flags;
>>>> 	...
>>>> 	uart_port_lock_irqsave(port, &flags);
>>>> 	...
>>>> }
>>>>
>>>> Because spinlocks are not recursive in the kernel, it appears this
>>>> sequence would cause an immediate deadlock on the same CPU.
>>>
>>> Although out of scope for my series, the reported issue is real. Perhaps
>>> something for Krzysztof or Alim to look into.
>>>
>>>>> @@ -493,7 +493,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
>>>>>  	struct tty_port *tport = &port->state->port;
>>>>>  
>>>>>  	if (!ourport->tx_enabled) {
>>>>> -		if (port->flags & UPF_CONS_FLOW)
>>>>> +		if (uart_cons_flow_enabled(port))
>>>>>  			s3c24xx_serial_rx_disable(port);
>>>>
>>>> Similarly here, s3c24xx_serial_start_tx() is also called with
>>>> port->lock held, and s3c24xx_serial_rx_disable() will attempt to
>>>> acquire port->lock again:
>>>>
>>>> static void s3c24xx_serial_rx_disable(struct uart_port *port)
>>>> {
>>>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>>>> 	unsigned long flags;
>>>> 	...
>>>> 	uart_port_lock_irqsave(port, &flags);
>>>> 	...
>>>> }
>>>>
>>>> Could this pre-existing locking issue in the samsung_tty driver be
>>>> addressed so that the rx enable/disable helpers do not try to take the
>>>> port lock when it is already held by the caller?
>>>
>>> Also legitimate. But out of scope for my series.
>>
>>
>> Thanks for letting us know. Deadlock did not happen so far, so something
>> is missing in Sashiko's report. :)
> 
> Nothing is missing. I am guessing you never use console flow
> control. The deadlock is clearly visible:
> 
> ->stop_tx() (always called with the port locked)
>   s3c24xx_serial_stop_tx()
>     s3c24xx_serial_rx_enable()
>       uart_port_lock_irqsave() (DEADLOCK!)
> 

Right.

The lock acquisitions in the rx helper functions are redundant and shall be
removed.

The serial core framework invokes the .stop_tx() and .start_tx() callbacks
with the port->lock spinlock already held. Furthermore, all internal driver
paths that invoke stop_tx/start_tx also acquire port->lock prior to calling
them.
    
However, s3c24xx_serial_rx_enable() and s3c24xx_serial_rx_disable()
unconditionally attempt to acquire port->lock again using
uart_port_lock_irqsave(). Since kernel spinlocks are not recursive, this
causes a deadlock on the same CPU when console flow control is engaged.

Just removing the redundant lock acquisitions shall fix it. I'll prepare
a patch.

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e27806bf2cf3..17cd5bb100b1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -245,12 +245,9 @@ static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
        struct s3c24xx_uart_port *ourport = to_ourport(port);
-       unsigned long flags;
        int count = 10000;
        u32 ucon, ufcon;
 
-       uart_port_lock_irqsave(port, &flags);
-
        while (--count && !s3c24xx_serial_txempty_nofifo(port))
                udelay(100);
 
@@ -263,23 +260,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
        wr_regl(port, S3C2410_UCON, ucon);
 
        ourport->rx_enabled = 1;
-       uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
        struct s3c24xx_uart_port *ourport = to_ourport(port);
-       unsigned long flags;
        u32 ucon;
 
-       uart_port_lock_irqsave(port, &flags);
-
        ucon = rd_regl(port, S3C2410_UCON);
        ucon &= ~S3C2410_UCON_RXIRQMODE;
        wr_regl(port, S3C2410_UCON, ucon);
 
        ourport->rx_enabled = 0;
-       uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)
