Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247691;
	b=aVpbieldmcYU17f+d9zsetxI+RqK7lZBA41OytWLSDFnOZdUTqabVk2TMfxXD0lwHozU
	 6W2ik3ycQwP3YVOvDU05r9KeZ0YtHPeRsiNh4OoLW41sOmBz0xQdYmvMrUrPJjyHgXEDT
	 8lG8t8oD9emmXZxyEdzDV7bc6VhC0zNcLmsvqtO1fKPT6iYkbuwXHAMnIZHqYcFrMtPZ1
	 eSTTkk6gfaz5yjgqF1CisEEdkCgqBAkzAssvWFnSOINK4ncHFCZU+8ma0s1d4w5JpwJCi
	 Yzjkq/F27VS435XqJBxSaUx/6Wy0IhWHD3b+GaJwUPM1gbu5UyyIcfeqB0wpL6IHESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247691;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=s7U/x5CE+niXpSBFgBUHJahPZfA7nFuXi/iUGvk2YDg=;
	b=j/Buw4lHRWZmII5hShFBtLq+bIMvLla8pe4WlITN2TFhdciVHL3dZsT7hDXIMC8S5zEF
	 cFlwy6BxhIrV9KBjvfq4+lT8WAOR2gVtd9q7KBqRlxrsoZrhRvbiVXTn6oH5qZ92Mai9c
	 Gz2JD3+57stYEXDfpPwKkiLv4W4LSuZY3Y11arpqinai4xbPn76swOQrThf4I4sS6xfyw
	 66/DV6HTsUuv3hw1Pir7wEqTYUqwNRvP+CLtA3e0iGPj2iNE5GYhwVAGTNO0sJbqDqabJ
	 WcJJ6jHBXeOEBv57ETWcG+pzZqCJHZFVuQCHBMDkMFnothPtr0vhTN7RkhycURWHsDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IP9SxyfD;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F481606A325;
	Mon,  9 Nov 2026 18:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F481606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IP9SxyfD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794247691; x=1825783691;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wfrbeowEpzlsOOtS5Xzt/Z99rOONWv91scfsMt1LT1o=;
  b=IP9SxyfDSB6EGFGs7A0bVCps7q2rwZcFhAiDYps8uP26aAu5UsHuIxSf
   tlmYluqa8O0Vkzw3iTrVKhijz+FC+kmiN5XaQ71GLb+8eONi8JfI0J27i
   gAac0Ey+5zHnjNqUoGr9URlzdDJ+F39/qK50JinS21ss/u/G8rc4vPQ7x
   mqFEASpQPYKebvqnlIxIvZKEEeurzQ5f47Zp+zwzxQZxNVFZvEO6oQe8W
   qyB2XD0JMOX45lgejPKqDw7YfMTajxl51pPK45w+PADjiswcG2ePqK5eB
   51DxM3/Q69Vre2Thnw8Y200cdNemMOs78amfHRZkMWzOSK6HYmZMgrBl8
   w==;
X-CSE-ConnectionGUID: KecGYyTSRKKI8ipgzy4cvw==
X-CSE-MsgGUID: CyDqiia7S7WO37n5QGEFUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2894249"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2894249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:08:09 -0800
X-CSE-ConnectionGUID: REOqqbgbSlKUYG/hgL23ew==
X-CSE-MsgGUID: M/rq1zH2TtK3zErWiBcqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8094048"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:07:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>, Andi
 Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marek =?utf-8?Q?Beh=C3=BA?=
 =?utf-8?Q?n?=
 <kabel@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg
 <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>, Chas Williams
 <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
In-Reply-To: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 09 Nov 2026 20:07:56 +0200
Message-ID: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>> moved it to the graveyard section at the end of linux/module.h
>>>
>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>> remove the macro.
>>>
>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>
>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>> 
>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>> and reviews.
>> 
>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>> should go through the hwmon tree. Once these changes are in mainline,
>> I plan to pick up the final patch ("module: Remove obsolete
>> __MODULE_STRING()").
>
> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
> the final removal in patch 3 on modules-next for 7.5-rc1.

Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
from cropping up between now and v7.5-rc1?

BR,
Jani.


-- 
Jani Nikula, Intel
