Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D141F5D4
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928592; cv=none; b=gP9Cxi2921dya58X8biQnva0yxvrK0Vkier64KYJzgpOXl2WtJwpk+Sq1ZLvs0yP7/UylsprRaLhFL/Zlm3bP8rBxpNKVy8/AXuOMKO2iOPWuhUZuHHhR0c8ZNEMFXjGPhFXbrHt54FKIs3/6ZJwaDtfogVNPg4cBiC20gEKakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928592; c=relaxed/simple;
	bh=DGpTwbDIeBlS7xGbevsnPXJ7r9V5/qe6fW0JwCkuRoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDGdV/KcklDoznnpK3PqOQXqdW6vZdldkq43g9JfTDu7Ot1gbWCyQHMHA0+6inqviFdoz7Xwu8/4RLUKqW8fQn7LfMQ6g5y7apFaXAL2FtE1oeZRI8J6CL1hP3oh1UYp2E41IYSiKryAA3uMDvnJi1tI1OSWu6Heh5w2I7A2h8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nlQrpZci; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nlQrpZci"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so17045875e9.0
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790928586; x=1791533386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyfq5Z39i3Aa9ox1entG/vitb9px1bSDrzF3bMpTbqM=;
        b=nlQrpZciIERMGLnEYKazKcxNj+AfzUsfyuG9eFIsindPMqlnlficfjm5HNNxocxGOY
         wAGucdObo5WGQCzAlz97WJbAHs2P+OPfYsF4y/aXpkdo9xW/H9fD5dNwC7m9mSMWTkce
         1B6BIhgCn628FpWP9dQFAlAjLDChlYAy/w6psUFv/DPquDGVbqZcS+4WaxlFIkLjfK03
         p18rV+K24eteG2OnZvEFFNL0mTGLg2BsffcfcL5HJd0MuD+ySCIRgbJvceZVBpfzW5gQ
         9xygZb/wmhajCIBDLvOn6JEQBSjgok/dHLWQAX7EAyC8HqXidy4o4FGTiKx6d58CoBZi
         +ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790928586; x=1791533386;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cyfq5Z39i3Aa9ox1entG/vitb9px1bSDrzF3bMpTbqM=;
        b=JaEBzdu3RTigOePRAJVNfBzPBUgDZKThw2xRJ0HmYbdl/NX91giXTkQIqgvkXXPJtQ
         mJVexYhMFCK3PHVf+wU+d3N1J2WavBdlu5kcfx1D37/DUH58oJlTkF9LaZmmVaLhVH1f
         LW2SwZ2yG5U1GIPJFMbDe1O+BfRWFY6vBZ3ZuYcLimXXkvjaJYCVoVxuYAIhagkActp6
         fb3FUpJpt21GvGPkt3MPlt5zjSSnCXInjrdn+Sy50fxiNvZhtfPkJYpgHAhZdSwY19oT
         s6FB/fb5dzDJBKZicODQqGNrquTBvU32F6EnNUMcRnHmkTP0kaashu4oy4Ph9+jwb8XD
         DAuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzU4Xjs9l1KF/fVQ0waayCaifH6aOAYfwdjX9mc4pqGwUEz88YyA25bMha5cSLME6sFyuXWGDjEN8foUho=@vger.kernel.org
X-Gm-Message-State: AFuF++ktDw7vOHpeizy1h6ZjsSbF/3xl824f4bC+1WynmD17QXgqRNtr
	Cf+IXnBXXufVfo7eBS1/0ySn1kI9Ty3K0raGSUdh11BgP4atTzaz2bz7psfYf4xAfRQ=
X-Gm-Gg: AYBFou1M0a1p219/mr9E51DpbFaZRxQj6n7Hcd9YaJkiLtjN6BZ2JdzoILj4v11a3Hq
	BHOMlEHnsNuiGxxLWLefR0HX0W+nNWrQ97dDdXaIMvupbwnZrY9W0r+VYXCbpnKLll6GRffMwXt
	iey3a5dnS2G3+MYMOSjxQysUr9kSazWLCY3aH+ZvegN4GF5YD5jusHE/vot7gbk2KCA6/We7CWo
	17Y07GFAmsmadC00lS/wl6fAVMTxMmuHXbwaQwYkEJ786ZJUPYhE/na0OVgPUSXoHJMVcD3MVYZ
	X+l/FTQaem9OG1FFfwZUGn4AyqTDL0Kk6bX/vX5PDtR6cHIsm9coDX/a0DVDnh0XtoLWCquw0Te
	ZazsH02pfRrJHVQzm5lcntcjShnyHAlZXcsSacyG+OB3i/5A+qO6tlCOt+T2pgdX01KVfOkp1r/
	sdzKshka+DGMLXsreq9nQ52yZfA2tY7T/lEIzzSPlDZ5uXItiYN+FSWyZ0Vl2YGIqmc4zEDAZ/R
	JdXdakT5cazwppE8wI=
