Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82996179AA
	for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760424; cv=none; b=Fv/fAo58VNtE5PkmKRb9Fptv2V+7Fgdw2Kb6nHrzKCv8rCgq5KbDFwSLmYcA9WFeHTbfB7/L0U0kVDFOJqD6WAPUS8chc28sUqdTrcR68c1ZS1v+pYI8P8Z94gc2GuMJmlQUPH50201gWAGGyQrHr+TEtuTd9erulKcyZcwyKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760424; c=relaxed/simple;
	bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ix3Fey0ucEu1H/CGtikyY7Ta3oCAZ9j3cHwTUTyADfe4xOPEsA6zPhuOPs6RAW8ZZePyNzo9SUPePev/jyNnQ98Ka3T9/xMCu9QxlVdfCZBfYqwpIdpbY9jdM+RWEHe6nVKGzKmNnF4d9dwG7uSte285XEAuhvQSV0ajeirPypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pB7faLpe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB7faLpe"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so10277075e9.2
        for <linux-serial@vger.kernel.org>; Thu, 11 Jul 2024 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720760421; x=1721365221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
        b=pB7faLpeVi+WDWOq3IWH+hnI0QFI+KQGUj9uO4ENgazkYZg/8+gdHfguV9/fhEGip6
         GaLl72DnNJZV4NKmdXk+sjUcAKRDt65rH5HZsrC3uS8YynIpgz6/CQGPFwcvNiA10pvd
         m7zAdOxfsoyCLsPOTVi0UCjW6zwW2fzBrjJE4xjRKsiHCT1qt5KnR1ZvdXSroJBgIn/Z
         qMlY6S1ufdNYC+pzE6LLcWHjT/YAmRG3mHPk/Ta7MTjx53k+rK4a7EVwAKXDCNvCcOjR
         1fxomeSf7pKaWfryWiEU0fCCdBdIyasWkS73BE4TRtXjEQTgu8tuzDku4k5V1QYnMrSX
         mD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720760421; x=1721365221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
        b=Uv3/yJmWMZIDL7YPiwIbpiKKQsuU+DucDiN3llydh0wjzXp6nnQkyQE0iK5j65+Jn9
         DicuPHMjlGWK+bM6MB+RvsfUDBFcDok/GwHM6rMzhsIzT3UM7cHP3AY7QyW7qTHzeldI
         Ywdi7zIKhDBWu7dp0/SjZ6TY+QNAlJ4lqElWKRX1JbI3foPd6kaDhdHEZWyrH0llWT8f
         df9agKWDfPbqCifEM98AzMmg0XuArSofaoiC++XkuAR2XwXECL13iHNo2zLPMiaXgKPM
         t3ilEc+qw8furZeq92ZAmNkLVXXBexaOItz7bDTQ/mYs8S0febDFwLzP4C0HHqFZlvSr
         k5IA==
X-Forwarded-Encrypted: i=1; AJvYcCWJEG8cb+SovyIhQXxofycyqtWNtV4j1gNLn7uN8IJBXzYGX4Gmw17zvF7hxcrNkAKxPrZ/L06rFwM/h9yzh2NnJzYpKVDK0t+IoKGW
X-Gm-Message-State: AOJu0Yz5rXdPmOsOGgPyM8uyzBRsDXH5uYSDMQOXSRWKwAZvq93GEO0c
	8B2pQV1toNPwyfZwPFY/hHZd8h5R+OPbIn8Xpd7Q56N0VjS3WdWuoIHr6Io3Z68=
X-Google-Smtp-Source: AGHT+IFiYFIGKJfQyPnchd/fwzShUwNh2360VhDrC8CiwYOSi3Z+91egB0zDkeO+M7mP7Zw60Obmkg==
X-Received: by 2002:adf:f584:0:b0:367:993e:874f with SMTP id ffacd0b85a97d-367cea8f98fmr7195391f8f.34.1720760420550;
        Thu, 11 Jul 2024 22:00:20 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89198sm9143958f8f.60.2024.07.11.22.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:00:20 -0700 (PDT)
Message-ID: <74fd5d7cabfda98f578b5a4d4f4df1adba05ca3d.camel@linaro.org>
Subject: Re: [PATCH v3 2/2] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Date: Fri, 12 Jul 2024 06:00:19 +0100
In-Reply-To: <0faacbeb-2ca3-4749-89a8-6dd81621a07d@samsung.com>
References: 
	<20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
	 <CGME20240710132933eucas1p1b4367ec7a3938a39e732b3079eff6f32@eucas1p1.samsung.com>
	 <20240710-gs101-non-essential-clocks-2-v3-2-5dcb8d040d1c@linaro.org>
	 <0faacbeb-2ca3-4749-89a8-6dd81621a07d@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 16:35 +0200, Marek Szyprowski wrote:
> I think that it would be much better to check if earlycon is specified=
=20
> in kernel's cmdline and if so, simply mark those problematic clocks=20
> critical in this driver. Make this code hidden under=20
> IS_ENABLED(CONFIG_SERIAL_EARLYCON) to avoid polluting release builds.=20
> Any comments?

Good idea, I've found that i.MX appears to suffer from a similar problem,
and I'm testing something similar now:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/clk/imx/clk.c#n157


Cheers,
Andre'

