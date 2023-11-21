Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3mmDQgO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896510C;
	Tue, 21 Nov 2023 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700580546; x=1732116546;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=pGlpOt8ekT8rI9o9vzav5LyZJntBPg8+ve6LRsfkTv4=;
  b=F3mmDQgOt26hYXHqldk8NRYt/5YioRpi7XzOvIL2YRKkqRrWeGCe11gC
   1Z8aeQrfOm88L0NBFlJgIOMlU1FT2rXRRzbXUyAAf35z8+BGb2e2DuVF8
   o7svDKBizOdN1sOgOR0/6/4Kr5FCzeX9weWBxV36Nafsv0Ikaap1s7EBe
   o6pgQSA5vfpWVnaTUQidIqtJ6YqONr0oik88oDazvV8wYIodsPLdbqP7C
   akpuxtSjrPvIDNGyJcGgYIobVLopIICBGkGwrKcu2a/SNsW2IkcgpyC3Y
   Rq4D1bbq3smVbZSyk44qHXluha6xCJRXt1KzjuFJq6oRfF7JhcEGvw+jV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391634468"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="391634468"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="940133682"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="940133682"
Received: from azanetti-mobl.ger.corp.intel.com ([10.249.46.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:29:03 -0800
Date: Tue, 21 Nov 2023 17:28:59 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 17/17] tty: srmcons: make 'str_cr' const and non-array
In-Reply-To: <20231121092258.9334-18-jirislaby@kernel.org>
Message-ID: <82caf538-cee5-1420-4944-b26b627ef145@linux.intel.com>
References: <20231121092258.9334-1-jirislaby@kernel.org> <20231121092258.9334-18-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-708007674-1700580476=:2370"
Content-ID: <35f46392-2e83-15f8-784d-c65e61e6a7a5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-708007674-1700580476=:2370
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9813717-44d-cd5a-dcc7-a59df464c62a@linux.intel.com>

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> 'str_cr' contains a single character: \n. There is no need to declare it

Aren't \r and \n different characters?

> -	static char str_cr[1] = "\r";
> +	static const char str_cr = '\r';

Thanks for making these cleanups.

I've reviewed all the patches in this series, so if I didn't comment a 
patch or when you address my remarks, feel free to add:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-708007674-1700580476=:2370--
