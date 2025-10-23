Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C419D07E
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184579; cv=none; b=P7ZN1YHms7l6lLWMDoV43dIzhAXPgjqa4NwfVjsYrKerbY2OjGa9VPsGIV41Dne3rDfrFcksWfgUZpe43vdMxS2WM0rhdeONynE/J/wMVa9OfgZoj3yLCEb7548LK7QeV5whU52mADo8jUdVbQcQyeJO3XxGBnC+E1flYeqqRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184579; c=relaxed/simple;
	bh=fRInwGC/3hTk4RjtbdZOXpb0q1FWbkiRLlzS2Tsb1Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tflAuHpYdItjnY0bd1qpWr8Giijn24oAiOFjsICbAnIOt38rEWOI2mmzL/YXM8agRv6o/WgeMn+n0Tr78jg1W+mMyb/F4W08E5job1MKnK32VNI1/CT4EVO2CvY120W/HHDLB0nh8zKj8Md2/+j5DUm0TlYTRvsgyt8i8c68bAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6D9712C02BA8;
	Thu, 23 Oct 2025 03:56:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3DF534A12; Thu, 23 Oct 2025 03:56:08 +0200 (CEST)
Date: Thu, 23 Oct 2025 03:56:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>,
	Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v3 2/2] serial: 8250: add driver for KEBA UART
Message-ID: <aPmLONW5q55Yta3N@wunner.de>
References: <20251020190658.30655-1-gerhard@engleder-embedded.com>
 <20251020190658.30655-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020190658.30655-3-gerhard@engleder-embedded.com>

On Mon, Oct 20, 2025 at 09:06:58PM +0200, Gerhard Engleder wrote:
> +++ b/drivers/tty/serial/8250/8250_keba.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 KEBA Industrial Automation GmbH
> + *
> + * Driver for KEBA UART FPGA IP core
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/misc/keba.h>

Duplicate inclusion of <linux/module.h>.

Usually these are sorted alphabetically.

Thanks,

Lukas
