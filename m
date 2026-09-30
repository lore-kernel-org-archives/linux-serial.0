Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E913C3F7B
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763521; cv=none; b=ZR6KRBmyQOyYYiBbDg1FP2r1N01/HcsDifXB1hETnKmIFeStcCA2WBwlPWtqpDJ+tHIem1h8ltqk8eGaOCQqLcyjrw8/ooDxoH9rY1AQP85AGSznT6B2Cwo0OVhFJbC82oARAmCeobeSI1zlxkQAC5LI3mSaZgi3A1E9qlLDbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763521; c=relaxed/simple;
	bh=vKCgEvmzuqdNYv8cvhm72vtRBBD6mf+wxSFZ0lP7EGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVyyYiqG1nqEDYMGXlTsX60u/YNXEdUxFkR9kRooxmk8HQC4hq2FwuQrEi7ygGzSCYV3jua8KEx8yW9Tigav8Yyqudm9jFRuP84T4/UdbGOuRHVru4OBLVUfyvjprO7jDK+rq1/TlF6cfLqRNtb9yBd4aLwjyocmZosEkMWdbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f558thlU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f558thlU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so38228745e9.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790763518; x=1791368318; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKCgEvmzuqdNYv8cvhm72vtRBBD6mf+wxSFZ0lP7EGc=;
        b=f558thlUhtGlo5ZBGdjYqF/f1WSQeDunDQlTVmZLXUOwnR4SLAis0l6wBS+cn7FVUC
         kA+FR40U6bUGLrh+mvimAmzX6wOBbj77M67HuAdvDhqggRHMr2yriYkghBSyF9rV0vts
         jrYG5oYSXgCSn19pZq8u0+rHa9Tp10fOqS+sHejI5WIe8HRlgAvAiBgoiWd53SrsHcq9
         M4vkxf36ZCcwT9IxP33m5/aNnQB6eWA/vx7AUrH+07uzfxYX4dPVyCkqAzpezcsKHIiP
         PgRJo/9ruEbZc+gYBwzPPvq7bfaD8QtWEMSG1pzMw4irZ/LgsPC2bz3Xjf3ic/q3AY+c
         4pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790763518; x=1791368318;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKCgEvmzuqdNYv8cvhm72vtRBBD6mf+wxSFZ0lP7EGc=;
        b=kZ58I9Ch0iVzZPdsPjfFC8l2ZfRQWFFKYe8Te2s3MwUB9fvs6yhY/mi+DuFVte7ylJ
         7XjGEATzymCvDj3c4SSUr7HMYy8MqEhmyT0JDtWcs8BAt2SMdSJw3NIoIbAFev0J1M+c
         5QD2xogDWKy4qv6Ja4etHpoKMdHcqbMXT5lAMZBMH+7QCptYRK8XdLRXqPoftVS0a2Pp
         zP05llcONoqSEFz+vFOMcKeOGYyGLBdxDwk1JFv0HOj6y+ALxR+sLxO9aLWQYXalmwsW
         gTTzrf6pjiYMJ3COqW/ONVNTGqM9s6oawyC2eRtXP9DvCB7OvwMZu0QaILxBdG+5e79d
         ygxw==
X-Forwarded-Encrypted: i=1; AKwUvBw+19bSkOJjsirFl+t9b8IKyv+tId8Xezr6xUihHcBwTTWQ9QlwjyI8Nc7KE01YONKT4MXnAqxhGsAbUVc=@vger.kernel.org
X-Gm-Message-State: AFuF++mtTJvnfEOMozFNqUe+6ofFQkOTVuq9D4Kc1a/xIOktwUBixO+s
	B9fD0pyKlcHXJ2Pgu7t7PQbKcbwjV5UFADljyKPG1TjqQtqcugTcQARD
X-Gm-Gg: AYBFou18JR/O6cNdAZ02pd0eJpLF0oASQsW+mfCDn835klib3mBUXCXiJkHfzRkTJEc
	Sgmi1nx6KWIMnDMX0Oab0N0OCsNW6BkTw2UpAilQbJiuW3o+tqOGOGHAMmKd9U6flg45KfccSbA
	YXZfW+is8kLfFwceX2sMUuRT/+JZHsshdOgXgnlOQN8nF1tWW6AeWn+mN1weIj2U/tQD/k/TeBQ
	eRbC6wBxkALM8h00VrPziNiMRBZj4NEx0gq7wmo9PjQ2WUYGb7GKAmaftaA1T12H64gA+d5bYtb
	DLEzxjtDApuA+0N8dduZUoKEQSPTK96DDcnEk9lzRa2w5OY64Hb86OVVbN/0Df02u3aQUhyakR9
	L92EBYTAORcw84yQ+Ngyc+FR11+tqUuDPsgPOc9C8yMn5Q1ztUWTwx73pwSkTBC8HRa3d+MahBy
	3Q+BJhK5nj2MAX5mVoDxIlMQJNYBAvCgWvMYAwR98VpwOZulFbcxCXLAwSGHguaEEc5Q705ll/j
	JweBoFr5ixd3ss2Uq+MMAgOCC34Qntf
X-Received: by 2002:a05:600c:4f4b:b0:4a0:35c:8953 with SMTP id 5b1f17b1804b1-4a01afe8499mr17900545e9.7.1790763517873;
        Wed, 30 Sep 2026 03:18:37 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a017468b10sm56852175e9.0.2026.09.30.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:18:37 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject:
 Re: [PATCH RFC 04/10] ARM: cortina: Add support for the CS75xx SoC family
In-Reply-To:
 <CAD++jLkXyh9ujjFEE5UwpMnj7Ykgb5_W+Mp-YXBakn5Q=_vj1g@mail.gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-4-4617c4463529@gmail.com>
 <CAD++jLkXyh9ujjFEE5UwpMnj7Ykgb5_W+Mp-YXBakn5Q=_vj1g@mail.gmail.com>
Date: Wed, 30 Sep 2026 13:18:34 +0300
Message-ID: <179076351495.2893601.12682235689198768135@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Wed, Sep 30, 2026 at 12:11 PM Linus Walleij <linusw@kernel.org> wrote:
> It's a bit weird to have a mach-cortina when mach-gemini is actually
> also a Cortina SoC.
>
> Could we call it mach-goldengate?

Sure, that is also what the vendor kernel called it. I will rename it
to arch/arm/mach-goldengate in v2.

Should the Kconfig symbol follow as ARCH_GOLDENGATE, or is
ARCH_CORTINA_CS75XX fine? I would keep the "cortina," compatible
prefix and the arch/arm/boot/dts/cortina directory as they are.

> I am OK with this because it's not like we will add hundreds of these,
> I just note that ARM64 has abstracted the spin table handling into a single
> driver used by all such systems:
> arch/arm64/kernel/smp_spin_table.c
>
> But implementing it for ARM is probably overzealous and just a waste
> of everyone's time.

Agreed, I will leave it as is.

Thanks for the reviews,
Fil

