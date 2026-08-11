Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8135E937;
	Tue, 11 Aug 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432918; cv=none; b=o1+MVDFXhghuudCeD7HkUwFBe6RpRr/MrTbKI6h8g0EYVSuWd0gukvmj5hg8V73Og9xVgdux2oJgHEArZan2Lb0UaOZByj0usE2IFaxnQFxlbcdVZ62bxCnJ/pHf00ufeuZDAKbQ0c/WLLW8E5YgnA75TdOKbAt18MO/l47cKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432918; c=relaxed/simple;
	bh=C4BlUjCA01JqoFbAOAXcenXhO/0Zi4vz6MHPwMyhSE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y73n5whVZK7nCaj9Y+GKta49BpmfYlv6pUdkBD0tMCw/MECKnBfotKqF4uo+apjI+Iqb8RCccKr3Ep4ZvZSHRG7YGD2j/jNBrYVCb5ptZrmlANLI6PMeEqsWIVxNNPlMyUNy4Zgun5tqGUulbxP8Ae6OJMpNWebKWjtOnRnrpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GppbUJdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GppbUJdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E6B1F000E9;
	Tue, 11 Aug 2026 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786432916;
	bh=fJrp2lP78WejqmA5ykH/0Rz2m9xseUC7aB4NSSNDAzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GppbUJdKPvXNm5WgT6J2T9PZJzgvpKMoLhhnPc4dy4yR2H/D43paHg1ocPmjo6FSm
	 dmTBP8VkWH0yLjwGysOrdAl/zBl9HabhF3+d4FhU/gmQ9vL5uNLHrdwERR6XqfMemZ
	 Cagw+9hsYH2Mbwnc5LCl4MNbhi9uxjlqdqJKzchnRSNZK58+n+RkYHzkJp/sCwwWeV
	 zSsIvazWPenHVRBS2qbpyQo/GNDBYkcRFTx/M0oxQqw10uyfj/bjdtj3X1l7J7ljvN
	 wZXSYaKNU1P7lwvVHB43yQdO784bNG62JtgKhy/9KVDxWH3d4O9ACZXCBpWn7MFZZ5
	 Dr/nK+Z7ZsmZA==
Date: Tue, 11 Aug 2026 09:21:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, John Ogness <john.ogness@linutronix.de>, 
	Jacques Nilo <jnilo@free.fr>, Randy Dunlap <rdunlap@infradead.org>, 
	Rong Zhang <rongrong@oss.cipunited.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Gerhard Engleder <eg@keba.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: serial: 8250: Reorganize compatible
 to single enum
Message-ID: <20260811-gabby-witty-deer-e7cc2c@quoll>
References: <20260810152636.658955-1-ansuelsmth@gmail.com>
 <20260810152636.658955-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810152636.658955-2-ansuelsmth@gmail.com>

On Mon, Aug 10, 2026 at 05:26:33PM +0200, Christian Marangi wrote:
> Instead of declaring each single compatible string with a const, move them
> to a single enum and reorder them.

Reordering is tricky to spot. You mean reordered Nuvoton?


> 
> First put the generic ns one and then follow alphabetical order.

s/one/first/

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++---------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Best regards,
Krzysztof

