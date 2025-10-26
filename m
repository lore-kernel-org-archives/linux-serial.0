Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107620B7E1
	for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470736; cv=none; b=kp71FDOfhoaIjVFwicEt0FyXs24E262M+8x+LkFcYjoX7IozGmPBEkXSZpHLGmLgED3C2Jnpa5jbdk8x+LaAdQ4rE0iEAlxP1HT7NlxLtEN6T1G+c9vpOmEz3d1/KbM9sdFo1unOWRGvzWsmKn/OIIaiO6scLBWwUeFjsyPFxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470736; c=relaxed/simple;
	bh=Tss/zvoXsMS02VBKCezKNf/AvHbAfwnexNTEWA5QtKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYXVsjo0pDD6680mWlMY5kEdPA8HaSJfBI3pU8MjsDAj96bmPa4AVeEx1ZRj6u+uN3YbTuRi6x25cn0DmMTqoWOvP0FWjWWWepfqnnVWcyulI19RpmJppQdFLy54piYMWwinfPD446kcNzZvC0eAnIJO9gGemZxhn0YQu1sFyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E7F02C02B8F;
	Sun, 26 Oct 2025 10:25:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4ADDD4A12; Sun, 26 Oct 2025 10:25:32 +0100 (CET)
Date: Sun, 26 Oct 2025 10:25:32 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v4 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aP3pDI27M-pttysA@wunner.de>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023151229.11774-2-gerhard@engleder-embedded.com>

On Thu, Oct 23, 2025 at 05:12:28PM +0200, Gerhard Engleder wrote:
> Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
> retrieves rs485 properties for 8250 drivers. These properties are read
> from the firmware node of the device within uart_get_rs485_mode(). If the
> firmware node does not exist, then the rs485 flags are still reset. Thus,
> 8250 driver cannot set rs485 flags to enable a defined rs485 mode during
> driver loading. This is no problem so far, as no 8250 driver sets the
> rs485 flags.
> 
> The default rs485 mode can also be set by firmware nodes. But for some
> devices a firmware node does not exist. E.g., for a PCIe based serial
> interface on x86 no device tree is available and the ACPI information of
> the BIOS often cannot by modified. In this case it shall be possible,
> that a driver works out of the box by setting a reasonable default rs485
> mode.
> 
> If no firmware node exists, then it should be possible for the driver to
> set a reasonable default rs485 mode. Therefore, reset rs485 flags only
> if a firmware node exists.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
