Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825D45D92F
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365662; cv=none; b=iu9DKIW3QPH4qiDnnOBwl9Fc6tAI/yo9VEnusRaJy4Rnh3sUKwcOOM7IYV0EAP9ssoi4i7rsOLIzDbYU5Ix+BxvMPynyX+MmGX/mnJ+OS84z+GMlcCaAoJocQzxjA1mK44SjUetHngV99x9Ez6+x4D50s4Umiw/tvUb+AUFiIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365662; c=relaxed/simple;
	bh=DEQoUozW/Cs8HCbMPzg7ZPhOKB0dfvcgpHAGzkIkN5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHNkFZnF8CfhWHca9f8ukNNfc/r0s1OMCJzljfxjbRlCHpdb2ai28GKnPEJb1uvgROCQWOxywyhFE6mNFszRvDugfTYyaA/cnWZdbWSKe6vAeAwI5VfmjvhOorIh3dK/fHFMGNoCnvc0ODnkDvAJtU2vHBKhyrlEcBayRwq4mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5hCY+Q1; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5hCY+Q1"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-989a4cab97dso257319241.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791365649; x=1791970449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEQoUozW/Cs8HCbMPzg7ZPhOKB0dfvcgpHAGzkIkN5g=;
        b=T5hCY+Q1YMRifQtJNpwfpRHJrL96eu66NyO8k/fOU6xriMjkUVzewqsf+D9cDW+g2S
         y+Z1vlokkYNXulEAg5ZorFJ5Bsd3AKNI6pOR5grOajPc9/p7m1haNxusFKr5/SGG6qIW
         DuE7xac9VE4JG34//XrBq9thtiGBXDRKtWR6lPJNK+zgcaTFW5RmJdS6FC8pfXhyqvxc
         RoGCL7KD+kO+5VWDsidVJqE1tb7RzrrPhGuIVOmyd8CQhpui/9kakH6dgM+7hs826n0O
         fOhLVQ2hjPaPkjdJ3gupw+0hwXzH97/RcnF29X9h4OSOGcCzonsyE4kbsbJpqAQU87OX
         ymDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791365649; x=1791970449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEQoUozW/Cs8HCbMPzg7ZPhOKB0dfvcgpHAGzkIkN5g=;
        b=uInoxtK6ujMpsgwbgAbBO+QhwqRSF5F1wdeFIJM6mRQt3NvJPcoKqXK5FPhO63JhFd
         KKE5qblfQqFo8XRWPqhJ5uJ8Getoxh9rWcvAUek6KEP1sZSP09SA4NVzreLHfKcH6H0m
         dNLO1NnK2LOXJD1n0NJ0FaT0IRkL4HAKxYgabTCOBoOhBhXh6JVq4MP6jMPBwbV80Jgy
         1aCqouWP9Ny1eHfm0CNLhcIqii9EX9VREyTzmxCJMOq/6dN1QRPq66ugUFVQPI+2S0Ht
         2uUSHrMHGSsDQktICP2fbz5/cOzJSOi7fbcIZIqbTbwFjOYHH3YKXYO7AdJWP+gORiXH
         O/6g==
X-Forwarded-Encrypted: i=1; AKwUvBwdq/q8CAv2IDrdMAuPusvFenUlyABW7Z2oOj63mexUjzFpGZ/mxz0pbKWAueBsgFJq0S6wj3O1ZwOoMo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGl3YUuOVlv7flsL03Ssxfu3nLNQl/MHHuoYg9WP99w9s1ThNr
	JROHc//od8dUC0L/NDl3OfmIbkzbqpu1T7vstY8T1yXvKUJxuNCfWIvY
X-Gm-Gg: AYBFou2YpXbGEyQj3Eo0Bt+EOboNE6GYex0XXnVWtP/cpaOzeN4W1Fg5KJqTcLtKwN2
	QeAER7rzg5IB9BNynPi8dIxoGXSMpllXd7cqEczR3UzI+tzrPqoY4Lhp7vArPdKyDs08/H4rUV2
	bBhsSVEYeUPi/yjI0NsC12N3gcJtG0a9jMDAIm11ysWU6HNbPCyGv0vaxyGIgkF/viQVI6rGnmG
	3UjoWZGFJrZG4V1Pq7Y98u5uJMp5/GGSdTxKnzILDSXjHNhYe7OGMAVP4nBirKDFQ9sriKU4S+i
	Gumtf+modUovDOnPFL6zaXRwffZGonJ4Bj+yw+9hJf9ZYJo2Yrw7jG/THcZ0qDCaC963KkpRTmF
	MeIVT7dfhPoIGOxkTx8ew/18abFMOVu7NjsJbSR9LOSo+jyZ56FwMUR4ABioRyGciCsrw1JlZfC
	2cA7uSxszfpChDo95qgow64f9QYjCOzaoxQoYu/cit7ztn7vmoI81Vh7V34pVvJZxPcBnoIcO/G
	AvjXInE7mvzCbLX/xTiQwNzrXGOEVL2tYHork85ZaRA0kdr44pSYb8zpsI4kMBLbfBXQZ1mNoOw
	VjCU8Xo=
X-Received: by 2002:a05:6102:2909:b0:7bd:732e:c615 with SMTP id ada2fe7eead31-7ca38e16ffamr456522137.26.1791365649209;
        Wed, 07 Oct 2026 02:34:09 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm1319958137.12.2026.10.07.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:34:08 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250_dw: Add Allwinner A733 UART
Date: Wed,  7 Oct 2026 06:33:23 -0300
Message-ID: <20261007093323.22104-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006193046.540252-1-vinicius.eduardo.pedrosa@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com> <603b4f40-2a60-4bc5-8b98-ada7a52fead9@arm.com> <20261006193046.540252-1-vinicius.eduardo.pedrosa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andre,

Correction to my last mail: the v2 change I proposed there is wrong.

Gating only when clk_round_rate() differs from the current rate is
e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at correct
rate"). 7dfae6cbadc1 reverted it because it broke the dw UARTs on Bay
Trail and Cherry Trail. Mine compares against clk_get_rate() instead of
p->uartclk. Peter suggested that variant in the revert thread, and Hans
pointed out it's the same check, since uartclk comes from clk_get_rate()
at probe.

From my reading of clk.c, the flag you mentioned seems to explain the
regression. The LPSS "-update" gate is registered with
CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE in drivers/acpi/x86/lpss.c.
Preparing it rate-protects the gate and its divider parent, and while
they're protected clk_round_rate() returns the current rate. So the
check always says there's nothing to do. The divider never gets
reprogrammed. Hans's debug log in
<20240317214123.34482-1-hdegoede@redhat.com> has a request for 1843200
rounded to 153600, the rate already set. I can't test LPSS.

So on LPSS the CCF does ask for the gate, and the disable/enable in
dw8250_set_termios() is how the driver gets clk_set_rate() past it.

For v2 I'm inclined to keep SKIP_SET_RATE for the A733, like JH7100
(b0ad20a3b64b) and SG2044 (cad4dda82c7e). The A733 bus-uart gates carry
no rate flags, so the rate calls there are no-ops. Calling
clk_set_rate() with the clock running and gating only on -EBUSY might
work for everyone, but it needs BYT/CHT testing I can't do.

This is separate from DLF. v2 still uses your 2^n - 1 check for that,
with no A733 quirk.

Thanks,
Vinicius