X-Received: by 2002:a05:600c:1e24:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a0275507d7mr31998105e9.11.1790928586168;
        Fri, 02 Oct 2026 01:09:46 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm38823805e9.4.2026.10.02.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:09:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: zl020895 <zl020895@163.com>, Linus Walleij <linusw@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, longzhao@ambarella.com,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvi?=
 =?utf-8?Q?nen?=
 <ilpo.jarvinen@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Lee Jones
 <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v9 13/15] serial: 8250_dw: add Ambarella CV75 quirks
In-Reply-To: <4405a61f.505.1a0fa675e43.Coremail.zl020895@163.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com>
 <2026100140-overbite-mundane-fc79@gregkh>
 <CAD++jLnv1Q7ChHuLo=ad9edqhZL8MNaMab8huMAepK_LwqVzGQ@mail.gmail.com>
 <4405a61f.505.1a0fa675e43.Coremail.zl020895@163.com>
Date: Fri, 02 Oct 2026 10:09:44 +0200
Message-ID: <1j1pa834mv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On ven. 02 oct. 2026 at 10:17, zl020895  <zl020895@163.com> wrote:

> Hi Greg, Linus,
>
> Thanks.
>
> This series follows the new-vendor, new-SoC process and is sent
> as one set, so the new Kconfig symbol and the drivers that use it
> land together.

What Greg and Linus say here is basically what I already suggested on
v6 [1]

Giving the whole context of a bring ups, mixing many trees, might be
nice at the RFC stage but then it makes a lot more difficult.

[1]: https://lore.kernel.org/all/1jld986j7m.fsf@starbuckisacylon.baylibre.c=
om/

>
> If it has to be split, the GPIO patches and the UART patches can
> go out as their own series. The SoC patches and the CV75 clock
> driver should stay in one series: the clock Kconfig depends on
> ARCH_AMBARELLA, which is added by the arm64 patch.
>
> Would that split be acceptable for you?
>

I don't get why clock is any different here. Just state your
dependencies in the cover letter. `b4` can help you there as well.

> Best regards,
> Long Zhao
>
> At 2026-10-02 03:20:51, "Linus Walleij" <linusw@kernel.org> wrote:
>>On Thu, Oct 1, 2026 at 2:52=E2=80=AFPM Greg Kroah-Hartman
>><gregkh@linuxfoundation.org> wrote:
>>> On Thu, Oct 01, 2026 at 08:41:02PM +0800, Long Zhao via B4 Relay wrote:
>>
>>> > From: Long Zhao <longzhao@ambarella.com>
>>> >
>>> > The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
>>> > licensed block. At the register level it is close enough to DW APB UA=
RT
>>> > that a full custom UART driver is unnecessary: reuse 8250_dw with a
>>> > small platform quirk.
>>> >
>>> > Quirks:
>>> > - keep IER ETOI (bit 5) set for RX timeout behaviour
>>> > - skip set_rate; baud clock is managed outside the UART block
>>> >
>>> > Reviewed-by: Linus Walleij <linusw@kernel.org>
>>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>> > Signed-off-by: Long Zhao <longzhao@ambarella.com>
>>> > ---
>>> >  drivers/tty/serial/8250/8250_dw.c | 32 +++++++++++++++++++++++++++++=
+++
>>> >  1 file changed, 32 insertions(+)
>>>
>>> When you submit lots of different subsystem patches all in one series,
>>> it's hard, if not impossible, for subsystem maintainers to take them :(
>>
>>In my experience people do this in cases like this it is because they
>>essentially dump out their "bring-up" tree, the thing they have
>>booting on the hardware so they know the pieces work together.
>>
>>Long: can you split it up in topic branches and work on e.g. the
>>serial driver on a separate branch?
>>
>>A better way to test the whole set of patces is to just create a
>>mixdown branch where you merge all the topic branched into
>>one "test" branch, then you boot and test this before sending
>>out each branch separately.
>>
>>Each topic branch can be versioned separately with b4.
>>
>>Yours,
>>Linus Walleij

--=20
Jerome
