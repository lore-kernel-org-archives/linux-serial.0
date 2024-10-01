Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B401ACDE3
	for <linux-serial@vger.kernel.org>; Tue,  1 Oct 2024 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767510; cv=none; b=B2hHci9YG55RloIZ+pipxAFLjmlZG5E6gY37M8hWTxN7AmDasGYjbrhpfsgIELdP+kNvA5yVKI2WQcvi7PaXnN2xWNso+YykkOKrsK922ajdiQvPJzPquk0oghWq1bsWaoJEr+HW2nk+gL5nFeVKGqm2RoS/7X3NN9dQo/tS0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767510; c=relaxed/simple;
	bh=jq7gk2jfZ+hdJ5OeRVSANOBdMJ5J12z2YwRxflKCCIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUKKDNXzmN1jlv6zhtN7zaQF/zADdtJQOr+T3fz2icunxfkWNAkuS0rPiwks91pAoiRuplU4+EXtsne3Xz3WYpYMAVmNixKDwGRjA37sdNuFNegJcO6iXvSzaeWa+0xMYnz5eougbttXl0wc9j2uYv++EbswUq6qZZrH226NaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFe-0001fs-Ec; Tue, 01 Oct 2024 09:24:54 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFd-002p0t-VX; Tue, 01 Oct 2024 09:24:53 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFd-004tso-2r;
	Tue, 01 Oct 2024 09:24:53 +0200
Date: Tue, 1 Oct 2024 09:24:53 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Hi,

gentle ping as this is series is two months old now.

Regards,
  Marco

On 24-08-07, Marco Felsch wrote:
> Hi,
> 
> this patchset is based on Johan's patches [1] but dropped the need of
> the special 'serial' of-node [2].
> 
> With the patches in place and the usb hierarchy described in properly we
> can use serdev on-top of usb-serial. The below example adds the support
> for the following hierarchy:
>  - host->usb-hub->ftdi-usb-uart->bt/wlan-module:
> 
> &usb_dwc3_1 {
> 	dr_mode = "host";
> 	status = "okay";
> 
> 	hub@1 {
> 		compatible = "usb424,2514";
> 		reg = <1>;
> 
> 		vdd-supply = <&reg>;
> 		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		device@1 {
> 			compatible = "usb403,6010";
> 			reg = <1>;
> 
> 			#address-cells = <2>;
> 			#size-cells = <0>;
> 
> 			interface@0 {
> 				compatible = "usbif403,6010.config1.0";
> 				reg = <0 1>;
> 
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 
> 				bluetooth {
> 					compatible = "nxp,88w8987-bt";
> 					fw-init-baudrate = <3000000>;
> 				};
> 			};
> 		};
> 	};
> };
> 
> If no serdev node is found the usb-serial is exposed as usual and can be
> accessed via /dev/ttyUSBx.
> 
> Regards,
>   Marco
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-serial-of&id=b19239022c92567a6a9ed40e8522e84972b0997f
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Marco Felsch (3):
>       serdev: ttyport: make use of tty_kopen_exclusive
>       USB: serial: cosmetic cleanup <space><tab> mix
>       USB: serial: enable serdev support
> 
>  drivers/tty/serdev/serdev-ttyport.c |  9 ++++++---
>  drivers/usb/serial/bus.c            | 10 ++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240807-v6-10-topic-usb-serial-serdev-83a7f8f86432
> 
> Best regards,
> -- 
> Marco Felsch <m.felsch@pengutronix.de>
> 
> 
