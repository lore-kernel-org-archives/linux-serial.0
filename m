Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9C1C84A6;
	Tue, 25 Mar 2025 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900474; cv=none; b=Py1l7McjmjwbmblJ6FBuEc/MX2qk5dLyEOTMPWrPiSnwGQNp1NaGGP/lHWcJWTYO0umjK3eFy9mTWEezcaxKOJyH5jzGvemJJm09iUKcJVFRnandslQV1Fy6RBdUpl7SkbSsK4ocRlrv0KZ5zzKNi550BThZHYLHo910tUsvd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900474; c=relaxed/simple;
	bh=JuaCPk3ExOlK9zmbI7EVpJxzROVhN5sSw+lzcIaED0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnjD/j8Ma3zxExRfgrb5QHS6HNcrxOu6TkPM5vtzZcch3h9G9el8xEiL2EYGuVxYsMVIue1aOmfCJuU0ne6Bmuuk/6vyU9CCNJbvM4s4jR68xEJVvzEoik2yCWXqdv1O1KxsYnrWz1bjdusY5yfQhN0ecNIKKf3CaDZkI5N22SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A10xKCKd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A10xKCKd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so102950855ad.0;
        Tue, 25 Mar 2025 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742900472; x=1743505272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFQjpijP51sT2xR77PHLhJDe/bbbSDnZKMZrsva8hbs=;
        b=A10xKCKdjessy1wXQjLc64esrVidFJjGozCZ3CQhcf4feOCY67u+6SET6G7sI/zVY+
         UOWV3EhP1PYi+TNdj+K++aNr5ZvVGtBGKEhT7Ko7cniqW3ZDUFxQr04ClS09FptpGxEF
         G85vmszaK1IuSW22neeaqc54jX+1VygroNntfwqYhL5fNANg/9VSmVg/GypRrhGYl3HY
         cngd8gO+H7cFxSsmzwDcw7g/nCWVVlR6vVdu8xXsmaa1of87BN5A85mKPhG2KkUctTg1
         9lDxoSgGDy+96atsRlA0lBJVcajMrsNgO/QwCsGuoAECeKgl6PLNIhY6vNkd3p6UelSv
         zAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900472; x=1743505272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFQjpijP51sT2xR77PHLhJDe/bbbSDnZKMZrsva8hbs=;
        b=fdrkgqPhsTpuid0D8n/FfOql+MuLZou9J6qqDNn7XeS5PvRtCzFVBgFkQe2mTqFPF1
         /8TgR/EL61tixvIcnj60F1x+T52t1Z5Dq89ujj0CeS81P5Tp5GFRiZpHfT5CfWrLIMPI
         8ilYWajmafhZ9ApFVUC7nQMKjW5KFLx1s3a6xW8SyIFXP6/3uwfAo9kIeZV62D2UFwtj
         Gyjg9m67FFr/b17I6lD9M3Xx3t2mM3eB/H424INuBzSVlvWTda+Rba8YJhrKxjJMyLNQ
         44uHryhhfDLlHSuvy5wLeDT/zn26az4M4ftuDDgfSEccrqUy57QUNKkNjFz9v92dxPqF
         v/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz+7OFFREpast537KCFDjHJmGV6pS0M9a4EH0Wv3O5Ll+qqoxIpU4/guZdhW+qPVusg4BZ3ZtlW/xTLcw=@vger.kernel.org, AJvYcCWMBF7nHZItDDzd4qkdnQdClKb0zDeQC6WfGrxSXcJBGlt+biZEuyqp4aYMY2Etp85ZsWeYud4h8eMnmZb3@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdGjILCeeReKvafBEoAIt9MoPCks9iqTxvEGpstec3ziL54eV
	5g1Q6xexfTMgjv4z+2n3qQgy2oN6ER90/qbI4gNPvAoB6A/wf9BC
