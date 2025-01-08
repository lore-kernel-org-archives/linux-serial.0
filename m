Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584341F2C50;
	Wed,  8 Jan 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343148; cv=none; b=qljk4/YTjql+DYKFloc9wS98ZqGqZowh8U/SEWNjcZL/gDWH7V2eWvagYN2SduBakPCjE0tDF6noi4lHjXPrAExjS+gZ28oECUMdzYGnLXRVheqjkXtsGcDIwc/GWbbinTQLbKxTbwZxM2wdYKb+wn9mHt44pL1s3cmAyNxAIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343148; c=relaxed/simple;
	bh=dAxFgrzG1HoxwzIUMYTk3N5n2IDUrRKAA4lDY4FZYFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXzIdLHV1h1HGJH46SaNJTb05Qu97brxp9C3flY7AbH9AwiWyGtCs19vH0jVv/XdmC/1LPJxQa8YYEMyviCecOvjxrfkezt6lAvLmhmts6CvGxLDYt/m6IcBBHNh86I9ztksxmeLLe3IIq7qRX3rZ8BgECMAUOqa/JfXw/Tx1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IOGZeUDG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IOGZeUDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736343146; x=1767879146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAxFgrzG1HoxwzIUMYTk3N5n2IDUrRKAA4lDY4FZYFY=;
  b=IOGZeUDGPE25PyWSeP+vvKl5nBtBMTX+rdJkSY8HpBsSGMg0vAKqXkwz
   jVG3UDcu+2A+SyzXdlN3lfyuM51DcTIk6QKGcRItTiibjIcQZd4AI3u1a
   tnFF2xb+cBLFKGkq4JHYuS6ddh5mbSihNWPtIh/DQLkvqID6VuU9z1yQ2
   3Dtj5rkPQzHW++9jxLKpNDBrc7p2CiRWAMz1BoigWeQR7kXkfxNkngKL3
   Mwe6jjsluL6sraHkt/AkRTAKlAhXeywpgPPTITdFyZGbTZ5bZxy3JVfKo
   lBxwM+tS0eeNTpBc+4YDLMK6SfUiiCegklt6t6qmhegVzMXfhZAsgtE+U
   w==;
X-CSE-ConnectionGUID: 8yblzpFQSpy0mdJMe/argg==
X-CSE-MsgGUID: 9tr49NP3TOGm+epbvodq0Q==
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="267567432"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2025 06:32:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 Jan 2025 06:32:22 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 8 Jan 2025 06:32:20 -0700
Date: Wed, 8 Jan 2025 13:32:20 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <lee@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <arnd@kernel.org>,
	<lars.povlsen@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<luka.perkov@sartura.hr>
Subject: Re: [PATCH v3 1/3] arm64: lan969x: Add support for Microchip LAN969x
 SoC
Message-ID: <20250108133220.xysvfof4puzr3jgr@DEN-DL-M70577>
References: <20250108131045.40642-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250108131045.40642-1-robert.marko@sartura.hr>

> This adds support for the Microchip LAN969x ARMv8-based SoC switch family.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> * Rebase on top of next-20250107
> 
> Changes in v2:
> * Add forgotten LAN969x architecture support itself
> 
>  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index e2638e5118a7..cd29480be792 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -133,6 +133,20 @@ config ARCH_SPARX5
>           security through TCAM-based frame processing using versatile
>           content aware processor (VCAP).
> 
> +config ARCH_LAN969X
> +       bool "Microchip LAN969X SoC family"
> +       select PINCTRL
> +       select DW_APB_TIMER_OF
> +       help
> +         This enables support for the Microchip LAN969X ARMv8-based
> +         SoC family of TSN-capable gigabit switches.
> +
> +         The LAN969X Ethernet switch family provides a rich set of
> +         switching features such as advanced TCAM-based VLAN and QoS
> +         processing enabling delivery of differentiated services, and
> +         security through TCAM-based frame processing using versatile
> +         content aware processor (VCAP).
> +
>  config ARCH_K3
>         bool "Texas Instruments Inc. K3 multicore SoC architecture"
>         select PM_GENERIC_DOMAINS if PM
> --
> 2.47.1
>

Acked-by: Daniel Machon <daniel.machon@microchip.com>
 
