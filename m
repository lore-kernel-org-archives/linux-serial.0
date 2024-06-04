Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8813A25D;
	Tue,  4 Jun 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511758; cv=none; b=GSXzQ+H0tsmBV+AQMhAXTEpcMmTdZ5RP6jraZ97vv8QPAeoJS+UON645Dvwt/p6aUYokmvJtkokVKtemp1Q9YziDoYW8j11SCcxA+BTBjWpOoW+WeDFRKCnqzRgSH653H7ctZi2IK+jGcUe22Rd1CK5lxUyV/ntcnlJDeAoRQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511758; c=relaxed/simple;
	bh=BcDCaCrTiv32Mv9KNcZ10IBirLsuHTSs72Lc0IOQWsE=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=ZltmAGR9O3cBhpaM+3GFsZkjQpf9mdZTTuX4CauKMVTbLfn8HXgJB4yGtSgnbBNQtj0mpCtCwEsUDYOHs9meGgBN3KKe5N+hP4Rw0LYviymHnkSkGaLUQTq8T6LF3w64+8bHHCFYc37vfk+hVOfmbU0NUnljsAZ/YwFWzb3aI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=kIQSDmR1; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="kIQSDmR1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=u5amUy6BDusyFy20+rJHPUSg+CiOQNC3U9ppdC22vEM=; b=kIQSDmR1xfp5YIjBkiBpSvj0ch
	YV9EQbXrr4B0/cJ8RXPvLmOUUnwvq+cNtNLL1gBnvAhkYJL4L6kCqjMV+wYfjHXixjTnvvMtCFdg1
	uG84C3/xrmdA3+ET5EOjIb0acHYesCYS00aIO+mHrZrCtBKXK9lSwaTdS9xdcb2rQVM0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:58222 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sEVGU-0005Tp-Kv; Tue, 04 Jun 2024 10:35:54 -0400
Date: Tue, 4 Jun 2024 10:35:38 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
Message-Id: <20240604103538.a96cef712dcff156eca099b0@hugovil.com>
In-Reply-To: <20240604132726.1272475-1-hui.wang@canonical.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
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
	* -2.5 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  4 Jun 2024 21:27:25 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> In some designs, the chip reset pin is connected to a gpio, this

"and this ..."

> gpio needs to be set correctly before probing the driver, so adding

"so add ..."

> a reset-gpios in the device tree.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> In the v2:
>  - include the gpio.h
>  - run the 'make dt_binding_check' and 'make dtbs_check'
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
> 
> 


-- 
Hugo Villeneuve
