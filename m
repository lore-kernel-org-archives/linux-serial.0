Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A43191D2;
	Fri,  5 Sep 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098138; cv=none; b=tw4B7s1r/kFZPF9OEsb3gNgKBC1F+MGAChZ/bNdWKnWQHiqsHeq1Ku9YS1e3PMFFkKpKR26pzd0b3u+TGJUCAHK5hACYc0OjJFUbha0WdLPi8TMHlKv1QAItCmTzz6OIEVuvuUJfFHmJfhQ1xeH2OCKFTXcAgET79eZMlB1jGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098138; c=relaxed/simple;
	bh=gT6iLDzXkn2vkQT7GPoK0T33+aXJivk9xetjRQ9j+q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvimoZuHhnDdKYxLZd6VpjhDtdv5oSE8NDSPxkAirfahj/nX3tvVgl5VDem8kegZlUWW0p7NsThNvbImxWX4NpBE8pxU5yC97m7NB5+8DpBLkLJ78BbdHE3MhUyPuLGFQDxcIjWD98zSWFku/cpo8V31vENfua4IxEPnUwYfWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LiePq/bb; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LiePq/bb"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585ImLAa3314373;
	Fri, 5 Sep 2025 13:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757098101;
	bh=i+QqUgGTAvZfE8MLyrDMwvyRy7EWTHhQeRZzEGO5LEc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LiePq/bbxWeXOukzQDZq892+phfvJweZoPr8QlhPlAL4BttslQArumXvZmSqRt84k
	 nYgTSMd3MgSlP3+uiGNMgc/gHmOdA53A3prPdYvBerdexJVvpacmIKpTLd5hvBuEvP
	 pMTO6urG8neIMH9iG+dskSksKhy24zV1iNpmxYuU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585ImKu01090339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 13:48:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 13:48:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 13:48:19 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585ImIE41165621;
	Fri, 5 Sep 2025 13:48:19 -0500
Date: Sat, 6 Sep 2025 00:18:17 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: Kendall Willis <k-willis@ti.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
        <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source
 type property
Message-ID: <20250905184817.7kdhroadthzesnaj@lcpd911>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-2-k-willis@ti.com>
 <20250905-saloon-siesta-77da98d7ae02@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905-saloon-siesta-77da98d7ae02@spud>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 19:38:00 +0100, Conor Dooley wrote:
> On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
> > Allow the wakeup-source property to be either of type boolean or of a
> > phandle array. The phandle array points to the system idle states that the
> > UART can wakeup the system from.
> > 
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > index 1859f71297ff2..851a5291b4be4 100644
> > --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > @@ -69,7 +69,13 @@ properties:
> >    clock-frequency: true
> >    current-speed: true
> >    overrun-throttle-ms: true
> > -  wakeup-source: true
> > +
> > +  wakeup-source:
> > +    oneOf:
> > +      - type: boolean
> > +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        description:
> > +          List of phandles to system idle states in which UARTs can wakeup the system.
> 
> Is there a single other instance of the wakeup-source property being
> used like this?

I think there's an ongoing thread here [1],
[1] https://lore.kernel.org/all/20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com/


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
