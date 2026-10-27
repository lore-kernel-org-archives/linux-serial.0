Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116331;
	b=ymB0igTMReyzpTzDiZ1YsCIjGmOy93aabEKA1VENEyrvEpxGqoxs0h3sxZCReixRmMFd
	 BSSGgCPff5ZOrIWEG/9yg/zixIf7WuXEWNjMsaCWATkRVrY8Mc3aBxRX2HAAUfbSSSq6L
	 GmTBYYyRZQqoLpAbs/RUklkQBjXly/ELJSt76Acs5s2wIbl+rNOWLkPjK6t7RlfGeIQcT
	 sdUJzq+Etr37PE1G275P2B0ZhXbMmstGkSGdnvTo54vuY/4sNVwJLE1XbeETEIVc+/vFa
	 zr6LPpoqZUKLmFOnaGMZyC/smmnJltZ/Deup5C1YfVT6Vz2wbm1xPeF8ik+oNa+r7dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116331;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pfnNDHItpoX/YzmzrmP5ur9HWzidKs0fEqz613nLINk=;
	b=T1M3RuiTDxhJnZlgD6RE0dzTEqaCZDTquYH+6/tK/WSNJUMN201Mj3unARKX7kA/gFQx
	 QwiUKDc47Tew9PEA7IGjCSJNcnG8Qy2HK5DS4U3zMm5dEj9JZ1YEAYD/hvNqeFDb7HiJL
	 NY3A2FsS8FWnhWDN3urxg0Rfnhfd94GnnoOWACzB83+NaW/YMn5isv9C0b3U6IMjRYmdq
	 d+NkaDn8YXJKknclci4xYGn2rIZSnno+j64fJVWZFK6MOpdDu5HDehkcEfLQR5633faUn
	 B8QXQxfVhBerrzToptDIyld2u24szWoFs28nlN2rScRckTsv8ga/MAN50ZH/+4WeCwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJ7nJavW;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBC606FC9E;
	Tue, 27 Oct 2026 15:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBBC606FC9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJ7nJavW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793116331; x=1824652331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AXbOS6yicrYkW6cWp25t1MxUM3pBn1J5M+NgEEWNqCw=;
  b=YJ7nJavW8lP2jJTrJMdE5h3N5bN9PMus75VN/vEzc4WA0hZWpKk72KCi
   1CARSZAWhKteVuUWkVKtwGs5G4Aa7oxSqYpXmmiZGJD4X0CMfE8UPIgXy
   OH6D6FDql7Y53J/RV4m2RJrS+2pTKRtB4xRD0rt+XEq5odKvZxK19j0R4
   OIfr5xgrJnRZcbocxCFc8iHKtoozIM0vZu3LnnnRgqgeNhnHV7WpjCs9t
   mfovoqBHNiK1ochiXVeCCsfdDL9cpWhdJta1MSi5VSREq41kepyw90XkY
   R9ZgQ0oTGTYiF2zLG3UEOrvTEZiRRyPSlbkCTs2tZpzKHzqUp2uiJzuoP
   w==;
X-CSE-ConnectionGUID: 5ntgXMZxR/GXAt7U+DFoHA==
X-CSE-MsgGUID: /kGhKfscRpyEEgBs6Bv+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1727155"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1727155"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:52:10 -0700
X-CSE-ConnectionGUID: Pu1kC4IwQKaeNIkpOo8VgQ==
X-CSE-MsgGUID: Px9sDWm1Qfu/HxUyZgAGpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4697457"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:52:01 -0700
Date: Tue, 27 Oct 2026 17:51:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 23/24] serial: st-asc: don't report a wakeup to a closed
 tty
Message-ID: <auDIn8NbW5vKLSQX@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-23-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-tty-llm-v1-23-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:49PM +0100, Greg Kroah-Hartman wrote:
> 
> If its interrupt is a wakeup source, asc_receive_chars() reports the
> characters which arrive as a wakeup event of tport->tty->dev.  That
> pointer is only set while the port is open.  The port of a console is
> not shut down by the last close, so its interrupt handler goes on
> running without a tty.  If the system is then woken up by a character on
> the console, the handler dereferences a NULL pointer.
> 
> Take a reference to the tty, and leave the event out if there is none.

...

> -	if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
> -		pm_wakeup_event(tport->tty->dev, 0);
> +	if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
> +		struct tty_struct *tty = tty_port_tty_get(tport);
> +
> +		/* A console goes on receiving after the last close */
> +		if (tty) {
> +			pm_wakeup_event(tty->dev, 0);
> +			tty_kref_put(tty);
> +		}
> +	}

I believe I saw already something like this. Taking into consideration that can
be a helper for all who wants the same functionality.

-- 
With Best Regards,
Andy Shevchenko


