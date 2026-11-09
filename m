Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241302;
	b=nVNsc7fF+X+H1pZSwK1XQ9hj+7gT9hjDQq18+TGzg1yxgnuS1SfA0nUxfpyYtM+LdBRu
	 voPKfex0/XeOirwaRWgYQvtkobhk6/aG1EO/27W3f+1hfxB9+uwN3LsKF6jhDxa9EScu9
	 VFh53HytVkHWlVzHncVvkI/0fUTaWK9/tAidBwwAK/PUYl5/Zg93XFzLao3CNFl8G9pVb
	 3/BvkMbzMw/CEC3EoNjO1uqxYwus+fBWacLFwB2n00dKW/d5/48Rgzs/ef+YrcOvV4z0G
	 +y/Yr3R/88rEp5Q2qiy+2dyq+J0hQ7kiE9ZI7acXdynlAUCmzIoAcNmM5uKdQMzoVZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=O+PcwR0y+/ts0U559gvZsteWYmvpsZxTpILNrtW3Lw9XZ7I/5jZfDw6u/PyVsUkgXVJW
	 7jQ/KT5dpZtK2gEFF7/adXFXNIKMebo1H1z1CNKZpoYiT8yFTCrNyIpI45+D9QjQm+GXN
	 mCQmXc7aM2YxYL60x/2vE4aZXFcv6geTnNOpzbg74ncCAQYD9kMOH5UGt4oWOJY6gMZ0z
	 aMzq1DOCUeuWfD49G4fHr1QgzVig5hXrab6qASxaJjDYuKpvyH7MuNkpyHsnxhlyI1jhN
	 rTDDJ3cZrABsWq5EFto4QmZ1hvpbGm417IH0FpkmZRLsY+kv83fimMCypS1SgkPy9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BYUY8iUp;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90328606A333
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 16:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90328606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BYUY8iUp
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48ed0b68895so640740fac.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794241300; x=1794846100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=BYUY8iUpoxJgXZvZRp6w1aavyM9A0ceNhMCb3GG+Imdaio8Mv3jFnLEGzoeNCZ7p5N
         g1X4197QMDdpQQ5f/IoXf3xJJx/VNN1+ADO+vIkqjpfL6ZUs43s8PLxfE0gWS6xHSJZH
         AJjMa/9vyARtwnThslbLsg0L+IG7+amY8DQyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241300; x=1794846100;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=KGnk8bv0LQ4US5oIQBLftSTPZqe31Y/Vj1z/8FRUJkoCTjhjIluCnqnXYe/e5yB/K6
         a7V/i7k5B5W9MBnGUAeDZHdun8V8El4LQdbZNxGBIGK8LHGhYysVCZj3Q8Mpx71MT9KO
         C8VWsMTF9ONTiLlxXs/bLnl9ypoNP38fO1VAWcbyhSt0OsHPFf4ouWN8Q8b8My19xAUm
         PYBNgR2rpd0uPemsdA47oUGlGz5tGHsQlNlezqEER1JCWG9vXNpv6oyqIu/xpqsidTmO
         hE/R23zBHg1Y1qBxdTFU1kVjnjExrfAKTkhu/vptYVf53m0Hy+KYMHCDfbRuav8Y7ZKK
         tBNg==
X-Forwarded-Encrypted: i=1; AL+hErFMtPMvWyO9X1EvHl7VLR7SYd1lDMLVs18yFz9JCohm5SwPOe9WAzE0t6J4RhgiAwknyiNpdzqJ6z8oEgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BYucXn12r+msKnE2FM3qZ8hg3C3U/BRAfnz4XjJNKuvg36wTj
	AI67gYVH+8/9dXiJCtGjHWqM2kq/ETWS0TPzAWear9rUO14R05wWTvVCjJkFRTAUyw==
X-Gm-Gg: AYBFou22Fm9PxY0UCJFLiLjjTpDNrt1+e4dLwepnwha8B88AxE1QIzyhJm1dtdOIcvo
	mqFa2p13mCGQ59wRvgXOacK6UHw+dngb2Uc4X1/qX8mKrc58Pc/84MnAb48Xm+bGgJgMLud15ZF
	on0359UYrGriR2Y7Tt1X1U+7uoJbIDa7rs1mDcYL7cR3W9CUsXNJSuMpjmLtYT4yxq67Hw9yIe7
	n0NJ4/KWjsL06ZcwlrZM9Ne2qhoP8U88K5zQ/DzCSTmEtedapaZegOdx2umS/FyvO4DOsbzqjvF
	dyuH9/pt9HhIEuPr0R5BWjO+JdFzL5An4axx5Lw8Kh1onRipYMMw+z14v63Wj9bteRa973PlnlR
	SwRvnrJju27R0sIyNntbxQLf6PasAttYTjTyv/lW7EcKaZy4QFRu3KnBuinxj2oEP43hnYL+VgE
	1p3xHUsnjUPn2I1+yvGDezk5L+PfzgqY0uPyAYbLlVSRLzXHdyFYKjKz3LegY4hpFjNunVSHZkd
	nuMIbzKoPvFwKUaAD4FKd5nV7OWtwb/sGvI2cvek5C90/rhdWRZu7AwoYpVn6ItDpcPWq+87hde
	uuLBX2x70Jmfx1YZlPqAZOrguONiPOatzNruY40GKYUt/SlwToG3CG3FwEK8iydPGEr/i52hDht
	yxkuxDgY6q+nwylIv9MJzrH1Tk7vCD8ywoAS5
X-Received: by 2002:a05:6871:3321:b0:4ad:2386:45ca with SMTP id 586e51a60fabf-4adecba6a5bmr2379052fac.55.1794241300604;
        Mon, 09 Nov 2026 08:21:40 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade694062csm5510676fac.8.2026.11.09.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:39 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 8/8] serial: 8250: retain DMA resources when termination fails
Date: Mon,  9 Nov 2026 09:21:35 -0700
Message-ID: <20261109162135.906262-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com> <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
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

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
