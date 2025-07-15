Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0668462
	for <linux-serial@vger.kernel.org>; Tue, 15 Jul 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579105; cv=none; b=sA9iXSEZRA/ouQ2/Wg642Q/oyub+H9g68FGuCe/81AvqRDKTUs6cAm9oTimlDthcr+Qfi/fQiDY16dcjrdTrsqQUgjNMc3uXZ/QqoG8O/Ku9NtcRmSt1tFrZ4QrOyrUE26mFW7fvJud9lih3PC6KeD64GAJEpUaEhFQvEbq3vXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579105; c=relaxed/simple;
	bh=B1i0Jy+iCmpT+TMn/plz7n65ehc42gy7Y3dHtaF5bWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsUV/hNkQWIyvbdTSPmZ7O2x0mD+hGxnDFe/yB1242AIXlTU8jT95WYSKbEozCpGNKaJSACio1TCKqRpzfHDMjYtnDdCxyvV3j1rf2FD5HxEzIXPvkewgD4X6PU2Hr6dv2ez0PyiJGSlFqXN2ZK9dzoUUQi/YnyhwYE/K8i41+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+qaOCaF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+qaOCaF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so2767432f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 15 Jul 2025 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752579102; x=1753183902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ZsnxPQOlzjyNW6a1iVcFG50PC2MlOpTArybpzvfKj8=;
        b=B+qaOCaFm3Sm0HWodh8FZLR3fJzakOEjjy8BcWhrMsAjxlXM/qJQFmHbdluSe762Is
         xuOyuRi3flfn5XjdqAoHDJoyqGBke08wj0NxYI8ZUweuAtpVBHnmvgVfEtC19wtJ7XTr
         mv+KwqcLi3RKqM9tFD6jNjYPTsSVWO3dwv/ojPc2zCmxEjrjNL2ETgrjZY8cpV/IRGTa
         JB4F1KMjRKihuPFXgzY8ws1k3Dv3/MTrFFwUksV8pTgH9lkGzD5/KWawxJw6/gVlxgXX
         UD8Tfg55+PZNInVw9NpwrwgmI4M4dls71AciUNnXOUvXW5GYxnHTYKqVJpVqw7vkpf1d
         sY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752579102; x=1753183902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZsnxPQOlzjyNW6a1iVcFG50PC2MlOpTArybpzvfKj8=;
        b=H9cNp/hQQRF1ZxYEy3pQeqXFwzu6h1LPRe2SVONnYvTFaVK8wyX8aZEFgBKLM8ZzVm
         eeymbXyM9wWvOjgoZiw1oIvzgXihPtkXEJIdNfnclgsK1ODaQeyW/zEI8f6ZZlrp07yo
         S17Byq9VLTVp5Yi6PINV3J3lu0bX/OeB9LYaZUKY7drsfNlysAR83+nuOmfCyZVFiloZ
         jW4wRccFkzOiPLacZYM1pHOhSLu6jzqZ8yOP1VOdOzVH/bu/atwuQ6UrSwhKTig0Ew7l
         qri6tpgvbel/9ehKKu9NJIkZu9wCZpNamS+sf7h+rZhddUY8M/HpOtg9NdDfQNGyAM2F
         PN+A==
X-Forwarded-Encrypted: i=1; AJvYcCUcccZ80HTgMewDe6Et0gOBaMpoLHcHUF0hif8wpnZUVdAS2JuCwqqGDDG9aOXZ5NS5N0sWOdCgY0BWziM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzohAMxZRKnLgyFOXX+EQpAupgApArm8/rj3dNKGLr+72QTS81C
	LFXlTzIH/uvuqjMVty7wNy3+JefkwrthBRyEz10XOWfpZExew7Zre77nL05revKrV4o=
X-Gm-Gg: ASbGncvGawp3YF2pUJ+75fAW0w+mgcg0IugEtBHfNt3zt0DbN1oWTHMdZBkWCXpw3eC
	RUiExNYZUS4ZvfT3FEqypzV54TJXr5JC6QQKFknc12EG0WUWQFBj9uhMw0xXWHVAF+IdR9se96a
	7huqtl8T5KSYEjTjBCOzFxIV7Ektw4fOR+ph2x7y6b/5eg+Pi8ABJCRq5HYYtmpvQQvn4N0a9B1
	RpYTH/hasme0aK7yTLd+ZTHMUTbAo1CuxXoTMOXVmTVYrXmc7UIIKfx0NYuOB1CDXt7xZW+YWz6
	7+FuDjZAXAcscCuB2BlLC/2acmSxV+gPi2Q+07zsF0/GCRWAzM+SGwiUZ7IPWgw1lSrcRIuadh3
	3fxrzVykC4aoJEzBuiCkxmbpLoqT9FKPnuIg1prntJceZHhb0SX560T85tBS8
X-Google-Smtp-Source: AGHT+IEKhxXOiGy+rRPRZDHvcFkEUJsQ0d14+0tBKDdlW4a1Tc6Bru+r7zuXvqC8THzAs7ZRIPDvKg==
X-Received: by 2002:a05:6000:1446:b0:3a5:2465:c0c8 with SMTP id ffacd0b85a97d-3b5f187a4b4mr14608177f8f.7.1752579101919;
        Tue, 15 Jul 2025 04:31:41 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2025sm15173960f8f.31.2025.07.15.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:31:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:31:39 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, qii.wang@mediatek.com,
	andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	tglx@linutronix.de, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/3] dt-bindings: timer: mediatek,timer: Add MediaTek
 MT8196 compatible
Message-ID: <aHY8Gyo5uy8P6VP1@mai.linaro.org>
References: <20250611110800.458164-1-angelogioacchino.delregno@collabora.com>
 <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>

On Wed, Jun 11, 2025 at 01:07:58PM +0200, AngeloGioacchino Del Regno wrote:
> Add a new compatible for the MediaTek MT8196 SoC, fully compatible
> with MT6765.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Applied patch 1/3, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
