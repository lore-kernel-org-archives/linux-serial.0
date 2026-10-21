Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594495;
	b=uLRi8t6qAdxbntGFuu45lgNxkv12Ui12f3fzhAyhaT09vJWqEjHSbMQNVstjYWC/dKbh
	 SVZIu4t9bxiB/1HD92T02xZPKLZSUfHWnSELKyxL6QZ5q9GiCB9jBp/Jma1e03J6adcXg
	 SwSb622AhNbF6xh5aS+YpdlwQ62BqaUktU9UVikBGgZpjntVsnfi7+cT34zmJI3IgOy7X
	 UbwPK56AMx+Gdx6g+UDb4/8BM9yZT98dHWDJUUky2Dpo1pfraQY37yr4gG2LUkY19FlNc
	 K9W2qMKEwOOXsb11A9ZuP9gzNlnxsdy4avP6VT1yAmvcuxoIDKkVqvq0x8ZUrK/fsvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594495;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x9wI+e3mIwOv7TfgzOPcvTuB5ZllHHGq2cVlkiHDhg4=;
	b=AXHhJn8nSjgKEKn7djUHFeoS9cT4jqPh4MpsuR85SpsM+5XSgrCLH4G1icMvYUOUJ2ev
	 5pmztkTPKlgw7a8kUH5wg2Zko/K9Bw9IK4jv1If8cezuh1Q/Rqmm3XztBvIkkMOWAaDhW
	 DstzPol36Aex/NJqOrucpGsZMg0V8Ie7WQrB9cQ7QLlL8KuuEjetaO2N6AdexzypjaRHu
	 18ncWenwRa75aAawX22FffKOQ80vwvPNIX2KWr3hxBqzGJqUjJ1j7Go5ttD/l8MUENwfg
	 Nc/qMgGnBR71DxxDzNj4oceO3JtagQnwWrw068cVOgj/2qckDJ2KxAaccHbdqwyL4JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BUIXxR7L;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377B606A32D;
	Wed, 21 Oct 2026 14:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6377B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BUIXxR7L
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789A22A68;
	Wed, 21 Oct 2026 07:54:50 -0700 (PDT)
Received: from [10.0.153.134] (e142021.arm.com [10.0.153.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011CE3F7D8;
	Wed, 21 Oct 2026 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792594493; bh=Q56jjRdUrfSyTENCqjYOItR4H4hbkkEVB7lVr72CSdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BUIXxR7Lqj1C0cgkRxEJqIG4Xqf7oO/pm85wuIGmPmyDo2OCsleYVpy5atgqS73il
	 HjdVv+No3NvzMmSCY7twv3F9ceoliutU8sQj72sRLJkpTu8prfuAW59DvBPjOlibxZ
	 oPfyKGmdpFqRMT/hTjhNVPf2lHoyulg4nCkGvO0A=
Message-ID: <414bbb7a-1018-41ac-a580-cd41708c6a78@arm.com>
Date: Wed, 21 Oct 2026 15:54:49 +0100
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
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: snps-dw-apb-uart: Add
 Allwinner A733
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vinicius,

On 10/19/26 22:06, Vinicius Pedrosa wrote:
> The Allwinner A733 UART is a DesignWare APB UART, but it needs
> SoC-specific handling so the driver can avoid stopping its clock during
> termios changes.
> 
> Add an A733-specific compatible, with "snps,dw-apb-uart" as the
> fallback.
> 
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index e2ca126d58ba..532392dd54cf 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -60,6 +60,7 @@ properties:
>             - const: renesas,rzn1-uart
>         - items:
>             - enum:
> +              - allwinner,sun60i-a733-uart

So if I understand correctly, this compatible is really there for the 
clock gating issue, right? As the DLF part is now somewhat correctly 
auto-detected?
Can you share what your termios test looks like? Because I assume this 
affects more Allwinner SoCs (the DLF change definitely does).
Then we should add more compatible strings here. If there is a simple 
test, I am happy to run this on a bunch of boards, to give you a list.

Cheers,
Andre

>                 - anlogic,dr1v90-uart
>                 - brcm,bcm11351-dw-apb-uart
>                 - brcm,bcm21664-dw-apb-uart

