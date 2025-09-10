Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530524DCE2;
	Wed, 10 Sep 2025 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492817; cv=none; b=oqKqGSLdQ2eqDq7Yq+FuVVKAaX4VUdzCBN/ogYa/5BBSm/O375176MItGS5i8xWTEsBTyxYoK8MO9xX15s5RN/WMJNWobwD10Eaisqt5qfhar2jT/ydcrlquNL7gk5Q3IOLDqqZRiebAAK9AjtGlkFdSYy/Qj9Un2qEca/qLS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492817; c=relaxed/simple;
	bh=9mx+Ut5pCG8Ht/qDJKuLcqdJYQ6qXk7RuykxdkN4zc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXdm966Y2wgGdArqfyRp74vcyzylE2Huq31pJ05Z/jpCF6zC3f7/3vHnpdcvC7Wljn11bHjQvzcXL14lsDaIWZ67omZub3l8yrW5PTstGAS90UvQdpHy/4GVwyoIFY0UiQ6kVYThF0BnZZRx3xMfeVFE/jS8ltvA7GY1eYJgVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtMG9JxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtMG9JxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0544DC4CEF0;
	Wed, 10 Sep 2025 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757492816;
	bh=9mx+Ut5pCG8Ht/qDJKuLcqdJYQ6qXk7RuykxdkN4zc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtMG9JxMz/LHNBxdYwBykKCFq/uh6kCpEaEMFlRFEcGWS8WgQ+MDMMbK6hcE3NsRZ
	 MnIM7CjGHUMhwf09CUCgEdTBlpfzEY6FNQlnjdxxlLUS7p6STggl1rxUJJDAvuCr7R
	 WjLHBe891j/Vn7//3wvFZ+mcnG3OfzjjTiJmhEyISCy6TjD4aNddTTv0X5aSO4x3CH
	 CXkwTQ1pnEKOS0WidgjANnctsdfc09ngzfUDPbPepoLVeFsy5uaUW1YBPqVnpiocT3
	 MMDnW2pqqOcSfaErLpxX3WgkRnfhc5UJuvCKj83Say/qSav9lSUh4+EVZQZaO0lYRk
	 /BSL5fFnsnZSQ==
Date: Wed, 10 Sep 2025 10:26:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: serial: Add Loongson UART controller
Message-ID: <20250910-rare-vigorous-woodlouse-e2a1e7@kuoka>
References: <cover.1757318368.git.zhoubinbin@loongson.cn>
 <8575ff2d46b701950b1b0da3d3c181db331f79db.1757318368.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8575ff2d46b701950b1b0da3d3c181db331f79db.1757318368.git.zhoubinbin@loongson.cn>

On Tue, Sep 09, 2025 at 08:11:18PM +0800, Binbin Zhou wrote:
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency: true

Device does not take any clocks, so you must be describing link speed.
What is wrong with current-speed property?

Best regards,
Krzysztof

