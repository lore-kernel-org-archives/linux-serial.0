Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C537153BF0;
	Tue, 13 May 2025 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106911; cv=none; b=WFZBN55zAW8flcqKvEkCkyAldlTK1H3mVdr55UgKFpkCSbwndcqaV1UbXKwKDE9swDWFDjG2D9rqfhRtDOntZJ34nTenmEQ1VbMPdYbO7L/HsdgrrsM+tQkKWku5Zh+xl+OsvGVUOJhSvrvpzABpxx+xxRuyBRb3INt452yr8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106911; c=relaxed/simple;
	bh=1R0TPLV1fY4t2g37KBmzssVJEC8EiArYZCeKJFP+Ing=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxqGf/zI+Uw5TtOddHHBXqYTHymPnpgGp8cN4fLqRuxx3W1sqOMmarCyrwDmxSqXYuSir75EC87bhFe1k9olTkibShVQPb7xws9I1tSLC2UzAl8zgjat0oUvpxEapddXxIuxbSz244kciI86J+WaA0Xhb6vMOHkNzrUaX85abqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLKcBHmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLKcBHmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A6DC4CEE7;
	Tue, 13 May 2025 03:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747106910;
	bh=1R0TPLV1fY4t2g37KBmzssVJEC8EiArYZCeKJFP+Ing=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WLKcBHmJ2LebbIKzF4bNFORZx8JFn6lPN5YeIFm0z+/VzCDzwkV+ZlJQOiKZ6HSui
	 Mv29RiFDIel3lV+E2k1CiP5tB5mCk4fq6U8WvH+TcFA45UVNZs/h8RimPjK4TSPJTU
	 i1lg2f3nx37gwmA5vPEHsTANx1n+zoso6bEkFkmVud0tWuDph833aFvMzHB2r7BvvG
	 SYz5B27hlT6/KAoPPpGHnb6h/MzWxYwPyYe6c0euX+TWgN0lw6glOSO26i1GMoOVPq
	 xOuRHHQ8vzfTxSPz33YVWd1mdWvlIHzkRkRRmyy9Tn+qphwHtkB0fGpSFZGQAInQkf
	 KDKhSyZH9jzBw==
Message-ID: <6e993906-0f90-4415-87b2-77ae6dbfb66e@kernel.org>
Date: Mon, 12 May 2025 22:28:29 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,uart-1.0 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250506220004.2545130-1-robh@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250506220004.2545130-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 17:00, Rob Herring (Arm) wrote:
> Convert the Altera JTAG UART binding to DT schema. The "ALTR,uart-1.0"
> compatible has long been deprecated, so drop it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../bindings/serial/altera_uart.txt           |  8 ------
>   .../bindings/serial/altr,uart-1.0.yaml        | 25 +++++++++++++++++++
>   2 files changed, 25 insertions(+), 8 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/serial/altera_uart.txt
>   create mode 100644 Documentation/devicetree/bindings/serial/altr,uart-1.0.yaml
> 

Applied!

Thanks,
Dinh

