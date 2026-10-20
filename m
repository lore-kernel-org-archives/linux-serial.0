Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460450;
	b=xZuH8sopUq8xlz09SOc+A9LPNLfDJZOvOB6MtHtEM3xeLV5VSU9EjYoWe6V/z1PUrt8j
	 7dKjLm22wwvZ4VcjMsAtI8acHuwsub/BbaNr3s9F5Y78k+kndAHSe3dttemLttWJ25ctC
	 5Q3mkdnHqc6Hrh4ObdD1uvqbi88vze13EvtbxITlqz7RmhOAGAyUNGB06kre2sRPCvmoI
	 FfeEDVhjWwePlPa78zjTLq+VsoyVVdlqgA1WK+V9ydD8Ytc8W+8QQeIyhrx0J4Z9HQiME
	 KUYIZJn0jmJtaMDPjsgPZMdVVGiqJ1S41Ywo1bwK3d/GLws3I1TVIzNwgm4N70mowYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
	b=CY4WPRjPscrDn2K/XPgyWGNqmoTHvuEun7f/bEV0uYgMN0g2QFfmlNXd+Kt/pmRNHcmO
	 ANmhc+7Je1bAtnwm5uCVqPv7L9jFy/I4X8B+9mLV35Saseve99BQnJEybc94zBiHyMfS2
	 f9MBTWMou7wPXS6tTgw/idzKtT+tql0l0rkSgjrOE85RDx5fi7ugrA0EH8AKMuZ9fXggL
	 TI36utIBkmaSE8dRCAJFYsDvEhy++4DHFXXvs5gB8qGVNldqshCiKBlOZsP3CH0leyRYn
	 0bN2ZuMUmuPuCJZVzh58ShuMe3O+ejlOENhNXJWpEdSoxNoSGpZO170JvklBjKtSnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yw62Pw4s;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DD606A319
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 01:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516DD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yw62Pw4s
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so7153593eec.1
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460449; x=1793065249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
        b=Yw62Pw4sArCsnM4IdWA5utZbwB57JnrIB/2ksf13OnirkbBAHxX5H6BkW38Rzv38V9
         Jin482MenoCD03jbOZlXql3n0wYe8AzMAabGsmL3kspaZexEQrB1Z/FIIjVVaOLNSFMV
         REXeQKHygLmkr1iDNCPmH/vWXmy40RIxqgHqjWwBfnqAJ+tVBjH2Cza0VX9bb6OubqNu
         J+VoR4I5sGLm1KHMh8iKnS+aFN3TOnDt7AkFQRiqD9Uc5+gRF0fKtaaTiVl2T8hQycA/
         EkdF6tf9SBJreYCotdl8RwOB+iUxY01relrAtgBZBt8B21DI3/sXa9ZG4QOUg6yiKNDS
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460449; x=1793065249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
        b=gg4IkDqfp89iD3xHerpWmpE8Tmh558waAMSUZ976nHar1EP8n6+Mz2A22+064ICHqu
         ljU+qmLpf+H4N2b8z/0kahlTvh6Ir8gJycOprJI571NOofOf0YZ5u0BrHF137IKpcKWw
         otvMmbfQjWhVhNeuvvPM8sHAriIiAWDkuqMzcgYhtmBGHjRqwS/tBFkzAqOHkgliXYKe
         ftoK4+MjxDDKjff2JI7Lx4gzAN2PJCvTT1wy8F2zZuL8x1W7Q63pjJ3Wq89r+s+5gF/l
         8NQDRjuLM9QPhv0sBh8zFfXOl3QqMWnmx0mpWeFY1OYcwsqNEWvxFFyKEnMp9AVEciwC
         +mNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5wYpqL2gu06oPYpPzaXGo3GqNTCFa89HeGULPrbKA3CU1Jhu0+dq3lvFUn9ePTD0Xe8GaclTthvDLpW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrCXwg0rpQizrUleu8J2tX53IlXBkKuinqrvVgpsfxlSSvJa4s
	bvDYuRjBvsjWcn2u75qMtW0AQaYMAsWe3eEqB5OuMyRDsYUoThbl7R3i5LOCsw==
X-Gm-Gg: AYBFou38MIjgc8eT25ZSleQA+fAlNRttroG42ATpVpJavUjxt353IZRVc+3WZJornvV
	z3WD4PojJUcIi6BCmmIfhTu3HuiROj0RqlZuAisiMUabh4QrWbR5UNn3s16GOpWH6sKW0ct6dOR
	pg+98SCfrL6bQ+QfvoujtNkraFEEtbxPo/EeuxbgFd+vOOt12jJjMcZ4Cj1fsEPE8wZqs3fYJg2
	NCiZ6VqaHkXOCZtjxeXPvysZaaBWHg1gV6ZuUurQqKpBi0fDulTT/88xayq3vNPML8Cck4eUlk/
	mwXis7Ryyx7xg6lXDAly8qUAFzuQda25FlUlq+SJ7W8YGm/n8miWjj7UdIS7KX6w36WRJsL39gV
	jByJvTm/z2IMRQGUkvbCtXuVpyEDOaaeIXwRwmg7wzPmXZzil1WLX0Pyisrg87ZOMo6QC5BVYy/
	OpZKP/t1JBQX2Qsqfv7LoGop3VEh/OIF+5Vpk65PVLv/AAigi6XtenpHiZGG+jEovcz3ly9ge2v
	/APBPuzMpLp
X-Received: by 2002:a05:693c:810f:b0:353:7d17:9a86 with SMTP id 5a478bee46e88-361a2549c60mr14463175eec.26.1792460449367;
        Mon, 19 Oct 2026 18:40:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm36078733eec.19.2026.10.19.18.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:40:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:40:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
Message-ID: <efbbf24a-59ec-44c7-8738-13242c7cd90c@roeck-us.net>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:01AM +0100, Ben Grisdale wrote:
> From: Ben Grisdale <bengris32@protonmail.ch>
> 
> Add a compatible string for the Top Reset Generation Unit (TOPRGU) and
> watchdog timer on the MediaTek MT8163 SoC, along with a header defining
> the reset IDs it provides.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
