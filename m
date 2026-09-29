Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAC3DCDB5;
	Tue, 29 Sep 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674876; cv=none; b=lJDY7MTUFdIrGOp3e2LGECMvxGmcOUUv9UgabS08xnnpvVinLoKQVfSgCu/TigynkCddd47Ulp7Fhr+TjzLciVbU7oFT33GSDH0Z/C3jEAh67mClR3ki1U0b1GW4rGUGG2x3lg5J8zNv6lJztFmNWsOk//nl/mjR6a2cmcGT5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674876; c=relaxed/simple;
	bh=HU7an8528N4aiVk6J/ZynRLoCHlTKnSIrJ26K63+oLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SZ+i9SAxl6vp1GIBCtDUYr7GrLTqUVnAgY57/KbraG96RT8G4OErIEOF8PhPYiUNYpgq6P+EcgmeOtEwAOpFoLpUMGFzigo2knx+GyDwqt++VNI06PLHI+MIWP+pZaHnN1TYc942lYDebZQCaJONI++YFSs/ht5AcQ9dWQG2OxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTycSW45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTycSW45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B868A1F000FF;
	Tue, 29 Sep 2026 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674875;
	bh=wh/y+8ww4qgzVtVEmUDXThCVXr+h/XhtDr932zbuajk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eTycSW45LWX7/MF/VprD1aZhTjRJiAnwtoSIPTcvI0ixyV2lo462dvvMoGBuXePXn
	 RcHqZ96S4lKeUa+2akNWJzW7T7MSIELhVevIsTmR0R0/dHxbKkO56mPQPFzWtTBq5g
	 5HUdFlp5nEQcsDhpTT5gSzE8BG9usfZegJKCptcAxCQPRztTkyySKoFLLzDOjMYcRm
	 dmHRFlf7VVwKXPh+bPs2E7hHvymkou/rjr8QhyA0UaGCigsoYz5go0TIUmjdqh5MFc
	 ibIChelswMAfcE2R7kWD7RSPpXJzdOsUz5/jpmC5cPcxTixG9lM8YnQ30llhP/bJpM
	 TIum7PFha6skQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
 Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
 Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
Subject: Re: [PATCH v4 0/4] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
Message-Id: <179067486422.102650.10176830320558486814.b4-ty@b4>
Date: Tue, 29 Sep 2026 11:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 18 Sep 2026 19:05:01 +0000, Peter Griffin wrote:
> This series adds initial basic support for Laguna (Tensor G5 SoC)
> found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
> 10 Pro XL) phones.
> 
> Whilst Tensor G1 to G4 SoCs (found in Pixel 6 to Pixel 9 and Pixel
> 10a) were offshoots from the Samsung Exynos family. Laguna is an
> entirely in-house Google designed SoC.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
      https://git.kernel.org/krzk/linux/c/ecf6405fa6c503c34eb4e7e905957d70d4018e93
[2/4] arm64: dts: google: Add dts directory for Google-designed silicon
      https://git.kernel.org/krzk/linux/c/cf3df78629f24b40cd0cb2da74e3ea4a944bed82
[3/4] arm64: dts: google: Add initial dts for frankel/blazer/mustang
      https://git.kernel.org/krzk/linux/c/54edd8698bb1fb40c339d0cb2f15baad6993dd48
[4/4] arm64: defconfig: enable Tensor G5 SoC family
      https://git.kernel.org/krzk/linux/c/63f674fe8a0a8d6e4bee3e72f7ae658f0e9a0686

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

