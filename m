Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033940F72B
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764290; cv=none; b=bQCh3AZk5Dab1IlD/QT9pFXhpALFapBIs23PAIbqg7I6Dbd/z4UlAWJH5CZzech4fXsyP4ZSoGDDIJIqC+RAp9D3/uGwUvy6tpQ7Vd2wcgqbcXJ602hXHGbM1OpFo1p1rPga4nTV4tAde/h7/bE5SaYF50jGNUHm5+qWZhjce9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764290; c=relaxed/simple;
	bh=l76vJB//fiv5NUToi24XYVgUjHJscXal8jTd8z2f55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwadCIgpDmSoYDnjHAcC0npC7qP1w3q/O84n7q4+SSJp/xj2brET3az9Tf4UPC37yeS2+NZt0ep+y8K7jbQAD4sgESApVjEAxiNqpHftJNXk+xF0ctTXxVyyl4BGBmaZzhfMJf2jA91UQvMPRfNtBKRdBY1s0LR5lXjVDOYtFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h3XuoyKw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h3XuoyKw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso238815ad.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784764288; x=1785369088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/owFfuQW7essVnvkb7c0YaK3a70SCLv8tN9SvYhKU00=;
        b=h3XuoyKwZmlKrruWjd31K78zdsYQfqD0AkXfe0mfklvzBiUn9AZsaqBcZtXcZRrf70
         0d14oISnkUegynuzomoXusI/3zGKOiDevMrfi/86w8Ho2XyTwJGVzo13oADpITTfClgz
         0VwVrz1CMaMNdWppzur+c5M7KxlY19DKsd4Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784764288; x=1785369088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/owFfuQW7essVnvkb7c0YaK3a70SCLv8tN9SvYhKU00=;
        b=DMwXItBJT4ykmdNYm9jzGS3f+xxx6jgwJYf1Wl7ypRW9OcEdrKmaTshmRP5EXtMHEB
         9E3KdkPtEvA3DfDsKWk0rF8Zps09t4tEm8/d0hYQfBILvSGO0JK7BNnCCVc8oFDOh5Ve
         /m7vr4h8+bnbV6qwtDipUaAjSWUnMlMNH6tHp17HxtAF9OP+/MZTI/1YNuDWqHunfKoe
         FBJtCSwuCULnQtArpt/+V+XM+ejTDnijctXGPgYKWb3FEQV9KRZimhoiER1wzGpTpEAc
         f32APhwlhjOOM90n0JCpGvhNyTPArci9eZrWulhFJKQeeyZOa9s3NCHqUJRqNu47ihwb
         8P8g==
X-Forwarded-Encrypted: i=1; AHgh+Rp4f27h5cKFionHIHTBJvPg2Tdr/VAQYMyV5aFqM/BMFQHfNL/FIyFIRAgqgDRbLv/Gk9cR3af2O/W9lOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38kUF5D0bNopWEbbZbNN1AtqZtxLMZUDOEQEY09mq5l8s8n06
	briWgKYO3gtZw35WvL9U2hdGFD8OyzpFzR5ZVShXzoHa8JxygWWh7YFCPTB9rp5q6Q==
X-Gm-Gg: AR+sD12Ns7QEaL3Qs43PItIqb9JYFunYi50dUpoR+kmeRq6N8USLTBE2In6Y4D3M5vG
	/x4YUcvN7JY0pRw/hqEALUr6KcWfW81wK5hMW6MqFfimOpy8LrkCH4elVUj9/kna+QK3Ydhza4F
	JZdTlzNm1IfQkSBDghWDbR/B24xG0CQiOZgQ4GB1SA+vOc4+dnvd/yGdK6m7ltgzQB1pkkQt5Kg
	ZWO30tNksTprJevg0B6vv/GSw0Sm5QRXrutf8hu8A8rJZtKyqKFU7JOfmh2n12V9dUy331t6T8z
	sQPue3LovelxcBGqbjcmBIIlMWfwU0VXzIFrtKU3gbCwpjDe5y7H+G7QJfhp8nVhaEPLfvVTCfe
	pafAZO0MOHJMX7GVpqoH/AhinbvA4roAgTdyGbFAJhfcsCt92YWRFC+WTDE41Tclr/ihU2FvH79
	OeZFRCvXa1T9mbpiGQlIBfcJzix9zmIXc3L1HqwF5UUoYwgKiXS0k=
X-Received: by 2002:a05:6a20:6a26:b0:3c4:2f75:719 with SMTP id adf61e73a8af0-3c44cd1de09mr386413637.37.1784764288427;
        Wed, 22 Jul 2026 16:51:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f3fd:a899:78ad:64d4])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3147e07000fsm25313445eec.21.2026.07.22.16.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:51:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:51:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>,
	William McVicker <willmcvicker@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Message-ID: <amFXfFFSGfqReFWO@google.com>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>

Hi Peter,

On Wed, Jul 22, 2026 at 10:55:55AM +0100, Peter Griffin wrote:
> diff --git a/arch/arm64/boot/dts/google/lga-pixel-common.dtsi b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
> new file mode 100644
> index 000000000000..57c318ab44c9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi

> +	aliases {
> +		serial0 = "/soc@0/serial@db62000";	/* &lsion_cli16_uart */
> +		ufs0 = "/ufs-placeholder";		/* &ufs - TODO "/soc@0/ufs@3c400000" */

I'm going to go out on a limb here and guess that these aliases are
being spelled literally (with comments pointing at their label) because
they used to be formed as overlays (where the label won't resolve
properly, I expect?).

Do we still want to spell it this way? This looks generally nicer, and
won't need an update when we get a real ufs node:

		serial0 = &lsion_cli16_uart;
		ufs0 = &ufs;

IMO, we can cross the overlay bridge when we come to it.

Brian

> +	};
