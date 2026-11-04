Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789980;
	b=IRa+vecje0Nj+dPFWm+fhJ5FnSSMRuwa4w8s3FUxPsOI9cMuO9IMfovLDeXmYzUcFJNQ
	 6GtxjFjRTXKutFasIbKK2fJL66cX4qFBqZLwvB2UUIfbp3HWIZiLMhOGy+XN/sSPILEjH
	 hkHOlwBaFnTHE3siqdgCUUy67EEWnHYAVZXn13T7T4KRN0MY982ve5r/pWcizpd6X+ojp
	 McZC+qIu9w2pYATBp9oz+SSp9Xxya9SfrIfdGWjJAmkNcP1Tz+RJ2z5AtEZDhPrG8N7AH
	 XgF2SmqOmyKdOb+AGBMes9Pe/gfLNXtA4gAfXuWUW6FGcrYH8MnT0r6BJlzqW4UixFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789980;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Awio7RId/8LME8MSZg4JrTdUAU4hYKWNdYybYK4ASqU=;
	b=iKIHN+DT36X0MtyVpIswp132Wz0nvG2ku0vgS2I9zOP4QTdxOgUxzQ2u03d8bAswZ432
	 1gnC9aPaNUcycUWAw8IcozLqCJzYLELWfWIP+XWnhXWd41si9I7Z13K72NQs9t3pXnkIp
	 BOcF8a77uvTBHqtS/4H388rUP//jJn7hNifIDrP64ZJWiyMjAsEFT2xX2NvpXKBTvL7zY
	 GOUbYrK54pCDCxQTb4knRL4YZANSweUVKE3DqKbpqZ9NV3GCZfjY/Gm1Kn5M/hr4kCRyC
	 KOAtAgxbuQh5jwHmcgWp1nk5cHBUHn4vueoKftufy05bLX4MTfk2Oj7G6mbQmT3rqCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="b6/VbMmw";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE6606A330;
	Wed,  4 Nov 2026 10:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76AE6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b6/VbMmw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A4222EA;
	Wed,  4 Nov 2026 02:59:35 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07FDE3F628;
	Wed,  4 Nov 2026 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793789978; bh=O82otjfYbzrbsMdYHm1dg0YttcpeVMXQMdvlI0lqyik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b6/VbMmwviI0PTu9dcW3SXxOUx6kJ9Rv3QIVBQORpkIxWz3lxrsQ69NBzPi1nnHWN
	 LRgA/d6cItBHCkFCYPGsU6RCpFmPu1J6VNpcyANfbxbCbWHVLwH688T5a5Ms7sKhn+
	 VMk8LTzzxBPKHpVV88xeJ2Psg+XDTk3ry6uDueLQ=
Message-ID: <32461e0e-2512-451a-8eca-f2df63553379@arm.com>
Date: Wed, 4 Nov 2026 11:59:34 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
To: James Hilliard <james.hilliard1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/3/26 22:39, James Hilliard wrote:
> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
> 
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.

I think we should not focus too much on single SoCs here, all the 
Allwinner UARTs need some care. We should have had SoC specific 
compatible strings (plus the fallback) from the beginning, but we 
didn't, mostly for historic reasons and because it just worked (TM).

So just from looking at the Allwinner A10 (the first one really 
supported mainline, since 2012): the manual reports a FIFO size of 64 
bytes, and it has none of the DW config registers.

So I'd suggest:
- We add compatible strings for *all* Allwinner SoC's UARTs in here, 
regardless of whether we currently need a quirk for each of them or not. 
This is now regarded best practise for DT anyway, we just catch up on this.

- The FIFO depth is all over the place for the various SoCs, and most of 
them do not implement the CPR register to announce the size. So we 
should use the already existing generic DT fifo-size property to 
describe the size. This is the simplest, yet most flexible solution, and 
avoids hardcoding implementation specific values in the driver. And it's 
friendly to other users of the DT nodes, be it U-Boot, the BSDs or 
whatever else is out there. IIUC, that should already work out of the 
box with the current Linux driver?
Since we need to touch the DTs anyway, I think this is the best way forward.

Cheers,
Andre

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index e2ca126d58ba..fc1289073241 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -60,6 +60,7 @@ properties:
>             - const: renesas,rzn1-uart
>         - items:
>             - enum:
> +              - allwinner,sun50i-h616-uart
>                 - anlogic,dr1v90-uart
>                 - brcm,bcm11351-dw-apb-uart
>                 - brcm,bcm21664-dw-apb-uart
> 

