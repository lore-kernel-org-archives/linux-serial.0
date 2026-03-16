Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE034DCCC;
	Mon, 16 Mar 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648686; cv=none; b=ZuNl+P7GQ/eSFPTas4wSzevYG3qKQ1aCLAJZ1668CBoqryFFH24BwBluu5hUM9/1xpeyRvusnqatODYo3dc4xtkrpoNGz8/Si4uDojPelmEsC6lh2q4ZePMyxerxOnKT2LGzsD3ns/2Rv+MawOWN16KTbpJ08GpSfJMjtdTlDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648686; c=relaxed/simple;
	bh=2/U22xyL14hpwzS+OtJ8KVxawev/mlvdeT5ndUJfiak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZTgR7gd/WVqxiBkwClTx/SNSPBIJisCWvsCwC9PNnNObhpYhpFrJFV4sgmkOBd6qUFqdNYM7F+LdS//uFjuTcTWZbBASSsz19kDJ1nhMiwrQv5hUXHC+ErZz5BRjKEM1EPJqz4Ko2NeNgXstzQESKIgC4CefFT8uaBA93crPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKPid3mN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKPid3mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D399C19421;
	Mon, 16 Mar 2026 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773648685;
	bh=2/U22xyL14hpwzS+OtJ8KVxawev/mlvdeT5ndUJfiak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKPid3mNQixso9Q5ycyABdADX0CqKUH6PGjRBtrVDxt1AIlWes4vtmf9aAHRvZUSD
	 G7AarnVVHvmIdMxX42IyPFW9z2rfQOLkvalgsomLpMKSDCqlRHlAeHETLpGMqpYyki
	 91KgLS8X8RFaHmB01GniI5Ubv3ZGIm5enHeee2hJfy67S3Bv7wqgfWiOepD3r235fS
	 P/89bTNIrS349p8+AeJ/i2EotHv9ezc1YGdpBs4/YJ2bjwqjabJPzmblUzjdOSOlQD
	 xEezynDm9ZCxDrlQ84SES5BxC46cglXeSII4uC6uJQL54LyyFp6RMZX6lSaUZaHuZx
	 zTIYvm9dQthHg==
Date: Mon, 16 Mar 2026 09:11:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: update bindings of ultrarisc
 dp1000 uart
Message-ID: <20260316-uptight-dachshund-of-grandeur-fbee0f@quoll>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
 <20260316-ultrarisc-serial-v2-1-6ab3e7fa891c@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-serial-v2-1-6ab3e7fa891c@ultrarisc.com>

On Mon, Mar 16, 2026 at 02:33:22PM +0800, Jia Wang wrote:
> Add DP1000 UART compatible information

We see this from the diff. Why this is not compatible with
snps,dw-apb-uart? What are the differences. You have entire commit msg
to explain the hardware.

> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 6efe43089a74..0040ed28e35b 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -78,6 +78,8 @@ properties:
>                - starfive,jh7100-uart
>                - starfive,jh7110-uart
>            - const: snps,dw-apb-uart
> +      - items:

Drop, not needed.

> +          - const: ultrarisc,dp1000-uart
>        - const: snps,dw-apb-uart

So just enum with the snps one.

Best regards,
Krzysztof

