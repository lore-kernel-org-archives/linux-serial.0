Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82044CE0C;
	Thu, 23 Nov 2023 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFmyOE20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF38C433C8;
	Thu, 23 Nov 2023 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700768879;
	bh=2TtoXB0PIrwOLtz3SYKRVHyvGICWs9Ipxsyoj3bA2AM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=dFmyOE20xa1FcdBElYVSdD3dTZ78t6CF+MeAK67lUUdyi3caegKqKt5JQCjhwOcVv
	 rlVq7CG4NxWGNvm+o6J8nASeStwm2HLOqgHYBbVidSqi73Em/A/hcD5C9emnwuJd/a
	 kLcZaTtl26cmX4b3IPAv5noVU8sHHbhifQXgk2Kc=
Date: Thu, 23 Nov 2023 19:47:56 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
	tomasz.figa@gmail.com, s.nawrocki@samsung.com,
	linus.walleij@linaro.org, wim@linux-watchdog.org,
	linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, olof@lixom.net, jirislaby@kernel.org,
	cw00.choi@samsung.com, alim.akhtar@samsung.com,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	semen.protsenko@linaro.org, saravanak@google.com,
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	kernel-team@android.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 16/19] tty: serial: samsung: Add gs101 compatible and
 common fifoszdt_serial_drv_data
Message-ID: <2023112347-hazelnut-plethora-9823@gregkh>
References: <20231120212037.911774-1-peter.griffin@linaro.org>
 <20231120212037.911774-17-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120212037.911774-17-peter.griffin@linaro.org>

On Mon, Nov 20, 2023 at 09:20:34PM +0000, Peter Griffin wrote:
> Add serial driver data for Google Tensor gs101 SoC and a common
> fifoszdt_serial_drv_data that can be used by platforms that specify the
> samsung,uart-fifosize DT property.
> 
> A corresponding dt-bindings patch updates the yaml to ensure
> samsung,uart-fifosize is a required property.
> 
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
