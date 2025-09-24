Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221B24A05D;
	Wed, 24 Sep 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709369; cv=none; b=FDs3ImGFbNQsWrypq12cBizZjXLVviv0qkf5oNaSntEq+7or3vtcvpi8WLMQaoubdQloi5RLT7e2bn7x242eDyKm41PrjKWcu9t+O+ifKKdBt3MStaM0PiQfdlLKX0vmgad49B2qARQCdINrQ9NosxjIA1lEVtTJMvMdTLK2oBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709369; c=relaxed/simple;
	bh=i/8c57xJ7LfF5nE7wYPBrai8xtoFVnojUkqn4RkrIhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj/b5VxkKU3k0DCXjNq1PinzwsYw98B0/ks3a9DDd4g9m+2/fOL76SAGkOJiMV6bhfcf/pESVwwOCRjZ+IjsMg6KlXkNgt4gYfzW6iknYoDJofSq936zPhJySRZ/qUL0gW5fX9bdHjcyQmiNcPkIbKkkYx3ALcSDwVHVCGtaDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yfjq5iN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yfjq5iN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC48C113CF;
	Wed, 24 Sep 2025 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758709368;
	bh=i/8c57xJ7LfF5nE7wYPBrai8xtoFVnojUkqn4RkrIhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yfjq5iN2jryJpV0DEAGbzF7A+wALDrpHpP1VcQrOAFnoIxQjU+qFPgVE1ps/tquFz
	 YSBRPpMpOmEv0W96xuGxBRJeAcvTSSxcRwljyV35FjKPJVDTvI4JHT0EeXBxL0GbeD
	 aiv6255cTI8kqp8DqazIrudVohFMWnqYuAn7awvQ=
Date: Wed, 24 Sep 2025 12:22:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
Message-ID: <2025092428-glade-monologue-3663@gregkh>
References: <cover.1758676290.git.zhoubinbin@loongson.cn>
 <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>

On Wed, Sep 24, 2025 at 02:29:37PM +0800, Binbin Zhou wrote:
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -31,6 +31,7 @@
>  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
>  #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
>  #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
> +#define PORT_LOONGSON	31	/* Loongson 16550 UART */

Why does userspace need to have this value exported?

thanks,

greg k-h
