Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF130FF02;
	Wed, 10 Sep 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492936; cv=none; b=Nc4oytsaxjUMV8+FojuQ0MdaSc2oGdtbYsf0/zcKHGF75VD9uyTLoxHL+7U3teRuI0zLstnh4QFRsjthxupzPmhuam+wlV20dbrbP8pKCmscPKrlPTDPMv946FpFzOmukq6Y33EeQ+Myw1lmz5inGd8erb29XF7/THOAdbGJApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492936; c=relaxed/simple;
	bh=Zzz+n+3XnhvvAwKjxQsHO9+m+x/oUwOy4G12ZoV2hV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNenhOEDJQMa+hWXAWXgXs+bqg9DFr2zXFxVXIYjrrcGK8YTomR6xEAr2fkL4YJCr0hu09ZYw5/fhQkw7BatJY3stoX9RWsiQtN21IbGvI3Op3wN+t+XBtX0h5ce/XHgpaw1em4JynG1LfLjSm4f/l8OYLkqvd4ESYUszR/x804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjTAPRQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjTAPRQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D654EC4CEF7;
	Wed, 10 Sep 2025 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757492936;
	bh=Zzz+n+3XnhvvAwKjxQsHO9+m+x/oUwOy4G12ZoV2hV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjTAPRQ4FDT5MZweJjJC+ihc1i5IfQyxrDV091Vzev11Tc0nP0z57Uuin25cK1zXk
	 YX6xNa73JWwuYzI1IQu9lLD5Er1pYZKPpp1FOVHrm1kMqQDLUwzpUDcRR9H6S6lyM2
	 ZFHPvb+N66JyG60wqrhp05uGe7fGFoKH2MAWZ/Bzg2X+rYqJ6nAdiPSdY9O+LKSEBu
	 juCpgf1quUKEEy8iCWZb0nfWK4YpUeBkXlX0ImM+kj5sOOpgFhAlUxFTj+a4mrUCR2
	 frSr4jnqME6mkxXQv+kKJj+zq3MsQq4CJaXVT+TfbbwUiaWqk+nHF7Do8gq9uvUtjb
	 +puGkScXW/g/w==
Date: Wed, 10 Sep 2025 10:28:53 +0200
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
Message-ID: <20250910-knowing-labradoodle-of-protection-d37884@kuoka>
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
> Add Loongson UART controller binding with DT schema format using
> json-schema.

Why? Your DTS claims this is 8250 / ns16550a.

This is just incomplete commit msg. You must explain the bigger picture
here, not repeat what the patch does. We see what the patch does from
the patch.

Best regards,
Krzysztof

