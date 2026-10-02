Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF73BED55;
	Fri,  2 Oct 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930974; cv=none; b=WRduyv6y+4ZqgsC1PJceh6QcnDIGnIc8z7ReVmiYwdBSCRZQMtZvLQslCvzf0/mqr8NJRKtgpLP3axBtqCtPOjeVBwGSlPZr/gZneLtuEan8hqeXAwGrNb6JM6rFM1wzzhp+76G+b7zkGquZzmEgsCK+/DIwZk6l6kJtxGFMI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930974; c=relaxed/simple;
	bh=YN0wOfl6bDY8nqUj5Q/9V9fQKfz4SuIc2QBNbMndnaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgs/y03T6IypxSQ58DrSzyvkuE1c2UnbOkwuBb5j+750aAucl6e7g5xkYAJ6sN14ou5g9m4VgGHTPwNXn8n38/4E43C0L5HS/5lWdRcKoo6r+kOM538oGcYahlNGPWaQE2F7K9L0XAM3EcDblHBOJnaep8iEfBBS4WYEnIVOKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewr6WtPx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewr6WtPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790930971; x=1822466971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YN0wOfl6bDY8nqUj5Q/9V9fQKfz4SuIc2QBNbMndnaU=;
  b=ewr6WtPxd1KcfTkOjEaFKJyKc75/Y9ggUa++rwzPuGuLMr3O1e/yacA1
   VKr5tDSI4xVYOR2ZIA3Ycav/DngT2j0am5uNJgSb+8oa81mVzE4zEHLwD
   qfYWzEim4TYvdnC3zjvfndlX7ou3RRBKdL7oHL/O265n8uzck6EGZlUdh
   8Wap/KlXI/k3oAnxiXUniRw8YrFmzbPieF7qOcswHhvsZ/7e+9C6UNEwK
   +AOGQHQQSUtQjT9vGaO1R3JH8YLKBXieZCydptiwlph1nkdjBYzDxtRZV
   0hWYRdsBhbd7ETibOzjinoQm2PEuuuEdi0ImuOxy67bSWi8uKe5TquVMF
   Q==;
X-CSE-ConnectionGUID: 36XcxpI7QJy8kA/qQnaUjA==
X-CSE-MsgGUID: VCaKetnRQFCxYkZgEKvXUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102219845"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102219845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:49:30 -0700
X-CSE-ConnectionGUID: EzkXN5aeRSCVrzI5i6k/hQ==
X-CSE-MsgGUID: jPdD+Ty8Tqyt/zWixcl59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="276262414"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 02 Oct 2026 01:49:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F042199; Fri, 02 Oct 2026 10:49:20 +0200 (CEST)
Date: Fri, 2 Oct 2026 10:49:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <20261002084920.GF176164@black.igk.intel.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>

Hi,

On Fri, Oct 02, 2026 at 10:31:02AM +0200, Petr Pavlu wrote:
>  drivers/thunderbolt/tb.c                              |  3 ++-
>  drivers/thunderbolt/tunnel.c                          |  5 +++--

For Thunderbolt,

Acked-by: Mika Westerberg <westeri@kernel.org>
