Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2740DB4B;
	Wed, 12 Aug 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530220; cv=none; b=MLFDOOZPrWIx+l1ITUqT/ZlmrcyyZlLgciQzwN01WJYCH8vDHpG9o/GcT7Ptl1G5PKdlSL5JBUb/Pog3n/db3PxjY3MEP93+5lt+rydti8YTV62/ns785rO0z5ie1XAr68vj22egGscuCeyh2AM67p8sJ+48544Gtjx43qThXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530220; c=relaxed/simple;
	bh=d032UWQFAq8xtMsJpdLnWn3LUcICswtEMi6ZFJeA+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ71SRh4jNQ2N8up2gGn3CdKfDlJCtuzdghRAZBp0r/IY2f1iHqhxZpmZTgQu70Ckzy7pfSnOjR6uRl0aEo9TWDmUUVefZ9y40QGZk/RS0zAeOaEVzhzCpMSlPyq0bASNRtsGO1F/AfMmDFRMuQeo/GHGZOLLa6eY31Hbkufmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3U9tcCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3U9tcCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539A41F000E9;
	Wed, 12 Aug 2026 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530219;
	bh=BUi2G9nHcNRXpNoOHPwrF4nLR968IPIZ5NGvD/zBplE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b3U9tcCGun/VO1nx++1iH9dkYGl58KQM9slm66/cg1JkhofXO4t3cd4U/2wtACig0
	 xI1GqJ0w51EYs222AkUMMjXhn33T5R3uHVkfpzXuTVhXa1oyrzP4bKaZNh1IsqnNKA
	 ppErb+hMkRcF0V7Me+9kK6S9pBNQGc2oDzNS0Ns5OJYDl+hw/10g9XbiDKNIjLWafQ
	 6m/2gSucpmyQlqyCqqS2DGH4TP8Z2Fd3t9SfFqxwEuuJPp+0zAt1G7ka0VGWVagilC
	 o8sz6+SNR5SzrQpq7sDmCfkHys1zltu47BS6pcJsXavvEPhkgGqWwprWMoP0309I8o
	 ppYpSL1fangyA==
Date: Wed, 12 Aug 2026 12:23:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, John Ogness <john.ogness@linutronix.de>, 
	Manuel Lauss <manuel.lauss@gmail.com>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Rong Zhang <rongrong@oss.cipunited.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Gerhard Engleder <eg@keba.com>, Lubomir Rintel <lkundrak@v3.sk>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: serial: 8250: Reorganize compatible
 to single enum
Message-ID: <20260812-tricky-bobcat-of-bliss-bd3fde@quoll>
References: <20260811080950.664379-1-ansuelsmth@gmail.com>
 <20260811080950.664379-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811080950.664379-2-ansuelsmth@gmail.com>

On Tue, Aug 11, 2026 at 10:09:46AM +0200, Christian Marangi wrote:
> Instead of declaring each single compatible string with a const, move them
> to a single enum and reorder the Nuvoton compatible as it wasn't sorted.
> 
> Put the generic ns first and then follow alphabetical order.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++---------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

