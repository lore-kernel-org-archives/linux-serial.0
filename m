Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606047;
	b=S04gU/Pv/aCRCPl0fRh2bb2HEf/91EggLnMwfaXFMm1FZ5TZyaOTDWxWWaBbvRrbc5bE
	 kNfY0PZ2CaUcgj8XtVPh2yV3zI1yh8RsWFMg/9u8iGoZdsj75OUBik9OYT3GtdVqm8dTw
	 Nq5ZoZADy8OnX9VGBWGO+kWJRG8o2jmJssJN42Bod1lJcQ7vjIbyx1IBYxly1yLqallO2
	 0qUYkPYQQcPc/nuxF4xoOCgHxPgwQlVTyKuLpbJbHrMlbsuYsXLx0emCTy6NI3qxqsOXM
	 FxM136Wd0pN2J/DQlXxN8N9vn1W/3GPOBw1By+jRvPbBp9Lf1UCm7QYD6PRLMhQ3+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
	b=hPxhPddWLfycp45HUPDER+FYggcfwmbfsUrjRzIXdEHyvdTl6ifc5E/Q2rPjf+8soS4Q
	 Qa2ykiJ90XsaEAtP1lHimjR8O10iev2uuAfAHVHK9FmL6RZ2RbNLnmUN+nRdx5cHJI4SM
	 pvrbpGcfZfTbldS4hbLrPg/NM0fNSn3Bg0RpYDZ/JUHE5OvO2oD5hnDtxC0fXjXmJTgW7
	 N0uUAkUgmSscY9wybgBetIar8xW3trX5xpfs3ugeNtkyAU2a1QMupTermqbgnXl2NjLxa
	 BCYmR/40Si/qHJP60Zo1ibfnY6HvmQZRRNfJA1NBxYwb2SEf2A0P1sWbPBFpx7F93nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmPuaxZx;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B847606A320
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 18:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B847606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmPuaxZx
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso338275e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606046; x=1793210846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
        b=jmPuaxZxGSuX2iUAkX5etUFc8l3rPMvgto8XSo5wtZwb/bT/7hXZd5zXz76Q3zTryw
         AHoQ+fHEfCnELueNC6j6PX5Fnc4K2VpLXakAFunBe+Mpc3uphKEEaJacETiZEaTxZZy+
         e2sKCGJviofNwT48s5JFb8OqqmXNunlx7Ty0tftUlJMIVauQaexhNpF67R8w8uEvVXIx
         N8dG1+T2D4Bp0ksb5ZmHMTflDJg4/I5YuUcP/iAGYZeZ0fdISC0jX82sJbCMoU0xlxhZ
         OqdwJicC/jegzyXcMpNBV17k1XuIQq3PE6tqJCnMnD1ulnQ7w0qBvYPGCkJ9hV+PjTge
         loxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606046; x=1793210846;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
        b=T1reGGidwrLkCUYBywLFXk+dbL1QYn20Y0fj0ZKahJmb+CI5xLVRVcPAszY9O48Qbx
         sOKR195DyrnJu2NF9a4bg3e6rHcEYJtGtCyE4BFeGRn0HhBemkIocU8riUgLUmOcNbPu
         Q53FRRMwCEBoj13JJMkabtbMDzMV+vPckie+VVmrnmGb8zeXeXvbn++QZAAsA20kFvD/
         YNpUZralVVwO7k17lYUJtoEb1Lv591u2QAX2KoRVRUQGgNi36VAj9bUyJtdqW97KfBjI
         IwUTt2Tp3SCEHM4RMIZc3TCykVGiv18TpbMQd109IDyPeA4d2kbOHzdUGecuBxGeXymV
         /4KQ==
X-Gm-Message-State: AFq9FYIr5IWo2XRIHmP+6nCK/7RhLLsgGPMOZYLnqcK8sbAzNADExgrq
	9Bh7BaTB/0sUeDCALJqBriDa9v0dVkWfnT+F6BM8M1U/0wdsLVahWJut
X-Gm-Gg: AYBFou3zefPzThjWM3dl67PZ8SR+0Vmxg/9XfmUkHijDUh3YC3WkdCeRLSw/PurgOBo
	g36710vY8uhTdRbZ6dk9G5CKhepJ+GCoMPDoIbErcDNW5Zvzbl3M7+woMwNcR22X1v7HI3+d66c
	Vegf4mVWkzs6KYOYCtJaeZsELVbIWf2EwrlRGq+xtrfVYQRd8+Y3p9J3wuHrn/lD06oH1sLBpzw
	yVlMEAMhH0x7SNypZS0llAHkNoProZhBXwlKk+ehcm8S/K7P9SLyKKb+IK8jIDCss+yEr0KcUQz
	BEzga4WHXTCL4T8b2TpqNBQ01n+8r9qnL1gAnYAcHbq98tAsD37lnK1S6rs1WqOojs+4glrieXL
	lNyH2n4JCX+Eo7jh+SrNS0hyUGUd/GA+N18mIkdOp1uQdFyREt1AdSACQ/iZkEsqrsko73WSyrU
	iUnjuNQrQWEBEkz9TeJxy7HYtg4UHarnROeVAeZXOeb/M/YQkJVAXiqno4Am9QxI1pXYxfhzIaK
	zNzGC8VKds02Aa1/AavVFjNPRvDBnS3BhxfU/nCSIMjuv2qefJH95vPAyffrfLpO6mAZ7CRlndX
	HEm3uCywrMxQjDTqemzXYrYkzkZUHeuvaQJ+cMxbWSGoz9gImBfbYs6rVlLfMDb2
X-Received: by 2002:a05:6123:6d:b0:5d2:4a4c:ad83 with SMTP id 71dfb90a1353d-5eaebefa0bemr1334431e0c.23.1792606046270;
        Wed, 21 Oct 2026 11:07:26 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9697814sm4054490e0c.1.2026.10.21.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:07:25 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 15:07:14 -0300
Message-ID: <20261021180714.473749-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atj0iRFTxHKmhxVG@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local> <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com> <atjqZPuAbHDdaexv@ashevche-desk.local> <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com> <atj0iRFTxHKmhxVG@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> Yes. but is it only a single device/platform affected or a big class of the
> devices? I assume only narrow part of them which unfortunately use DFL register
> offset for something else in their RTL.

The A733 is the only case I've seen, and the false DLF is what exposed
it. But I don't think the BUSY problem depends on the DLF offset being
reused: with a real DLF on a UART that isn't 16550-compatible,
dw8250_setup_port() also replaces the BUSY-safe setter with the dwlib
one, so the same path exists. I haven't confirmed that on hardware.

With patch 2 the A733 no longer takes that path.

> It all depends on the outcome of the above discussion. Maybe others can share
> their opinions, but I lean towards a series-as-a-fix rather than a bit ugly fix
> + proper refactoring on top.

I'm fine with a series-as-a-fix, and with deferring the deduplication
patch.

Thanks,
Vinicius
