Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BA14EC62;
	Mon, 17 Jun 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639387; cv=none; b=tfMIMkWpm670k/cKMArsOZXFHXgCt4zHxQjWZMCsx1rhIweov5xIOD8wdzmgLcNeT0MgBsYkEqo04pdY6BhR2/BVMffubdXtTjNHbvp9ZM1zDBNHR0lt+GY7bUEDVyJ5VLHpC9cXGqUJsAp/E/85g0lQRr9/frFiJdN9z+Ss320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639387; c=relaxed/simple;
	bh=PfgonVgFYp61t/c8MZcCMIQbGRvfn27Xsd4DtpDziwQ=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=p/DxtGsoKco6LmeC5rrC1q3/Xfz7f2ok8iySMauZB6NbLy0eGR4dMEtzqPtKni+DcIfFrGINrLrhZHrVE8k1sOfEAhHeSXiyB4U0/8a0MFDOGfF1VZ/cvMh5BbUiQww3UHDxiUUiTEWNRLS1/ghYuRkxfvs836yypPMzSjhAqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=MZ+kQN7y; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="MZ+kQN7y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=pajbFnbgEHmNkP9OmvMt+YaCSM1Vfl2Psgvjwr2BIfk=; b=MZ+kQN7yQoQBm+Se75WsLfLfg0
	I09oaBimbkGffo1m20hJbQRIKR1yButSr8+LQ3M/fW9/icPX/ZxQFY3YZJRRJGUC348OFS/RIRs9m
	WCIAJLR+6eQYJdCBWB3gmplBhKRdmWpL4MQ/lN/CJaIFDiPLkYADiwqejlyOTScYg+pw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:56466 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sJEbw-000781-HN; Mon, 17 Jun 2024 11:49:36 -0400
Date: Mon, 17 Jun 2024 11:49:14 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Message-Id: <20240617114914.329fb547ff82776b1c03e4e9@hugovil.com>
In-Reply-To: <20240614102952.679806-1-hui.wang@canonical.com>
References: <20240614102952.679806-1-hui.wang@canonical.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 14 Jun 2024 18:29:51 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> In some designs, the chip reset pin is connected to a GPIO, and this
> GPIO needs to be set correctly before probing the driver, so add a
> reset-gpios in the device tree.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> No change in the v5
> 
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> index 5dec15b7e7c3..88871480018e 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -28,6 +28,9 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  reset-gpios:
> +    maxItems: 1
> +
>    clock-frequency:
>      description:
>        When there is no clock provider visible to the platform, this
> @@ -91,6 +94,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -120,6 +124,7 @@ examples:
>              compatible = "nxp,sc16is752";
>              reg = <0x54>;
>              clocks = <&clk20m>;
> +            reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>              interrupt-parent = <&gpio3>;
>              interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>              nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
> -- 
> 2.34.1
> 

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
 
-- 
Hugo Villeneuve
