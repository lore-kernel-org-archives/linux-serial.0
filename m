Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D64275401;
	Fri, 14 Feb 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522647; cv=none; b=LBeXgKwX2rsYcBVHERADPAIqjaw0dksmS7W6+BDMw5U4SQpfQV8L8lOFrW8ll15L8n2iTN4Rb/64ARPM2rnmosPfUXPypwJgjMeWK2NUKjXy2jCTeTBIgtmf4Q5EvFiCadYv33POM6fR7cpI+MuYqCW2RPL/hGdjBfPuPOW7j2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522647; c=relaxed/simple;
	bh=ykvEShYNLVtLUN8WbhFUSrKQ/Ai8VO/e+8edobeJJcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft7RghC0312RqKoyAIl/+wW739/sPa/NOoKZtOBZMb8VPxWSjPg8TtTcE2d5usniaN6CgRxNdZ2u4WwcMgAjc/tYQRa7jxZ2MK7meDBEWAvBmvnJg2nKCf31LLPCocgN6attTEsmwfPAwoW9X31y9WUeruQUj0vLqv9rCO4hWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iF611NiJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iF611NiJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D198441E5;
	Fri, 14 Feb 2025 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739522643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSaeyfo8DQwqJGKUIUvYkkgVgRZAUJU2hAJTGaurvSE=;
	b=iF611NiJf5UmWwAeRJ9fSRHPIr3slCUYg5J6GAy0IdyLMF/8cuZA6Vlvrdk9KqZZpGEpG8
	kLtnvTavAgWOoMu/olJ9i0hTVWQZKGjyvLFuGt9ENeeuW2gHQeRM3dozeIy233+ZMMhS5l
	4cDs+4mGEpzgEf4vKDvoq+1MDohQXLjW1DGeXMvZ8xsXfUVsOcYUKMMVf6067nFcAb05mB
	cfewLHnFQN1PM5oKIbQVBVnPsEDPGm/PFVLg9W1dFGD/POGdAICBc/mMRZ+80qIVM1vKux
	lBikh5Q99/eDpUU7L0gR4sCdqdJ80nrXpDpQzlbTGaohs3kqxrCBjUkk1PI9qQ==
Message-ID: <1274bae7-e473-4711-9235-de0aeeadb02f@bootlin.com>
Date: Fri, 14 Feb 2025 09:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: mctrl_gpio: add parameter to skip sync
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-doc@vger.kernel.org
References: <20250214-atomic_sleep_mctrl_serial_gpio-v2-1-1e60c732fd90@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250214-atomic_sleep_mctrl_serial_gpio-v2-1-1e60c732fd90@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegledvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetteektdehudelheehkeeggfejgfelveevgeevtdejudfgveetgefhtdduuedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghro
 hgthhhiphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrdhhrghuvghrsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/14/25 09:38, Alexis Lothoré wrote:
> The following splat has been observed on a SAMA5D27 platform using
> atmel_serial:
> 
> BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
> preempt_count: 1, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<00000000>] 0x0
> hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
> softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
> softirqs last disabled at (0): [<00000000>] 0x0
> CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
> Hardware name: Atmel SAMA5
> Workqueue: hci0 hci_power_on [bluetooth]
> Call trace:
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x44/0x70
>   dump_stack_lvl from __might_resched+0x38c/0x598
>   __might_resched from disable_irq+0x1c/0x48
>   disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
>   mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
>   atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
>   atmel_set_termios from uart_change_line_settings+0x15c/0x994
>   uart_change_line_settings from uart_set_termios+0x2b0/0x668
>   uart_set_termios from tty_set_termios+0x600/0x8ec
>   tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
>   ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
>   wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
>   hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
>   hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
>   hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
>   process_one_work from worker_thread+0x6e0/0xfb4
>   worker_thread from kthread+0x3d4/0x484
>   kthread from ret_from_fork+0x14/0x28
> 
> This warning is emitted when trying to toggle, at the highest level,
> some flow control (with serdev_device_set_flow_control) in a device
> driver. At the lowest level, the atmel_serial driver is using
> serial_mctrl_gpio lib to enable/disable the corresponding IRQs
> accordingly.  The warning emitted by CONFIG_DEBUG_ATOMIC_SLEEP is due to
> disable_irq (called in mctrl_gpio_disable_ms) being possibly called in
> some atomic context (some tty drivers perform modem lines configuration
> in regions protected by port lock).
> 
> Split mctrl_gpio_disable_ms into two differents APIs, a non-blocking one
> and a blocking one. Replace mctrl_gpio_disable_ms calls with the
> relevant version depending on whether the call is protected by some port
> lock.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

So despite changing the commit description, I forgot to update the actual commit
message, which is eventually not adding a flag anymore but new APIs. v3 will
follow, sorry for the noise.

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