X-Gm-Gg: ASbGncvLAiolICybwvVMNontMpdAEMsvgxMZUpTjbaefn0Dr+PFfMr8aehM9xD/qw3g
	sZA68pxDlde79TjtDRn2lm6QIiKMOJz1k2pgWPvl8hCeef+hgLfB72rxioKwhZFFgqzsLnR6V+z
	L+95Yrma9Av6iJ3eWllNCkqQxoRkydn/6TWcT8K15YcnUvBLPeR7WYzD7AWDWaZufaaeUJ7/9cx
	SETmbzMNEjC9xzPwpnCEcsPvHTJ7GBe3G1iyu1Eb9znxRiqxLQWKvIZEZOeBFhy0V8KoJBoizGw
	1dlVyUQGikWFS5ZQVJRClUYD1wx35hgqJbkiauZuvE9/6Mzb0HlKPZc0HAj8IucVtEXabqNEsf3
	BFpkgc+MzpnChUBFxt7ssVaH2gQ==
X-Google-Smtp-Source: AGHT+IE/9aU5DXDSbNLr6CpVc3OhmADZ8TZGgoBnPhuMD9l4jDbW2fGVkGfWJrE5J2PwPPFItN+9FQ==
X-Received: by 2002:a05:6a20:2585:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-1fe4300f7d1mr26494791637.29.1742900471815;
        Tue, 25 Mar 2025 04:01:11 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a27d9a13sm8842971a12.6.2025.03.25.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:01:11 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH] serial: sifive: Switch to nbcon console
Date: Tue, 25 Mar 2025 20:01:07 +0900
Message-Id: <20250325110107.28570-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84sen2fo4b.fsf@jogness.linutronix.de>
References: <84sen2fo4b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

On Mon, 24 Mar 2025 16:30:20 +0106, John Ogness wrote:
>On 2025-03-23, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> Add the necessary callbacks(write_atomic, write_thread, device_lock
>> and device_unlock) and CON_NBCON flag to switch the sifive console
>> driver to perform as nbcon console.
>>
>> Both ->write_atomic() and ->write_thread() will check for console
>> ownership whenever they are accessing registers.
>>
>> The ->device_lock()/unlock() will provide the additional serilization
>> necessary for ->write_thread() which is called from dedicated printing
>> thread.
>>
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>
>This driver has the same issue that the 8250 previously had. The
>->startup() and ->shutdown() callbacks are called without the port
>lock. However, the sifive driver is accessing SIFIVE_SERIAL_IE_OFFS in
>these callbacks and this register is also accessed by the ->write()
>callback. This needs to be synchronized.

I see. Thanks for pointing out.
(I didn't know about console_on_rootfs() and what it does. Interesting!)

>The related 8250 patches fixing this are startup [0] and shutdown [1]. I
>am assuming the following change would be sufficient:
>
>diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
>index d032de6199af..1de1b2a5833d 100644
>--- a/drivers/tty/serial/sifive.c
>+++ b/drivers/tty/serial/sifive.c
>@@ -564,8 +564,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
> static int sifive_serial_startup(struct uart_port *port)
> {
>       struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
>+      unsigned long flags;
>
>+      uart_port_lock_irqsave(&ssp->port, &flags);
>       __ssp_enable_rxwm(ssp);
>+      uart_port_unlock_irqrestore(&ssp->port, flags);
>
>       return 0;
> }
>@@ -573,9 +576,12 @@ static int sifive_serial_startup(struct uart_port *port)
> static void sifive_serial_shutdown(struct uart_port *port)
> {
>       struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
>+      unsigned long flags;
>
>+      uart_port_lock_irqsave(&ssp->port, &flags);
>       __ssp_disable_rxwm(ssp);
>       __ssp_disable_txwm(ssp);
>+      uart_port_unlock_irqrestore(&ssp->port, flags);
> }
>
> /**
>
>The fix should be applied first (and likely Cc stable) since it is
>fixing an existing mainline problem.

Ok, I will add a patch in the next version and cc stable.

>Your patch also needs the synchronization. The ->write_atomic() callback
>does not use the port lock. However, the uart_port_*() functions also
>take the nbcon console ownership, so they synchronize against
>->write_atomic() callbacks.

I see, nice!

>Otherwise, this patch looks good. If the ->startup() and ->shutdown()
>callbacks are fixed in a previous patch, feel free to add:
>
>Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
>to this patch.

I'll add in the next verison.
Thanks for reviewing!

Sincerely,
Ryo Takakura

>John Ogness
>
>[0] https://lore.kernel.org/lkml/20230525093159.223817-2-john.ogness@linutronix.de
>[1] https://lore.kernel.org/lkml/20230525093159.223817-9-john.ogness@linutronix.de
