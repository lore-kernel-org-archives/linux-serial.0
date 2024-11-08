Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDD1E7C19;
	Fri,  8 Nov 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072326; cv=none; b=c4MfxbPy6DuvKF9hzsExp6gbt/Utv7bpBVDbvHnkLGDUf5mgBryoUgh+X24g8s2GH/1SHWlemtui5cElcKU24UCIfZxRsiMzZxY7e7PZ02U0F9x/ctiizN3TMX8thAKvZto7rGz7WRd1+leP/CdQuaUVkJS0zqmpFDMWxFuKor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072326; c=relaxed/simple;
	bh=5hvLEyTFPQx5H7v3dFuZN0FjYzVD+U3f2NNRdnnKXSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oky3w7nbODNNXMwXq1oCZ3Ls2o8MzYISP392xhudJAR5cTl+W8GYMKs77O8MY4+MnD5YtkFAgAtIexd2GiOxorC2cjSrJ2bhYubJODceREeBwhhxG7i7ozv49IxH+5Ly7L/F6tOxZfVLwCVRuXB+QP6G9gBKTrljK8BmS2TWuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z/rTn1SE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z/rTn1SE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731072325; x=1762608325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hvLEyTFPQx5H7v3dFuZN0FjYzVD+U3f2NNRdnnKXSw=;
  b=z/rTn1SEg0zMlcljsCfRu7YEc2eluWeGz/JryqQRsJHN+xMGgAGKo7Sq
   cmKBQ5R+a727mFaYZiPfrFykya+2V0duPkAtbBgtn5cs4u9IO2nsN4Hpe
   mJIjEV2QqBaHaIXf5nsT0YPEZiMbBD2sF7LhIbkn0mp1moqBo3bSVnwNZ
   54SYGp5HIt7W1H+jKCs/lTft2JmyX+6xuIF2Ac9k/NjSB9CKbTA2u0hjc
   4F+Wrk6Anm693UCF2v8WBJ/DjjRAvrasN4ytyhCQZCD4xqLrXtnUee0u/
   BMWHg2MZV2JdLsV6lGgbZ4ItIuoLEX2sbBEuKbny7lrYoDS1CLS1/gdlx
   A==;
X-CSE-ConnectionGUID: iH+GyLWgRPSUWZyqd7expw==
X-CSE-MsgGUID: a1xqAW10RbmjJ1w3OUmEkg==
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="34573173"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 06:25:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 06:25:23 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 06:25:21 -0700
Message-ID: <609ef9c4-18cd-4a80-9821-5df27727772e@microchip.com>
Date: Fri, 8 Nov 2024 14:25:31 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tty: serial: atmel: make it selectable for
 ARCH_LAN969X
Content-Language: en-US, fr-FR
To: Robert Marko <robert.marko@sartura.hr>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <lee@kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <luka.perkov@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
 <20241108112355.20251-3-robert.marko@sartura.hr>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241108112355.20251-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2024 at 12:22, Robert Marko wrote:

A little commit message would be better.

> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   drivers/tty/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 45f0f779fbf9..e6cf20b845f1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
>   config SERIAL_ATMEL
>          bool "AT91 on-chip serial port support"
>          depends on COMMON_CLK
> -       depends on ARCH_AT91 || COMPILE_TEST
> +       depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST

Checkpatch.pl reports some "DOS line endings", you might need to fix this.

>          select SERIAL_CORE
>          select SERIAL_MCTRL_GPIO if GPIOLIB
>          select MFD_AT91_USART
> --
> 2.47.0


Once fixed, you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas
